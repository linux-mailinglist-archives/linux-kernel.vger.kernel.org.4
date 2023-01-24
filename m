Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB35679780
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjAXMQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjAXMQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:16:33 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06344523E;
        Tue, 24 Jan 2023 04:16:13 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30OBn3WW005401;
        Tue, 24 Jan 2023 12:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=f07QMuBUSg3ZarMkt3Gwjde/EaP6Bc9lH2qZXl5nyCY=;
 b=gfreqFprsd6yG+wEqww+B7Z8olg2a6AhtG7A9foPXXeWRsW97SScghsj8+ARFWHovfLF
 KKd3iVLa0FtJRCwrBVXpP9TL+z+BYQrJ5+WU7M/5SxtJg8AVF8NHn+zrNrbL4fn4W8re
 8/uvgjTblLP4SeFZoxvXUMonZhB7ZhnC8oU8ML23i5MrEXYc60B4VszTHIcYQcKquHPZ
 3voa7XAHQkedsymHIKwmgy4mHkPSX4MhjrdY/rQ9ns/hLJT/QhJ6M7S8QY4/bsz3WvZs
 /xgioy0EuND+J3kWKREhXVca9hktVD/dzTgtHaTZd+yOxHn10jDrsVG4mzIsVVF+8CnI Xg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vbqkux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:16:07 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30OCG6Gd004119;
        Tue, 24 Jan 2023 12:16:06 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3na9vbqku6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:16:06 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30NNTwa9011514;
        Tue, 24 Jan 2023 12:16:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6kshv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 24 Jan 2023 12:16:04 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30OCG2Hn40370608
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 24 Jan 2023 12:16:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4B3CE2004D;
        Tue, 24 Jan 2023 12:16:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E79952004B;
        Tue, 24 Jan 2023 12:16:01 +0000 (GMT)
Received: from [9.171.71.154] (unknown [9.171.71.154])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 24 Jan 2023 12:16:01 +0000 (GMT)
Message-ID: <86bb384b-0084-05ac-3a13-ef462d1c0a35@linux.ibm.com>
Date:   Tue, 24 Jan 2023 13:16:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/1] checkpatch: recognise NOKPROBE_SYMBOL for blank line
 detection after function/struct/union/enum
Content-Language: en-US
To:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>
Cc:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org,
        kernel-janitors <kernel-janitors@vger.kernel.org>
References: <20230120114649.117018-1-borntraeger@linux.ibm.com>
 <e092f27243feeeec282ef8fdab57d8f9ee88a32d.camel@perches.com>
From:   Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <e092f27243feeeec282ef8fdab57d8f9ee88a32d.camel@perches.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B6cJ4QtP57BqYT7t9v8F4mRo1EDn66_o
X-Proofpoint-ORIG-GUID: oT6S8bMmXIr5ds1smx_vAzFJkC2qCxgL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-23_12,2023-01-24_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 clxscore=1011 spamscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301240111
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 20.01.23 um 17:10 schrieb Joe Perches:
> On Fri, 2023-01-20 at 12:46 +0100, Christian Borntraeger wrote:
>> NOKPROBE_SYMBOL should be treated like EXPORT_SYMBOL to avoid
>> false positives.
> []
>> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
>> @@ -3995,6 +3995,7 @@ sub process {
>>   		    $line =~ /^\+/ &&
>>   		    !($line =~ /^\+\s*$/ ||
>>   		      $line =~ /^\+\s*(?:EXPORT_SYMBOL|early_param)/ ||
>> +		      $line =~ /^\+\s*NOKPROBE_SYMBOL/ ||
>>   		      $line =~ /^\+\s*MODULE_/i ||
>>   		      $line =~ /^\+\s*\#\s*(?:end|elif|else)/ ||
>>   		      $line =~ /^\+[a-z_]*init/ ||
> 
> $ git grep -P -w -oh '\w*NOKPROBE_SYMBOL\w*' | sort | uniq -c
>       60 _ASM_NOKPROBE_SYMBOL
>        2 __NOKPROBE_SYMBOL
>      304 NOKPROBE_SYMBOL
> 
> Any issue with these other variants? (it doesn't seem so)
7
The other variants should not matter.
> 
> btw: __NOKPROBE_SYMBOL has a ; at the end of its definition.
> 
> include/asm-generic/kprobes.h:# define __NOKPROBE_SYMBOL(fname)                         \
> include/asm-generic/kprobes.h-static unsigned long __used                                       \
> include/asm-generic/kprobes.h-  __section("_kprobe_blacklist")                          \
> include/asm-generic/kprobes.h-  _kbl_addr_##fname = (unsigned long)fname;
> 
> And so there are extra ; uses after ever use of NOKPROBE_SYMBOL(foo);
> 
> $ git grep -w NOKPROBE_SYMBOL | grep ';' | wc -l
> 285
> 
> There are only 10 uses of NOKPROBE_SYMBOL(foo) without a semicolon
> 
> $ git grep -P '\bNOKPROBE_SYMBOL\s*\(\s*\w+\s*\)\s*(?:[^\;]|$)'
> arch/arm/kernel/traps.c:NOKPROBE_SYMBOL(do_undefinstr)
> arch/arm/probes/kprobes/opt-arm.c:NOKPROBE_SYMBOL(optimized_callback)
> arch/arm64/kernel/kgdb.c:NOKPROBE_SYMBOL(kgdb_brk_fn)
> arch/powerpc/mm/cacheflush.c:NOKPROBE_SYMBOL(flush_dcache_icache_phys)
> arch/powerpc/platforms/82xx/pq2.c:NOKPROBE_SYMBOL(pq2_restart)
> include/asm-generic/kprobes.h:# define NOKPROBE_SYMBOL(fname)   __NOKPROBE_SYMBOL(fname)
> include/asm-generic/kprobes.h:# define NOKPROBE_SYMBOL(fname)
> kernel/fail_function.c:NOKPROBE_SYMBOL(fei_kprobe_handler)
> kernel/kprobes.c:NOKPROBE_SYMBOL(__kretprobe_trampoline_handler)
> kernel/trace/trace_eprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)
> kernel/trace/trace_kprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)
> kernel/trace/trace_uprobe.c:NOKPROBE_SYMBOL(process_fetch_insn)
> 
> The actual uses with NOKPROBE_SYMBOL(foo) should likely have semicolons added
> and the __NOKPROBE_SYMBOL definition should have the semicolon removed.

That would be an independent check I guess.
  
