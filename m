Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8F87218CA
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 19:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjFDRJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 13:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjFDRJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 13:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6FDA
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 10:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685898518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PdD6fLCgV2aQnBd7dmmJ3kgTXzpNFEeCf0r/5R17D2M=;
        b=XrTYWZ4YBmVOl0SygssuK04sz6eS/iFVIMGoSkQ0Vu8Emw+pJKINYJ+uhV3vh+cHQ3J0wq
        15NDal1oNv/vhHooPfY58vmLwWZMX4X5vE/tsIisIBuwAJWY1LCPcsUrA36CjyeauoEgr6
        cuR+tLWoiJGJWDs9yqOCCJgsP7K0SQQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Ki0VgwlEOmaNtUPpoQ6UOg-1; Sun, 04 Jun 2023 13:08:35 -0400
X-MC-Unique: Ki0VgwlEOmaNtUPpoQ6UOg-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a356c74e0so283445366b.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 10:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685898514; x=1688490514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PdD6fLCgV2aQnBd7dmmJ3kgTXzpNFEeCf0r/5R17D2M=;
        b=bGisD2zFr2SzZ/dsuId1+h0iQBvgRS1pRxcM1fBWcRYeKLqIE91PCc2BjPH9mCLJUu
         n31WVmX8P3b4/Zxa0ikTb5y83UuzmUoScVVtTOzRDpgNRyWnNRXefoN1qwk5czrNa8Wk
         TdAyyN4gmgf9f8Lthr/EhUXdhlCdxVk4f+SJibCKncfW/cVBhB67kw9dvBOFnnmIX4gf
         4hC0Q6l+LO5f8Jpf0frDKPm/S/YgbKZhtx+2gBAmSmTHka6TOerzkTuUGyIaxLRyDWXv
         WEWBfrOHmCU+HXMpa008OIBpAOVO13XkQGqMeEqNyuBs/S4wUFrU74Uv1xOFXk/zLgu+
         cllQ==
X-Gm-Message-State: AC+VfDwcphvRr0UWszLQABd1OOaHjuey1kZuORC6yBbSjSUQFogxXjTd
        QUUbJC4nJTplRmrRU4aaN1Kdc/mCKJ3tTdN9VWuRJ56OTktGuas1f/yE7ZR3dFHX5KzbdqeU1fG
        Otrq1IxPIAKk/FTWNfcL7TyeQ
X-Received: by 2002:a17:907:168a:b0:967:21:5887 with SMTP id hc10-20020a170907168a00b0096700215887mr4095483ejc.40.1685898513852;
        Sun, 04 Jun 2023 10:08:33 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4TPZilX3j01WIYfIYhahPcl8kTB8RkUD2ANGHMSpVRbwGGQb9vu22ijVQ0bzecqOBy+9DBTQ==
X-Received: by 2002:a17:907:168a:b0:967:21:5887 with SMTP id hc10-20020a170907168a00b0096700215887mr4095470ejc.40.1685898513516;
        Sun, 04 Jun 2023 10:08:33 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j24-20020a170906095800b009659fa6eeddsm3269450ejd.196.2023.06.04.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 10:08:32 -0700 (PDT)
Message-ID: <48a267c4-15c5-4ab6-7704-f7ee41e2fb90@redhat.com>
Date:   Sun, 4 Jun 2023 19:08:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 4/4] platform/x86/amd: pmc: Use pm_pr_dbg() for suspend
 related messages
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Rafael Wysocki <rafael@kernel.org>, linus.walleij@linaro.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org, Basavaraj.Natikar@amd.com,
        Shyam-sundar.S-k@amd.com
References: <20230602073025.22884-1-mario.limonciello@amd.com>
 <20230602073025.22884-4-mario.limonciello@amd.com>
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230602073025.22884-4-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 6/2/23 09:30, Mario Limonciello wrote:
> Using pm_pr_dbg() allows users to toggle `/sys/power/pm_debug_messages`
> as a single knob to turn on messages that amd-pmc can emit to aid in
> any s2idle debugging.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Thanks, patch looks good to me.

Here is my ack for merging this through the linux-pm tree:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/platform/x86/amd/pmc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/x86/amd/pmc.c b/drivers/platform/x86/amd/pmc.c
> index 427905714f79..1304cd6f13f6 100644
> --- a/drivers/platform/x86/amd/pmc.c
> +++ b/drivers/platform/x86/amd/pmc.c
> @@ -543,7 +543,7 @@ static int amd_pmc_idlemask_read(struct amd_pmc_dev *pdev, struct device *dev,
>  	}
>  
>  	if (dev)
> -		dev_dbg(pdev->dev, "SMU idlemask s0i3: 0x%x\n", val);
> +		pm_pr_dbg("SMU idlemask s0i3: 0x%x\n", val);
>  
>  	if (s)
>  		seq_printf(s, "SMU idlemask : 0x%x\n", val);
> @@ -769,7 +769,7 @@ static int amd_pmc_verify_czn_rtc(struct amd_pmc_dev *pdev, u32 *arg)
>  
>  	*arg |= (duration << 16);
>  	rc = rtc_alarm_irq_enable(rtc_device, 0);
> -	dev_dbg(pdev->dev, "wakeup timer programmed for %lld seconds\n", duration);
> +	pm_pr_dbg("wakeup timer programmed for %lld seconds\n", duration);
>  
>  	return rc;
>  }

