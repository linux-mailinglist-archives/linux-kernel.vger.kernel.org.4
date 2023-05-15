Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBDB702D50
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242038AbjEONAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242067AbjEOM7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 08:59:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E7E19BA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684155531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FWCSgHKgkfiwsZPIbDFMuCcNPnF6WGYEGag89qGrc3E=;
        b=INbALebSyeFPuehk6FrrTKDeHsFn/UJXk4Dn0LlWpazMTjJl9748n+16rgFm5/FKhzw539
        ODqC7qdBg7tOYZaCRBNERp4LPmVI/XoH2+WiM3Hhe2mF+PBGOVAKQlg87QuA0ZqyDAZ/AQ
        DuESjuPk5w1HyQ1ITsnHlFSibi5J+cs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-266-Bv4l8o1fNlK59ITGeSWcdg-1; Mon, 15 May 2023 08:58:49 -0400
X-MC-Unique: Bv4l8o1fNlK59ITGeSWcdg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-50bcc3ee913so11269478a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 05:58:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155528; x=1686747528;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FWCSgHKgkfiwsZPIbDFMuCcNPnF6WGYEGag89qGrc3E=;
        b=BSrsLwBzXtzNw6cudhfnZF1zsTJAynxLVl3pfWeDcf0Bgyat8tD0Oe7jDEuZrds+GU
         z6j1twSqASszdJ23Bi+G9qt2ZLGMlMTE2RVHXdryM9lpXfFox+J8+tSDKajrjxjyQL4X
         tE185BAbAwoHlX02hiwOwLQVrkEBvTj959n9o7PStD5Dd/sWNxaqENwz7EwF9aBD82Dc
         p3KGJRwpZMu9BjQsoIbWrI0VdTFugXKksz8Je3WYvjLsHFdclcP0718HA6Q1GM6t5dSW
         LrvxLwBxoZ7cExB9Z/50dvrr3aRzcj4fgYP8g3sWf4SSGvS0pJAnO8EyNvxjHAiVjB8p
         PkDQ==
X-Gm-Message-State: AC+VfDzEhGgBSM+4vzVXJZylIRx0QWghboDG7/NSHDxUD5+AzbhJL3fN
        AdvniS/lyHlhfdv9RS48IldgntFHarLWjshCIE4P3c/z1YuScpNSXUp+Ig6Op3OuTymNysw9Vsh
        wJyMJ5F/aZA90nY74eg1u0QIy
X-Received: by 2002:a17:907:31ca:b0:960:d28d:3368 with SMTP id xf10-20020a17090731ca00b00960d28d3368mr29751364ejb.60.1684155528690;
        Mon, 15 May 2023 05:58:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6xkL6WGxU1o9yYr/28OLbSJCo+7UtLQGQNg33hogDZC56D+3LydUsY1jPyQc5CP9a5ic0ZGw==
X-Received: by 2002:a17:907:31ca:b0:960:d28d:3368 with SMTP id xf10-20020a17090731ca00b00960d28d3368mr29751349ejb.60.1684155528335;
        Mon, 15 May 2023 05:58:48 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906939300b0094e7d196aa4sm9298799ejx.160.2023.05.15.05.58.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 05:58:47 -0700 (PDT)
Message-ID: <ffe8f013-b666-0e8b-af19-4eda14fbe928@redhat.com>
Date:   Mon, 15 May 2023 14:58:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: asus-wmi: Ignore WMI events with codes
 0x7B, 0xC0
Content-Language: en-US
To:     Alexandru Sorodoc <ealex95@gmail.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>
Cc:     acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230512101517.47416-1-ealex95@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230512101517.47416-1-ealex95@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/12/23 12:15, Alexandru Sorodoc wrote:
> On ASUS GU604V the key 0x7B is issued when the charger is connected or
> disconnected, and key 0xC0 is issued when an external display is
> connected or disconnected.
> 
> This commit maps them to KE_IGNORE to slience kernel messages about
> unknown keys, such as:
> 
>     kernel: asus_wmi: Unknown key code 0x7b
> 
> Signed-off-by: Alexandru Sorodoc <ealex95@gmail.com>

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
> I'm not sure what those keys events actually mean. I assume they are
> some redundant notifications because no laptop functionality seems to
> depend on them.
> 
> If there is anything I can check or investigate please let me know.
> 
> Thanks,
> Alex
> 
>  drivers/platform/x86/asus-nb-wmi.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-nb-wmi.c b/drivers/platform/x86/asus-nb-wmi.c
> index e2c9a68d12df..fdf7da06af30 100644
> --- a/drivers/platform/x86/asus-nb-wmi.c
> +++ b/drivers/platform/x86/asus-nb-wmi.c
> @@ -555,6 +555,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0x71, { KEY_F13 } }, /* General-purpose button */
>  	{ KE_IGNORE, 0x79, },  /* Charger type dectection notification */
>  	{ KE_KEY, 0x7a, { KEY_ALS_TOGGLE } }, /* Ambient Light Sensor Toggle */
> +	{ KE_IGNORE, 0x7B, }, /* Charger connect/disconnect notification */
>  	{ KE_KEY, 0x7c, { KEY_MICMUTE } },
>  	{ KE_KEY, 0x7D, { KEY_BLUETOOTH } }, /* Bluetooth Enable */
>  	{ KE_KEY, 0x7E, { KEY_BLUETOOTH } }, /* Bluetooth Disable */
> @@ -584,6 +585,7 @@ static const struct key_entry asus_nb_wmi_keymap[] = {
>  	{ KE_KEY, 0xAE, { KEY_FN_F5 } }, /* Fn+F5 fan mode on 2020+ */
>  	{ KE_KEY, 0xB3, { KEY_PROG4 } }, /* AURA */
>  	{ KE_KEY, 0xB5, { KEY_CALC } },
> +	{ KE_IGNORE, 0xC0, }, /* External display connect/disconnect notification */
>  	{ KE_KEY, 0xC4, { KEY_KBDILLUMUP } },
>  	{ KE_KEY, 0xC5, { KEY_KBDILLUMDOWN } },
>  	{ KE_IGNORE, 0xC6, },  /* Ambient Light Sensor notification */

