Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861F624533
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 16:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiKJPJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 10:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230320AbiKJPJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 10:09:20 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F3B275DB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 07:09:12 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2AAEe180024750;
        Thu, 10 Nov 2022 15:09:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LhSQ1qYeN8I3wz44Gku+pmpYQySw53dMuLC0/1DDilo=;
 b=Mf0rsZC6rSjIKZxM8D2Y46OUMR+p7aCRKQo6lC1vk7sKsvbqhZwyJkkCQCYYFTn+nWcX
 9yTyBgQO2/ewHpQE0DwfmQBNABaO8Am5lpsJucvc1bYRl1bBW9d8BHv7nx72XdvVwFVp
 1derLwcsJngX6Ufs3jPtoYL+hiZ1ay5aH5B3jnlit1dWM/r1jZYSti5yaDi7qk570P4O
 8xCfOyhOYdjRQmebc2oFQ31O33kbXRXHWaelmOXaJZcdirwhKpcI3EkFabQez7IuT07o
 euVYHKbnhfo5kuKku0+CMGkB2SGosUelzJjYPM6P7Dg3PeE62bZYP/Qw33h1vTEuh+2+ sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks07dx6gw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 15:09:03 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AAEgP2r031200;
        Thu, 10 Nov 2022 15:09:02 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ks07dx6fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 15:09:02 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AAF68QI032120;
        Thu, 10 Nov 2022 15:09:00 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03ams.nl.ibm.com with ESMTP id 3kngqgfe8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Nov 2022 15:09:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AAF8vXO655940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Nov 2022 15:08:57 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B40EA42042;
        Thu, 10 Nov 2022 15:08:57 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 691C842041;
        Thu, 10 Nov 2022 15:08:57 +0000 (GMT)
Received: from [9.171.50.166] (unknown [9.171.50.166])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 10 Nov 2022 15:08:57 +0000 (GMT)
Message-ID: <94dbb4c5-e895-0909-d231-893812cc9bc0@linux.ibm.com>
Date:   Thu, 10 Nov 2022 16:08:56 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2] gcov: clang: fix the buffer overflow issue
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com, trix@redhat.com
References: <1668020497-13142-1-git-send-email-quic_mojha@quicinc.com>
Content-Language: en-US
From:   Peter Oberparleiter <oberpar@linux.ibm.com>
In-Reply-To: <1668020497-13142-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LeOk0_4nbRGklzaUu0hhJ3IpYIfLDdGc
X-Proofpoint-GUID: J_5smJMgYJbW8ndoMzdc9MuiSzGSlfpK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_10,2022-11-09_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 clxscore=1011 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211100107
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.11.2022 20:01, Mukesh Ojha wrote:
> Currently, in clang version of gcov code when module is getting removed
> gcov_info_add() incorrectly adds the sfn_ptr->counter to all the
> dst->functions and it result in the kernel panic in below crash report.
> Fix this by properly handling it.
> 
> [    8.899094][  T599] Unable to handle kernel write to read-only memory at virtual address ffffff80461cc000
> [    8.899100][  T599] Mem abort info:
> [    8.899102][  T599]   ESR = 0x9600004f
> [    8.899103][  T599]   EC = 0x25: DABT (current EL), IL = 32 bits
> [    8.899105][  T599]   SET = 0, FnV = 0
> [    8.899107][  T599]   EA = 0, S1PTW = 0
> [    8.899108][  T599]   FSC = 0x0f: level 3 permission fault
> [    8.899110][  T599] Data abort info:
> [    8.899111][  T599]   ISV = 0, ISS = 0x0000004f
> [    8.899113][  T599]   CM = 0, WnR = 1
> [    8.899114][  T599] swapper pgtable: 4k pages, 39-bit VAs, pgdp=00000000ab8de000
> [    8.899116][  T599] [ffffff80461cc000] pgd=18000009ffcde003, p4d=18000009ffcde003, pud=18000009ffcde003, pmd=18000009ffcad003, pte=00600000c61cc787
> [    8.899124][  T599] Internal error: Oops: 9600004f [#1] PREEMPT SMP
> [    8.899265][  T599] Skip md ftrace buffer dump for: 0x1609e0
> ....
> ..,
> [    8.899544][  T599] CPU: 7 PID: 599 Comm: modprobe Tainted: G S         OE     5.15.41-android13-8-g38e9b1af6bce #1
> [    8.899547][  T599] Hardware name: XXX (DT)
> [    8.899549][  T599] pstate: 82400005 (Nzcv daif +PAN -UAO +TCO -DIT -SSBS BTYPE=--)
> [    8.899551][  T599] pc : gcov_info_add+0x9c/0xb8
> [    8.899557][  T599] lr : gcov_event+0x28c/0x6b8
> [    8.899559][  T599] sp : ffffffc00e733b00
> [    8.899560][  T599] x29: ffffffc00e733b00 x28: ffffffc00e733d30 x27: ffffffe8dc297470
> [    8.899563][  T599] x26: ffffffe8dc297000 x25: ffffffe8dc297000 x24: ffffffe8dc297000
> [    8.899566][  T599] x23: ffffffe8dc0a6200 x22: ffffff880f68bf20 x21: 0000000000000000
> [    8.899569][  T599] x20: ffffff880f68bf00 x19: ffffff8801babc00 x18: ffffffc00d7f9058
> [    8.899572][  T599] x17: 0000000000088793 x16: ffffff80461cbe00 x15: 9100052952800785
> [    8.899575][  T599] x14: 0000000000000200 x13: 0000000000000041 x12: 9100052952800785
> [    8.899577][  T599] x11: ffffffe8dc297000 x10: ffffffe8dc297000 x9 : ffffff80461cbc80
> [    8.899580][  T599] x8 : ffffff8801babe80 x7 : ffffffe8dc2ec000 x6 : ffffffe8dc2ed000
> [    8.899583][  T599] x5 : 000000008020001f x4 : fffffffe2006eae0 x3 : 000000008020001f
> [    8.899586][  T599] x2 : ffffff8027c49200 x1 : ffffff8801babc20 x0 : ffffff80461cb3a0
> [    8.899589][  T599] Call trace:
> [    8.899590][  T599]  gcov_info_add+0x9c/0xb8
> [    8.899592][  T599]  gcov_module_notifier+0xbc/0x120
> [    8.899595][  T599]  blocking_notifier_call_chain+0xa0/0x11c
> [    8.899598][  T599]  do_init_module+0x2a8/0x33c
> [    8.899600][  T599]  load_module+0x23cc/0x261c
> [    8.899602][  T599]  __arm64_sys_finit_module+0x158/0x194
> [    8.899604][  T599]  invoke_syscall+0x94/0x2bc
> [    8.899607][  T599]  el0_svc_common+0x1d8/0x34c
> [    8.899609][  T599]  do_el0_svc+0x40/0x54
> [    8.899611][  T599]  el0_svc+0x94/0x2f0
> [    8.899613][  T599]  el0t_64_sync_handler+0x88/0xec
> [    8.899615][  T599]  el0t_64_sync+0x1b4/0x1b8
> [    8.899618][  T599] Code: f905f56c f86e69ec f86e6a0f 8b0c01ec (f82e6a0c)
> [    8.899620][  T599] ---[ end trace ed5218e9e5b6e2e6 ]---
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Looks good to me! Successfully tested on s390.

Fixes: e178a5beb369 ("gcov: clang support")
Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Tested-by: Peter Oberparleiter <oberpar@linux.ibm.com>

And I'm not sure if this is strictly needed, but we could also add:

Cc: <stable@vger.kernel.org> # 5.2+

@Andrew: could you pick this up via your tree?

> ---
> v1..v2:
>  - Addressed Peter O. comment.
> 
>  kernel/gcov/clang.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/gcov/clang.c b/kernel/gcov/clang.c
> index cbb0bed..7670a81 100644
> --- a/kernel/gcov/clang.c
> +++ b/kernel/gcov/clang.c
> @@ -280,6 +280,8 @@ void gcov_info_add(struct gcov_info *dst, struct gcov_info *src)
>  
>  		for (i = 0; i < sfn_ptr->num_counters; i++)
>  			dfn_ptr->counters[i] += sfn_ptr->counters[i];
> +
> +		sfn_ptr = list_next_entry(sfn_ptr, head);
>  	}
>  }
>  

-- 
Peter Oberparleiter
Linux on IBM Z Development - IBM Germany R&D

