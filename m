Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518F63F760
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 19:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbiLASRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 13:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230197AbiLASR2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 13:17:28 -0500
Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BA8C06
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 10:17:23 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a02:8440:3340:1594:24ae:608:767e:668e])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 468A119F5AB;
        Thu,  1 Dec 2022 19:17:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1669918641;
        bh=yxEVDTvGTZcnEnYtE53ZMy6FH6lbU2OVBznc2Ae2Vsg=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=nNyGDinHie6GalI1DnVVjBdlpM28kWYyVbBg0fWCqZLE2DZnLu0Jv/ShjntpZXDj3
         kXVc3svS3LFzfmgBNTTsAr0dBJw6A998H12ssfliWurwVN8QoxWhDKSbvEFZ62CwXH
         ANzLXLfUI+vj/w1u3lBuEVUjO1k1e77Ga3agZKDN2ZWbMODHTYq02iBb75QjYV5teq
         kqxaO4FjqhKWFjl730i+st+2d8Qq7JPtxjm5DlbGNZ+S5xIOTzakUX0SvclQVWhfyh
         iZ9ztqiD5QkDywThQIBPZe9nIeuCtrwiPPDzBF1Iyo7kGVapdH9oiekYg8GPYYZiv0
         LYaPCbO5CymtA==
References: <202211301556064978448@zte.com.cn>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     zhang.songyi@zte.com.cn
Cc:     arnd@arndb.de, robert.jarzmik@free.fr, lkundrak@v3.sk,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] pxa: Remove dev_err() after platform_get_irq()
Date:   Thu, 01 Dec 2022 19:15:34 +0100
In-reply-to: <202211301556064978448@zte.com.cn>
Message-ID: <m25yevf0ph.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


<zhang.songyi@zte.com.cn> writes:

> From: zhang songyi <zhang.songyi@zte.com.cn>
>
> There is no need to call the dev_err() function directly to 
> print a
> custom message when handling an error from either the 
> platform_get_irq()
> or platform_get_irq_byname() functions as both are going to 
> display an
> appropriate error message in case of a failure.
>
> /drivers/soc/pxa/ssp.c:150:2-9: line 150 is redundant because
> platform_get_irq() already prints an error
>
> Signed-off-by: zhang songyi <zhang.songyi@zte.com.cn>
> ---
>  drivers/soc/pxa/ssp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/soc/pxa/ssp.c b/drivers/soc/pxa/ssp.c
> index 93449fb3519e..7085901b4e4b 100644
> --- a/drivers/soc/pxa/ssp.c
> +++ b/drivers/soc/pxa/ssp.c
> @@ -147,7 +147,6 @@ static int pxa_ssp_probe(struct 
> platform_device *pdev)
>
>         ssp->irq = platform_get_irq(pdev, 0);
>         if (ssp->irq < 0) {
> -               dev_err(dev, "no IRQ resource defined\n");
>                 return -ENODEV;
>         }
As you're leaving only one statement in the if, you should drop 
the braces as well.

Other than that, it looks good :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
