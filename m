Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5F5260562B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiJTD6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiJTD6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:58:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6341A0C37
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:58:34 -0700 (PDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29K3EQv3008940;
        Thu, 20 Oct 2022 03:58:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=vW4o+CsUymmKrBV1g3y7S7jSyvhovk+xCA/YYHh7cjI=;
 b=AJnLrHyp/rWfV9soh1OVv3Kz3ky+BMRXDgZuVZfwOgljkZnAtQDJdyl40HlqceRsd8Qv
 X9SaPKoVvfy+RXqIskJ9wOQOXfAF5QL96y8doh/9b8nV1H79KGEbef82OQ4QuTJKiay/
 c8ZVsPM5eCNhPcyOwySJPMrRRNDm4fB431t/kodWO3xay38XUZnG8mnlOliB4yOaqV0c
 KOC8cpwPARClwqfngNRuK7SKhGr5rLjI9zuf0c2xtVt8f0Tsty2QUtBUWbfN4q9B93F1
 8kmc3H29vkNe3V3dVeEfsY/NHY28SG5gesvf9ZMpQFKim+ookQ04uIvaAth//sAVN3kt ig== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3katdyxsbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 03:58:05 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 29K3lqbT028300;
        Thu, 20 Oct 2022 03:58:04 GMT
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3katdyxsb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 03:58:04 +0000
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 29K3pRCi017277;
        Thu, 20 Oct 2022 03:58:03 GMT
Received: from b03cxnp08025.gho.boulder.ibm.com (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
        by ppma04dal.us.ibm.com with ESMTP id 3k7mgbgysx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 20 Oct 2022 03:58:03 +0000
Received: from smtpav01.dal12v.mail.ibm.com ([9.208.128.133])
        by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 29K3w0dD59113800
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 20 Oct 2022 03:58:00 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8469858062;
        Thu, 20 Oct 2022 03:58:01 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DDD9F58057;
        Thu, 20 Oct 2022 03:57:55 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.20.46])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 20 Oct 2022 03:57:55 +0000 (GMT)
X-Mailer: emacs 29.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>,
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
Subject: Re: [PATCH] memory tier, sysfs: rename attribute "nodes" to "nodelist"
In-Reply-To: <20221020015122.290097-1-ying.huang@intel.com>
References: <20221020015122.290097-1-ying.huang@intel.com>
Date:   Thu, 20 Oct 2022 09:27:52 +0530
Message-ID: <874jvzdu4f.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AVbrlLe7IWdOWc_CwrKsVXoo5XGxrfJl
X-Proofpoint-GUID: Y-Duv5DpQLjM87HM65AkQcGmzn_er7MV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-19_13,2022-10-19_04,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 priorityscore=1501 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2210200018
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang Ying <ying.huang@intel.com> writes:

> In sysfs, we use attribute name "cpumap" or "cpus" for cpu mask and
> "cpulist" or "cpus_list" for cpu list.  For example, in my system,
>
>  $ cat /sys/devices/system/node/node0/cpumap
>  f,ffffffff
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>  0,00100004
>  $ cat cat /sys/devices/system/node/node0/cpulist
>  0-35
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>  2,20
>
> It looks reasonable to use "nodemap" for node mask and "nodelist" for
> node list.  So, rename the attribute to follow the naming convention.
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Hesham Almatary <hesham.almatary@huawei.com>
> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers | 4 ++--
>  mm/memory-tiers.c                                      | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> index 45985e411f13..721a05b90109 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> @@ -10,7 +10,7 @@ Description:	A collection of all the memory tiers allocated.
>  
>  
>  What:		/sys/devices/virtual/memory_tiering/memory_tierN/
> -		/sys/devices/virtual/memory_tiering/memory_tierN/nodes
> +		/sys/devices/virtual/memory_tiering/memory_tierN/nodelist
>  Date:		August 2022
>  Contact:	Linux memory management mailing list <linux-mm@kvack.org>
>  Description:	Directory with details of a specific memory tier
> @@ -21,5 +21,5 @@ Description:	Directory with details of a specific memory tier
>  		A smaller value of N implies a higher (faster) memory tier in the
>  		hierarchy.
>  
> -		nodes: NUMA nodes that are part of this memory tier.
> +		nodelist: NUMA nodes that are part of this memory tier.
>  
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index f116b7b6333e..fa8c9d07f9ce 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
>  	kfree(tier);
>  }
>  
> -static ssize_t nodes_show(struct device *dev,
> -			  struct device_attribute *attr, char *buf)
> +static ssize_t nodelist_show(struct device *dev,
> +			     struct device_attribute *attr, char *buf)
>  {
>  	int ret;
>  	nodemask_t nmask;
> @@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
>  	mutex_unlock(&memory_tier_lock);
>  	return ret;
>  }
> -static DEVICE_ATTR_RO(nodes);
> +static DEVICE_ATTR_RO(nodelist);
>  
>  static struct attribute *memtier_dev_attrs[] = {
> -	&dev_attr_nodes.attr,
> +	&dev_attr_nodelist.attr,
>  	NULL
>  };
>  
> -- 
> 2.35.1
