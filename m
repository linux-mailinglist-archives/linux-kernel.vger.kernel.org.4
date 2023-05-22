Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3752270B72F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 09:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjEVH56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 03:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbjEVH5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 03:57:35 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5404E1713
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 00:56:51 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M7MUNW009047;
        Mon, 22 May 2023 07:56:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=3QrsntSsD4Hu78UtO76TcdO0ktwTOOqOoVfo2qZoV+s=;
 b=f1sbLPZJNEZ19j7ldKs8JPKIDZmDnSK6wDBVsDvFKKhr6h15CypoUSvxdYIGso8Gaz+y
 +jeOYMTtMktkd6VOluMepLqo54f1tFejqe884hNzqVe0/muy4lK47bC723ZXjWvGetpQ
 ZWmPmvH2gtUgQUTGjRNFxxTtSFwbwMozntrEwhlEbRLKxgP/pprhBKC2iCFk0zG9Kxvm
 s2rSUR4LpZWI0E/tNT+xn5nDNBQRJ1pSaI7bSVFGc0ofv5GcqeLlC6O5DhPUr+GaZXIe
 O6oUQ6Rz8r2AOIXgUy+Mtnv8Do8AAT1QARaY3BcXlvyrty/2ot+/k+Xu4jHMqf4Y8b4I Hg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq7qjc4rt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:56:21 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34M7PbTc018270;
        Mon, 22 May 2023 07:56:20 GMT
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qq7qjc4qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:56:20 +0000
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34M4tcJB018060;
        Mon, 22 May 2023 07:56:18 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01wdc.us.ibm.com (PPS) with ESMTPS id 3qppdq9cat-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 May 2023 07:56:18 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34M7uISH38601404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 07:56:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 04EFE58061;
        Mon, 22 May 2023 07:56:18 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D937D58057;
        Mon, 22 May 2023 07:55:56 +0000 (GMT)
Received: from [9.171.17.157] (unknown [9.171.17.157])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 22 May 2023 07:55:56 +0000 (GMT)
Message-ID: <69a4403e-354c-7380-56e0-d311a5d1d918@linux.vnet.ibm.com>
Date:   Mon, 22 May 2023 13:25:54 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 00/12] sched: Avoid unnecessary migrations within SMT
 domains
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ricardo Neri <ricardo.neri@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Len Brown <len.brown@intel.com>, Mel Gorman <mgorman@suse.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        naveen.n.rao@linux.vnet.ibm.com,
        Peter Zijlstra <peterz@infradead.org>
References: <20230406203148.19182-1-ricardo.neri-calderon@linux.intel.com>
 <20230429153219.GC1495785@hirez.programming.kicks-ass.net>
 <de79bd2c-42cb-23f2-a951-5a5caab0bacf@linux.vnet.ibm.com>
 <20230519000335.GB24449@ranerica-svr.sc.intel.com>
Content-Language: en-US
From:   Shrikanth Hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20230519000335.GB24449@ranerica-svr.sc.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2x3TEsZ9Xux7J9XgvITu3pF5ZQvF3SY9
X-Proofpoint-GUID: bDq545VF_extdebLH0OlXU3H29F8Tziz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_04,2023-05-17_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 impostorscore=0
 mlxscore=0 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305220064
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/19/23 5:33 AM, Ricardo Neri wrote:
> On Fri, May 12, 2023 at 11:53:48PM +0530, Shrikanth Hegde wrote:
>>
>>
>> On 4/29/23 9:02 PM, Peter Zijlstra wrote:
>>> On Thu, Apr 06, 2023 at 01:31:36PM -0700, Ricardo Neri wrote:
>>>> Hi,
>>>>
>>>> This is v4 of this series. Previous versions can be found here [1], [2],
>>>> and here [3]. To avoid duplication, I do not include the cover letter of
>>>> the original submission. You can read it in [1].
>>>>
>>>> This patchset applies cleanly on today's master branch of the tip tree.
>>>>
>>>> Changes since v3:
>>>>
>>>> Nobody liked the proposed changes to the setting of prefer_sibling.
>>>> Instead, I tweaked the solution that Dietmar proposed. Now the busiest
>>>> group, not the local group, determines the setting of prefer_sibling.
>>>>
>>>> Vincent suggested improvements to the logic to decide whether to follow
>>>> asym_packing priorities. Peter suggested to wrap that in a helper function.
>>>> I added sched_use_asym_prio().
>>>>
>>>> Ionela found that removing SD_ASYM_PACKING from the SMT domain in x86
>>>> rendered sd_asym_packing NULL in SMT cores. Now highest_flag_domain()
>>>> does not assume that all child domains have the requested flag.
>>>>
>>>> Tim found that asym_active_balance() needs to also check for the idle
>>>> states of the SMT siblings of lb_env::dst_cpu. I added such check.
>>>>
>>>> I wrongly assumed that asym_packing could only be used when the busiest
>>>> group had exactly one busy CPU. This broke asym_packing balancing at the
>>>> DIE domain. I limited this check to balances between cores at the MC
>>>> level.
>>>>
>>>> As per suggestion from Dietmar, I removed sched_asym_smt_can_pull_tasks()
>>>> and placed its logic in sched_asym(). Also, sched_asym() uses
>>>> sched_smt_active() to skip checks when not needed.
>>>>
>>>> I also added a patch from Chen Yu to enable asym_packing balancing in
>>>> Meteor Lake, which has CPUs of different maximum frequency in more than
>>>> one die.
>>>
>>> Is the actual topology of Meteor Lake already public? This patch made me
>>> wonder if we need SCHED_CLUSTER topology in the hybrid_topology thing,
>>> but I can't remember (one of the raisins why the endless calls are such
>>> a frigging waste of time) and I can't seem to find the answer using
>>> Google either.
>>>
>>>> Hopefully, these patches are in sufficiently good shape to be merged?
>>>
>>> Changelogs are very sparse towards the end and I had to reverse engineer
>>> some of it which is a shame. But yeah, on a first reading the code looks
>>> mostly ok. Specifically 8-10 had me WTF a bit and only at 11 did it
>>> start to make a little sense. Mostly they utterly fail to answer the
>>> very fundament "why did you do this" question.
>>>
>>> Also, you seem to have forgotten to Cc our friends from IBM such that
>>> they might verify you didn't break their Power7 stuff -- or do you have
>>> a Power7 yourself to verify and forgot to mention that?
>>
>> Very good patch series in addressing asym packing. Interesting discussions as
>> well. Took me quite sometime to get through to understand and do a little bit
>> of testing.
>>
>> Tested this patch a bit on power7 with qemu. Tested with SMT=4. sched domains
>> show ASYM_PACKING present only for SMT domain.
>>
>> We don't see any regressions/gain due to patch. SMT priorities are honored when
>> tasks are scheduled and load_balanced.
> 
> Thank you very much for your review and testing! Would you mind sharing the
> qemu command you use? I would like to test my future patches on power7.

Sure. I tried this qemu command on a Power9 system. It loads in compat mode.
This would simulate 4Core and SMT4 
you need the have CONFIG_POWER7_CPU=y and CONFIG_CPU_BIG_ENDIAN=y and right
qcow2 image. 

qemu-system-ppc64 -M pseries,accel=kvm,max-cpu-compat=power7 -m 8192 -smp cores=4,threads=4 -enable-kvm  -drive file=<qcow2_image>,format=qcow2 -vga none -nographic -net nic -net user,hostfwd=tcp::2222-:22 -kernel ./<custom_vmlinux> --append "noautotest root=/dev/sda2"


> 
> BR,
> Ricardo
