Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093D26EE726
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 19:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbjDYR4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 13:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjDYR4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 13:56:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5C3D30A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682445329;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qwU0ROkheDnijyi+MYsBDonZSHpK8JQv792q8U7KINI=;
        b=XklaCZBJicqovIJAjUUYczMPHuUPJpumBGDC9Lrw2uSn6vPPnGCgHlPKpX51o6YfgPG0Sh
        c2e5BqNca0zbx16ZRxE9Qhf5nch8RraXyB82Bqh2JQOFsYA7P44iNeV45prgThCXzltr4p
        hWgzs647nwpTRs8QUpP0T+K0K+PnNQI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-qFkGwR8bPT23y_SC-zQdLg-1; Tue, 25 Apr 2023 13:55:27 -0400
X-MC-Unique: qFkGwR8bPT23y_SC-zQdLg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-506b0b75731so5664995a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 10:55:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682445326; x=1685037326;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwU0ROkheDnijyi+MYsBDonZSHpK8JQv792q8U7KINI=;
        b=ZEG8M0A4BRMv1IQ6UpD3U1GS4c86RgPL/N13lemsL4fdEF8gfToI/7d2jfffyNyp8h
         SJwCH2mGPw9qeKFIXHPde56hCq8PqMxV/4cu0r8AuwtJmLXHIUQ+vqy6GVQIfynohL3B
         FZzxTddwPzlXOynWVeSvPP7cDRFU3JYnoxz3Edbp/uNGHwlzJ3wOIAUpvQcHMRJjTvA2
         qWzbmIst8wnToDruLsg8pKav14kXPMBhUOcy70Yjj9NihuQn13P4Wn1Ix5WzsfXBzpap
         f92428EzNeyMUB35A2/sw397gVtuvNJBJpIxhVmssxDohrM6jtXv3vIH/F/IzyilbsYh
         kIIQ==
X-Gm-Message-State: AAQBX9dBa9A2+kDp6FIHp9ZWxgOTBlmUt+OEPnJ3LxcP7N6pbFc06gmk
        9itEUE0NgJJxC127U9vDHo7OEIInli/gcwi8V2U/eKxX0iB9RHE06T87MxWXlATInDG2l8sATav
        tUQ2D3y4IyRJ94eLTPmnkouMq
X-Received: by 2002:a17:906:15d:b0:932:e6d5:bd7c with SMTP id 29-20020a170906015d00b00932e6d5bd7cmr14872419ejh.20.1682445326528;
        Tue, 25 Apr 2023 10:55:26 -0700 (PDT)
X-Google-Smtp-Source: AKy350aSoLy6Ajs1Vc+A4XVuIr1XE5/6cvhrX1DjpSEeoqnm+h+xFklrE+mzwA3LrGe3XBm17iVKlw==
X-Received: by 2002:a17:906:15d:b0:932:e6d5:bd7c with SMTP id 29-20020a170906015d00b00932e6d5bd7cmr14872400ejh.20.1682445326184;
        Tue, 25 Apr 2023 10:55:26 -0700 (PDT)
Received: from ?IPV6:2001:1c00:2a07:3a01:67e5:daf9:cec0:df6? (2001-1c00-2a07-3a01-67e5-daf9-cec0-0df6.cable.dynamic.v6.ziggo.nl. [2001:1c00:2a07:3a01:67e5:daf9:cec0:df6])
        by smtp.gmail.com with ESMTPSA id 26-20020a170906101a00b0095729352bf3sm5597938ejm.215.2023.04.25.10.55.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 10:55:25 -0700 (PDT)
Message-ID: <2225a78f-5766-c6d9-68d5-32da7f9d2791@redhat.com>
Date:   Tue, 25 Apr 2023 19:55:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] hp-wmi: add micmute to hp_wmi_keymap struct
Content-Language: en-US
To:     Fae <faenkhauser@gmail.com>, markgross@kernel.org
Cc:     jorge.lopez2@hp.com, kai.heng.feng@canonical.com,
        rishitbansal0@gmail.com, dhould3@gmail.com,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230425063644.11828-1-faenkhauser@gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230425063644.11828-1-faenkhauser@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/25/23 08:36, Fae wrote:
> Fixes micmute key of HP Envy X360 ey0xxx
> 
> Signed-off-by: Fae <faenkhauser@gmail.com>

Thank you for your patch, I've applied this patch to my review-hans 
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans

Note it will show up in my review-hans branch once I've pushed my
local branch there, which might take a while.

Patches which are added to review-hans now are intended for
the next rc1. This branch will get rebased to the next rc1 when
it is out and after the rebasing the contents of review-hans
will be pushed to the platform-drivers-x86/for-next branch.

Regards,

Hans



> ---
>  drivers/platform/x86/hp/hp-wmi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
> index 873f59c3e280..6364ae262705 100644
> --- a/drivers/platform/x86/hp/hp-wmi.c
> +++ b/drivers/platform/x86/hp/hp-wmi.c
> @@ -211,6 +211,7 @@ struct bios_rfkill2_state {
>  static const struct key_entry hp_wmi_keymap[] = {
>  	{ KE_KEY, 0x02,    { KEY_BRIGHTNESSUP } },
>  	{ KE_KEY, 0x03,    { KEY_BRIGHTNESSDOWN } },
> +	{ KE_KEY, 0x270,   { KEY_MICMUTE } },
>  	{ KE_KEY, 0x20e6,  { KEY_PROG1 } },
>  	{ KE_KEY, 0x20e8,  { KEY_MEDIA } },
>  	{ KE_KEY, 0x2142,  { KEY_MEDIA } },

