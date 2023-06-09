Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 132C472A62E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 00:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbjFIWMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 18:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjFIWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 18:12:42 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3754A3588;
        Fri,  9 Jun 2023 15:12:42 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-777a4926555so71942639f.0;
        Fri, 09 Jun 2023 15:12:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686348761; x=1688940761;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DfKKtcaDIw3HAbtkucqdOOtGatBesAW+tExD2IkvYeM=;
        b=gGZWZeBfRcEHi3HwCrvHNGKeX9wee1ndGleRq//k/KQuhfAg/tQyJGMPM3jZp1a38/
         obDQR0T5UkDhkw+iIFjEWH2bCG1qBefp+8qkCOfQeArhcoZ/oYDvkVIOyPvajxQNUObI
         fXtKkoi6PE3uheqNtiL6NCduqBeUoCIKxWzaJEfVZ++k2gKLrmWQvQj0dcOL7AYAFGEy
         XpLFi6HBKEDG0jrW8zKsHquywp+d9iI2JAZH5kGVsagVU83Cb7jDKoEbEdaUui4Tof4Z
         WGzLaNS6E2i7Hr9dRvql2Q2UlBTqOKCAPQX2bLdC6kjhZvNc0KfgXKQpsX2vtE1Tmbbv
         NIqg==
X-Gm-Message-State: AC+VfDwYdcxdOQdWmSaMbnQiKRN2c9V69ZTQpleyrlQ+E9k2aZppsPuB
        o+fkbd/IEP61bqaLYSYlKQ==
X-Google-Smtp-Source: ACHHUZ507G8Op5ly5XbaycSXgEJIT0YOWrWxWDzc51BuhpeFgN5SSbobdxITVuJ8T+UWVsXqP8bqJA==
X-Received: by 2002:a05:6602:2d01:b0:777:a4d2:8871 with SMTP id c1-20020a0566022d0100b00777a4d28871mr5310666iow.5.1686348761363;
        Fri, 09 Jun 2023 15:12:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id z3-20020a056638000300b004163438fd4esm1181748jao.92.2023.06.09.15.12.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 15:12:40 -0700 (PDT)
Received: (nullmailer pid 2553353 invoked by uid 1000);
        Fri, 09 Jun 2023 22:12:39 -0000
Date:   Fri, 9 Jun 2023 16:12:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH] of: overlay: Fix missing of_node_put() in error case of
 init_overlay_changeset()
Message-ID: <168634875769.2553276.1278623531665525216.robh@kernel.org>
References: <20230602020502.11693-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602020502.11693-1-hayashi.kunihiko@socionext.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 02 Jun 2023 11:05:02 +0900, Kunihiko Hayashi wrote:
> In init_overlay_changeset(), the variable "node" is from
> of_get_child_by_name(), and the "node" should be discarded in error case.
> 
> Fixes: d1651b03c2df ("of: overlay: add overlay symbols to live device tree")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  drivers/of/overlay.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!

