Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784B17179AE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbjEaILt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234370AbjEaILr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:11:47 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3790BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:11:46 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4f3b5881734so6330877e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685520705; x=1688112705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=djQp6xXJB76HLCESd2F3vNeh5AutF5do3+uW6pj9IuA=;
        b=dlgAi76fwrHBNV3xO0if+tVJBJVOd5Ea5U31Jkukoh83W3PISrWN1bUnmnrYhsjlis
         FH52Rq0t1Yf5S6z3MgfwjegEa8GmmJfAYgp3DRrI7YdaRfEYX1L24oMO23MULlHTDMF7
         TedjM96r1F766DN6A6LBpcriY/+oOsbVcggxZOmv/43Hu5dYZH8SISQZDXmghHJR/uKK
         2wKPviZC6+tewJVn5yOEIde3DRmoAm2t5TPVL3OH1MygBSkyqfKiYBfBQ9V4kZvUYLlF
         kMl6PxVe1fzTwb4n8qd/S1QPrbXaj9KCseS9yU3drnWqgfebEMpZww+Mri1uHYFAYiQz
         PW4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685520705; x=1688112705;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=djQp6xXJB76HLCESd2F3vNeh5AutF5do3+uW6pj9IuA=;
        b=Bvta8CvFsUxINU6HTDelQUw/gfofsTfbaCfQhMAaiVPb5yzNiI5JMGCgWMfzsIS9ez
         QwK7EqSaD/qQAfCH6KQIK/qazu73Gl2CFQMAHTeWxGOiSdemNU/G1luMiSGw/17O6Lkr
         rHKigT14dEz8qjO7PHyZ+7QHoDQ/ZbHHBG4RR8UZSRz20buRRQqvHQPR9m/YngFCSi7h
         UA9gNnmwNxvFareJ4ta4gLEFnYt/UnRa4wAZa8kigtA5hewyUirHqMb22TfVagODbpDT
         JBP9A01khTId6rnYEIxmNXjZYoagubk9/4Ro7jvkVb+YDh90mwS8DI/GFWyAJdiyIiEs
         CACg==
X-Gm-Message-State: AC+VfDwIqF1cKFrPfIpxl5cRzglGr5Lza3n5Glc9HLjGIC9K2H6fsYvl
        IGpg85puai9N7b8KKcXw5F8W/BT1rrkxAbEG69w=
X-Google-Smtp-Source: ACHHUZ5rYHDeeSg0XtC/27c5tpai1Ctc5llD+NlGEP/YA8e4frgKM7+jMqUn4iigN2Wk40R4dtfXAg==
X-Received: by 2002:a19:f706:0:b0:4f3:afcc:e1bb with SMTP id z6-20020a19f706000000b004f3afcce1bbmr2012530lfe.1.1685520705131;
        Wed, 31 May 2023 01:11:45 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id 13-20020a05600c24cd00b003f4dde07956sm23395334wmu.42.2023.05.31.01.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:11:43 -0700 (PDT)
Date:   Wed, 31 May 2023 11:11:39 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Edward Cree <ecree.xilinx@gmail.com>
Cc:     oe-kbuild@lists.linux.dev, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>
Subject: Re: drivers/net/ethernet/sfc/tc.c:450 efx_tc_flower_replace() warn:
 missing unwind goto?
Message-ID: <2fca6bb6-a964-4b77-b99e-fad244fde732@kili.mountain>
References: <cbbbf576-6788-4049-b1e8-a05862f62cc2@kili.mountain>
 <4eabd7b1-66b3-7b3a-cabd-d1876767c49c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eabd7b1-66b3-7b3a-cabd-d1876767c49c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 07:26:46PM +0100, Edward Cree wrote:
> Guess efx_tc_flower_replace_foreign() now has the latter problem
>  too?  (And it _does_ want to use the failure ladder, because we've
>  got to release the encap match.)

Oh, yeah.  Right.

regards,
dan carpenter

