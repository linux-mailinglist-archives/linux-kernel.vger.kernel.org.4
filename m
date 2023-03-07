Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA04F6AD988
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjCGItg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbjCGItd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:49:33 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CD27982
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:49:31 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3278832D013880;
        Tue, 7 Mar 2023 08:49:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=6mGG0WTaQn/PNFPFt9pxB866ZLdmwgCMdNTy93Z/y3w=;
 b=nCcvcBWkK8rFJtEJxcak7T7ZLrt2ut/bJDmGvwleVjov4hsotRWQiH4Lawyke3iLu+74
 nZoRVqA3q11SlRwnXbMajHM+TlRqnxhvqderoqZSwHSU+RyJeqnTYj20be6b5/s4KX8A
 qYs3+1/ZkE8ZrpkxBzZQYGaNozitKvrk1QlA1M1qqsYqyGlF/7hY0eVwTkAY4AEF4rPn
 bJXERX8WePDAwN2nidZm7yjdNkdks+O0yBeYqKbIpgCysHxk4p80+YTb85OFSCRs45lG
 FzOVoVuQQRs9wVjQr4e10ki/jiUDk056nok4usei4WOqNDQfuvOpeMLiCflubF4Q3AOz Cw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4uafcr2h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 08:49:08 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3278imFH038763;
        Tue, 7 Mar 2023 08:49:07 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p4uafcr1b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 08:49:07 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3271gUji005556;
        Tue, 7 Mar 2023 08:49:05 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brbync-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 08:49:04 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3278n2qH52166956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 08:49:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65E2920040;
        Tue,  7 Mar 2023 08:49:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0F94620043;
        Tue,  7 Mar 2023 08:48:58 +0000 (GMT)
Received: from [9.43.86.225] (unknown [9.43.86.225])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 08:48:57 +0000 (GMT)
Message-ID: <c9db3d66-f74d-fcab-837e-bfcabae8bce7@linux.ibm.com>
Date:   Tue, 7 Mar 2023 14:18:57 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v19 6/7] crash: change crash_prepare_elf64_headers() to
 for_each_possible_cpu()
To:     Eric DeVolder <eric.devolder@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        kexec@lists.infradead.org, ebiederm@xmission.com,
        dyoung@redhat.com, bhe@redhat.com, vgoyal@redhat.com
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        nramas@linux.microsoft.com, thomas.lendacky@amd.com,
        robh@kernel.org, efault@gmx.de, rppt@kernel.org, david@redhat.com,
        konrad.wilk@oracle.com, boris.ostrovsky@oracle.com
References: <20230306162228.8277-1-eric.devolder@oracle.com>
 <20230306162228.8277-7-eric.devolder@oracle.com>
Content-Language: en-US
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230306162228.8277-7-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aFXcfKvsaQRm2Wg0p0ZMYNHRsyk6M2qi
X-Proofpoint-ORIG-GUID: rPcoXFfS1QFZIKh2XnQsMPTySvp16jpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_02,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 mlxscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Eric,

On 06/03/23 21:52, Eric DeVolder wrote:
> The function crash_prepare_elf64_headers() generates the elfcorehdr
> which describes the cpus and memory in the system for the crash kernel.
> In particular, it writes out ELF PT_NOTEs for memory regions and the
> cpus in the system.
>
> With respect to the cpus, the current implementation utilizes
> for_each_present_cpu() which means that as cpus are added and removed,
> the elfcorehdr must again be updated to reflect the new set of cpus.
>
> The reasoning behind the change to use for_each_possible_cpu(), is:
>
> - At kernel boot time, all percpu crash_notes are allocated for all
>    possible cpus; that is, crash_notes are not allocated dynamically
>    when cpus are plugged/unplugged. Thus the crash_notes for each
>    possible cpu are always available.
>
> - The crash_prepare_elf64_headers() creates an ELF PT_NOTE per cpu.
>    Changing to for_each_possible_cpu() is valid as the crash_notes
>    pointed to by each cpu PT_NOTE are present and always valid.
>
> Furthermore, examining a common crash processing path of:
>
>   kernel panic -> crash kernel -> makedumpfile -> 'crash' analyzer
>             elfcorehdr      /proc/vmcore     vmcore
>
> reveals how the ELF cpu PT_NOTEs are utilized:
>
> - Upon panic, each cpu is sent an IPI and shuts itself down, recording
>   its state in its crash_notes. When all cpus are shutdown, the
>   crash kernel is launched with a pointer to the elfcorehdr.
>
> - The crash kernel via linux/fs/proc/vmcore.c does not examine or
>   use the contents of the PT_NOTEs, it exposes them via /proc/vmcore.
>
> - The makedumpfile utility uses /proc/vmcore and reads the cpu
>   PT_NOTEs to craft a nr_cpus variable, which is reported in a
>   header but otherwise generally unused. Makedumpfile creates the
>   vmcore.
>
> - The 'crash' dump analyzer does not appear to reference the cpu
>   PT_NOTEs. Instead it looks-up the cpu_[possible|present|onlin]_mask
>   symbols and directly examines those structure contents from vmcore
>   memory. From that information it is able to determine which cpus
>   are present and online, and locate the corresponding crash_notes.
>   Said differently, it appears that 'crash' analyzer does not rely
>   on the ELF PT_NOTEs for cpus; rather it obtains the information
>   directly via kernel symbols and the memory within the vmcore.
>
> (There maybe other vmcore generating and analysis tools that do use
> these PT_NOTEs, but 'makedumpfile' and 'crash' seems to be the most
> common solution.)
>
> This change results in the benefit of having all cpus described in
> the elfcorehdr, and therefore reducing the need to re-generate the
> elfcorehdr on cpu changes, at the small expense of an additional
> 56 bytes per PT_NOTE for not-present-but-possible cpus.
>
> On systems where kexec_file_load() syscall is utilized, all the above
> is valid. On systems where kexec_load() syscall is utilized, there
> may be the need for the elfcorehdr to be regenerated once. The reason
> being that some archs only populate the 'present' cpus in the
> /sys/devices/system/cpus entries, which the userspace 'kexec' utility
> uses to generate the userspace-supplied elfcorehdr. In this situation,
> one memory or cpu change will rewrite the elfcorehdr via the
> crash_prepare_elf64_headers() function and now all possible cpus will
> be described, just as with kexec_file_load() syscall.
>
> Suggested-by: Sourabh Jain <sourabhjain@linux.ibm.com>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   kernel/crash_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/crash_core.c b/kernel/crash_core.c
> index dba4b75f7541..537b199a8774 100644
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -365,7 +365,7 @@ int crash_prepare_elf64_headers(struct crash_mem *mem, int need_kernel_map,
>   	ehdr->e_phentsize = sizeof(Elf64_Phdr);
>   
>   	/* Prepare one phdr of type PT_NOTE for each present CPU */
We need to change this comment as well.
> -	for_each_present_cpu(cpu) {
> +	for_each_possible_cpu(cpu) {
- Sourabh Jain
