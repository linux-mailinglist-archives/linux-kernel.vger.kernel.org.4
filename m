Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71864629F24
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 17:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiKOQe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 11:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238547AbiKOQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 11:34:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8692EE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668530031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=repiNXo5iHvAUL0PM+bzqCOpF/xPqjBsShePYq+SbJ0=;
        b=MIzkmns2chm11LZ5XsierqUYGACrnaNW1WFK3fodGUN6/7+cP/gtu6DOJ+NjCd869qzszz
        NE8yJLuCZzQp0cjuDXUwMFncwwZKJbn57UuWKLyBgUY2RDNpcMA/LcDsfEov/afEv7mtm+
        FsK6UCC0d1k80M7jP24d3b5WG/PGgZo=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-y7rBaEC8OQqgo0x5jmlOHw-1; Tue, 15 Nov 2022 11:33:50 -0500
X-MC-Unique: y7rBaEC8OQqgo0x5jmlOHw-1
Received: by mail-ed1-f69.google.com with SMTP id y20-20020a056402271400b004630f3a32c3so10280997edd.15
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 08:33:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=repiNXo5iHvAUL0PM+bzqCOpF/xPqjBsShePYq+SbJ0=;
        b=w8WeXQmlYjVj+eUw79N6w4wOHZjdUWc0ZRcRCqdF/wnuBBWtsmVF/hG0+989e806qU
         OgJLntTRWxD+VatVBtJ2pbePuk6ET+fW48oTz75Nm+4TvFIsW6ynZbI8S17QPxRupDs9
         YiPFbn5lQ3ViyM/HoIRPOBHzcyFygYjPAStRQZsrtaMvNwTft+BKO/EESX7DO4sBFwKu
         EWWnvYLrhkB+TpjGWDQB3DFpLtYf15r0XXNzJWAueFRNg8Sc+CkRmKXNWZT3NaPXLgMb
         kqTphC9uew/CbTomct3O1NRyPzOoinE8hTs67PY2//Nkw9aUvUuXnSADUcdZQqfLbFv+
         E51g==
X-Gm-Message-State: ANoB5pmvPCLjJgzfIOHqrwaoZ2eY+p9iGbVSiNQ9CcHULNdn7CLOhUyt
        eGQX11dP4s/c2fSQeP3ALW74sdwCYJ+hy+QXoSDPj+sRIVVRns6xKUWyeVXudQ95Yi2NPWsZ5R3
        +u7FVV4lZ1QhPhyoPijXs98TN
X-Received: by 2002:aa7:db85:0:b0:463:f3a:32ce with SMTP id u5-20020aa7db85000000b004630f3a32cemr15943119edt.366.1668530029418;
        Tue, 15 Nov 2022 08:33:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5GSyAEjAbyTtBDveymZpactdPH6ufaiBtqmVFF8weDzdWrbfUEIeX8pnjwdQbyTgpzzTdYkQ==
X-Received: by 2002:aa7:db85:0:b0:463:f3a:32ce with SMTP id u5-20020aa7db85000000b004630f3a32cemr15943105edt.366.1668530029239;
        Tue, 15 Nov 2022 08:33:49 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id g21-20020a50ee15000000b004677b1b1a70sm4994841eds.61.2022.11.15.08.33.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 08:33:48 -0800 (PST)
Message-ID: <660117a0-07ba-069b-7b04-7b624801d735@redhat.com>
Date:   Tue, 15 Nov 2022 17:33:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH] platform/x86: hp-wmi: Ignore Smart Experience App event
Content-Language: en-US, nl
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114073842.205392-1-kai.heng.feng@canonical.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20221114073842.205392-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 11/14/22 08:38, Kai-Heng Feng wrote:
> Sometimes hp-wmi driver complains on system resume:
> [ 483.116451] hp_wmi: Unknown event_id - 33 - 0x0
> 
> According to HP it's a feature called "HP Smart Experience App" and it's
> safe to be ignored.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

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
>  drivers/platform/x86/hp-wmi.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> index 12449038bed12..0a99058be8130 100644
> --- a/drivers/platform/x86/hp-wmi.c
> +++ b/drivers/platform/x86/hp-wmi.c
> @@ -90,6 +90,7 @@ enum hp_wmi_event_ids {
>  	HPWMI_PEAKSHIFT_PERIOD		= 0x0F,
>  	HPWMI_BATTERY_CHARGE_PERIOD	= 0x10,
>  	HPWMI_SANITIZATION_MODE		= 0x17,
> +	HPWMI_SMART_EXPERIENCE_APP	= 0x21,
>  };
>  
>  /*
> @@ -859,6 +860,8 @@ static void hp_wmi_notify(u32 value, void *context)
>  		break;
>  	case HPWMI_SANITIZATION_MODE:
>  		break;
> +	case HPWMI_SMART_EXPERIENCE_APP:
> +		break;
>  	default:
>  		pr_info("Unknown event_id - %d - 0x%x\n", event_id, event_data);
>  		break;

