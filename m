Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1A972DF64
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239502AbjFMK2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 06:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241685AbjFMK1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 06:27:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED161BE5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:26:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686651966;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rZcEQjdnUPfgnpDLwolPkeA4s5uTdek4kX0pKcQkY8Y=;
        b=UTxaSFRZNPbqSpWBLefX6TdizxU0IqvEF+9SOK9rWers6Hkk0yhOISZXqIzXjUTG788bmU
        ADIIQIWl8P71u816XGbZq+fJ+8Now/I6VLQ6JvsQXslRbzoC8M7/Gp+EpdC7FgGhucD3O5
        x6ty6lWf3NmlRt1qrRGZs5Li/KKp6DA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Kk-nxHX-MKi2p84CUMRSWw-1; Tue, 13 Jun 2023 06:26:05 -0400
X-MC-Unique: Kk-nxHX-MKi2p84CUMRSWw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-974566553ccso608279566b.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 03:26:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686651964; x=1689243964;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rZcEQjdnUPfgnpDLwolPkeA4s5uTdek4kX0pKcQkY8Y=;
        b=FNtu5Crg8ezrFOnki/0NxaqJcvATPa+S+uMyjbuLIr/wTDyizO9nMn4ZofD0lq/1a8
         RuG2hJusI57NEe7qCIB1RjuwDaJWjqVCMIBS96k0MKR76Pykm9z93TLGu66YvwF1hyji
         /LV8pEAQGXdMwullFpIha3KLksK+zXeuZ8Hz0rF+IpdRoqlPjy+8gxU2jIg8vvoI+4WG
         Gf+RLtXezI/R5HqDg1EuBezQ0VoSfph9WGLUWdEt1TVqgo7kCq+ovZDsOpxMTLaCMbUC
         X/cqKq92/5oLd4dLfimyT+mKdbuFDPPhtIo6qjEXIeKWUXVSVIUMy266pY9pqKfpWziv
         SUfw==
X-Gm-Message-State: AC+VfDzEgXbeCWFJrnB7gf7QjlAL5roV3B9f+5IX0rFWtqG3R1L8YKmt
        SUXgUNLKs4tUpg7UpKQ53ZSbzPTWve+dETlIiO/pB3P6r/QBN37TCwMo3DeZSfQu4DEjV8wpDNf
        Mh5e1gteB5IIoaj/OzNg5Q87O
X-Received: by 2002:aa7:d753:0:b0:516:af22:bccc with SMTP id a19-20020aa7d753000000b00516af22bcccmr6962274eds.21.1686651964348;
        Tue, 13 Jun 2023 03:26:04 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4tlMWLfp9k2VwaUsES5I5/qCebnVY4QmLrOb65dkTElszfGX1KeIZRlmbWTJ1Hg0MZYQv25g==
X-Received: by 2002:aa7:d753:0:b0:516:af22:bccc with SMTP id a19-20020aa7d753000000b00516af22bcccmr6962261eds.21.1686651964027;
        Tue, 13 Jun 2023 03:26:04 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id o13-20020aa7d3cd000000b005083bc605f9sm6254625edr.72.2023.06.13.03.26.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 03:26:03 -0700 (PDT)
Message-ID: <89f6fe6b-c674-1ff6-dddb-06050ad5c97d@redhat.com>
Date:   Tue, 13 Jun 2023 12:26:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Fix lkp-tests warnings for
 platform profiles
Content-Language: en-US, nl
To:     Mark Pearson <mpearson-lenovo@squebb.ca>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        dan.carpenter@linaro.org, mario.limonciello@amd.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Dan Carpenter <error27@gmail.com>
References: <mpearson-lenovo@squebb.ca>
 <20230606151804.8819-1-mpearson-lenovo@squebb.ca>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230606151804.8819-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/6/23 17:18, Mark Pearson wrote:
> Fix issues identified in dytc_profile_refresh identified by lkp-tests.
> drivers/platform/x86/thinkpad_acpi.c:10538
> 	dytc_profile_refresh() error: uninitialized symbol 'funcmode'.
> drivers/platform/x86/thinkpad_acpi.c:10531
> 	dytc_profile_refresh() error: uninitialized symbol 'output'.
> drivers/platform/x86/thinkpad_acpi.c:10537
> 	dytc_profile_refresh() error: uninitialized symbol 'output'.
> 
> These issues should not lead to real problems in the field as the refresh
> function should only be called if MMC or PSC mode enabled. But good to fix.
> 
> Thanks to Dan Carpenter and the lkp-tests project for flagging these.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202306011202.1hbgLRD4-lkp@intel.com/
> Fixes: 1bc5d819f0b9 ("platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms")
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Once I've run some tests on this branch the patches there will be
added to the platform-drivers-x86/for-next branch and eventually
will be included in the pdx86 pull-request to Linus for the next
merge-window.

Regards,

Hans




> ---
>  drivers/platform/x86/thinkpad_acpi.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index b3808ad77278..4b89f42de723 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -10524,7 +10524,7 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
>  static void dytc_profile_refresh(void)
>  {
>  	enum platform_profile_option profile;
> -	int output, err = 0;
> +	int output = 0, err = 0;
>  	int perfmode, funcmode;
>  
>  	mutex_lock(&dytc_mutex);
> @@ -10538,6 +10538,8 @@ static void dytc_profile_refresh(void)
>  		err = dytc_command(DYTC_CMD_GET, &output);
>  		/* Check if we are PSC mode, or have AMT enabled */
>  		funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
> +	} else { /* Unknown profile mode */
> +		err = -ENODEV;
>  	}
>  	mutex_unlock(&dytc_mutex);
>  	if (err)

