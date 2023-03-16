Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67A1D6BCBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjCPKB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbjCPKBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:01:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5123D96F32
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678960784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ylFiBZu5OGGbsmvOePqsTG1AwPkUkSz655S/TiVEnq8=;
        b=CFoyOQaDBFG33BivQvACNWLCJInJW0gcDxJzl5PMAQ4Jut6dcfS3lvj3J0horTcAcuQlZC
        U34MqTBfqoLayiZ7w2fAtenl6222ZpNBSSEH2V4Mr6o0gqV0Ty57myVQ9B2yLgDh/idHb6
        Gu0Dj72TvyfDa50hmZalGDNiOSTlB4Y=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-NyzOIOK6NNysB9NuIn5WuA-1; Thu, 16 Mar 2023 05:59:42 -0400
X-MC-Unique: NyzOIOK6NNysB9NuIn5WuA-1
Received: by mail-ed1-f70.google.com with SMTP id es16-20020a056402381000b004fa3e04c882so2260475edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 02:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678960781;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylFiBZu5OGGbsmvOePqsTG1AwPkUkSz655S/TiVEnq8=;
        b=aiO+fb5zwMcL6sfdYDsibtdMpOeIdhFMGJ9+8eqzBGATu46MuN1Si/MD3I3fpqg5+K
         OAkiltogqp3hb3dH4av6iRvhrJfn3xVka3tWB+ufYFKxcQrMjBlBJ6kXhPntMVooa4Tp
         Edm18oeGkusbqrX4e+BSR4n4ClkOlsUpWhCfGbmkOtoHU+ku80povcoXPmglTY0VS0ex
         EG6Cyvc0Rebza1Nf10NYNSTnZEJgpluTaEtw6/S2BdQNC7rXZwTRH9ZIb+jpai5vSusp
         glqrJo9T4IIWdQWIAGfTc5RIjdgSJamiJKfBwUOghOW5lpb0ttih8NoQCv7ePVypZORY
         OobA==
X-Gm-Message-State: AO0yUKWNygeFHd7gexyYqTXqnoww669iidjH4amoNyKGxXx1WBT5EbwU
        7SMPwnooh4vdPnzHQ3ZVl+Aw+SBSUjlWnMr1pnUT+uIFdahbI2hT7kyOVjZGbXGdGGrWY2dOZyR
        uuQp2pQiz0386quU8cQFpGWiq
X-Received: by 2002:a17:907:205b:b0:88b:23bb:e61f with SMTP id pg27-20020a170907205b00b0088b23bbe61fmr9603537ejb.25.1678960781135;
        Thu, 16 Mar 2023 02:59:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set8Sz0SFHs/UmJuu26j1Jjqszhy38U54HxyUuMT5NiJshmkPZYUQeLPKwBIccXNADpsBGOK6pg==
X-Received: by 2002:a17:907:205b:b0:88b:23bb:e61f with SMTP id pg27-20020a170907205b00b0088b23bbe61fmr9603512ejb.25.1678960780887;
        Thu, 16 Mar 2023 02:59:40 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id r24-20020a50d698000000b004af71e8cc3dsm3584347edi.60.2023.03.16.02.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 02:59:40 -0700 (PDT)
Message-ID: <f45c26ae-865b-b7b6-0f2a-5906d9c0a349@redhat.com>
Date:   Thu, 16 Mar 2023 10:59:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 6/8] platform/x86/intel/ifs: Implement Array BIST test
Content-Language: en-US, nl
To:     "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        gregkh@linuxfoundation.org, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        thiago.macieira@intel.com, athenas.jimenez.gonzalez@intel.com,
        sohil.mehta@intel.com
References: <20230214234426.344960-1-jithu.joseph@intel.com>
 <20230301015942.462799-1-jithu.joseph@intel.com>
 <20230301015942.462799-7-jithu.joseph@intel.com>
 <628e092c-793e-96ce-71f5-80392ad69569@redhat.com>
 <9dde72aa-a28d-2b0e-7b90-6b1996dbf202@intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9dde72aa-a28d-2b0e-7b90-6b1996dbf202@intel.com>
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

On 3/13/23 17:37, Joseph, Jithu wrote:
> Hans,
> 
> Thank-you very much for the review.
> 
> On 3/13/2023 9:24 AM, Hans de Goede wrote:
> 
> 
>>>  
>>> +#define SPINUNIT 100 /* 100 nsec */
>>> +static atomic_t array_cpus_out;
>>
>> This variable is only inc-ed + read, it is never reset to 0
>> so the "while (atomic_read(t) < all_cpus)"
>> check only works for the first test run.
>>
> 
> It is reset to zero as annotated below. Let me know if this doesn't address your concern.

Ah, I somehow missed that despite looking for it twice, yes that is fine.

>> Also even static atomic_t variables must be initialized, you cannot
>> assume that using using zeroed mem is a valid value for an atomic_t.
>>
>> And this is also shared between all smt pairs, so if 2 "real"
>> CPU cores with both 2 sibblings are asked to run IFS tests at
>> the same time, then array_cpus_out will get increased 4 times
>> in total, breaking the wait_for_sibbling loop as soon as
>> the counter reaches 2, so before the tests are done.
> 
> Only one IFS test is allowed at a time. This is done using "ifs_sem" defined in sysfs.c

Ah I see.

After taking a closer look I do see one unrelated issue with this patch
sysfs.c: run_test_store() does:

        if (!ifsd->loaded)
                rc = -EPERM;
        else
                rc = do_core_test(cpu, dev);

But AFAICT the loaded check really only applies to the first (intel_ifs_0 device) test type and the 
Array BIST test should work fine when loaded is false.

So I think that the if (!ifsd->loaded) error check should be moved to 
ifs_test_core() ?

Regards,

Hans


> 
> ...
> 
>>> +static void ifs_array_test_core(int cpu, struct device *dev)
>>> +{
>>> +	union ifs_array command = {};
>>> +	bool timed_out = false;
>>> +	struct ifs_data *ifsd;
>>> +	unsigned long timeout;
>>> +
>>> +	ifsd = ifs_get_data(dev);
>>> +
>>> +	command.array_bitmask = ~0U;
>>> +	timeout = jiffies + HZ / 2;
>>> +
>>> +	do {
>>> +		if (time_after(jiffies, timeout)) {
>>> +			timed_out = true;
>>> +			break;
>>> +		}
>>> +		atomic_set(&array_cpus_out, 0);
> 
> The above line is where the zero initialization happens before every test.
> 
>>> +		stop_core_cpuslocked(cpu, do_array_test, &command);
>>> +
>>> +		if (command.ctrl_result)
>>> +			break;
>>> +	} while (command.array_bitmask);
>>> +
>>> +	ifsd->scan_details = command.data;
>>> +
>>> +	if (command.ctrl_result)
>>> +		ifsd->status = SCAN_TEST_FAIL;
>>> +	else if (timed_out || command.array_bitmask)
>>> +		ifsd->status = SCAN_NOT_TESTED;
>>> +	else
>>> +		ifsd->status = SCAN_TEST_PASS;
>>> +}
> 
> Jithu
> 

