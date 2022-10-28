Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B27610983
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 07:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiJ1FGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 01:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJ1FGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 01:06:30 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2D597D54
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 22:06:26 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29S4g2vh029832;
        Fri, 28 Oct 2022 05:05:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=7Gmvpkjc6jY2xEC5y+Kh/tkZ9ISWjOSHKCfGL8gGIGE=;
 b=Ghqv5R+u2eHsuJlxeBNkEdQFUldPkIUf3+rBnaA8kXHhz0znEYsQaMMoxUYPak7urjsz
 wuJ0xT3nnzhQGivLojDQS969dtU7otPE4dJGomxGVGyEjRz6v0EUDmsgSq8RA0dHT+Mp
 U5dsHwpfu2UdJInN/7gwtVYpCnnbm29BE3b82cXfOGQYZzbwme8ETpUg8cGYgDCiCPn5
 VA9KQEEz17qzbwp357XLIH2r5ZiklM9ya1Ld4/LCG7Ny8vOOITn/CcHzENLc8a6s4VAf
 6oU6SnobceYnNZd/tvX+xmJVkg39Q/zhmjoX7PpxXs+jguVnZzfnhSl42ubOPSuaX0w+ pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg89m0ksu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:05:54 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29S4h1xq034620;
        Fri, 28 Oct 2022 05:05:53 GMT
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3kg89m0kn9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:05:53 +0000
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29S557MU005708;
        Fri, 28 Oct 2022 05:05:50 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma01fra.de.ibm.com with ESMTP id 3kfaht2603-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Oct 2022 05:05:50 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29S55lr817564124
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Oct 2022 05:05:47 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D317CA4040;
        Fri, 28 Oct 2022 05:05:47 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15385A4092;
        Fri, 28 Oct 2022 05:05:45 +0000 (GMT)
Received: from [9.109.205.170] (unknown [9.109.205.170])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Oct 2022 05:05:44 +0000 (GMT)
Message-ID: <59291b98-6907-0acf-df11-6d87681027cc@linux.ibm.com>
Date:   Fri, 28 Oct 2022 10:35:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [RFC] memory tiering: use small chunk size and more tiers
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>,
        Yang Shi <shy828301@gmail.com>
References: <20221027065925.476955-1-ying.huang@intel.com>
 <578c9b89-10eb-1e23-8868-cdd6685d8d4e@linux.ibm.com>
 <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <877d0kk5uf.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: U7R2Bb33ph324x6JVL2wa-Eq7YV6JmxF
X-Proofpoint-GUID: 2daodrFf5J-Y6fpthTV-eAfE8F3DV_sN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-28_02,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 mlxlogscore=890 mlxscore=0 suspectscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210280031
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/22 8:33 AM, Huang, Ying wrote:
> Hi, Aneesh,
> 
> Aneesh Kumar K V <aneesh.kumar@linux.ibm.com> writes:
> 
>> On 10/27/22 12:29 PM, Huang Ying wrote:
>>> We need some way to override the system default memory tiers.  For
>>> the example system as follows,
>>>
>>> type		abstract distance
>>> ----		-----------------
>>> HBM		300
>>> DRAM		1000
>>> CXL_MEM		5000
>>> PMEM		5100
>>>
>>> Given the memory tier chunk size is 100, the default memory tiers
>>> could be,
>>>
>>> tier		abstract distance	types
>>>                 range
>>> ----		-----------------       -----
>>> 3		300-400			HBM
>>> 10		1000-1100		DRAM
>>> 50		5000-5100		CXL_MEM
>>> 51		5100-5200		PMEM
>>>
>>> If we want to group CXL MEM and PMEM into one tier, we have 2 choices.
>>>
>>> 1) Override the abstract distance of CXL_MEM or PMEM.  For example, if
>>> we change the abstract distance of PMEM to 5050, the memory tiers
>>> become,
>>>
>>> tier		abstract distance	types
>>>                 range
>>> ----		-----------------       -----
>>> 3		300-400			HBM
>>> 10		1000-1100		DRAM
>>> 50		5000-5100		CXL_MEM, PMEM
>>>
>>> 2) Override the memory tier chunk size.  For example, if we change the
>>> memory tier chunk size to 200, the memory tiers become,
>>>
>>> tier		abstract distance	types
>>>                 range
>>> ----		-----------------       -----
>>> 1		200-400			HBM
>>> 5		1000-1200		DRAM
>>> 25		5000-5200		CXL_MEM, PMEM
>>>
>>> But after some thoughts, I think choice 2) may be not good.  The
>>> problem is that even if 2 abstract distances are almost same, they may
>>> be put in 2 tier if they sit in the different sides of the tier
>>> boundary.  For example, if the abstract distance of CXL_MEM is 4990,
>>> while the abstract distance of PMEM is 5010.  Although the difference
>>> of the abstract distances is only 20, CXL_MEM and PMEM will put in
>>> different tiers if the tier chunk size is 50, 100, 200, 250, 500, ....
>>> This makes choice 2) hard to be used, it may become tricky to find out
>>> the appropriate tier chunk size that satisfying all requirements.
>>>
>>
>> Shouldn't we wait for gaining experience w.r.t how we would end up
>> mapping devices with different latencies and bandwidth before tuning these values? 
> 
> Just want to discuss the overall design.
> 
>>> So I suggest to abandon choice 2) and use choice 1) only.  This makes
>>> the overall design and user space interface to be simpler and easier
>>> to be used.  The overall design of the abstract distance could be,
>>>
>>> 1. Use decimal for abstract distance and its chunk size.  This makes
>>>    them more user friendly.
>>>
>>> 2. Make the tier chunk size as small as possible.  For example, 10.
>>>    This will put different memory types in one memory tier only if their
>>>    performance is almost same by default.  And we will not provide the
>>>    interface to override the chunk size.
>>>
>>
>> this could also mean we can end up with lots of memory tiers with relative
>> smaller performance difference between them. Again it depends how HMAT
>> attributes will be used to map to abstract distance.
> 
> Per my understanding, there will not be many memory types in a system.
> So, there will not be many memory tiers too.  In most systems, there are
> only 2 or 3 memory tiers in the system, for example, HBM, DRAM, CXL,
> etc. 

So we don't need the chunk size to be 10 because we don't forsee us needing
to group devices into that many tiers. 

> Do you know systems with many memory types?  The basic idea is to
> put different memory types in different memory tiers by default.  If
> users want to group them, they can do that via overriding the abstract
> distance of some memory type.
> 

with small chunk size and depending on how we are going to derive abstract distance,
I am wondering whether we would end up with lots of memory tiers with no 
real value. Hence my suggestion to wait making a change like this till we have
code that map HMAT/CDAT attributes to abstract distance. 




>>
>>> 3. Make the abstract distance of normal DRAM large enough.  For
>>>    example, 1000, then 100 tiers can be defined below DRAM, this is
>>>    more than enough in practice.
>>
>> Why 100? Will we really have that many tiers below/faster than DRAM? As of now 
>> I see only HBM below it.
> 
> Yes.  100 is more than enough.  We just want to avoid to group different
> memory types by default.
> 
> Best Regards,
> Huang, Ying
> 

