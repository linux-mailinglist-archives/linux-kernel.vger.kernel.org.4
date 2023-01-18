Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75C2671891
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbjARKIs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjARKHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:07:54 -0500
Received: from freundtech.com (freundtech.com [IPv6:2a01:4f8:c17:2d66::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8567656CF;
        Wed, 18 Jan 2023 01:13:24 -0800 (PST)
Received: from [IPV6:2a02:8071:2b80:7760:fecd:7e78:31fb:a087] (unknown [IPv6:2a02:8071:2b80:7760:fecd:7e78:31fb:a087])
        by freundtech.com (Postfix) with ESMTPSA id C554C1EBBBE;
        Wed, 18 Jan 2023 10:13:22 +0100 (CET)
Message-ID: <e2b16837-cc05-4f04-f58e-a8315ab85321@freund.io>
Date:   Wed, 18 Jan 2023 10:13:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] HID: amd_sfh: Add support for tablet-mode-switch
 sensor
Content-Language: en-US
To:     Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Basavaraj Natikar <basavaraj.natikar@amd.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Luke D. Jones" <luke@ljones.dev>, Ivan Dovgal <iv.dovg@gmail.com>
References: <20221218214723.14735-1-adrian@freund.io>
 <nycvar.YFH.7.76.2301180948450.1734@cbobk.fhfr.pm>
From:   Adrian Freund <adrian@freund.io>
In-Reply-To: <nycvar.YFH.7.76.2301180948450.1734@cbobk.fhfr.pm>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/23 09:49, Jiri Kosina wrote:
> On Sun, 18 Dec 2022, Adrian Freund wrote:
>
>> This patch adds support for the tablet mode switch sensors on
>> convertible devices where that sensor is managed by AMD SFH, like the
>> Asus Flow X13 and the Lenovo ThinkPad L13 Yoga Gen2 (AMD).
>>
>> Co-developed-by: Ivan Dovgal <iv.dovg@gmail.com>
>> Signed-off-by: Ivan Dovgal <iv.dovg@gmail.com>
>> Co-developed-by: Luke D. Jones <luke@ljones.dev>
>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>> Signed-off-by: Adrian Freund <adrian@freund.io>
> Basavaraj, could you please review this? Thanks,
>
I think this doesn't need a review right now. I recently found some big 
problems with the patch recently and am working on an updated version. I 
think reviewing once I send v3 should be enough.

In short: This patch generates nonsensical HID messages that don't even 
contain the sensor state.
It still makes the tablet-mode-switch work on some but not all devices 
due to a mechanism I don't fully understand yet. Somehow ACPI devices 
that previously did nothing suddenly work with this patch and are then 
getting picked up by various platform drivers depending on the device. 
This driver however doesn't properly handle the actual data directly 
from the sensor.

---
Adrian
