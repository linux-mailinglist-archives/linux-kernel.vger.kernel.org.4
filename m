Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1C062558F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:44:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbiKKIoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:44:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbiKKIoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:44:13 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F2B7830F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 00:44:11 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id C56A1604F6;
        Fri, 11 Nov 2022 09:44:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668156248; bh=5Gq+pWXvlvlyukMht8Ezfdo6aGvQh8qweh+KwFXiV6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TybZcZw3NhjGeFOC3UPjS499o3odNELvG2yQCi99tIGSV66M3+6RENQpAHVP712y5
         2P8hx9l/EH1Q6LT9EfXar8XtBgW9tYSId7g0klYxdrb0i2T4olmRU3ESOlP8TSWzdt
         uPpOH1EqiiBImJCJrTEaKvGqw51MVkPYgbljQofI+Dh7zIGlsSWN9+OlyPvPjQfosn
         ++oekYdSPKxmksWA9AxDzyxwTE5CZ39D6WGwQiRiBwUJkNuuXizqZ3SjMuhGHbEcWp
         1o37qsh09zLjmgfWgDJ1BnIOhAjxo11fSTksCLUqkW0LhzEuQ59Zm65KxI6frI68gX
         G//+5u3zkDfTg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lne_zQnl8vpE; Fri, 11 Nov 2022 09:44:06 +0100 (CET)
Received: from [10.0.2.211] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id E7D06604F3;
        Fri, 11 Nov 2022 09:44:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668156246; bh=5Gq+pWXvlvlyukMht8Ezfdo6aGvQh8qweh+KwFXiV6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hSb+uRm0CdMAX9mLm8x3yF2Jl0GSRlNb0//L2mLcE3khZ/35bDyAnNa/N1TTU3id5
         0umA32vkw2ZmqOf+8UXnW9IomZ5xsUzF2ZGHu8TxgCT8oW1oBj2DG1wVDXziaA0yef
         Nu89LpRVIC6TVVJFvqrqREnBbwTnmXshVnQ9E6c2jWmmtL9shqjKnCeiUqk2h5aMTI
         ihUO+G1JsDX7Trof1Q3ZvTQabAaASHu91qSY2Pl32jtHsNOumUOWdJYgKvhTEEOOxi
         ccO4Z+LPeoS9c9gjCUGNHdXaFBFhPHQTnCH6CUuQHp5XOi75AHPDD7PrMyK57L17kq
         X2zpF3Jt4zPxA==
Message-ID: <96903e75-63b4-8c59-6c78-0e641b1fc2c5@alu.unizg.hr>
Date:   Fri, 11 Nov 2022 09:44:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Content-Language: en-US
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>,
        systemd-devel@lists.freedesktop.org
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
 <3f1721d6-e5d9-8861-4e3c-802a711e71da@leemhuis.info>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <3f1721d6-e5d9-8861-4e3c-802a711e71da@leemhuis.info>
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

On 10.11.2022. 9:28, Thorsten Leemhuis wrote:

> This bug is confirmed in 6.1-rc4, among the "thermald" and "systemd-dev"
> kernel memory leaks, potentially exposing race conditions or other more
> serious bug.
>> Maybe, but that sadly is also true for a lot of other known issues, for
>> example those in this quite long list:
>> https://syzkaller.appspot.com/upstream#open
>>
>> It would help if you could pinpoint the problem, then we know who should
>> look into this. You CCed me and the regression list, so I assume it's a
>> regression. Hence: Could you try to bisect it?
>>
>> Ciao, Thorsten

Hi, Thorsten!

I am taking this task, however, it might not be a relatively easy bisect 
like the past
two or three (probably were beginner's luck).

It appears to predate 4.19:

$ head -13 memleak-kwork-4.19.0-08-84df9525b0c2-memlk-menu-al.log
unreferenced object 0xffff8ff917c79c40 (size 16):
   comm "kworker/u12:4", pid 422, jiffies 4294672757 (age 380.342s)
   hex dump (first 16 bytes):
     6d 65 6d 73 74 69 63 6b 30 00 00 00 00 00 00 00 memstick0.......
   backtrace:
     [<000000004f7bc99c>] kobject_set_name_vargs+0x1e/0x90
     [<00000000f00ab312>] dev_set_name+0x57/0x70
     [<000000001fd9518e>] memstick_check+0x99/0x330 [memstick]
     [<000000008c797991>] process_one_work+0x1a7/0x3a0
     [<00000000405c5133>] worker_thread+0x30/0x390
     [<0000000060a58c2e>] kthread+0x112/0x130
     [<000000004b138871>] ret_from_fork+0x35/0x40
     [<0000000029f3e0aa>] 0xffffffffffffffff
$

Cheers,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union
--
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

