Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6F9629AD7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 14:42:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238366AbiKONmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 08:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiKONmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 08:42:16 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039A813FA6;
        Tue, 15 Nov 2022 05:42:16 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so13855805pjk.1;
        Tue, 15 Nov 2022 05:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q24KX2057pThKailHphOfjZ+3umm1xp/JerUuUNakT4=;
        b=H6qyXXfuORPButKx1DlsOyhRzLlNHomtiA2jsmTdIkaeHKMm5NTaL5ppqj73pRf95K
         CmvBO6D+aHpO9xQ/nDntRFyOmmaeoGwnPIrvPnkGVlvOMADW8c5NkY2QL3aZKUf8MTl4
         wSjzeB38FnMMf0goyKzdka9uQLLuZoggC6dupkPOAkl09pHpKjeguQhHEWJ1xr/NYcOC
         bi9o1NFty7WsAUm7xjw+B6h/mgw47w5aV6Zn4HpYyQIhBnO5qILWlGFxO7jIL4DJsrAp
         wI514g5uaiprB0fVhC8bULN96X/0jbgExQUzyXc8F2i86G/OTArwRs7VWcfAjHB16RrY
         DjiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q24KX2057pThKailHphOfjZ+3umm1xp/JerUuUNakT4=;
        b=yqEjYmOc4PV3ylDycWnID1eUoZwKs68Gti+4nrxgZBgkSh+kdMy6GqkT9DNUTGK7bd
         Wo4mSqGYULtaz+0nSzU1xE7Ky4idi1YYM3mdyIanhEWYHv9sKr/MKS1L/ybDxi5JmCMA
         /zb6vAtUAFJnPTCN09328t8iocVEsEjMb0u7i+n7krYWBDtr1MmSSWiPDcWlCDlkHfTb
         hfweevtYi7FBxq63yTp+GEhpj19oCdfyJz1Dosv7Gy9oGx2Djbx3kwYyBbrd2+++PiAn
         6jpoyNNEX8L1wqwTscCojGRxv+YlZrH1CLXGHMKV0JhYd+HkavfL6Fp+sgvNgBdTWSbx
         Pe5Q==
X-Gm-Message-State: ANoB5pnxlCOrkvAO95s0xjQS+NuPDryXeCUprrNsGInvRWqILqvfkuIw
        ltikE3SrAiundpEMwVKHkcCPbICuciM=
X-Google-Smtp-Source: AA0mqf60R/9MpoTfSGFM4O2rRKTX/bGNgCOssKA2u+wkXmEW2qcHg9fOQ13VvEjwrCvPJGb9Bf6j3Q==
X-Received: by 2002:a17:902:f803:b0:188:602b:8259 with SMTP id ix3-20020a170902f80300b00188602b8259mr4044393plb.139.1668519735440;
        Tue, 15 Nov 2022 05:42:15 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b00186b55e3cd6sm9954797plf.133.2022.11.15.05.42.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 05:42:14 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 15 Nov 2022 05:42:13 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Li Hua <hucool.lihua@huawei.com>
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, weiyongjun1@huawei.com,
        yusongping@huawei.com
Subject: Re: [PATCH] watchdog: pcwd_usb: Fix attempting to access
 uninitialized memory
Message-ID: <20221115134213.GD4189373@roeck-us.net>
References: <20221115083555.22928-1-hucool.lihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221115083555.22928-1-hucool.lihua@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 04:35:55PM +0800, Li Hua wrote:
> The stack variable msb and lsb may be used uninitialized in function
> usb_pcwd_get_temperature and usb_pcwd_get_timeleft when usb card no response.
> 
> The build waring is:
> drivers/watchdog/pcwd_usb.c:336:22: error: ‘lsb’ is used uninitialized in this function [-Werror=uninitialized]
>   *temperature = (lsb * 9 / 5) + 32;
>                   ~~~~^~~
> drivers/watchdog/pcwd_usb.c:328:21: note: ‘lsb’ was declared here
>   unsigned char msb, lsb;
>                      ^~~
> cc1: all warnings being treated as errors
> scripts/Makefile.build:250: recipe for target 'drivers/watchdog/pcwd_usb.o' failed
> make[3]: *** [drivers/watchdog/pcwd_usb.o] Error 1
> 
> Fixes: b7e04f8c61a4 ("mv watchdog tree under drivers")
> Signed-off-by: Li Hua <hucool.lihua@huawei.com>
> ---
>  drivers/watchdog/pcwd_usb.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/pcwd_usb.c b/drivers/watchdog/pcwd_usb.c
> index 1bdaf17c1d38..89b0b5d8a7e6 100644
> --- a/drivers/watchdog/pcwd_usb.c
> +++ b/drivers/watchdog/pcwd_usb.c
> @@ -326,8 +326,13 @@ static int usb_pcwd_get_temperature(struct usb_pcwd_private *usb_pcwd,
>  							int *temperature)
>  {
>  	unsigned char msb, lsb;
> +	int retval;
>  
> -	usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
> +	retval = usb_pcwd_send_command(usb_pcwd, CMD_READ_TEMP, &msb, &lsb);
> +	if (retval != 1) {
> +		pr_err("Card did not acknowledge CMD_READ_TEMP\n");
> +		return -1;
> +	}

That all isn't really worth the trouble. If anyone still has the hardware,
the driver should be converted to use the watchdog subsystem and to return
useful error codes where appropriate. For example, returning -EFAULT as
response to errors from WDIOC_GETTIMELEFT or WDIOC_GETTEMP is just wrong.
If you really want to do anything, just initialize lsb and msb with 0.

Guenter
