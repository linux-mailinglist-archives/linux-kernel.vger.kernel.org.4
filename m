Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E41B6AD9C6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjCGJAq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:00:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjCGJAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:00:43 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486F14FABC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:00:41 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3278EDpk011019;
        Tue, 7 Mar 2023 09:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=sjyp27yd+u1WP09IS2rhBU8r0yuFSmfQ4TdgCFDrkRY=;
 b=dM0zdl9isAhjcch5QkQoFdQ9QiGlGcYFQ6RP45u4Np9y+2TwS4EKPpOfAkGG0nQh1eUe
 lA6CMlP/igYWknj8RGPZGInAu/jcmS0b0k7sTfht0tY/x4d1MM86YnJ0wAmuRUpwwsx2
 0f0/I+clTd/xR/V7O5RH2erXTIHx70JObaWdWrQVjvWphzayBlSEB+8FY3zsCgC5XEn8
 i42PasHEvVOsfjmIjBMWHawn4t1PDJ8sa/cYAqcHGOCx81xvrNzNNQgJX6UcjQJlkO7j
 Rr+md297pFIGrdnokjabe04xXl6FcG4zNCcPPawVdKn+JJ4bNp7UBbbTk9foinb/mEdV pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n4yf4q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:00:21 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3277NGtP001589;
        Tue, 7 Mar 2023 09:00:21 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p50n4yf3g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:00:21 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3270DVPm002520;
        Tue, 7 Mar 2023 09:00:18 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma03fra.de.ibm.com (PPS) with ESMTPS id 3p41c3u41w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 09:00:18 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 32790Eri59048280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 09:00:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 687422004D;
        Tue,  7 Mar 2023 09:00:14 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EA8020040;
        Tue,  7 Mar 2023 09:00:10 +0000 (GMT)
Received: from [9.43.86.225] (unknown [9.43.86.225])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue,  7 Mar 2023 09:00:10 +0000 (GMT)
Message-ID: <53343c55-c59f-fee7-22f5-94de15a1d18c@linux.ibm.com>
Date:   Tue, 7 Mar 2023 14:30:09 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v19 7/7] x86/crash: optimize cpu changes
Content-Language: en-US
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
 <20230306162228.8277-8-eric.devolder@oracle.com>
From:   Sourabh Jain <sourabhjain@linux.ibm.com>
In-Reply-To: <20230306162228.8277-8-eric.devolder@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 84xdR1RfuFvvetxdCOa8JqRtX7qirWJs
X-Proofpoint-GUID: 3VQw42llU9aYtWCrm9EDe93uSRRcFkii
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_02,2023-03-06_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2303070077
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 06/03/23 21:52, Eric DeVolder wrote:
> This patch is dependent upon the patch 'crash: change
> crash_prepare_elf64_headers() to for_each_possible_cpu()'. With that
> patch, crash_prepare_elf64_headers() writes out an ELF cpu PT_NOTE
> for all possible cpus, thus further cpu changes to the elfcorehdr
> are not needed.
>
> This change works for kexec_file_load() and kexec_load() syscalls.
> For kexec_file_load(), crash_prepare_elf64_headers() is utilized
> directly and thus all ELF cpu PT_NOTEs are in the elfcorehdr already.
> This is the kimage->file_mode term.
> For kexec_load() syscall, one cpu or memory change will cause the
> elfcorehdr to be updated via crash_prepare_elf64_headers() and at
> that point all ELF cpu PT_NOTEs are in the elfcorehdr. This is the
> kimage->elfcorehdr_updated term.
>
> This code is intentionally *NOT* hoisted into
> crash_handle_hotplug_event() as it would prevent the arch-specific
> handler from running for cpu changes. This would break PPC, for
> example, which needs to update other information besides the
> elfcorehdr, on cpu changes.
>
> Signed-off-by: Eric DeVolder <eric.devolder@oracle.com>
> ---
>   arch/x86/kernel/crash.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/arch/x86/kernel/crash.c b/arch/x86/kernel/crash.c
> index c9aaec9de775..82ea2b1bdc61 100644
> --- a/arch/x86/kernel/crash.c
> +++ b/arch/x86/kernel/crash.c
> @@ -471,6 +471,16 @@ void arch_crash_handle_hotplug_event(struct kimage *image)
>   	unsigned long mem, memsz;
>   	unsigned long elfsz = 0;
>   
> +	/* As crash_prepare_elf64_headers() has already described all
> +	 * possible cpus, there is no need to update the elfcorehdr
> +	 * for additional cpu changes. This works for both kexec_load()
> +	 * and kexec_file_load() syscalls.
> +	 */
> +	if ((image->file_mode || image->elfcorehdr_updated) &&
> +		((image->hp_action == KEXEC_CRASH_HP_ADD_CPU) ||
> +		(image->hp_action == KEXEC_CRASH_HP_REMOVE_CPU)))
> +		return;

I like the idea of having elfcorehdr_updated to track elfcoredhr segment 
updates.
It handles the possible CPU thing for kexec_load syscall nicely.

Thanks for incorporating the possible CPU change.

The patch series looks good to me.
Reviewed-by: Sourabh Jain <sourabhjain@linux.ibm.com>

- Sourabh Jain

