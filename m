Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3FD631919
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 05:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiKUEEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 23:04:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiKUEEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 23:04:45 -0500
Received: from domac.alu.hr (domac.alu.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A724526111
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 20:04:43 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 576A0604F0;
        Mon, 21 Nov 2022 05:04:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669003481; bh=1MW333K3VDN0Co8XYMSRHiHHGVR2b/CHRQ8hKCJmTtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Kpk/NqjBkgxazdd7tjp6tmGIkEAQWXIgC3DUiiX7jzEFy6z7pmv4hOpjVs8/f1d2m
         WUEyWVGIrsZu7oRxK/kqliGtkkAEzN8iHK/qHtGAmqg0F6TaqU5ahthotBRoLSMTHt
         FqUz5R4FerXVjoPHbE8jGl58xa3G+LkVUr4Ya8/YuklupGNR0TsH0/AekGMiXNjTjs
         5sfiUiK82mZT7RlU6UMDMnshec+hUwdteMcvGYi5u69tG7F1zTl2YYcyCTNxE6iOvu
         gVbgKgIoJiwoLfaY2Cf1Zd1Bk3Y2WwWTWGe6R/NMZ6Cx5sJSsvzV6KcTJ+L5r7Lnj2
         Bjjgg/72V3DtQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id dnE-pQNgxT5p; Mon, 21 Nov 2022 05:04:38 +0100 (CET)
Received: from [192.168.0.12] (unknown [188.252.198.198])
        by domac.alu.hr (Postfix) with ESMTPSA id 7CF9F604ED;
        Mon, 21 Nov 2022 05:04:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1669003478; bh=1MW333K3VDN0Co8XYMSRHiHHGVR2b/CHRQ8hKCJmTtQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=aJv09ULiXx7q/8DU017t8ZI9elSegSenpdFhQJkg7iluUNHxzee4gkgUyNEdOh5cp
         TfPIUCu951t1GXRAoEVBGR1Ybts4uRk215uMk0jZRXsGwF7RZN+U7VLN0pnE7vFKcz
         GIW7dzmOD7RiJcJl2KX9KX/8VDgQGZa5ldLzozSR3vxOceJrNkjXr5WWjoZdYPh+NX
         a2BiySMJ5aRbvss8lbscr86igbTJKf3+tDR1t2MSF6brAIhFY2L/HL+heehC8Vkbg0
         0y53j4fKtJ5krkNVvgqyNIv9u35zwZCaPzDxnhuWm0Msnvn+CeVkAwrjrUlcktAmuX
         BLdS8+0tJC/2g==
Message-ID: <8c9eb87b-5623-730a-5cf6-72d831ef797a@alu.unizg.hr>
Date:   Mon, 21 Nov 2022 05:04:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: BUG: BISECTED: in squashfs_xz_uncompress() (Was: RCU stalls in
 squashfs_readahead())
Content-Language: en-US
To:     paulmck@kernel.org
Cc:     Phillip Lougher <phillip@squashfs.org.uk>,
        LKML <linux-kernel@vger.kernel.org>, phillip.lougher@gmail.com,
        Thorsten Leemhuis <regressions@leemhuis.info>, elliott@hpe.com
References: <9697fcf5-4213-3d5e-176a-e82d4bd07870@alu.unizg.hr>
 <eac8af79-8936-f845-c8dd-c63ebf0d5e81@alu.unizg.hr>
 <02877aee-8c05-6534-8a91-94ba366d0276@squashfs.org.uk>
 <20221118155534.GJ4001@paulmck-ThinkPad-P17-Gen-1>
 <dd430080-774b-1cba-1758-2bf92cb1acac@alu.unizg.hr>
 <20221120175016.GC4001@paulmck-ThinkPad-P17-Gen-1>
 <8e62a31f-3ef8-71ec-6181-2afa56eeb5db@alu.unizg.hr>
 <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20221120192150.GE4001@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20. 11. 2022. 20:21, Paul E. McKenney wrote:

>> And what about the Mr. Robert Elliott's observation about calling conf_recshed()?
>>
>>> How big can these readahead sizes be? Should one of the loops include
>>> cond_resched() calls?
>>
>> That is IMHO better than allowing 21000 milisecond stalls on a core (or more of them).
>>
>> I don't think it is correct to stay in kernel mode for more than an timer unit
>> without yielding the CPU. It creates stalls in multimedia and audio (chirps like on scratched
>> CD-ROMs). This is especially noticeable with a KASAN build.
>>
>> Since Firefox and most snaps are using squashfs as compressed ROFS, the Firefox appears
>> to perform poorer since snaps are introduced than Chrome.
>>
>> IMHO, if we want something like realtime and multimedia processing (which is the specific
>> area of my research), it seems that anything trying to hold processor for 21000 ms (21 secs)
>> is either buggy or deliberately malicious. 20 ms is quite enough of work for a threat
>> in one allotted timeslot.
>>
>> I do not agree with Mr. Lougher's observation that I am thrashing my laptop. I think that
>> a system has to endure stress and torture testing. I was raised on Digital MicroVAX systems
>> on Ultrix which compiled lab at a time in memory that would today sound funny. :)
> 
> I personally think that it would be great if you were to work to decrease
> the Linux kernel's latency.  Doing so would not be fixing a regression,
> but I personally would welcome it.  Others might have different opinions,
> but please do CC me on any resulting patches.
> 
> And I will see your MicroVAX and raise you a videogame written on a
> PDP-12 whose fastest instruction executed in 1.6 microseconds (-not-
> nanoseconds!).  ;-)

I'm afraid that I would lose in Far Cry miserably if my cores
decided to all lock up for 21 secs. :-(

> You can can see a couple of people playing the game on a PDP-12 in
> a computer museum: https://www.rcsri.org/collection/pdp-12/
> 
>> Besides, this is the very idea behind the MG-LRU algorithm commit, to test eviction of
>> memory pages in the system with heavy load and low on memory.
>>
>> I will probably test your commits, but now I have to do my own evening ritual, unwinding,
>> and knowledge and memory consolidation (called "sleep").
> 
> And yes, sleep is often one of the best debugging tools available.
> 
>> I appreciate your lots of commits on the kernel.org and I hope I do not sound like
>> I am thinking you are a village idiot :(
>>
>> I am trying to adhere to the Code of Conduct with mutual respect and politeness.
> 
> Skepticism is not necessarily a bad thing, especially given that I
> am not immune from errors and confusion.  Me, I just thought you were
> forcefully reporting the regression, so I forcefully pointed you at the
> fix for that regression.
> 
> Again, I have absolutely no objection to your improving the kernel's
> response time.

This is at present just the wishful thinking, as I lack your 30 years of
experience with the kernel and RCU update system. I am only beginning to realise
why it is more efficient than the traditional locking, and IMHO it should
avoid locking up cores instead of increasing the number of complaints.

But even if the Linux kernel source is magically "memory mapped" into my
mind, I still do not see how it could be done. My Linux kernel learning curve
had not yet got that up, but I have no doubts that it is designed by
Intelligent Designers who are very witty people, and not village idiots ;-)

>> I know that the Linux kernel is about 30 million lines by now, and by the security experts
>> we should expect 30,000 bugs in such a solid piece of written code (one per thousand of
>> lines). Only Mr. Thorsten mentioned 950 unresolved in the "open" list.
> 
> At least 30,000 bugs, of which we know of maybe 950.  ;-)

So I need no point in banning the kernel from screaming to logs that it had
core stalls that needed a physical NMI to recover from, or they would potentially
last much longer.

>> Knowing all of this is difficult, but I still believe in open source and open systems
>> interconnected.
> 
> If it was easy, where would be the challenge?

AFAIK, the point I was taught in life was obedience, not overcoming challenges.

>> Of course, I always remember a proverb "Who hath despised the day of the small beginnings?"
>>
>> Hope this helps. My $0.02.
> 
> I think we are good.   ;-)

Yes, you guys do an amasing job of keeping 30 million lines of code organised
and making some sense. I will cut the smalltalk as I know you are a busy man.
If I make a progress to actually produce any patches fixing these lockups and
stalls, I will be sure to include you into CC: as you requested.

Have a nice day!

Mirsad

--
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
-- 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

