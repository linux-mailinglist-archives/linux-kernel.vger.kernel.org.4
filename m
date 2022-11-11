Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4A16257AB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbiKKKJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiKKKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:09:29 -0500
Received: from domac.alu.hr (domac.alu.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF51748D1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:09:23 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B69C2604F2;
        Fri, 11 Nov 2022 11:09:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668161361; bh=CElacBSfN4wYwRkOcJdp4SRDIGxK/pa4saNiSjR2T6A=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=TDND0Y7NQsnT3vUa/2NPldbHYgasnsVxootalHbDRWtYGiJJ8IW5kSLPgh3VssrHJ
         8kB4bNZPruwHk2EeCEI/0xFJxE1jcLU/QovLlTPkvsWBExYPaKK9aNJ35DISDADJVv
         O4c8YHVVyuUy+R9FiXX+RsVYvhg3bz0XNKnmOCtSHTobrXHpfvKIPJviwp7oAZEvEG
         0BB30laaF5yaFP1v3MQLRJfdxhIJgQBFpEVI8ugKfJWBEksyM1E9PgQoG4Wg8MeRkb
         9ZDWfwrXzdSkieCNjb/qXMSatM/KDoJ36tfHsuRKAml+nwEiu2VX6A87Sy0DNkoh06
         h+sjTqOeOF3Mg==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id f4iIIzKqRJim; Fri, 11 Nov 2022 11:09:19 +0100 (CET)
Received: from [10.0.2.211] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 9065C604F3;
        Fri, 11 Nov 2022 11:09:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1668161359; bh=CElacBSfN4wYwRkOcJdp4SRDIGxK/pa4saNiSjR2T6A=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=1hmfbliTVCDrcaqsjRAz/iXFo5VgQJhFULP43SIi3uQn4lEhWz+S674DDX3OP1TFg
         xEtVUWGe6erbW+2tLtwfYRC/z3/0Oj72y3TUjRCh1NoC3E384CqCYzytq9fDyBI0wy
         4RNCLTll+pJm/2HTcdt8e69LPC4e9XfSkrLv6qia5j35kSxW/Fg+5R6OMglL9XhdP2
         3Eq6riNFOLI7cKeGbGh5+nEggtvP31NtPcyZKUx2tOw3f0meVrtpuK4klPhPQLSq7i
         qu3IG27cZe2BmcOB0r2LasRL5O+ADYaX6zm5QANH3W51s/5uKHfUJNK6MxwfHU0k7r
         eBY7uR4VCSq0Q==
Message-ID: <7d2c05b9-ca22-8cde-216b-b418da6c7428@alu.unizg.hr>
Date:   Fri, 11 Nov 2022 11:09:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: BUG: kworker + systemd-udevd memory leaks found in 6.1.0-rc4
Content-Language: en-US
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     Thorsten Leemhuis <regressions@leemhuis.info>,
        linux-kernel@vger.kernel.org
Cc:     "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        Tejun Heo <tj@kernel.org>,
        Florian Mickler <florian@mickler.org>
References: <0d9c3f6c-3948-d5d1-bcc1-baf31141beaa@alu.unizg.hr>
 <a6b76ce0-0fb3-4434-cc3e-ab6f39fb1cf9@alu.unizg.hr>
 <3f1721d6-e5d9-8861-4e3c-802a711e71da@leemhuis.info>
 <96903e75-63b4-8c59-6c78-0e641b1fc2c5@alu.unizg.hr>
In-Reply-To: <96903e75-63b4-8c59-6c78-0e641b1fc2c5@alu.unizg.hr>
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

P.S. This mail is re-sent because of forgetting to set "Plain text" mode 
to Thunderbird.

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

