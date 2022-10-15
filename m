Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8B5FFC83
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 00:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJOW1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Oct 2022 18:27:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiJOW1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Oct 2022 18:27:17 -0400
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C494003D;
        Sat, 15 Oct 2022 15:27:15 -0700 (PDT)
Message-ID: <5b3c2ccb-4e77-5707-d41a-5a91bd677c8f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1665872833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jyH/LzULF59OH5GGYkSCeFkBRluBAuYmG36QDeuLDGA=;
        b=ItVPqsA8nPWYRcgRztZnKGeigQevIb9NNMeUq1fNX+x4UrWR9/a/r4xf9hM1/M/UN/A0FE
        J0jjez2AWgJo3JWhZKhTKzlqPa+y42b15ojkvYOEoa+ulIkQTOuTTRZJIw0bPYje9gkI6f
        tYhoEvKW6MGKkq4vtGWr/i4EaGVLM5Y=
Date:   Sat, 15 Oct 2022 16:27:12 -0600
MIME-Version: 1.0
Subject: Re: [PATCH v2 0/3] Bitmap percentage flushing
Content-Language: en-US
To:     John Stoffel <john@stoffel.org>
Cc:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, jonathan.derrick@solidigm.com,
        jonathanx.sk.derrick@intel.com,
        Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
References: <20221013224151.300-1-jonathan.derrick@linux.dev>
 <25417.53318.731340.683540@quad.stoffel.home>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Jonathan Derrick <jonathan.derrick@linux.dev>
In-Reply-To: <25417.53318.731340.683540@quad.stoffel.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/14/2022 3:10 PM, John Stoffel wrote:
>>>>>> "Jonathan" == Jonathan Derrick <jonathan.derrick@linux.dev> writes:
> 
>> This introduces a percentage-flushing mechanism that works in-tandem to the
>> mdadm delay timer. The percentage argument is based on the number of chunks
>> dirty (rather than percentage), due to large drives requiring smaller and
>> smaller percentages (eg, 32TB drives-> 1% is 320GB).
> 
> I've been reading and re-reading this and I still don't understand
> what you're saying here.  You say you're adding a percentage based
> mechanism, but then you say it's based on chunk counts, not
> percentages.  I think you need to clean this up and re-word it.> 
> Maybe you're trying to say that you only take a percentage of the
> available write bandwidth per second or something like that? 
I'll adjust it to chunk-count-based in the cover letter and make sure it
specifies bandwidth. I figured the chunk-count-based was a good way to
cover the desired percentage-based feature [1]. 

[1] https://elixir.bootlin.com/linux/latest/source/drivers/md/md-bitmap.c#L16


> 
> 
>> This set hopes to provide a way to make the bitmap flushing more consistent. It
>> was observed that a synchronous, random write qd1 workload, could make bitmap
>> writes easily become almost half of the I/O. And in similar workloads with
>> different timing, it was several minutes between bitmap updates. This is too
>> inconsistent to be reliable.
> 
>> This first and second patches adds the flush_threshold parameter. The default
>> value of 0 defines the default behavior: unplugging immediately just as before.
>> With a flush-threshold value of 1, it becomes more consistent and paranoid,
>> flushing on nearly every I/O, leading to a 40% or greater situation. From
> 
> What situation?  Please be more clear here.  

40% or more of given workload I/Os being bitmap flushes.
Will be more clear in v3

> 
>> there, the flush_threshold can be defined higher for those situations where
>> power loss is rare and full resync can be tolerated.
> 
>> The third patch converts the daemon worker to an actual timer. This makes it
>> more consistent and removes some ugly code.
> 
>> Jonathan Derrick (3):
>>   md/bitmap: Add chunk-threshold unplugging
>>   md/bitmap: Add sysfs interface for flush threshold
>>   md/bitmap: Convert daemon_work to proper timer
> 
>>  Documentation/admin-guide/md.rst |  5 ++
>>  drivers/md/md-bitmap.c           | 98 +++++++++++++++++++++++++-------
>>  drivers/md/md-bitmap.h           |  4 +-
>>  drivers/md/md.c                  |  9 ++-
>>  drivers/md/md.h                  |  2 +
>>  5 files changed, 93 insertions(+), 25 deletions(-)
> 
>> -- 
>> 2.31.1
> 
