Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FCFB61A6B8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 02:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiKEBn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 21:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiKEBnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 21:43:25 -0400
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38411DFD;
        Fri,  4 Nov 2022 18:43:22 -0700 (PDT)
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4N40d01Z6Wz9sLw;
        Sat,  5 Nov 2022 02:43:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1667612596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=q9MpPY/CCOcTDSed4LlfWRh5Fv+iRkBbMnta7aKGGA0=;
        b=MNsTVvxfb55Rm3kRQ9vVwESFU8GJc987eq4prXHUJG4lDYkKXfCae25Jy3Y7hUQPCf+HFD
        3ggPmtG/TJAtOiDLFfj1BpIait33ulfCKkPHUBRBHTQzWkH4PiJKMcktZjoW8v36qqnL/3
        Idd+RFxJ0pkdVIplyHYOQ9pdoBQm2YzIQ0aIer2vWkI/7E7Fdi7yJ5XMTXMqcsHd82oycx
        SEvfwWAyr2DaeOyZAZvQowzX31LuOBkiziKLaLl27krerPjGNMP7tJEnUWFf+rBJJ2i6/C
        O+mP/aPwEcn8BJ0Klilq13Y77VX3D/gBfhF0ZVHVdP8RKJamr4WVbsjPHQck0w==
Message-ID: <c33ec3b6-0e5b-5bb2-1793-c23406c68b40@sylv.io>
Date:   Sat, 5 Nov 2022 02:43:11 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/1] hwmon: (pmbus) Add regulator supply into macro
To:     Guenter Roeck <linux@roeck-us.net>,
        Zev Weiss <zev@bewilderbeest.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <cover.1645437439.git.sylv@sylv.io>
 <58f2ff7b90233fad3d7ae2e9d66d5192e2c1ac01.1645437439.git.sylv@sylv.io>
 <20220222165104.GA255067@roeck-us.net>
 <Y2WShmSmnEjpgVEE@hatter.bewilderbeest.net>
 <20221104234250.GB2443898@roeck-us.net>
Content-Language: en-US
From:   Marcello Sylverster Bauer <sylv@sylv.io>
In-Reply-To: <20221104234250.GB2443898@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 4N40d01Z6Wz9sLw
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/5/22 00:42, Guenter Roeck wrote:
> On Fri, Nov 04, 2022 at 03:30:30PM -0700, Zev Weiss wrote:
>> On Tue, Feb 22, 2022 at 08:51:04AM PST, Guenter Roeck wrote:
>>> On Mon, Feb 21, 2022 at 12:09:56PM +0100, Marcello Sylvester Bauer wrote:
>>>> Add regulator supply into PWBUS_REGULATOR macro. This makes it optional
>>>> to define a vin-supply in DT. Not defining a supply will add a dummy
>>>> regulator supply instead and only cause the following debug output:
>>>>
>>>> ```
>>>> Looking up vin-supply property in node [...] failed
>>>> ```
>>>>
>>>> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
>>> Applied to hwmon-next. That should give it some time to mature,
>>> and we can pull or modify it if it causes any problems.
>>>
>> Wish I'd caught this sooner, but unfortunately I've just discovered that
>> this does in fact cause breakage on my systems -- having regulator-dummy set
>> as a supply on my PMBus regulators (instead of having them as their own
>> top-level regulators without an upstream supply) leads to enable-count
>> underflow errors when disabling them:
>>
>>      # echo 0 > /sys/bus/platform/devices/efuse01/state
>>      [  906.094477] regulator-dummy: Underflow of regulator enable count
>>      [  906.100563] Failed to disable vout: -EINVAL
>>      [  136.992676] reg-userspace-consumer efuse01: Failed to configure state: -22
>>
>> A simple revert solves the problem for me, but since I'm honestly a little
>> unclear on the intent of the patch itself I'm not sure what a revert might
>> break and hence I don't know if that's necessarily the right fix.  Marcello
>> (or others), any thoughts?
Oh, my bad. I thought this makes it optional to add a supply without 
having a negative effect.
Reverting this patch makes sense, but I'm not sure how else to integrate 
this.

Thanks,
Marcello

> Revert now, ask questions later. I'll send a patch.
>
> Guenter
>
>>
>> Thanks,
>> Zev
>>
