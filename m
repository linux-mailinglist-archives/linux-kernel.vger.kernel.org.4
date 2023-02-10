Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDB06920C8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 15:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjBJOZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 09:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjBJOZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 09:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CDB5C49A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:24:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676039098;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=odE0ulKx/K2tP8WDUPs0emv0tzyNVjbbkK3x7rqNiF0=;
        b=Hlp/0HFUAB1ZvNeQ4zhMDwOMBW4i9LnsL1ncGEolLCyvkt6prKAsxWrbzg4CRcKwwpdC6+
        DXy+N9bkHC+h85dzr8Vft2eXUpYXITEaLBX3S/+zY/t9wunVWicFsTnEKPuABh1Kfmfncy
        xGSmwwzdVuDaa3ON3BgFizaaF8gEBSw=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-218-tsWTRTUxP_KFnyvz5i85sw-1; Fri, 10 Feb 2023 09:24:57 -0500
X-MC-Unique: tsWTRTUxP_KFnyvz5i85sw-1
Received: by mail-ej1-f70.google.com with SMTP id fy3-20020a1709069f0300b008a69400909fso3684048ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 06:24:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=odE0ulKx/K2tP8WDUPs0emv0tzyNVjbbkK3x7rqNiF0=;
        b=Dyv6k73cq4EGcijvsH4QaCzwhuEiUR/xSz+Kvx1bMDI8fqviUvXuy1PRb8UoxlyPES
         VH4PdGGuGovyZQNjHMGLni2PacVUScv3eH3I+Rs5lCiQjpVJMoiFb48Ylg8ifY0W6keT
         d4zgp33pGcho+FxbVcOcSBvOP8Wmoik+Ehekou4EHQOBFbCRu22/ohaOwQnRHoI54orO
         k5xYSiGp2kfzlgwazhXdJc89oGRs/7woR451NWklsAQYPGY18yDQAby1iDO/IjOSbLW1
         j7F/9npTlJcQNIxHCJhfm9iKahcb8zZWOgdib9JakDkvgPNxvgWKYlFrvcztxS58vCaJ
         C0TA==
X-Gm-Message-State: AO0yUKXmgv5/owZGyGNIoxXUTQTolKaSwaE+BUneAE1Fp37Kw4CokEyT
        bAAr8QMADKVshW6/HN/6WFl9yO5/EYYluUVxn50xZK7Gkth3xmS+U5b9SwZQioLjq887fGbqQv6
        gyyhs23V6JF9RIXYkMd6s0fYi
X-Received: by 2002:a17:906:ecb0:b0:84d:4325:7f7a with SMTP id qh16-20020a170906ecb000b0084d43257f7amr15326647ejb.65.1676039095922;
        Fri, 10 Feb 2023 06:24:55 -0800 (PST)
X-Google-Smtp-Source: AK7set+zswQt13cn5YUp6iD0g7CxsUnSmZHstm6R8s9QSMmuUng9vCJInctZAL+ONFhUkP6+Wxq/Tg==
X-Received: by 2002:a17:906:ecb0:b0:84d:4325:7f7a with SMTP id qh16-20020a170906ecb000b0084d43257f7amr15326632ejb.65.1676039095692;
        Fri, 10 Feb 2023 06:24:55 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id c10-20020a170906694a00b00856ad9108e7sm2436134ejs.70.2023.02.10.06.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 06:24:55 -0800 (PST)
Message-ID: <5f413b79-cc1a-0479-6d15-3f89cc2ea514@redhat.com>
Date:   Fri, 10 Feb 2023 15:24:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/7] Add TPMI support
Content-Language: en-US, nl
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
 <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
 <6f51fcb89d0f1aad5d4f4e2cacb407a620454886.camel@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6f51fcb89d0f1aad5d4f4e2cacb407a620454886.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/10/23 09:04, srinivas pandruvada wrote:
> Hi Hans,
> 
> On Mon, 2023-02-06 at 13:49 +0100, Hans de Goede wrote:
>> Hi,
>>
>> On 2/2/23 02:07, Srinivas Pandruvada wrote:
>>
>>
> [...]
> 
>> Thank you for your patch-series, I've applied the series to my
>> review-hans branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
>>
>>
> Thanks for the help here.

You're welcome.

>> Note it will show up in my review-hans branch once I've pushed my
>> local branch there, which might take a while.
>>
>> Once I've run some tests on this branch the patches there will be
>> added to the platform-drivers-x86/for-next branch and eventually
>> will be included in the pdx86 pull-request to Linus for the next
>> merge-window.
> I guess this will appear in 6.3 merge window.

Yes I plan to push my review-hans branch to for-next shortly.

> Can I post next set of patches (targeted for 6.4)?

Yes please, I'm not sure if I can review them next week,
but that will also give other people a chance to take
a look and comment so getting them out there would be good.

Regards,

Hans




>>> Srinivas Pandruvada (7):
>>>   platform/x86/intel/vsec: Add TPMI ID
>>>   platform/x86/intel/vsec: Enhance and Export intel_vsec_add_aux()
>>>   platform/x86/intel/vsec: Support private data
>>>   platform/x86/intel: Intel TPMI enumeration driver
>>>   platform/x86/intel/tpmi: Process CPU package mapping
>>>   platform/x86/intel/tpmi: ADD tpmi external interface for tpmi
>>> feature
>>>     drivers
>>>   MAINTAINERS: Add entry for TPMI driver
>>>
>>>  MAINTAINERS                         |   6 +
>>>  drivers/platform/x86/intel/Kconfig  |  13 +
>>>  drivers/platform/x86/intel/Makefile |   4 +
>>>  drivers/platform/x86/intel/tpmi.c   | 415
>>> ++++++++++++++++++++++++++++
>>>  drivers/platform/x86/intel/vsec.c   |  21 +-
>>>  drivers/platform/x86/intel/vsec.h   |   6 +
>>>  include/linux/intel_tpmi.h          |  30 ++
>>>  7 files changed, 490 insertions(+), 5 deletions(-)
>>>  create mode 100644 drivers/platform/x86/intel/tpmi.c
>>>  create mode 100644 include/linux/intel_tpmi.h
>>>
>>
> 

