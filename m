Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 667DF694881
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:47:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBMOrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMOr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:47:26 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA8E1B30F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:47:12 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDUiKu008361;
        Mon, 13 Feb 2023 14:47:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=QPbIJT1R+C2zP+fBcszLLqmmE3eMP/+u6XJt5DvBiW8=;
 b=FneBY2U1OErUNU2JlBwGEG+b0Ejt5GsE0ydoS4FWAftWhS/3bxddSiYo2H35310C2YDC
 o0OHzUWtCjpbySOJ/gJqX8WXhJYqRmWNYpfABUmbVoiag2vTMMpScKb6zfhMtjwt5dOX
 M8b9Eedop7ChEhbnBZ3eojwCdN8+bKUlBCJ0GJ97NfYRHIcM/N99ZhUvHm82r5mHbppW
 vtsRQV1dZyxeQE6BCdt+x5QNRxuGEJkJkPzg05lzSU8KCiHgDuhmn6SJkIit5Fq+TV6B
 e+4eX+xJxwzMH2mI9BjdnEbJBMwkrOyV7TsiKLpsEsVpOgzn7cqryG0ONmkJFCshDrQm UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqp5et605-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 14:47:01 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31DEkBij032281;
        Mon, 13 Feb 2023 14:47:01 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nqp5et5w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 14:47:01 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DDJh5a000883;
        Mon, 13 Feb 2023 14:46:53 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([9.208.129.113])
        by ppma04dal.us.ibm.com (PPS) with ESMTPS id 3np2n75mg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Feb 2023 14:46:52 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
        by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31DEkoWi590432
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Feb 2023 14:46:51 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CBCB658065;
        Mon, 13 Feb 2023 14:46:50 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B279A5805A;
        Mon, 13 Feb 2023 14:46:50 +0000 (GMT)
Received: from localhost (unknown [9.211.96.43])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 13 Feb 2023 14:46:50 +0000 (GMT)
From:   Nathan Lynch <nathanl@linux.ibm.com>
To:     Laurent Dufour <ldufour@linux.ibm.com>, mpe@ellerman.id.au,
        npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Srikar Dronamraju <srikar@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/pseries/cpuhp: respect current SMT when adding
 new CPU
In-Reply-To: <20230213124510.12651-1-ldufour@linux.ibm.com>
References: <20230213124510.12651-1-ldufour@linux.ibm.com>
Date:   Mon, 13 Feb 2023 08:46:50 -0600
Message-ID: <87ilg5aahx.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: md95E-y93AZ79lrnfDcPw_kVHyuS2O3M
X-Proofpoint-ORIG-GUID: ZKtSF9cYHdXI1pVJ8GkkUCtgV6K5kNUO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-13_09,2023-02-13_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1011 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302130131
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laurent Dufour <ldufour@linux.ibm.com> writes:
> When a new CPU is added, the kernel is activating all its threads. This
> leads to weird, but functional, result when adding CPU on a SMT 4 system
> for instance.
>
> Here the newly added CPU 1 has 8 threads while the other one has 4 threads
> active (system has been booted with the 'smt-enabled=4' kernel option):
>
> ltcden3-lp12:~ # ppc64_cpu --info
> Core   0:    0*    1*    2*    3*    4     5     6     7
> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>
> There is no SMT value in the kernel. It is possible to run unbalanced LPAR
> with 2 threads for a CPU, 4 for another one, and 5 on the latest.
>
> To work around this possibility, and assuming that the LPAR run with the
> same number of threads for each CPU, which is the common case,

I am skeptical at best of baking that assumption into this code. Mixed
SMT modes within a partition doesn't strike me as an unreasonable
possibility for some use cases. And if that's wrong, then we should just
add a global smt value instead of using heuristics.

> the number
> of active threads of the CPU doing the hot-plug operation is computed. Only
> that number of threads will be activated for the newly added CPU.
>
> This way on a LPAR running in SMT=4, newly added CPU will be running 4
> threads, which is what a end user would expect.

I could see why most users would prefer this new behavior. But surely
some users have come to expect the existing behavior, which has been in
place for years, and developed workarounds that might be broken by this
change?

I would suggest that to handle this well, we need to give user space
more ability to tell the kernel what actions to take on added cores, on
an opt-in basis.

This could take the form of extending the DLPAR sysfs command set:

Option 1 - Add a flag that tells the kernel not to online any threads at
all; user space will online the desired threads later.

Option 2 - Add an option that tells the kernel which SMT mode to apply.
