Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC22E6277A4
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:29:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiKNI3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236377AbiKNI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:29:19 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAD91AF29
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668414500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0cKHoFafz+LP1S2CBddADOVNwHT2k+gOLa+MKsB3ptw=;
        b=RmkDB7Opd/lYCxyAvrYE8dOu8PI8FgXJw4MEZQUTuPF5P3ykD/SvvsaUP5oJDexWup2CCT
        jm/K6/VuOG5IiuzTOB2flPQjazr4LsRnrK9X67jC7K43ETqzYqQ/OtxPulIdNG/6MwYCrR
        +HTxrP2+Oz8lu4z0r0OGw7OchFIVNz8=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-9MigZtXDPtScb6uK4nqrQw-1; Mon, 14 Nov 2022 03:28:18 -0500
X-MC-Unique: 9MigZtXDPtScb6uK4nqrQw-1
Received: by mail-ed1-f71.google.com with SMTP id r12-20020a05640251cc00b00463699c95aeso7759854edd.18
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:28:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0cKHoFafz+LP1S2CBddADOVNwHT2k+gOLa+MKsB3ptw=;
        b=I15uCHHQylQriBQXBi4b8b794TTGgSbiaGp78QQrtT4ehafHNXntHItZyABqgHUbrn
         ihxc5AbHuSpzedYWj8HgaQYQLKFbHd1fyFO/eo3mC2rHKgubmiGPewV6E7fjuFBMzgzU
         hRQY7TWoPAMqaH7R2Rckmfw/8tGHHwOI6yoT3JaZvGyNxUibjOFHlzWPSJMC0GnIrvtH
         bUE0myXfPdEDLDxnwWbHu8LWFTIjg77gYxM/SD1SorJcdTltVphtxpaGns6VNqBKbOFP
         jp/ToImyJHT3pwEzKL5s7w8cAYqDmncLF3ON7dj7wY7HIn444wPlvS8DeMlrqHAoLr8u
         FnfA==
X-Gm-Message-State: ANoB5pnn96kEy+SOihmAbslOdEqRu7q0dgfVzhfsM1mEvBtLi8+lohb9
        SDpaZOgvq0Xo5LeeRANN6AcEpX744CEjwudSZId1cKzw9lmfWRtwm58BsSlSgdrnbawe9twiqYl
        9xdcg6HykjseMpYHPr5VLCkot
X-Received: by 2002:a17:906:a148:b0:79e:9d9b:d41f with SMTP id bu8-20020a170906a14800b0079e9d9bd41fmr9465085ejb.404.1668414496895;
        Mon, 14 Nov 2022 00:28:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6llvFfjsia9EdK19bkvVH34sDfeBmnZsD9XX/oHCPsIbjxTUEgWIQrbHxvv3fFbacyGd35kg==
X-Received: by 2002:a17:906:a148:b0:79e:9d9b:d41f with SMTP id bu8-20020a170906a14800b0079e9d9bd41fmr9465074ejb.404.1668414496703;
        Mon, 14 Nov 2022 00:28:16 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id sz15-20020a1709078b0f00b0073cf6ec3276sm3840583ejc.207.2022.11.14.00.28.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 00:28:15 -0800 (PST)
Message-ID: <ab0db3fa-4106-da16-7771-8ab50aa0f3b5@redhat.com>
Date:   Mon, 14 Nov 2022 09:28:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        Thiago Macieira <thiago.macieira@intel.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com> <Y3DZmKYV+8HBtZ+Q@zn.tnic>
 <2537334.Lt9SDvczpP@tjmaciei-mobl5> <Y3F4Uq+1qi5tnmeG@zn.tnic>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <Y3F4Uq+1qi5tnmeG@zn.tnic>
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

Hi,

On 11/14/22 00:05, Borislav Petkov wrote:
> On Sun, Nov 13, 2022 at 01:51:56PM -0800, Thiago Macieira wrote:
>> Anyway, we can update the tool to print "%02x-%02x-%02x-%02x.%s" instead of 
>> "%d". That's trivial to us. I just don't think it's a worthwhile change, 
> 
> As I wrote to Tony, "I guess time will show whether the sequence number
> thing was a good idea."

Just for the record: I've read the entire thread and I'm fine with doing
things either way.

If I understand this last email correctly then the plan is to move
ahead with the patches as-is, with writing only the batch-number and
have the kernel create the filename. This was and still is fine with me.

Regards,

Hans

