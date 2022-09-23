Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6BB45E787D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 12:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbiIWKgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 06:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbiIWKgP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 06:36:15 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA3C122619
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 03:36:13 -0700 (PDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28N9xZps016526;
        Fri, 23 Sep 2022 10:35:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ooxMihpH152oG5VCj9k8zT0AYwKGGyXZsd3SxSfv/Mg=;
 b=YSmP1tBiERN4CvL/u1SFXYI2gtimnBHgDWwwQCbsnFSd1D8e2FN7AJmwdDjVbph0jNTi
 4zJkIMyXbwR1yXbbFpeb/qV5Unz01W3luNh4nxQIkDlLrIU+8ZkTsxWoO3Otx3W5hzSG
 U5QYvU/fkbLtXja79Qzo7Vnf8MMNsDs2sUCjiwWG/acXzGzdsvEkIZsn/rwrJJi2iwf7
 jGOSXwEaBpqEBW6sWy+yHBJ+LvMdQ5dewGOnTFiv8dI95ik4gsCP2Zv5eOeTgckkU+qg
 NxzdlumeoAV89fkgTjWSGcCHnG3hQVOrLtY1D8VLqm0b/ne1jQmoay/j4Bw9h4aJ+Ume 2w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js8necbyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 10:35:46 +0000
Received: from m0098420.ppops.net (m0098420.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 28N89EQ0000401;
        Fri, 23 Sep 2022 10:35:46 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3js8necbxa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 10:35:45 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 28NAZi2A014518;
        Fri, 23 Sep 2022 10:35:44 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 3jn5ghnv3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Sep 2022 10:35:43 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 28NAa8YR39977348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Sep 2022 10:36:08 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6202CAE059;
        Fri, 23 Sep 2022 10:35:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A1EF5AE057;
        Fri, 23 Sep 2022 10:35:36 +0000 (GMT)
Received: from [9.43.40.22] (unknown [9.43.40.22])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 23 Sep 2022 10:35:36 +0000 (GMT)
Message-ID: <3a966604-77c5-e6fc-1541-2fed7c71cc0c@linux.ibm.com>
Date:   Fri, 23 Sep 2022 16:05:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: [PATCH v4] mm/demotion: Expose memory tier details via sysfs
Content-Language: en-US
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com,
        Bharata B Rao <bharata@amd.com>
References: <20220922102201.62168-1-aneesh.kumar@linux.ibm.com>
 <874jwyjyy9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Aneesh Kumar K V <aneesh.kumar@linux.ibm.com>
In-Reply-To: <874jwyjyy9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: INbxC0JoIBAkkr3j-pMzcrV5m05BRPRE
X-Proofpoint-ORIG-GUID: X6-BGHRBFgUjWrMlgzwXW4O5k3W1p20y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-23_02,2022-09-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2209230068
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/23/22 1:37 PM, Huang, Ying wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> This patch adds /sys/devices/virtual/memory_tiering/ where all memory tier
>> related details can be found. All allocated memory tiers will be listed
>> there as /sys/devices/virtual/memory_tiering/memory_tierN/
>>
>> The nodes which are part of a specific memory tier can be listed via
>> /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> 
> It appears that XXXs is used for mask while XXXs_list is used for list?
> For example,
> 
> # cat /sys/devices/system/cpu/cpu2/topology/core_cpus
> 0,00100004
> # cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
> 2,20
> 
> It's better to follow the this convention?
> 

That is not followed in other parts of the kernel. I was loking at cpuset 

$cat cpuset.cpus.effective 
0-7




>> A directory hierarchy looks like
>> :/sys/devices/virtual/memory_tiering$ tree memory_tier4/
>> memory_tier4/
>> ├── nodes
>> ├── subsystem -> ../../../../bus/memory_tiering
>> └── uevent
>>
>> :/sys/devices/virtual/memory_tiering$ cat memory_tier4/nodes
>> 0,2
>>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> Best Regards,
> Huang, Ying
> 
> [snip]

