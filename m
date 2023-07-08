Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C67674BA5B
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 02:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbjGHAEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 20:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232698AbjGHAEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 20:04:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6CC2130;
        Fri,  7 Jul 2023 17:04:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b8b318c5cfso16598735ad.1;
        Fri, 07 Jul 2023 17:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688774652; x=1691366652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ztQCxeXoo5kQn8PZtji0Y2HWvCLcFtr33w03kp0/pcU=;
        b=bWy5ZXuE2LJFeEB75Djpfv5aKY9zBdR+6+kVzokxYHQKsXGtdjHMND58jLk7b4EBsA
         yzBgg7DLBzc36CsLP2Q6BEDRNeSYU+JylHvt+fAkjp0so/IgExLF9ljvIansMlW2+1nK
         pm5BqLKmTAx99ygWpHvgpA4w1WCUgooVplHiKr4LDi5kSp2cNS7RmPmYVSBs6BzdwZCc
         jCR4IsTpy1qifXG+Scxi4v2CvXNtUfwrkBf3T1QuvTUYdb84hyiz/7KyM+tc9ZDBxr/a
         VV8qvj4M27O2bWpjSWOXPWBjQWPYEQrHnOVjyqK/jzOyqBUaCm1KkQrqUHV5OvgMLeLA
         +AvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688774652; x=1691366652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ztQCxeXoo5kQn8PZtji0Y2HWvCLcFtr33w03kp0/pcU=;
        b=E0UcZAgPDaWahLC2a58zFN0Uah+c4LofE/Q8mm7kUIKdmCj+hGe4qGBePDrfqdnYrE
         H6PtWiaI9Kkt3w08Hc85tcuPH3iFQDWeziggwd9J9DLH3S8gcVa8IGDFoHOuWR590Vsi
         ezUecuCaoEH0sEXbHWwQPveWvnCBZ4XlnyPuEWiyM19Ptq77dPGzMAjrb07jJNy4itUB
         AWR1d2pdyAB/lBGuLWLNNWR389Bs1bfs9YdMFtqeRt+qzVjzMzFsi8OHgJ2IlqUyEaca
         Ig9akckoRThvffwhK0SW0uvIyiSageTLd74nAwz1f+t8zQX6RbC4oD6uHlI4x+mvqkgs
         Qxmw==
X-Gm-Message-State: ABy/qLZ9B7DrS7NNyLYqtIqCZNrpKzl3x1wLNKVAB4dVC3F5yWZVrYrT
        fHOAswXtUJ0iuGUA3ojldGU=
X-Google-Smtp-Source: APBJJlHSaoSuzGF1gnYxKelHVlYkL7IjsQpxui71O9OFVIw1A7CIFX88Xw2dH0O9qBxd+uHLJyyTfQ==
X-Received: by 2002:a17:902:8bcb:b0:1b8:94f4:3e0 with SMTP id r11-20020a1709028bcb00b001b894f403e0mr6064083plo.14.1688774652594;
        Fri, 07 Jul 2023 17:04:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:38de:2bd4:8f55:60cd])
        by smtp.gmail.com with ESMTPSA id p8-20020a170902e74800b001adf6b21c77sm3785270plf.107.2023.07.07.17.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 17:04:12 -0700 (PDT)
Date:   Fri, 7 Jul 2023 17:04:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] Input: adp5588-keys - Use devm_regulator_get_enable()
Message-ID: <ZKin+ZxMgZnAtsq0@google.com>
References: <af343b5b0d740cc9f8863264c30e3da4215721d7.1686985911.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af343b5b0d740cc9f8863264c30e3da4215721d7.1686985911.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 17, 2023 at 09:12:03AM +0200, Christophe JAILLET wrote:
> Use devm_regulator_get_enable() instead of hand writing it. It saves some
> line of code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thank you.

-- 
Dmitry
