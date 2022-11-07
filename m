Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAB4561F861
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbiKGQHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:07:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232937AbiKGQGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:06:55 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDEB2037C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:06:45 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A7EwhnT027594;
        Mon, 7 Nov 2022 16:06:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=di9Ha1vTRpf1SjhO+duGyKMWntDGDAXAzylEOWMY+iE=;
 b=bz5MpVdHsVq2wyNhWYRjc2AW9tStDFzOsEFgGm3tNXSo6taDEAOy1gEoHQ19uFy2kp4D
 jEkDxd1dH8266SH8vCzI80A8B/kuGUyl20kFg9jML2/lzsqqVmSuRTOwngAzdL0Nf6pH
 rGd5uqlX+GIUhAepSg7ey8nBDXdtpy7BiRCBJEKGyoJptT//OFIhDPraLul9njBZa381
 mDWhPiRPQ3ptKVKCHfWjUNH5LQrojyP4m0/cyy9RmWgYky2XW1hp6EmHbQkRVtqe9dUC
 6VINId+Lolof2Fb+jA8ZUc1iTZmgKRjzF4opEGrObuDICesVkdrIcechDgiGd5AvE6ma oQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp8bfadn1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 16:06:36 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2A7EwtxG028764;
        Mon, 7 Nov 2022 16:06:36 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kp8bfadkp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 16:06:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2A7G5RgZ024338;
        Mon, 7 Nov 2022 16:06:33 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06fra.de.ibm.com with ESMTP id 3kngq8j1tc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 16:06:33 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2A7G6UL42032292
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Nov 2022 16:06:30 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 986B1A405F;
        Mon,  7 Nov 2022 16:06:30 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D6D1A4054;
        Mon,  7 Nov 2022 16:06:30 +0000 (GMT)
Received: from [9.101.4.33] (unknown [9.101.4.33])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  7 Nov 2022 16:06:30 +0000 (GMT)
Message-ID: <b5085cee-0ecc-fd20-f038-83a643c4482b@linux.ibm.com>
Date:   Mon, 7 Nov 2022 17:06:29 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH 1/2] powerpc: export the CPU node count
To:     Nicholas Piggin <npiggin@gmail.com>, mpe@ellerman.id.au,
        christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20221028160034.44400-1-ldufour@linux.ibm.com>
 <20221028160034.44400-2-ldufour@linux.ibm.com>
 <CO61XSIISI9G.PHZVHP50ZWUU@bobo>
Content-Language: fr
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <CO61XSIISI9G.PHZVHP50ZWUU@bobo>
Content-Type: text/plain; charset=UTF-8
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HvOP1zYnP9YWgKy_t7dyFeiX9J12JCDd
X-Proofpoint-ORIG-GUID: v3cx5O_l2mPe7_DnCQ11uQTPW2ckpzTw
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 7 URL's were un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_08,2022-11-07_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211070129
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 13:11:17, Nicholas Piggin wrote:
> On Sat Oct 29, 2022 at 2:00 AM AEST, Laurent Dufour wrote:
>> At boot time, the FDT is parsed to compute the number of CPUs.
>> In addition count the number of CPU nodes and export it.
>>
>> This is useful when building the FDT for a kexeced kernel since we need to
>> take in account the CPU node added since the boot time during CPU hotplug
>> operations.
> 
> It would be nice if it just realloced memory in this case, but that
> looks like a bigger change.

I agree, and I think the best option in long term would be the series 
Sourabh Jain sent in June, updating the crash kernel FDT without reloading
it (https://lore.kernel.org/linuxppc-dev/20220620070106.93141-1-sourabhjain@linux.ibm.com/)

In the meantime, this solves the issue.

> 
> But these patches look okay to me, if you can solve the compile bug.

Indeed, the compile bugs are raised because I added the definition of the new variable 
'boot_cpu_node_count' in kexec_ranges.h, and add the inclusion of that file in prom.c.

I was not confident putting this new variable definition in that header file, but I 
didn't find a better option.

Do you have a better idea of header file to use?

Could I just declare this variable "extern" in arch/powerpc/kexec/file_load_64.c? This looks
ugly to me.

Thanks,
Laurent.


> Thanks,
> Nick
> 
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.ibm.com>
>> ---
>>  arch/powerpc/include/asm/kexec_ranges.h | 2 ++
>>  arch/powerpc/kernel/prom.c              | 4 ++++
>>  2 files changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/include/asm/kexec_ranges.h b/arch/powerpc/include/asm/kexec_ranges.h
>> index f83866a19e87..bf35d00ddd09 100644
>> --- a/arch/powerpc/include/asm/kexec_ranges.h
>> +++ b/arch/powerpc/include/asm/kexec_ranges.h
>> @@ -22,4 +22,6 @@ int add_rtas_mem_range(struct crash_mem **mem_ranges);
>>  int add_opal_mem_range(struct crash_mem **mem_ranges);
>>  int add_reserved_mem_ranges(struct crash_mem **mem_ranges);
>>  
>> +extern unsigned int boot_cpu_node_count;
>> +
>>  #endif /* _ASM_POWERPC_KEXEC_RANGES_H */
>> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
>> index 1eed87d954ba..d326148fd5a4 100644
>> --- a/arch/powerpc/kernel/prom.c
>> +++ b/arch/powerpc/kernel/prom.c
>> @@ -56,6 +56,7 @@
>>  #include <asm/drmem.h>
>>  #include <asm/ultravisor.h>
>>  #include <asm/prom.h>
>> +#include <asm/kexec_ranges.h>
>>  
>>  #include <mm/mmu_decl.h>
>>  
>> @@ -72,6 +73,7 @@ int __initdata iommu_is_off;
>>  int __initdata iommu_force_on;
>>  unsigned long tce_alloc_start, tce_alloc_end;
>>  u64 ppc64_rma_size;
>> +unsigned int boot_cpu_node_count __ro_after_init;
>>  #endif
>>  static phys_addr_t first_memblock_size;
>>  static int __initdata boot_cpu_count;
>> @@ -335,6 +337,8 @@ static int __init early_init_dt_scan_cpus(unsigned long node,
>>  	if (type == NULL || strcmp(type, "cpu") != 0)
>>  		return 0;
>>  
>> +	boot_cpu_node_count++;
>> +
>>  	/* Get physical cpuid */
>>  	intserv = of_get_flat_dt_prop(node, "ibm,ppc-interrupt-server#s", &len);
>>  	if (!intserv)
>> -- 
>> 2.38.1
> 

