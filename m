Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9075A6D4651
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 15:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjDCN51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 09:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232749AbjDCN5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 09:57:23 -0400
Received: from p3plwbeout26-04.prod.phx3.secureserver.net (p3plsmtp26-04-2.prod.phx3.secureserver.net [216.69.139.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3776E1BF62
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 06:57:18 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.143])
        by :WBEOUT: with ESMTP
        id jKgOpwxkjJzPrjKgPpDhO5; Mon, 03 Apr 2023 06:57:17 -0700
X-CMAE-Analysis: v=2.4 cv=OJjiYQWB c=1 sm=1 tr=0 ts=642adb3d
 a=EhJYbXVJKsomWlz4CTV+qA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=IkcTkHD0fZMA:10 a=dKHAf1wccvYA:10 a=v52JICOvAAAA:20
 a=4ao_m9BdAAAA:8 a=WCF8PDb0v4YLkHPhQUUA:9 a=QEXdDO2ut3YA:10
 a=MsgbvsnFcLE8lbaOJhbn:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  jKgOpwxkjJzPr
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=[192.168.178.33])
        by smtp03.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1pjKgA-00005A-Od; Mon, 03 Apr 2023 14:57:05 +0100
Message-ID: <ab1c2512-7dd6-5246-7213-077022a85c2f@squashfs.org.uk>
Date:   Mon, 3 Apr 2023 14:57:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 1/2] block: Rework bio_for_each_segment_all()
To:     Kent Overstreet <kent.overstreet@linux.dev>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        willy@infradead.org, axboe@kernel.dk,
        Ming Lei <ming.lei@redhat.com>
References: <20230327174402.1655365-1-kent.overstreet@linux.dev>
 <20230327174402.1655365-2-kent.overstreet@linux.dev>
 <52a5bd5c-d3a1-71d7-e1e5-7965501818bd@squashfs.org.uk>
 <ZCXNDQ6Eslhj+9g5@moria.home.lan>
 <4753802a-685f-ab56-fed2-22d6eb4cfccd@squashfs.org.uk>
 <5ab59623-4317-5aff-5173-d7285b5b224c@squashfs.org.uk>
 <ZCeW6j44aHGI/v5Q@moria.home.lan>
From:   Phillip Lougher <phillip@squashfs.org.uk>
In-Reply-To: <ZCeW6j44aHGI/v5Q@moria.home.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfK3f+MDVXoFRtin485DFFzlIRVdxg0qVA+GWjA05vGW2VyzcJIPoCK0uGIhCXDqApniUXrj2Tdan4gdcgZiw474qLG22fi4KZGfdS91yTNjLwLY6d3wY
 rWvKpfFFzFcsYMhfQj/g4rBr52mOMNpMCDxNC2o45p0loZV5pZAmxC8+JGkj/1ENDO45wb1Yark8w2DfGVgkV34ggESOTjglpFQPEgKkFUHsAvoT7DvFFoow
 SiM+O2gImWKVlb/yvHJkjQ==
X-Spam-Status: No, score=-1.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 03:28, Kent Overstreet wrote:
> On Fri, Mar 31, 2023 at 02:10:15AM +0100, Phillip Lougher wrote:
>> On 30/03/2023 19:59, Phillip Lougher wrote:
>>> On 30/03/2023 18:55, Kent Overstreet wrote:
>>>> On Wed, Mar 29, 2023 at 05:50:27PM +0100, Phillip Lougher wrote:
>>>>> There is a problem with the above code, on testing I get the following
>>>>> results:
>>>>>
>>>>> Index 78018785329, offset 49, bvec.bv_len 1024: In same bio,
>>>>> metadata length
>>>>> 32780
>>>>
>>>> Could you share how you're doing your testing? I set up a basic test
>>>> (created images using every compression type, tested reading them) and
>>>> so far I'm not able to reproduce this.
>>>
>>> I use a very large Squashfs file that triggers the edge case.
>>>
>>> That is too big to post, and so I'll see if I can artifically generate
>>> a small Squashfs filesystem that triggers the edge case.
>>>
>>> Phillip
>>>
>>>
>>
>> Hi,
>>
>> This is a Google drive link to a file that triggers the issue.
>>
>> https://drive.google.com/file/d/1-3-a1BKq62hZGQ6ynioreMSWFMuCV9B4/view?usp=sharing
>>
>> To reproduce the issue
>>
>> % mount -t squashfs <the file> /mnt -o errors=panic
>>
>> then either one of the following will produce a panic
>>
>> % ls /mnt
>> % find /mnt -type f | xargs wc > /dev/null
> 
> Appears to be fixed now - updated version of the patchset is at
> https://evilpiepirate.org/git/bcachefs.git bio_folio_iter
> 
> Can you confirm, then I'll mail out the updated series?

Thw updated patch-set fixes the issues seen.

Phillip

