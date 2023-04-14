Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 235836E1F43
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjDNJ0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjDNJ0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:26:32 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F542100
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:26:30 -0700 (PDT)
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id DACCA60027FE8;
        Fri, 14 Apr 2023 11:26:27 +0200 (CEST)
Message-ID: <a5ab1099-fd08-c708-5532-21dc2a622695@molgen.mpg.de>
Date:   Fri, 14 Apr 2023 11:26:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: AMD EPYC 25 (19h): Hardware Error: Machine Check: 0 Bank 17:
 d42040000000011b
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Yazen Ghannam <yazen.ghannam@amd.com>
References: <21a09968-296b-5b21-8079-6d9d4e0769d4@molgen.mpg.de>
 <20230412163240.GAZDbdKHjmQcxqkeDQ@fat_crate.local>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230412163240.GAZDbdKHjmQcxqkeDQ@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Borislav,


Thank you for your quick and helpful reply.

Am 12.04.23 um 18:32 schrieb Borislav Petkov:
> On Wed, Apr 12, 2023 at 05:11:26PM +0200, Paul Menzel wrote:
>> On a Dell PowerEdge R7525 with AMD EPYC 7763 64-Core Processor, Linux
>> 5.15.94 logs the machine check exceptions (MCE) below:
>>
>> ```
>> [5154053.127240] mce: [Hardware Error]: Machine check events logged
>> [5154053.133711] mce: [Hardware Error]: CPU 3: Machine Check: 0 Bank 17: d42040000000011b
>> [5154053.141948] mce: [Hardware Error]: TSC 0 ADDR b3cbdbbc0 PPIN 2b615bef7f48098 SYND 6bd210000a801002 IPID 9600650f00
> 
> Build the latest kernel with CONFIG_X86_MCE_INJECT and
> CONFIG_EDAC_DECODE_MCE enabled and CONFIG_RAS_CEC *disabled*. Then boot
> it on that machine with and do the following below.
> 
> The files are in debugfs:
> 
> /sys/kernel/debug/mce-inject/
> ├── addr
> ├── bank
> ├── cpu
> ├── flags
> ├── ipid
> ├── misc
> ├── README
> ├── status
> └── synd
> 
> so you go and do
> 
> echo 0xd42040000000011b > status
> echo 0xb3cbdbbc0 > addr
> echo 3 > cpu
> echo "sw" > flags
> echo 0x6bd210000a801002 > synd
> echo 0x9600650f00 > ipid
> echo 17 > bank
> 
> Remember to keep the bank write last because this one injects the error.
> 
> It should dump the decoded error in dmesg.

Yes, that worked:

```
[  436.584741] mce: [Hardware Error]: Machine check events logged
[  436.590638] [Hardware Error]: Corrected error, no action required.
[  436.596869] [Hardware Error]: CPU:3 (19:1:1) 
MC17_STATUS[Over|CE|-|AddrV|-|SyndV|CECC|-|-|-]: 0xd42040000000011b
[  436.607083] [Hardware Error]: Error Addr: 0x0000000b3cbdbbc0
[  436.612763] [Hardware Error]: IPID: 0x0000009600650f00, Syndrome: 
0x6bd210000a801002
[  436.620569] [Hardware Error]: Unified Memory Controller Ext. Error 
Code: 0, DRAM ECC error.
[  436.628942] [Hardware Error]: cache level: L3/GEN, tx: GEN, mem-tx: RD
```

It says “no action required”, but out of the identical 14 servers with 
the same workload this is the only one having shown this errors three times.

Maybe the DIMM at bank 17 should just be replaced.

[…]


Kind regards,

Paul
