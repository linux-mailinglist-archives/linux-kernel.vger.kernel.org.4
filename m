Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA815624D2A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232470AbiKJViV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:38:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiKJViT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:38:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079F41C10C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668116237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kvsDxKUAqwhEsPuDSPoSE+BmSi+geYyZ/4NKm7RNeR8=;
        b=eF5Naq91Ltlc8nxnh9cronSKoRlV+G8CGQjJpBm3TpdOKk0urPsV0zzDxwz7PSoNDiAcd5
        +6rpG7EOUNci167DwZ+p37WdELlSxZdkvz81spkUonurETeqW5xj5ygCrQpvuVF2xaozJH
        qbEEFmZOtnC5UBZZCz7v/kv6ErHJQPE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-504-BI-a0roiPimgUhZgKqbt2g-1; Thu, 10 Nov 2022 16:37:14 -0500
X-MC-Unique: BI-a0roiPimgUhZgKqbt2g-1
Received: by mail-ej1-f72.google.com with SMTP id xh12-20020a170906da8c00b007413144e87fso1914749ejb.14
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:37:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kvsDxKUAqwhEsPuDSPoSE+BmSi+geYyZ/4NKm7RNeR8=;
        b=FsDBF/i6xGYmzoWWja/KPZMAjFQ9Xbh4Tg7cEtHvytGWzDbpm6XJdaYDACeS/vthvr
         wx9Q4jql/OnAX8NCZPDfMne/CZnAV7DEDth+SAbClqTJQ9AkLftoHO1ynSlgAhSJuR/P
         PHOtFYrIR8NjFnP5XqOGYhVKhuFpEsA+qX91TfhVQtR6tBK/JWQwmdIQO5y+jN3KzUAe
         yDcNIriEToK9A7JnDPMCD0IVC/qmJFzK/nQQ0nczQ+UbFNpucXkYXjYRXejqEy/MqeIk
         38fatfKL+o6uGdFiHFm7mW3AvNLl8varzNbOYyiOk7oojUlDeUulrMw657dANyNeVqCM
         1CaA==
X-Gm-Message-State: ACrzQf1Y5eRLT9mf+/x04DDPF20MUQ/g/tocO89GveznPdPQdON4O98G
        7UoClfqdAcbH5kLJ/NSDZSnR53VOT99BgTJo1jIg9zTQf94jwf8DJAL6/Kew71sMxcPlHcnr2Zh
        WfLBaRQSW1lqo2nNdlS2qjJgT
X-Received: by 2002:a05:6402:d50:b0:463:5d1b:99fb with SMTP id ec16-20020a0564020d5000b004635d1b99fbmr3677152edb.269.1668116233113;
        Thu, 10 Nov 2022 13:37:13 -0800 (PST)
X-Google-Smtp-Source: AMsMyM4ictsTm2dFxSHcggJ8pFAA+iJT5cUeirtyr6bMeG9QGFQLps9RbWdUO2eVkvNjg82Z9F/gpQ==
X-Received: by 2002:a05:6402:d50:b0:463:5d1b:99fb with SMTP id ec16-20020a0564020d5000b004635d1b99fbmr3677138edb.269.1668116232896;
        Thu, 10 Nov 2022 13:37:12 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id ky14-20020a170907778e00b0078afe360800sm129717ejc.199.2022.11.10.13.37.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 13:37:12 -0800 (PST)
Message-ID: <c4b0cd93-767c-a778-6a38-0e4d981506d3@redhat.com>
Date:   Thu, 10 Nov 2022 22:37:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 00/14] IFS multi test image support and misc changes
Content-Language: en-US, nl
To:     Borislav Petkov <bp@alien8.de>,
        Jithu Joseph <jithu.joseph@intel.com>
Cc:     markgross@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, ashok.raj@intel.com,
        tony.luck@intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, thiago.macieira@intel.com,
        athenas.jimenez.gonzalez@intel.com, sohil.mehta@intel.com
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com> <Y2zLYDmO1fkOmFgw@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y2zLYDmO1fkOmFgw@zn.tnic>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 11/10/22 10:59, Borislav Petkov wrote:
> On Mon, Nov 07, 2022 at 02:53:09PM -0800, Jithu Joseph wrote:
>> Changes in v2
>>  - Rebased ontop of v6.1-rc4
>>  Boris
>>    - Moved exported functions (microcode_sanity_check(),
>>       find_matching_signature ) from microcode/intel.c to cpu/intel.c 
>>       (patch4,6)
>>    - Removed microcode metadata specific code changes to
>>       microcode_sanity_check() (patch6)
>>    - Moved find_meta_data() from common to IFS driver (Patch 8)
> 
> What's the upstreaming plan here - I'm assuming I should take the
> microcode patches through the tip tree?
> 
> Or should I take the whole thing through tip so that there's no
> confusion and having to sync and share branches between trees?

I have just reviewed all the platform/x86/intel/ifs changes
and they all look good to me.

I think it is the best and easiest if you just take the whole
branch.

I don't have any changes pending under drivers/platform/x86/intel/ifs
so there should not be any conflicts.

Regards,

Hans


