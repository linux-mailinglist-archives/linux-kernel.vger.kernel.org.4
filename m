Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158C6696825
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 16:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjBNPde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 10:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232366AbjBNPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 10:33:32 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685FC6EA5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 07:33:22 -0800 (PST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31EFG6E5016249;
        Tue, 14 Feb 2023 15:33:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=rxiIRvgDtu/UmpixXsnC5Kfmjr3BQVamhmokBC+aDLo=;
 b=s4ogpTXCXJO0QkKSS0T8k51A0PFPplA/4hTncrxn06WN5f4tbpV0GwQgoQfmNRQZT+9P
 6RpX+8dK7wi5lz4zgGCrf1BFRkAtAcBsiT9m/SoYC2bJJkBsFpIBA5br6Wmfox5txMib
 wv97B4UFnipRmFsYj0qjO7BxRCcImGJXHPYQTlXnFTxagbeHLOogTwY3Pk9ONmLXgMaa
 lmt4t2YSZrKo3q0ES18/62lDCefixr+cvLohg3k5nmi+l2hW2FXrSOY8wIBudDbqtqQr
 RaXONq3Fo/mvDVoKOIx6HfDHm/uRMhjA2Tx4zDFYSkmV/Oo7Lw0j1BVrZpBkYCzfaJ31 dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrcsuge9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:33:04 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 31EFHj0H024352;
        Tue, 14 Feb 2023 15:33:04 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3nrcsuge8w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:33:04 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 31DLbOqK002747;
        Tue, 14 Feb 2023 15:33:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma05fra.de.ibm.com (PPS) with ESMTPS id 3np2n6b2va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 14 Feb 2023 15:33:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 31EFWw3S39715218
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Feb 2023 15:32:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF67E20040;
        Tue, 14 Feb 2023 15:32:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D3112004B;
        Tue, 14 Feb 2023 15:32:58 +0000 (GMT)
Received: from [9.171.28.15] (unknown [9.171.28.15])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 14 Feb 2023 15:32:58 +0000 (GMT)
Message-ID: <0dd90256-883d-ceec-570e-9cade65b2722@linux.ibm.com>
Date:   Tue, 14 Feb 2023 16:32:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] powerpc/pseries/cpuhp: respect current SMT when adding
 new CPU
To:     Nathan Lynch <nathanl@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Srikar Dronamraju <srikar@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20230213124510.12651-1-ldufour@linux.ibm.com>
 <87ilg5aahx.fsf@linux.ibm.com> <20230213150429.GZ19419@kitsune.suse.cz>
 <87fsb9a7zx.fsf@linux.ibm.com>
Content-Language: en-US
From:   Laurent Dufour <ldufour@linux.ibm.com>
In-Reply-To: <87fsb9a7zx.fsf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zfqeg2zDBZuY04vbom5FvixqruJBGGKk
X-Proofpoint-ORIG-GUID: nKqF96Z8XD0RH9yJHeD1tyJ0WPvKF09U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-14_10,2023-02-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302140125
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2023 16:40:50, Nathan Lynch wrote:
> Michal Suchánek <msuchanek@suse.de> writes:
>> On Mon, Feb 13, 2023 at 08:46:50AM -0600, Nathan Lynch wrote:
>>> Laurent Dufour <ldufour@linux.ibm.com> writes:
>>>> When a new CPU is added, the kernel is activating all its threads. This
>>>> leads to weird, but functional, result when adding CPU on a SMT 4 system
>>>> for instance.
>>>>
>>>> Here the newly added CPU 1 has 8 threads while the other one has 4 threads
>>>> active (system has been booted with the 'smt-enabled=4' kernel option):
>>>>
>>>> ltcden3-lp12:~ # ppc64_cpu --info
>>>> Core   0:    0*    1*    2*    3*    4     5     6     7
>>>> Core   1:    8*    9*   10*   11*   12*   13*   14*   15*
>>>>
>>>> There is no SMT value in the kernel. It is possible to run unbalanced LPAR
>>>> with 2 threads for a CPU, 4 for another one, and 5 on the latest.
>>>>
>>>> To work around this possibility, and assuming that the LPAR run with the
>>>> same number of threads for each CPU, which is the common case,
>>>
>>> I am skeptical at best of baking that assumption into this code. Mixed
>>> SMT modes within a partition doesn't strike me as an unreasonable
>>> possibility for some use cases. And if that's wrong, then we should just
>>> add a global smt value instead of using heuristics.
>>>
>>>> the number
>>>> of active threads of the CPU doing the hot-plug operation is computed. Only
>>>> that number of threads will be activated for the newly added CPU.
>>>>
>>>> This way on a LPAR running in SMT=4, newly added CPU will be running 4
>>>> threads, which is what a end user would expect.
>>>
>>> I could see why most users would prefer this new behavior. But surely
>>> some users have come to expect the existing behavior, which has been in
>>> place for years, and developed workarounds that might be broken by this
>>> change?
>>>
>>> I would suggest that to handle this well, we need to give user space
>>> more ability to tell the kernel what actions to take on added cores, on
>>> an opt-in basis.
>>>
>>> This could take the form of extending the DLPAR sysfs command set:
>>>
>>> Option 1 - Add a flag that tells the kernel not to online any threads at
>>> all; user space will online the desired threads later.
>>>
>>> Option 2 - Add an option that tells the kernel which SMT mode to apply.
>>
>> powerpc-utils grew some drmgr hooks recently so maybe the policy can be
>> moved to userspace?
> 
> I'm not sure whether the hook mechanism would come into play, but yes, I
> am suggesting that user space be given the option of overriding the
> kernel's current behavior.

I agree, sounds doable using the new drmgr hook mechanism.
