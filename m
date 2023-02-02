Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25A4687C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbjBBLgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:36:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjBBLgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:36:46 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A19018
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 03:36:44 -0800 (PST)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P6xZR2pcYzfYq9;
        Thu,  2 Feb 2023 19:36:31 +0800 (CST)
Received: from [10.67.110.108] (10.67.110.108) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Thu, 2 Feb 2023 19:36:41 +0800
Message-ID: <8a87d19b-f612-0f5b-7a13-d3c42822313e@huawei.com>
Date:   Thu, 2 Feb 2023 19:36:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] riscv: Add header include guards to insn.h
To:     Joe Perches <joe@perches.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <heiko.stuebner@vrull.eu>,
        <ajones@ventanamicro.com>,
        <prabhakar.mahadev-lad.rj@bp.renesas.com>, <jszhang@kernel.org>,
        <vincent.chen@sifive.com>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230129094242.282620-1-liaochang1@huawei.com>
 <Y9fZ2ZxdMmXgO5aB@wendy> <9a4f98a7-fa03-7960-29ce-0bff018c0ac9@huawei.com>
 <Y9o0Bv7VBM74ePHH@wendy> <f161df27-f2d7-0367-33a0-9ff5e4b880d9@huawei.com>
 <38d7d022d6e88d643c8037e26707a719cb55ff1d.camel@perches.com>
From:   "liaochang (A)" <liaochang1@huawei.com>
In-Reply-To: <38d7d022d6e88d643c8037e26707a719cb55ff1d.camel@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.108]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2023/2/2 11:33, Joe Perches 写道:
> On Thu, 2023-02-02 at 08:52 +0800, liaochang (A) wrote:
>>
>> 在 2023/2/1 17:42, Conor Dooley 写道:
>>> Hi,
>>>
>>> On Wed, Feb 01, 2023 at 05:37:24PM +0800, liaochang (A) wrote:
>>>> 在 2023/1/30 22:53, Conor Dooley 写道:
>>>>> On Sun, Jan 29, 2023 at 05:42:42PM +0800, Liao Chang wrote:
>>>>>> Add header include guards to insn.h to prevent repeating declaration of
>>>>>> any identifiers in insn.h.
>>>>>
>>>>> I'm curious, did you spot this "by hand" while doing other work, or do
>>>>> you have a tool that found it for you?
>>>>
>>>> I found this "by hand", inspired by scripts/checkdeclares.pl, i write a tiny tool
>>>> to analyse the missing header guards in header file.
>>>
>>> Ohh, cool! I'd love to add this one to the checks on patchwork so that
>>> we do not end up adding any more of these. If this is based on
>>> checkdeclares, is it GPLv2?
>>
>> Definitely, it is GPLv2,i will appending licence identifier and copyright info later.
>>
>> Hi，@Joe Perches, is it ok to integrate this tool to scripts?
> 
> Don't see why not.
> Perhaps submit it as a real patch to Andrew Morton <akpm@linux-foundation.org>
> 
> Trivial notes below:
> 
>>>> #!/usr/bin/env perl
>>>> use strict;
>>>>
>>>> sub usage {
>>>>         print "Usage: checkguards.pl file1.h ...\n";
>>>>         print "Warn of missing header guards\n";
>>>>         exit 1;
>>>> }
>>>>
>>>> if ($#ARGV < 0) {
>>>>         usage();
>>>> }
>>>>
>>>> foreach my $file (@ARGV) {
>>>>         open(my $f, '<', $file)
>>>>             or die "Cannot open $file: $!.\n";
>>>>
>>>>         my $scan_area = 1;
>>>>         my $guards_warn = 0;
>>>>
>>>>         # The lines of header file are divided into several areas as follows:
>>>>         #
>>>>         # ... area1 ...
>>>>         # #ifndef _HEADER_GUARD
>>>>         # ... area2 ...
>>>>         # #define _HEADER_GUARD
>>>>         # ... area3 ...
>>>>         # #endif /* _HEADER_GUARD */
>>>>         # ... area4 ...
>>>>         # EOF
>>>>         #
>>>>         # If any statement is found in area1, area2, and area4, it
>>>>         # throws a warning of illegal usage of header guard usage.
> 
> Not illegal, invalid
> 
>>>>         while (<$f>) {
>>>>                 if (m/^(.*);\s*$/o) {
>>>>                         if ($scan_area == 1 || $scan_area == 2 || $scan_area == 4) {
>>>>                                 ++$guards_warn;
>>>>                         }
>>>>                 } elsif (m/^\s*(#ifndef\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
>>>>                         ++$scan_area;
>>>>                 } elsif (m/^\s*(#define\s+)[a-zA-Z0-9_]*_H[_]*\s*$/o) {
>>>>                         ++$scan_area;
>>>>                 } elsif (m/^\s*(#endif)\s*\/\*\s*[a-zA-Z0-9_]*_H[_]*\s*\*\/\s*$/o) {
>>>>                         ++$scan_area;
>>>>                 }
>>>>         }
>>>>
>>>>         close($f);
>>>>
>>>>         if ($guards_warn) {
>>>>                 print "Illegal usage of header guard found in $file.\n";
> 
> here too
> 
> There are also uses like #if !defined(FOO)
> There can be spaces before and after the #
> 
> It might also be useful to have a check for missing header guards.

OK, i will use a stricter pattern in the real patch.

Thanks.

> 
> 
> 
> 

-- 
BR,
Liao, Chang
