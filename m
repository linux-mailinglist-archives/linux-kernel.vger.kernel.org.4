Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0FB7362EE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 07:03:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjFTFDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 01:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjFTFDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 01:03:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C09DF
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687237400; x=1718773400;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=cnS/cu2Wflxtyu8R7xE428+IO3kIRTADI/+XFzqP+Yw=;
  b=bMexGHWEqg8ow2X5+tfclcm8aRK0gqEeU2VrGQiU1Hh2EHem3ytOwvso
   UHjDY8M9nNCUbIiykFcf6LVQSHgqs/bTjvVvDb4IY5NFYjI+lFfChv321
   ijJa/0SptdHBWEndNA2yIdx69Usb7k9BjGbj00hoyiXjMBJxU7349YLqQ
   WuY1z0hJUH0PjBdo3pCVJklPbMMjA2Lafj+4KJuiezL1i/5EO2NKi35YT
   TPO47opqLqm4+LQbv6hgU/QJRybP+bKgB2OPczjfUV6Hcr4ncHe2CvkSl
   EpbmDbJduO/YX+sV4iCzvcK9zDvxAw93/s0QbzLqYPvm+mM0ovtjdaBv0
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="349494973"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="349494973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:03:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="664152869"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; 
   d="scan'208";a="664152869"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 22:03:16 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: Re: [RFC 3/4] acpi, hmat: calculate abstract distance with HMAT
References: <20230616070538.190042-1-ying.huang@intel.com>
        <20230616070538.190042-4-ying.huang@intel.com>
        <87352nifox.fsf@linux.ibm.com>
Date:   Tue, 20 Jun 2023 13:01:41 +0800
In-Reply-To: <87352nifox.fsf@linux.ibm.com> (Aneesh Kumar K. V.'s message of
        "Mon, 19 Jun 2023 21:53:42 +0530")
Message-ID: <87352m916y.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Aneesh,

Thanks for your comments.

"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> Huang Ying <ying.huang@intel.com> writes:
>
>> A memory tiering abstract distance calculation algorithm based on ACPI
>> HMAT is implemented.  The basic idea is as follows.
>>
>> The performance attributes of system default DRAM nodes are recorded
>> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
>> Then, the ratio of the abstract distance of a memory node (target) to
>> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
>> attributes of the node to that of the default DRAM nodes.
>>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Hansen <dave.hansen@intel.com>
>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>> Cc: Johannes Weiner <hannes@cmpxchg.org>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Cc: Michal Hocko <mhocko@kernel.org>
>> Cc: Yang Shi <shy828301@gmail.com>
>> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/acpi/numa/hmat.c     | 124 ++++++++++++++++++++++++++++++++++-
>>  include/linux/memory-tiers.h |   2 +
>>  mm/memory-tiers.c            |   2 +-
>>  3 files changed, 126 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
>> index 2dee0098f1a9..21e4deb581ad 100644
>> --- a/drivers/acpi/numa/hmat.c
>> +++ b/drivers/acpi/numa/hmat.c
>> @@ -24,6 +24,7 @@
>>  #include <linux/node.h>
>>  #include <linux/sysfs.h>
>>  #include <linux/dax.h>
>> +#include <linux/memory-tiers.h>
>>  
>>  static u8 hmat_revision;
>>  static int hmat_disable __initdata;
>> @@ -759,6 +760,123 @@ static int hmat_callback(struct notifier_block *self,
>>  	return NOTIFY_OK;
>>  }
>>  
>> +static int hmat_adistance_disabled;
>> +static struct node_hmem_attrs default_dram_attrs;
>> +
>> +static void dump_hmem_attrs(struct node_hmem_attrs *attrs)
>> +{
>> +	pr_cont("read_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
>> +		attrs->read_latency, attrs->write_latency,
>> +		attrs->read_bandwidth, attrs->write_bandwidth);
>> +}
>> +
>> +static void disable_hmat_adistance_algorithm(void)
>> +{
>> +	hmat_adistance_disabled = true;
>> +}
>> +
>> +static int hmat_init_default_dram_attrs(void)
>> +{
>> +	struct memory_target *target;
>> +	struct node_hmem_attrs *attrs;
>> +	int nid, pxm;
>> +	int nid_dram = NUMA_NO_NODE;
>> +
>> +	if (default_dram_attrs.read_latency +
>> +	    default_dram_attrs.write_latency != 0)
>> +		return 0;
>> +
>> +	if (!default_dram_type)
>> +		return -EIO;
>> +
>> +	for_each_node_mask(nid, default_dram_type->nodes) {
>> +		pxm = node_to_pxm(nid);
>> +		target = find_mem_target(pxm);
>> +		if (!target)
>> +			continue;
>> +		attrs = &target->hmem_attrs[1];
>> +		if (nid_dram == NUMA_NO_NODE) {
>> +			if (attrs->read_latency + attrs->write_latency == 0 ||
>> +			    attrs->read_bandwidth + attrs->write_bandwidth == 0) {
>> +				pr_info("hmat: invalid hmem attrs for default DRAM node: %d,\n",
>> +					nid);
>> +				pr_info("  ");
>> +				dump_hmem_attrs(attrs);
>> +				pr_info("  disable hmat based abstract distance algorithm.\n");
>> +				disable_hmat_adistance_algorithm();
>> +				return -EIO;
>> +			}
>> +			nid_dram = nid;
>> +			default_dram_attrs = *attrs;
>> +			continue;
>> +		}
>> +		if (abs(attrs->read_latency - default_dram_attrs.read_latency) * 10 >
>> +		    default_dram_attrs.read_latency ||
>> +		    abs(attrs->write_latency - default_dram_attrs.write_latency) * 10 >
>> +		    default_dram_attrs.write_latency ||
>> +		    abs(attrs->read_bandwidth - default_dram_attrs.read_bandwidth) * 10 >
>> +		    default_dram_attrs.read_bandwidth) {
>> +			pr_info("hmat: hmem attrs for DRAM nodes mismatch.\n");
>> +			pr_info("  node %d:", nid_dram);
>> +			dump_hmem_attrs(&default_dram_attrs);
>> +			pr_info("  node %d:", nid);
>> +			dump_hmem_attrs(attrs);
>> +			pr_info("  disable hmat based abstract distance algorithm.\n");
>> +			disable_hmat_adistance_algorithm();
>> +			return -EIO;
>> +		}
>
> What is this check about? what is the significance of 10? Can you add
> the details as a code comment ?

We want to check the validity of HMAT here.  We expect the performance
of all default DRAM nodes are almost same, that is, the variation is
less than 10%.  And that will be used as base to calculate the abstract
distance of other memory devices.  If there is large variation among the
performance of default DRAM nodes, it's hard to set a reasonable base
for abstract distance calculation.

I will add some comments for this in the next version.

>
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int hmat_calculate_adistance(struct notifier_block *self,
>> +				    unsigned long nid, void *data)
>> +{
>> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
>> +	struct memory_target *target;
>> +	struct node_hmem_attrs *attrs;
>> +	int *adist = data;
>> +	int pxm;
>> +
>> +	if (hmat_adistance_disabled)
>> +		return NOTIFY_OK;
>> +
>> +	pxm = node_to_pxm(nid);
>> +	target = find_mem_target(pxm);
>> +	if (!target)
>> +		return NOTIFY_OK;
>> +
>> +	if (hmat_init_default_dram_attrs())
>> +		return NOTIFY_OK;
>> +
>> +	mutex_lock(&target_lock);
>> +	hmat_update_target_attrs(target, p_nodes, 1);
>> +	mutex_unlock(&target_lock);
>> +
>> +	attrs = &target->hmem_attrs[1];
>> +
>> +	if (attrs->read_latency + attrs->write_latency == 0 ||
>> +	    attrs->read_bandwidth + attrs->write_bandwidth == 0)
>> +		return NOTIFY_OK;
>> +
>> +	*adist = MEMTIER_ADISTANCE_DRAM *
>> +		(attrs->read_latency + attrs->write_latency) /
>> +		(default_dram_attrs.read_latency +
>> +		 default_dram_attrs.write_latency) *
>> +		(default_dram_attrs.read_bandwidth +
>> +		 default_dram_attrs.write_bandwidth) /
>> +		(attrs->read_bandwidth + attrs->write_bandwidth);
>
>
> Can you write a comment describing how we use all these attributes in
> deriving the abstract distance value?

Sure.  How about the following text?

The abstract distance of a memory node is in direct proportion to its
memory latency (read + write) and inversely proportional to its memory
bandwidth (read + write).  The abstract distance, memory latency, and
memory bandwidth of default DRAM nodes are used as base.

Best Regards,
Huang, Ying

>
>> +
>> +	return NOTIFY_STOP;
>> +}
>> +
>> +static __meminitdata struct notifier_block hmat_adist_nb =
>> +{
>> +	.notifier_call = hmat_calculate_adistance,
>> +	.priority = 100,
>> +};
>> +
>>  static __init void hmat_free_structures(void)
>>  {
>>  	struct memory_target *target, *tnext;
>> @@ -801,6 +919,7 @@ static __init int hmat_init(void)
>>  	struct acpi_table_header *tbl;
>>  	enum acpi_hmat_type i;
>>  	acpi_status status;
>> +	int usage;
>>  
>>  	if (srat_disabled() || hmat_disable)
>>  		return 0;
>> @@ -841,8 +960,11 @@ static __init int hmat_init(void)
>>  	hmat_register_targets();
>>  
>>  	/* Keep the table and structures if the notifier may use them */
>> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
>> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
>> +	usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
>> +	if (usage)
>>  		return 0;
>> +
>>  out_put:
>>  	hmat_free_structures();
>>  	acpi_put_table(tbl);
>> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
>> index c6429e624244..9377239c8d34 100644
>> --- a/include/linux/memory-tiers.h
>> +++ b/include/linux/memory-tiers.h
>> @@ -33,6 +33,7 @@ struct memory_dev_type {
>>  
>>  #ifdef CONFIG_NUMA
>>  extern bool numa_demotion_enabled;
>> +extern struct memory_dev_type *default_dram_type;
>>  struct memory_dev_type *alloc_memory_type(int adistance);
>>  void destroy_memory_type(struct memory_dev_type *memtype);
>>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
>> @@ -64,6 +65,7 @@ static inline bool node_is_toptier(int node)
>>  #else
>>  
>>  #define numa_demotion_enabled	false
>> +#define default_dram_type	NULL
>>  /*
>>   * CONFIG_NUMA implementation returns non NULL error.
>>   */
>> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
>> index fb5398e710cc..3aabc7240402 100644
>> --- a/mm/memory-tiers.c
>> +++ b/mm/memory-tiers.c
>> @@ -37,7 +37,7 @@ struct node_memory_type_map {
>>  static DEFINE_MUTEX(memory_tier_lock);
>>  static LIST_HEAD(memory_tiers);
>>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
>> -static struct memory_dev_type *default_dram_type;
>> +struct memory_dev_type *default_dram_type;
>>  
>>  static struct bus_type memory_tier_subsys = {
>>  	.name = "memory_tiering",
>> -- 
>> 2.39.2
