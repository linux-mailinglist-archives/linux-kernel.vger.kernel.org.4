Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDB5735C25
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 18:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbjFSQYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 12:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232215AbjFSQYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 12:24:32 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2DE5C
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 09:24:30 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35JGK0ac032374;
        Mon, 19 Jun 2023 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=X1v6V8A8RWjvjICN/a2k2VECbrHR6onQY35uUlc45nQ=;
 b=gMTMThV/doQ17V6FAiPWESXl9oaa1GZIfUyox9DchUrLDyEOAtuxiQ6osDu0KJ8Kehdw
 h24l74Zs32jXo9idDThSc56RJxyITOGCkwdszN7GEZK/7/IfseoWY0kFoeD6ynppENJf
 UJ08ktjnfLVaupi4PV2lOCxSiEBQRaE4D8/1ON/GWxwWUDiHw+md9u+i0qv+hQnLtpU7
 Vum38j38kFa85tI8W4YcP+BOXt3r+dyYJbmJQoTggnj1MOEd3/UhbYNYnBYoEnlMpk3B
 oST4AJe0jDaYWg2e9+RRCATF6dULKD/LyH4bSerbVPUxJsyv4VMscW5QMmurOdHYKqdJ RQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rateug2dw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 16:24:09 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 35JGKJ5G000623;
        Mon, 19 Jun 2023 16:24:08 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rateug2dq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 16:24:08 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35JG0HMf031839;
        Mon, 19 Jun 2023 16:24:07 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([9.208.130.99])
        by ppma02dal.us.ibm.com (PPS) with ESMTPS id 3r94f61qqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Jun 2023 16:24:07 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
        by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35JGO6lZ36700698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 19 Jun 2023 16:24:06 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B607158057;
        Mon, 19 Jun 2023 16:24:06 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E959158058;
        Mon, 19 Jun 2023 16:23:44 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.80.193])
        by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 19 Jun 2023 16:23:44 +0000 (GMT)
X-Mailer: emacs 29.0.91 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Huang Ying <ying.huang@intel.com>, Wei Xu <weixugc@google.com>,
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
In-Reply-To: <20230616070538.190042-4-ying.huang@intel.com>
References: <20230616070538.190042-1-ying.huang@intel.com>
 <20230616070538.190042-4-ying.huang@intel.com>
Date:   Mon, 19 Jun 2023 21:53:42 +0530
Message-ID: <87352nifox.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: P03RsTRvyHazbFogDjxPUYxgdd1MmH2x
X-Proofpoint-GUID: UQz9lgxvU6-SHb1YrLRzqo6prZoctKD1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-19_11,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 impostorscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306190147
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Huang Ying <ying.huang@intel.com> writes:

> A memory tiering abstract distance calculation algorithm based on ACPI
> HMAT is implemented.  The basic idea is as follows.
>
> The performance attributes of system default DRAM nodes are recorded
> as the base line.  Whose abstract distance is MEMTIER_ADISTANCE_DRAM.
> Then, the ratio of the abstract distance of a memory node (target) to
> MEMTIER_ADISTANCE_DRAM is scaled based on the ratio of the performance
> attributes of the node to that of the default DRAM nodes.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Yang Shi <shy828301@gmail.com>
> Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/numa/hmat.c     | 124 ++++++++++++++++++++++++++++++++++-
>  include/linux/memory-tiers.h |   2 +
>  mm/memory-tiers.c            |   2 +-
>  3 files changed, 126 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2dee0098f1a9..21e4deb581ad 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -24,6 +24,7 @@
>  #include <linux/node.h>
>  #include <linux/sysfs.h>
>  #include <linux/dax.h>
> +#include <linux/memory-tiers.h>
>  
>  static u8 hmat_revision;
>  static int hmat_disable __initdata;
> @@ -759,6 +760,123 @@ static int hmat_callback(struct notifier_block *self,
>  	return NOTIFY_OK;
>  }
>  
> +static int hmat_adistance_disabled;
> +static struct node_hmem_attrs default_dram_attrs;
> +
> +static void dump_hmem_attrs(struct node_hmem_attrs *attrs)
> +{
> +	pr_cont("read_latency: %u, write_latency: %u, read_bandwidth: %u, write_bandwidth: %u\n",
> +		attrs->read_latency, attrs->write_latency,
> +		attrs->read_bandwidth, attrs->write_bandwidth);
> +}
> +
> +static void disable_hmat_adistance_algorithm(void)
> +{
> +	hmat_adistance_disabled = true;
> +}
> +
> +static int hmat_init_default_dram_attrs(void)
> +{
> +	struct memory_target *target;
> +	struct node_hmem_attrs *attrs;
> +	int nid, pxm;
> +	int nid_dram = NUMA_NO_NODE;
> +
> +	if (default_dram_attrs.read_latency +
> +	    default_dram_attrs.write_latency != 0)
> +		return 0;
> +
> +	if (!default_dram_type)
> +		return -EIO;
> +
> +	for_each_node_mask(nid, default_dram_type->nodes) {
> +		pxm = node_to_pxm(nid);
> +		target = find_mem_target(pxm);
> +		if (!target)
> +			continue;
> +		attrs = &target->hmem_attrs[1];
> +		if (nid_dram == NUMA_NO_NODE) {
> +			if (attrs->read_latency + attrs->write_latency == 0 ||
> +			    attrs->read_bandwidth + attrs->write_bandwidth == 0) {
> +				pr_info("hmat: invalid hmem attrs for default DRAM node: %d,\n",
> +					nid);
> +				pr_info("  ");
> +				dump_hmem_attrs(attrs);
> +				pr_info("  disable hmat based abstract distance algorithm.\n");
> +				disable_hmat_adistance_algorithm();
> +				return -EIO;
> +			}
> +			nid_dram = nid;
> +			default_dram_attrs = *attrs;
> +			continue;
> +		}
> +		if (abs(attrs->read_latency - default_dram_attrs.read_latency) * 10 >
> +		    default_dram_attrs.read_latency ||
> +		    abs(attrs->write_latency - default_dram_attrs.write_latency) * 10 >
> +		    default_dram_attrs.write_latency ||
> +		    abs(attrs->read_bandwidth - default_dram_attrs.read_bandwidth) * 10 >
> +		    default_dram_attrs.read_bandwidth) {
> +			pr_info("hmat: hmem attrs for DRAM nodes mismatch.\n");
> +			pr_info("  node %d:", nid_dram);
> +			dump_hmem_attrs(&default_dram_attrs);
> +			pr_info("  node %d:", nid);
> +			dump_hmem_attrs(attrs);
> +			pr_info("  disable hmat based abstract distance algorithm.\n");
> +			disable_hmat_adistance_algorithm();
> +			return -EIO;
> +		}

What is this check about? what is the significance of 10? Can you add
the details as a code comment ?


> +	}
> +
> +	return 0;
> +}
> +
> +static int hmat_calculate_adistance(struct notifier_block *self,
> +				    unsigned long nid, void *data)
> +{
> +	static DECLARE_BITMAP(p_nodes, MAX_NUMNODES);
> +	struct memory_target *target;
> +	struct node_hmem_attrs *attrs;
> +	int *adist = data;
> +	int pxm;
> +
> +	if (hmat_adistance_disabled)
> +		return NOTIFY_OK;
> +
> +	pxm = node_to_pxm(nid);
> +	target = find_mem_target(pxm);
> +	if (!target)
> +		return NOTIFY_OK;
> +
> +	if (hmat_init_default_dram_attrs())
> +		return NOTIFY_OK;
> +
> +	mutex_lock(&target_lock);
> +	hmat_update_target_attrs(target, p_nodes, 1);
> +	mutex_unlock(&target_lock);
> +
> +	attrs = &target->hmem_attrs[1];
> +
> +	if (attrs->read_latency + attrs->write_latency == 0 ||
> +	    attrs->read_bandwidth + attrs->write_bandwidth == 0)
> +		return NOTIFY_OK;
> +
> +	*adist = MEMTIER_ADISTANCE_DRAM *
> +		(attrs->read_latency + attrs->write_latency) /
> +		(default_dram_attrs.read_latency +
> +		 default_dram_attrs.write_latency) *
> +		(default_dram_attrs.read_bandwidth +
> +		 default_dram_attrs.write_bandwidth) /
> +		(attrs->read_bandwidth + attrs->write_bandwidth);


Can you write a comment describing how we use all these attributes in
deriving the abstract distance value?


> +
> +	return NOTIFY_STOP;
> +}
> +
> +static __meminitdata struct notifier_block hmat_adist_nb =
> +{
> +	.notifier_call = hmat_calculate_adistance,
> +	.priority = 100,
> +};
> +
>  static __init void hmat_free_structures(void)
>  {
>  	struct memory_target *target, *tnext;
> @@ -801,6 +919,7 @@ static __init int hmat_init(void)
>  	struct acpi_table_header *tbl;
>  	enum acpi_hmat_type i;
>  	acpi_status status;
> +	int usage;
>  
>  	if (srat_disabled() || hmat_disable)
>  		return 0;
> @@ -841,8 +960,11 @@ static __init int hmat_init(void)
>  	hmat_register_targets();
>  
>  	/* Keep the table and structures if the notifier may use them */
> -	if (!hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI))
> +	usage = !hotplug_memory_notifier(hmat_callback, HMAT_CALLBACK_PRI);
> +	usage += !register_mt_adistance_algorithm(&hmat_adist_nb);
> +	if (usage)
>  		return 0;
> +
>  out_put:
>  	hmat_free_structures();
>  	acpi_put_table(tbl);
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index c6429e624244..9377239c8d34 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -33,6 +33,7 @@ struct memory_dev_type {
>  
>  #ifdef CONFIG_NUMA
>  extern bool numa_demotion_enabled;
> +extern struct memory_dev_type *default_dram_type;
>  struct memory_dev_type *alloc_memory_type(int adistance);
>  void destroy_memory_type(struct memory_dev_type *memtype);
>  void init_node_memory_type(int node, struct memory_dev_type *default_type);
> @@ -64,6 +65,7 @@ static inline bool node_is_toptier(int node)
>  #else
>  
>  #define numa_demotion_enabled	false
> +#define default_dram_type	NULL
>  /*
>   * CONFIG_NUMA implementation returns non NULL error.
>   */
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index fb5398e710cc..3aabc7240402 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -37,7 +37,7 @@ struct node_memory_type_map {
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
>  static struct node_memory_type_map node_memory_types[MAX_NUMNODES];
> -static struct memory_dev_type *default_dram_type;
> +struct memory_dev_type *default_dram_type;
>  
>  static struct bus_type memory_tier_subsys = {
>  	.name = "memory_tiering",
> -- 
> 2.39.2
