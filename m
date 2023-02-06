Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8193A68BD5C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 13:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjBFMzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 07:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjBFMzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 07:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E154222CF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 04:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675688105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UX1daTOnFKuVGY1erJNvOV1r3LJAnkWkwfFQVfdnZmc=;
        b=KDeyCPV/ui0Xvm0+HroWy/XQPnPJsSkGfEgJzArPEtQBDE+ugkWSZUE6arjXUHib1/8UY0
        zekKf2qMnXYk6SQSBjxvK2VNb/HB12AOuZQ5GGFZgfZv1Y67ChMEi17jDMYMElfhI9ASp8
        etcZzgnYOhAg5AjPout1SFciP+buPSs=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-652-aculSU8HNd2epFkM8HMI4Q-1; Mon, 06 Feb 2023 07:55:04 -0500
X-MC-Unique: aculSU8HNd2epFkM8HMI4Q-1
Received: by mail-ed1-f69.google.com with SMTP id w6-20020aa7d286000000b004aaa832ef36so2070202edq.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 04:55:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UX1daTOnFKuVGY1erJNvOV1r3LJAnkWkwfFQVfdnZmc=;
        b=5UmzhfHMWO/9gL2KRPL3M+CIsmCMGN8atluoLrZzmSav4rYIo0chEMm6kDpRG3AOoO
         8ECbvPutlVgZcqSCuUyOQD3aMij/I83O1vrMXkuYPhhgywONg6kLdHFCbLVFJzCjil+B
         6nuaTAgLUovUnO4mMjADmO/vIcekKaI3dA4Ubyx2IZgZprrxdgkxowVhBZ53gZCF4sJJ
         cmv1dHDtn6yNKRUASCTpcxwU6wuFNGWJNLXPzYLWTUwG3xFvHpqaXcJNSLTUcNRaV20V
         htC+HOrVVIpPdcBEVMUJoJWfARTqcNugzBDKVAK4SF8bZvkKYNjtWsoLxzp8JauWnocG
         he8w==
X-Gm-Message-State: AO0yUKU6XCrEwJOY8gSR6s5iZYTFALrhkegamljljID81CeLPEJWQGqQ
        ZOtuMkiuneFM2VQ0KilpXSYKk49cCykpKQHEjtrcpj2VStxlm8PuQKvXl8MvMM8qV2dYkPEPiPt
        JeCufj0qdG9ny1Hm2N3tDS69q
X-Received: by 2002:a17:906:5658:b0:878:7b5c:3811 with SMTP id v24-20020a170906565800b008787b5c3811mr18145536ejr.42.1675688102742;
        Mon, 06 Feb 2023 04:55:02 -0800 (PST)
X-Google-Smtp-Source: AK7set8BAMTxyg8K7m5+aY3GW33lxao9oRWSvbibbghTiKRaybEKgPTSyk9g9sXLTrfSGV9maPvHIw==
X-Received: by 2002:a17:906:5658:b0:878:7b5c:3811 with SMTP id v24-20020a170906565800b008787b5c3811mr18145526ejr.42.1675688102586;
        Mon, 06 Feb 2023 04:55:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id lv3-20020a170906bc8300b00883410a786csm5350194ejb.207.2023.02.06.04.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 04:55:02 -0800 (PST)
Message-ID: <14c1201b-7caf-e096-624c-e5ec3597d67f@redhat.com>
Date:   Mon, 6 Feb 2023 13:55:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 0/7] Add TPMI support
Content-Language: en-US, nl
From:   Hans de Goede <hdegoede@redhat.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230202010738.2186174-1-srinivas.pandruvada@linux.intel.com>
 <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
In-Reply-To: <918ac0c5-9f35-0099-5be8-6dbc72aa88e9@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2/6/23 13:49, Hans de Goede wrote:

> Thank you for your patch-series, I've applied the series to my
> review-hans branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=review-hans
> 
> Note it will show up in my review-hans branch once I've pushed my
> local branch there, which might take a while.
> 
> Once I've run some tests on this branch the patches there will be
> added to the platform-drivers-x86/for-next branch and eventually
> will be included in the pdx86 pull-request to Linus for the next
> merge-window.

One thing which I did notice, which is a pre-existing problem
is that the IDA accesses in drivers/platform/x86/intel/vsec.c
are not protected by any locking.

This is likely ok for now because there is only 1 PCI device
per type of ida and the enumeration of the vsec devices
under the PCI device is done in a single loop, so all
IDA accesses are single threaded atm.

But still IMHO it would be good to protect the IDA accesses
(ida_alloc() / ida_free()) with a mutex to protect against
any future races.

I think that a single global static mutex inside
drivers/platform/x86/intel/vsec.c to protect the
ida calls there should suffice for this.

Regards,

Hans



