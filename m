Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFD7667E6B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 19:50:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjALSuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 13:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbjALStd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 13:49:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F311DBF45
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673547693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xvPUTgSTTtddM5dDfnOu8lQSC/kechSSbCUe5L06LTk=;
        b=eJuNMimlLrTt5arsBUJVKQ1TzpO19rruGjMQJiM91MGkLZ9uMKQgXZg6AIVMcWFdy4iTKQ
        29uGEsXQ37M5woAC6id5WwPZGxT2kb39wRo7CJXQjs5U530ce/32LbtFp0TJ19OWqCQfUL
        efIoYtsbkBjftrzxxljaOCU/cnq3ft0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-479-ifHIU4HTOlqv4xbbt5N2Cg-1; Thu, 12 Jan 2023 13:21:32 -0500
X-MC-Unique: ifHIU4HTOlqv4xbbt5N2Cg-1
Received: by mail-ej1-f71.google.com with SMTP id nb4-20020a1709071c8400b0084d4712780bso9584292ejc.18
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 10:21:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xvPUTgSTTtddM5dDfnOu8lQSC/kechSSbCUe5L06LTk=;
        b=UuyacKdXNTybZd1aEP24vtm/CxdX4m83oaqPF+RwPF4EhgOeY9CyGUkW0h/dO91jHb
         qYTE1xZwI4L1IvL9BrdkH5b/5b0q5xVIemh7wuTDWkVhXQb+MOBLr0h4tkSBQM4zpBER
         +KtfKoxfjkkZcbTKCtrhqIhe1WCYs+dvdYj4TcPeKBmis8cFr07AmZ4ubrOAlzN+s95d
         ihXJkwfHkJluUi3dxJinlpCTKz/zprUzlwcLZQfpywV/huxmFTy9TnrzuAPZfK7ahuhy
         xS8f1kC65XLBk0/JKfJIBN1nX6yUpRm1lZ2Em9OOo/cAxT/dieqrEn1GYED1bkv/mgiz
         P5rg==
X-Gm-Message-State: AFqh2koOz63kiftWeIT9a6n+ltvteeccjNs+5eduvMZe6/tWNxtL2iSY
        yTLDPcw2NOKpbm38zmXRvDysjLryUSiKm5FBQvec6achbnwnZxKnqkFItBId2saxh7L8JsVx7zZ
        zz3uyyqxZDpJL0v5abPWwk4NE
X-Received: by 2002:a05:6402:2a08:b0:470:4d71:6d43 with SMTP id ey8-20020a0564022a0800b004704d716d43mr70339412edb.25.1673547690997;
        Thu, 12 Jan 2023 10:21:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXth8VNWGy6klRzrsNc5MVA2aExa7fD1TfSHtAya8rJf/uU68HWO0o52vVBJZZ+5hPwrc3M5kQ==
X-Received: by 2002:a05:6402:2a08:b0:470:4d71:6d43 with SMTP id ey8-20020a0564022a0800b004704d716d43mr70339407edb.25.1673547690866;
        Thu, 12 Jan 2023 10:21:30 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w2-20020aa7cb42000000b0046a0096bfdfsm7487578edt.52.2023.01.12.10.21.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 10:21:30 -0800 (PST)
Message-ID: <32af40f9-8b67-ae75-8b10-88475e90eb9c@redhat.com>
Date:   Thu, 12 Jan 2023 19:21:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] platform/x86: asus-nb-wmi: Add alternate mapping for
 KEY_CAMERA
Content-Language: en-US, nl
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221216-asus-key-v1-1-45da124119a3@weissschuh.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221216-asus-key-v1-1-45da124119a3@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12/21/22 04:49, Thomas Weißschuh wrote:
> This keycode is emitted on a Asus VivoBook E410MAB with firmware
> E410MAB.304.
> 
> The physical key has a strikken-through camera printed on it.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans


> ---
>  drivers/platform/x86/asus-nb-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index c685a705b73d..8ee5d108e9e0 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -544,6 +544,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
>  	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
>  	{ KE_KEY, 0x82, { KEY_CAMERA } },
> +	{ KE_KEY, 0x85, { KEY_CAMERA } },
>  	{ KE_KEY, 0x86, { KEY_PROG1 } }, /* MyASUS Key */
>  	{ KE_KEY, 0x88, { KEY_RFKILL  } }, /* Radio Toggle Key */
>  	{ KE_KEY, 0x8A, { KEY_PROG1 } }, /* Color enhancement mode */
> 
> ---
> base-commit: b6bb9676f2165d518b35ba3bea5f1fcfc0d969bf
> change-id: 20221216-asus-key-b3bfb3bc2e77
> 
> Best regards,

