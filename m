Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9764773B2D5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 10:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbjFWIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 04:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjFWIle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 04:41:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5F310C2;
        Fri, 23 Jun 2023 01:41:32 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35N8ei0q008734;
        Fri, 23 Jun 2023 08:41:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=wbDpukB6EcoDMgMhtdtYou3jl/+Z9bf22pAkaqy4JPQ=;
 b=sSIyXqaZfghlh5i9uh2w1gT9JP5qu19yqZSo1hyyi6+8hJFsl+5XbyVcFKpsWiAoy8Pe
 81nfIiZCXFeAke0Vmit4I6pCd1a5eY0vHZcIa7cRLmBCtKkXd/MrM10Jxd4lFkVfoDjb
 8mAy4gX65hwxqO0rNSOSxHL+1i85R7Ahbxv1RW8y/Gsq0Wrf2mvPPahMUZ9vKA6qDjvw
 8WMePMuxXeNodKHVGDKoZIISjsXpfw5FQEf+jScxoemZ0IFMX3DEktdGbq2GWGu+LKw3
 YRNPvt8WpUM+wGk2Gbm8BgnrJw2AvFdPGBQkRaH+sAXW+CzyFQXB/mem2GNqNr0gZBc2 DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd7upre2c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 08:41:09 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35N8erGS009097;
        Fri, 23 Jun 2023 08:41:09 GMT
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rd7upre1u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 08:41:09 +0000
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35N7dHUt001270;
        Fri, 23 Jun 2023 08:41:07 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([9.208.130.97])
        by ppma05wdc.us.ibm.com (PPS) with ESMTPS id 3r94f6e0gq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 23 Jun 2023 08:41:07 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
        by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35N8f7D342991886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 23 Jun 2023 08:41:07 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 113FB58068;
        Fri, 23 Jun 2023 08:41:07 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF3ED58056;
        Fri, 23 Jun 2023 08:41:01 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.18.202])
        by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 23 Jun 2023 08:41:01 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Vishal Verma <vishal.l.verma@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org, Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] mm/memory_hotplug: Allow an override for the
 memmap_on_memory param
In-Reply-To: <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
 <20230613-vv-kmem_memmap-v1-1-f6de9c6af2c6@intel.com>
Date:   Fri, 23 Jun 2023 14:10:58 +0530
Message-ID: <87mt0qy3j9.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -2aAWK_DDa6XyaRL594jM6M3_jR34vSM
X-Proofpoint-GUID: af9dV7ZApH8KD2C7zgQKTGsabPIJtEn6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-23_03,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 clxscore=1011 suspectscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306230076
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vishal Verma <vishal.l.verma@intel.com> writes:

> For memory hotplug to consider MHP_MEMMAP_ON_MEMORY behavior, the
> 'memmap_on_memory' module parameter was a hard requirement.
>
> In preparation for the dax/kmem driver to use memmap_on_memory
> semantics, arrange for the module parameter check to be bypassed via the
> appropriate mhp_flag.
>
> Recall that the kmem driver could contribute huge amounts of hotplugged
> memory originating from special purposes devices such as CXL memory
> expanders. In some cases memmap_on_memory may be the /only/ way this new
> memory can be hotplugged. Hence it makes sense for kmem to have a way to
> force memmap_on_memory without depending on a module param, if all the
> other conditions for it are met.
>
> The only other user of this interface is acpi/acpi_memoryhotplug.c,
> which only enables the mhp_flag if an initial
> mhp_supports_memmap_on_memory() test passes. Maintain the existing
> behavior and semantics for this by performing the initial check from
> acpi without the MHP_MEMMAP_ON_MEMORY flag, so its decision falls back
> to the module parameter.
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  include/linux/memory_hotplug.h |  2 +-
>  drivers/acpi/acpi_memhotplug.c |  2 +-
>  mm/memory_hotplug.c            | 24 ++++++++++++++++--------
>  3 files changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
> index 9fcbf5706595..c9ddcd3cad70 100644
> --- a/include/linux/memory_hotplug.h
> +++ b/include/linux/memory_hotplug.h
> @@ -358,7 +358,7 @@ extern struct zone *zone_for_pfn_range(int online_type, int nid,
>  extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
>  				      struct mhp_params *params);
>  void arch_remove_linear_mapping(u64 start, u64 size);
> -extern bool mhp_supports_memmap_on_memory(unsigned long size);
> +extern bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags);
>  #endif /* CONFIG_MEMORY_HOTPLUG */
>  
>  #endif /* __LINUX_MEMORY_HOTPLUG_H */
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 24f662d8bd39..119d3bb49753 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -211,7 +211,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
>  		if (!info->length)
>  			continue;
>  
> -		if (mhp_supports_memmap_on_memory(info->length))
> +		if (mhp_supports_memmap_on_memory(info->length, 0))
>  			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
>  		result = __add_memory(mgid, info->start_addr, info->length,
>  				      mhp_flags);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 8e0fa209d533..bb3845830922 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1283,15 +1283,21 @@ static int online_memory_block(struct memory_block *mem, void *arg)
>  	return device_online(&mem->dev);
>  }
>  
> -bool mhp_supports_memmap_on_memory(unsigned long size)
> +bool mhp_supports_memmap_on_memory(unsigned long size, mhp_t mhp_flags)
>  {
>  	unsigned long nr_vmemmap_pages = size / PAGE_SIZE;
>  	unsigned long vmemmap_size = nr_vmemmap_pages * sizeof(struct page);
>  	unsigned long remaining_size = size - vmemmap_size;
>  
>  	/*
> -	 * Besides having arch support and the feature enabled at runtime, we
> -	 * need a few more assumptions to hold true:
> +	 * The MHP_MEMMAP_ON_MEMORY flag indicates a caller that wants to force
> +	 * memmap_on_memory (if other conditions are met), regardless of the
> +	 * module parameter. drivers/dax/kmem.c is an example, where large
> +	 * amounts of hotplug memory may come from, and the only option to
> +	 * successfully online all of it is to place the memmap on this memory.
> +	 *
> +	 * Besides having arch support and the feature enabled at runtime or
> +	 * via the mhp_flag, we need a few more assumptions to hold true:
>  	 *
>  	 * a) We span a single memory block: memory onlining/offlinin;g happens
>  	 *    in memory block granularity. We don't want the vmemmap of online
> @@ -1315,10 +1321,12 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
>  	 *       altmap as an alternative source of memory, and we do not exactly
>  	 *       populate a single PMD.
>  	 */
> -	return mhp_memmap_on_memory() &&
> -	       size == memory_block_size_bytes() &&
> -	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> -	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
> +
> +	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) || mhp_memmap_on_memory())
> +		return size == memory_block_size_bytes() &&
> +		       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
> +		       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
> +	return false;
>  }
>  
>  /*
> @@ -1375,7 +1383,7 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
>  	 * Self hosted memmap array
>  	 */
>  	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
> -		if (!mhp_supports_memmap_on_memory(size)) {
> +		if (!mhp_supports_memmap_on_memory(size, mhp_flags)) {
>  			ret = -EINVAL;
>  			goto error;
>  		}
>

I was working on enabling memmap_on_memory for ppc64 and came across
this. Can we do this as below?

commit d55eddf71032cad3e057d8fa4c61ad2b8e05aaa8
Author: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Date:   Fri Jun 23 12:11:31 2023 +0530

    mm/hotplug: Allow to force enable memmap on memory
    
    In some cases like DAX kmem, we want to enable memmap on memory
    even if we have memory_hotplug.memmap_on_memory disabled. This
    patch enables such usage. DAX kmem can use MHP_MEMMAP_ON_MEMORY
    directly to request for memmap on memory.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
index 24f662d8bd39..4d0096fc4cc2 100644
--- a/drivers/acpi/acpi_memhotplug.c
+++ b/drivers/acpi/acpi_memhotplug.c
@@ -211,8 +211,7 @@ static int acpi_memory_enable_device(struct acpi_memory_device *mem_device)
 		if (!info->length)
 			continue;
 
-		if (mhp_supports_memmap_on_memory(info->length))
-			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+		mhp_flags |= get_memmap_on_memory_flags();
 		result = __add_memory(mgid, info->start_addr, info->length,
 				      mhp_flags);
 
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 9fcbf5706595..f7f534084393 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -359,6 +359,13 @@ extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
 				      struct mhp_params *params);
 void arch_remove_linear_mapping(u64 start, u64 size);
 extern bool mhp_supports_memmap_on_memory(unsigned long size);
+bool mhp_memmap_on_memory(void);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
+static inline unsigned long get_memmap_on_memory_flags(void)
+{
+	if (mhp_memmap_on_memory())
+		return MHP_MEMMAP_ON_MEMORY;
+	return 0;
+}
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index eb18d1ac7e84..85d29909fd89 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -50,7 +50,7 @@ static bool memmap_on_memory __ro_after_init;
 module_param(memmap_on_memory, bool, 0444);
 MODULE_PARM_DESC(memmap_on_memory, "Enable memmap on memory for memory hotplug");
 
-static inline bool mhp_memmap_on_memory(void)
+bool mhp_memmap_on_memory(void)
 {
 	return memmap_on_memory;
 }
@@ -1316,10 +1316,9 @@ bool mhp_supports_memmap_on_memory(unsigned long size)
 	 *       altmap as an alternative source of memory, and we do not exactly
 	 *       populate a single PMD.
 	 */
-	return mhp_memmap_on_memory() &&
-	       size == memory_block_size_bytes() &&
-	       IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
-	       IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
+	return size == memory_block_size_bytes() &&
+		IS_ALIGNED(vmemmap_size, PMD_SIZE) &&
+		IS_ALIGNED(remaining_size, (pageblock_nr_pages << PAGE_SHIFT));
 }
 
 /*

