Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868666CA30C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 14:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjC0MES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 08:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjC0MEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 08:04:16 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D65A3A8D;
        Mon, 27 Mar 2023 05:04:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id B2AE6604F9;
        Mon, 27 Mar 2023 14:04:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679918651; bh=2qn7tQz4Wsy7KiaxUkWsPEtOXrlWXUluDRiyZZzfMGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cMo+nOj422y0yfPlcW1KCKMXguM5sIqc6AWVuG4QA3SUnI1ktrIrY6ADE5rlHyMNl
         niggDxsuijM5Wzdo9IR/xW9xu2n0JEeMHAYWGAIIPXJsyTjncQI0kvB1+v8jOy4Uay
         kqrUQS2qDSFKu5StZ6oitiYBffYAsf1Uw8fdeH5qpHkeYlEmqcp4snwmuE2GeofUqL
         U0ZOq9A4b0MHZH+SNX5LGzjXhLXaWi/YD671PoHf5EbVz3UFNAfWRs6365MT6Rit1X
         M89q99Waci+PcINfCYqkJtXDGGzlR5w3yZK5h8TTqIrT605UcOc2plRTrXSdDWv3jd
         CHr6T6B9s4HWw==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fykIBuf8Syi3; Mon, 27 Mar 2023 14:04:09 +0200 (CEST)
Received: from [10.0.1.103] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id EE834604EF;
        Mon, 27 Mar 2023 14:04:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1679918649; bh=2qn7tQz4Wsy7KiaxUkWsPEtOXrlWXUluDRiyZZzfMGA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JpVPLlby5viqDTjS/9a4veW8S8Vii/rh3YOtwrF3eePTTf4ZuMyzc26aPz16kF2Ji
         yd1QkCXiU+7omf1B6HJvqPDvLx1nzVQrC1evw+ruRPxBGpjJCXbHT8xvKSk5A0+a8m
         dsSUTCJ0WAlbez1cfzdz4echbDkJ3eADE7nHnVSp+nlMolWfUy4ci7+CkrXWt85ozA
         5YVX0cvlZvoYR628tfk7Hk6COnb3GzCyT/YeSSE3YKXz7ypGu/S/x3hr1B7tYW6cKa
         5QDYG3KBfSinzYxoHaLtrqTAJIzOgs1N5h5gB+YBk1RrFRywr4A3fIjzKqA8cXASwY
         rL27XI17NMtFw==
Message-ID: <04d5e796-8938-3faa-c7dc-f966135da1b9@alu.unizg.hr>
Date:   Mon, 27 Mar 2023 14:04:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: BUG: drivers/usb/host/xhci: memleak in alloc from
 xhci_disable_usb3_lpm_timeout()
Content-Language: en-US
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
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <b86fcdbd-f1c6-846f-838f-b7679ec4e2b4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27.3.2023. 11:41, Mathias Nyman wrote:
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
>>>      [<ffffffffb31a8a3e>] xhci_change_max_exit_latency+0x2e/0x1c0>>      [<ffffffffb31a8c5b>] 
>>> xhci_disable_usb3_lpm_timeout+0x7b/0xb0
>>>      [<ffffffffb31457a7>] usb_disable_link_state+0x57/0xe0
> 
> Thanks for the report.
> 
> I think I found the leak, and wrote a patch for it.
> Any chance you could test it with the same setup?
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mnyman/xhci.git/commit/?h=for-usb-linus&id=8bacee588602ed74cc22aaf4c56b796300e5a943

Hi, Mathias,

Great you have found the leak!

I cannot make testing in the same setup because I can access that particular box
until after I finish my day job.

I will prioritise it.

If this is the catch, it will save me almost a dozen bisect builds. :-)

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

