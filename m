Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85386626E71
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 09:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiKMIHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 03:07:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbiKMIHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 03:07:47 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1853C1263A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 00:07:47 -0800 (PST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.5) with ESMTP id 2AD7rTZ8025608;
        Sun, 13 Nov 2022 08:02:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=hLdxzrFVlJZEbaCxWDQ6zbhK4CRN1hXW8wjFLLufZ/c=;
 b=OPJ4yPEiEvRUM7sQEgubLGMj/RUsm6HbUoJDbo0qTj4LgQcfv7g8VdIpPtHGFfARtZDt
 pOa6JXsJAW4n9wENUSEop/Za0/X1nsfdd0PTsDlbflfV2Bt6F0oN2jNkR5lhhI06oQIE
 tv0X0SQ3rK0ti2Rhyjr4wj3clEV3da3zno7hPuSqxoGpus1ek29XuUGqEPtx2AZp/sCF
 gP+tpRqVVYibtxckwfnnUaI1bCNUfgrEZgiKITjOqXSeF/QL1qpckQcW3yqpPgXCeZM2
 2jHvtaShbzZ2sTljo8M9CLiWTowLglMAjetHvWzhY1DgiIeCR6EszII10krnXZRkUFJj bA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktvkbr4nq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:02:34 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2AD7t8C4029800;
        Sun, 13 Nov 2022 08:02:33 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ktvkbr4kf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:02:33 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2AD7od5i023792;
        Sun, 13 Nov 2022 08:02:26 GMT
Received: from b03cxnp07029.gho.boulder.ibm.com (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
        by ppma05wdc.us.ibm.com with ESMTP id 3kt349exmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Nov 2022 08:02:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com ([9.208.128.128])
        by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2AD82NmD35652262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 13 Nov 2022 08:02:24 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E5B85805E;
        Sun, 13 Nov 2022 08:02:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656385805F;
        Sun, 13 Nov 2022 08:02:06 +0000 (GMT)
Received: from [9.160.60.23] (unknown [9.160.60.23])
        by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Sun, 13 Nov 2022 08:02:06 +0000 (GMT)
Message-ID: <d0edcb38-709f-2c29-b541-cc39d41d378c@linux.vnet.ibm.com>
Date:   Sun, 13 Nov 2022 13:32:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 5/9] sched/fair: Take into account latency priority at
 wakeup
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
References: <20221028093403.6673-1-vincent.guittot@linaro.org>
 <20221028093403.6673-6-vincent.guittot@linaro.org>
From:   shrikanth suresh hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <20221028093403.6673-6-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: aUykjjNO4y5JlxuTcXihL3uojkl9vVPy
X-Proofpoint-ORIG-GUID: RgB-3o6gPkAQDD03utkm-7goZ8rhhTqa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-13_05,2022-11-11_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211130049
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>   /*
>    * Preempt the current task with a newly woken task if needed:
>    */
> @@ -4566,7 +4568,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>   {
>   	unsigned long ideal_runtime, delta_exec;
>   	struct sched_entity *se;
> -	s64 delta;
> +	s64 delta, offset;
>   
>   	ideal_runtime = sched_slice(cfs_rq, curr);
>   	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
> @@ -4591,10 +4593,12 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>   	se = __pick_first_entity(cfs_rq);
>   	delta = curr->vruntime - se->vruntime;
>   
> -	if (delta < 0)
> +	offset = wakeup_latency_gran(curr, se);
> +	if (delta < offset)
>   		return;
>   
> -	if (delta > ideal_runtime)
> +	if ((delta > ideal_runtime) ||
> +	    (delta > get_latency_max()))
>   		resched_curr(rq_of(cfs_rq));
>   }
>   
>
Hi Vincent,

I am not sure if i have understood this below change correctly.

wakeup_latency_gran - this function returns difference in latency nice offsets.
Hence the more negative the value, it means se has more latency requirement
compared to current. Hence se should preempt the current here right?
  
we are comparing delta to get_latency_max and ideal_runtime, both of which can
be higher positive value, hence we will not preempt. that is not what we want
right?

