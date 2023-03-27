Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE0E6CB16F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 00:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbjC0WHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 18:07:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjC0WHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 18:07:47 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4896930F6;
        Mon, 27 Mar 2023 15:07:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 4CADA604F2;
        Tue, 28 Mar 2023 00:07:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679954861; bh=0s/d/USegEOfMNZixrmaI9bdcodvzQhQGCIicwZZdp4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=zIXIXfocUSvmt3crdRX6cbNbaO0NXBJ00pdXBC2o1RrC5eR92lWEJCryVnYB+MKSg
         xtvpQufIdPHWVAH4wBEyVJD0A+LwpIJn/UDotEWibtLPBF7sViHiq7yhul+fDR8Ds3
         fMr67/DSXjJJsCbeeMLcWgkE8KDwBWFFnNnARi6SfjuJr+vNUgUDzbWnzABQwGk8k1
         c9qUKt5hUAqJVCRCkzss7w5n1b1p9n7xSFSA6A6tXMNh5hmDsLM6M51zlXTgAYIm7q
         Qc5kmFbl04Aug5AcRvaI/TA93V95s1WzGBQQsFFmIHheLp655eCLLhZopmHzQN1MP5
         gGxdscyRFg2xw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id D0VMoCKh5xgq; Tue, 28 Mar 2023 00:07:38 +0200 (CEST)
Received: from [192.168.1.3] (unknown [77.237.101.225])
        by domac.alu.hr (Postfix) with ESMTPSA id BBD06604EF;
        Tue, 28 Mar 2023 00:07:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679954858; bh=0s/d/USegEOfMNZixrmaI9bdcodvzQhQGCIicwZZdp4=;
        h=Date:From:Subject:To:Cc:References:In-Reply-To:From;
        b=IrG7h6orpedl7Gnu9qW7PHi6eHpp8yFaq/7RrOQN0JTAm8+4zkLQEacjJ77tFzpKK
         lDL958d6cDIr/XBXJeKrTAKYTPeerT/O+CeDX/yA5TxxO3SG5FlykQTc+Ve0Gs9DQw
         aSdOC0PIsFf+negy1ELdMQ8ebJ2704+ouj0cy2OaQqRw4JXXJ25U4Lev3S9XWtb4AR
         zjaBZuK88z/UqXMTadYPsE7NIYJrUDG5imWYOuBVUlxD4L8Qsg650opwhhQUr0hZH9
         lfxgQ/lVBWNwhNgDNAcAKCgVrGFvrvBoyziYkEPHKTl5SSwisHF/vFZWjdfycA8Awg
         BVmvrzI2j4M6g==
Message-ID: <eccc0aff-b963-5594-0874-4ab8889e0b80@alu.unizg.hr>
Date:   Tue, 28 Mar 2023 00:07:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: BUG: BISECTED: drivers/usb/host/xhci: memleak in alloc from
 xhci_disable_usb3_lpm_timeout()
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Arnd Bergmann <arnd@arndb.de>
References: <24263902-c9b3-ce29-237b-1c3d6918f4fe@alu.unizg.hr>
 <651c0500-2b84-d938-fdc2-45e92b322b38@alu.unizg.hr>
 <b86fcdbd-f1c6-846f-838f-b7679ec4e2b4@linux.intel.com>
Content-Language: en-US, hr
In-Reply-To: <b86fcdbd-f1c6-846f-838f-b7679ec4e2b4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 03. 2023. 11:41, Mathias Nyman wrote:
> On 25.3.2023 13.33, Mirsad Goran Todorovac wrote:
>> On 25. 03. 2023. 12:27, Mirsad Goran Todorovac wrote:
>>> Hi all!
>>>
>>> Here are again the good news and the bad news:
>>>
>>> BAD:  another kernel memory leak detected (one more to hunt down and fix)
>>> GOOD: another kernel memory leak detected (one less unaccounted for)
>>>
>>> I tried to make some fun, but maintainers are busy folks, so let's get down
>>> to business:
>>>
>>> ---
>>> Nine (9) new systemd-udevd kernel memory leaks occurred (unable to reproduce).
>>>
>>> The platform is Ubuntu 22.10 with (relatively recent) systemd 251.4-1ubuntu7.1
>>> on LENOVO_MT_82H8_BU_idea_FM_IdeaPad 3 15ITL6 with BIOS GGCN51WW from 11/16/2022.
>>>
>>> The symptom (/sys/kernel/debug/kmemleak output):
>>>
>>> unreferenced object 0xffff909698ff9280 (size 64):
>>>    comm "systemd-udevd", pid 436, jiffies 4294893239 (age 6287.088s)
>>>    hex dump (first 32 bytes):
>>>      e0 51 bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  .Q..............
>>>      40 5b bb 99 96 90 ff ff 00 00 00 00 00 00 00 00  @[..............
>>>    backtrace:
>>>      [<ffffffffb29de94c>] slab_post_alloc_hook+0x8c/0x320
>>>      [<ffffffffb29e5107>] __kmem_cache_alloc_node+0x1c7/0x2b0
>>>      [<ffffffffb2962f3b>] kmalloc_node_trace+0x2b/0xa0
>>>      [<ffffffffb31af2ec>] xhci_alloc_command+0x7c/0x1b0
>>>      [<ffffffffb31af451>] xhci_alloc_command_with_ctx+0x21/0x70
>>>      [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0>>      [<ffffffffb31a8c5b>] xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>>>      [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0
> 
> Thanks for the report.
> 
> I think I found the leak, and wrote a patch for it.
> Any chance you could test it with the same setup?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=8bacee588602ed74cc22aaf4c56b796300e5a943

As I have already been half-through bisect, I took the liberty to finish it.

# good: [5ce036b98dd3301fc43bb06a6383ef07b6c776bc] xhci: dbc: create and remove dbc structure in dbgtty driver.
git bisect good 5ce036b98dd3301fc43bb06a6383ef07b6c776bc
# bad: [d016cbe4d7acf5100df83ecf4d02db4e9f607c1d] usb: typec: Support the WUSB3801 port controller
git bisect bad d016cbe4d7acf5100df83ecf4d02db4e9f607c1d
# bad: [cd36facf104afbde7e8fa25cd6f5b6dd9fa97bb2] usb: remove Link Powermanagement (LPM) disable before port reset.
git bisect bad cd36facf104afbde7e8fa25cd6f5b6dd9fa97bb2
# good: [6aec50009d52f28ef8b512cba0f5078b3928064d] xhci: dbc: Don't call dbc_tty_init() on every dbc tty probe
git bisect good 6aec50009d52f28ef8b512cba0f5078b3928064d
# bad: [5c2a380a5aa8c15985359904b6d47466528d2993] xhci: Allocate separate command structures for each LPM command
git bisect bad 5c2a380a5aa8c15985359904b6d47466528d2993
# good: [e1ec140f273e1e30cea7e6d5f50934d877232121] xhci: dbgtty: use IDR to support several dbc instances.
git bisect good e1ec140f273e1e30cea7e6d5f50934d877232121
# first bad commit: [5c2a380a5aa8c15985359904b6d47466528d2993] xhci: Allocate separate command structures for each LPM command

Interesting enough, Mr. Greg predicted this is an xhci problem already in November [1],
but I did not embolden myself to bisect until this weekend, seeing that it was
still leaking.

But then I was brand new to the CONFIG_DEBUG_KMEMLEAK feature.

[1] https://lore.kernel.org/lkml/Y2zCYwNNvQWppLWZ@kroah.com/

I think the culprit patch is otherwise awesome, reducing latency and locking, especially
welcome in multimedia use.

So far, I was unable to exploit this leak as non-superuser or automate it like gpio-sim
to exhaust the kernel's limited memory, but this doesn't prove that smarter hackers
couldn't devise some means to do that exploit.

BTW: Full designation of the patch is 5.17.0-rc4-kmemlk-xhci-00071-g5c2a380a5aa8, so all
kernels 5.17-rc4+ appear affected by the issue.

Thank you and if you will need any more testing, I am available in my off hours.

Really nice working to assist your dynamic team.

To compare, another developer from another project was desperate about a software giant
being unwilling to abandon deprecated MODP 1024 DH renegotiation for its native VPN,
now for a couple of years ...

Best regards,
Mirsad

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"

