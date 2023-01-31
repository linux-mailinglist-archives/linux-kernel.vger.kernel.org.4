Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B238682C88
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 13:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjAaM1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 07:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjAaM1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 07:27:48 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4073A90
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 04:27:47 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VBnaYT025120;
        Tue, 31 Jan 2023 12:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=xB5fUspCTO+VQj/5dpcV2OhNZHk7ltHcKSbXlXQu3hs=;
 b=oM5QzJ9qdL1oa0uyr5yfRNBHnmE/7yjkFFcxsEsie2QO/wsPksmbE0xl1OeW9S0DaeDK
 Jg7md2jZy0KFsGh166KpaOEoZfzIqLG4l2KnaLr2ft54jkvjzEFix6rpOps2Oymnbvle
 TKNttQij4RhhmxYuZUxS7ltnHfs2gxWthN3Z80O4mFOjvDFKz+XfNkUFstNIOTZwbmz+
 sKpj7SBO97EElhnNNzdWke5qSHaDQbXl17qIINhjSP4v0SQeFnGPHOWEDV8o90TDL7po
 mbPlF54MxGROy0wUadW59GVhry4P7Y5FXR1x8gYRT8Y+jmnZmZPrAGUmdPpNVYvVnGI6 Vg== 
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3nf05g4abq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:27:40 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30VADt1W006508;
        Tue, 31 Jan 2023 12:27:39 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3ncvtmbvc4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jan 2023 12:27:39 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30VCRcSf33161968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 12:27:38 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 578655805D;
        Tue, 31 Jan 2023 12:27:38 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 048CE58043;
        Tue, 31 Jan 2023 12:27:35 +0000 (GMT)
Received: from [9.160.34.223] (unknown [9.160.34.223])
        by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Jan 2023 12:27:34 +0000 (GMT)
Message-ID: <7116a13a-6566-3cff-50ef-137d8ed0c7e4@linux.vnet.ibm.com>
Date:   Tue, 31 Jan 2023 17:57:32 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH] hrtimer: interleave timers for improved single thread
 performance at low utilization
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org, arjan@linux.intel.com, mingo@kernel.org,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        svaidy@linux.ibm.com, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de
References: <5ae3cb09-8c9a-11e8-75a7-cc774d9bc283@linux.vnet.ibm.com>
 <877cx30xnt.ffs@tglx>
From:   shrikanth hegde <sshegde@linux.vnet.ibm.com>
In-Reply-To: <877cx30xnt.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IqagJaLwvkz35pqivFWNWLRsJv53wxc3
X-Proofpoint-GUID: IqagJaLwvkz35pqivFWNWLRsJv53wxc3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_07,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301310107
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/23 4:38 PM, Thomas Gleixner wrote:
> On Tue, Jan 31 2023 at 11:18, shrikanth hegde wrote:
>> As per current design of hrtimer, it uses the _softexpires to trigger the
>> timer function.  _softexpires is set as multiple of the period/interval value.
> 
> Wrong. _softexpires is _hardexpires + slack. The slack allows for
> batching which:
> 
Ok. understood.
>> This will benefit the power saving by less wakeups.
> 
This is what i thought was the rationale of _softexpires
> But that has absolutely nothing to do with your problem:
> 
Yes. 
>> Due to this, different timers of the same period/interval values align
>> and the callbacks functions will be called at the same time.
> 
> The whole point of hrtimer_forward_now() is to forward the expiry time
> of a timer with the given period so that it expires after 'now'.
> 
> That's functionality which is used by a lot of callers to implement
> proper periodic timers.
> 
>> Came up with a naive patch, more of hack.
> 
> A broken hack to be precise because any existing user of
> hrtimer_forward() will be broken by this hack.
> 
Agree. Aim was to describe the problem. 
>> Other alternative is to use a slightly modified API for cgroups, so
>> that all other timers align and wakeups remain reduced.
> 
> I'm not seeing why you need a new API for that. The problem is _NOT_ in
> the hrtimer code at all.
> 
> Lets look at the math:
> 
>     expiry = $INITIAL_EXPIRYVALUE + $N * $PERIOD
> 
> If $INITIAL_EXPIRYVALUE is the same then for all instances then
> obviously the expiry values of all instances will be all aligned on
> multiples of $PERIOD, right?
> 
> So why the heck do you need a new hrtimer API? There is an obvious
> solution, right?
> 
> Thanks,
> 
>         tglx

Thanks Thomas for taking a look and correcting wrong bits here.  The problem    
here was that $INITIAL_EXPIRYVALUE was never set. Hence the _softexpires was    
always set as the Multiple of $PERIOD.                                          
                                                                                
As Ingo Suggested this, this can be done in sched code. would need to set the    
$INITIAL_EXPIRYVALUE in start_cfs_bandwidth and Timers would interleave on the  
same logic which was described in the patch.                                    
                                                                                
No change in hrtimer code  would be needed. will send out the patch after some  
more testing.
