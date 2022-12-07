Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361CF645518
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiLGIIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLGIIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:08:01 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6EC4A467
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 00:08:00 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B77JchB006562;
        Wed, 7 Dec 2022 08:07:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=DcDGIvYVdbdAqyEwBkkOLzRLvOMlS6ry6s1TVR1e1NA=;
 b=UkYtN7tZkaPCS7sC0KUx2Blca6Yo6UHSe5/qsQykPtcFoxxf1t4YvPk9Ot/zWIbzviJE
 KOEzBjagyJElpuGWWKLZGY8HzUY/02AOyVbkkicAE23YmxtAD7oW0wcQWUb6F69e8X0F
 qHykCeTBVreseFm9bTiVz2MmT0uTScxTlmd2dOuCbfOOs95Mn4A0UmuiAnTyM0KTfZ47
 L7TBCM+lXMOCvhSCD4xon+uaNCX4lQM15ZAAwfycKX9pVetFMXFhchpX6R3INOaoJ1hE
 sBg+hs4o4fX+B4cWhOXGoCXZzs01e8KyDxieGh5SN4PPRJw0JHgRgCXRQ9fNus55fDjn iA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mapbdh2mp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 08:07:50 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 2B77M8TO017010;
        Wed, 7 Dec 2022 08:07:49 GMT
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mapbdh2mb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 08:07:49 +0000
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.17.1.19/8.16.1.2) with ESMTP id 2B76loBL023448;
        Wed, 7 Dec 2022 08:07:48 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([9.208.129.117])
        by ppma01dal.us.ibm.com (PPS) with ESMTPS id 3m9pd9vkqq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 07 Dec 2022 08:07:48 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2B787lRI8520420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 7 Dec 2022 08:07:47 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 731F25805C;
        Wed,  7 Dec 2022 08:07:47 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F7C058058;
        Wed,  7 Dec 2022 08:07:42 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.35.67])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  7 Dec 2022 08:07:42 +0000 (GMT)
X-Mailer: emacs 29.0.60 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     Mina Almasry <almasrymina@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Huang Ying <ying.huang@intel.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Yosry Ahmed <yosryahmed@google.com>, weixugc@google.com,
        fvdl@google.com, Mina Almasry <almasrymina@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] [mm-unstable] mm: Fix memcg reclaim on memory tiered
 systems
In-Reply-To: <20221204093008.2620459-1-almasrymina@google.com>
References: <20221204093008.2620459-1-almasrymina@google.com>
Date:   Wed, 07 Dec 2022 13:37:40 +0530
Message-ID: <87k033eiwj.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: sL8Vt7X254w7fVSWAsYD1LZ8IIXl4aE4
X-Proofpoint-GUID: u0IQ6Ib-_G0k6f-4D0tLI-qEmdVnipc2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-07_04,2022-12-06_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1011 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2212070066
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mina Almasry <almasrymina@google.com> writes:

> commit 3f1509c57b1b ("Revert "mm/vmscan: never demote for memcg
> reclaim"") enabled demotion in memcg reclaim, which is the right thing
> to do, but introduced a regression in the behavior of
> try_to_free_mem_cgroup_pages().
>
> The callers of try_to_free_mem_cgroup_pages() expect it to attempt to
> reclaim - not demote - nr_pages from the cgroup. I.e. the memory usage
> of the cgroup should reduce by nr_pages. The callers expect
> try_to_free_mem_cgroup_pages() to also return the number of pages
> reclaimed, not demoted.
>
> However, try_to_free_mem_cgroup_pages() actually unconditionally counts
> demoted pages as reclaimed pages. So in practice when it is called it will
> often demote nr_pages and return the number of demoted pages to the caller.
> Demoted pages don't lower the memcg usage as the caller requested.
>
> I suspect various things work suboptimally on memory systems or don't
> work at all due to this:
>
> - memory.high enforcement likely doesn't work (it just demotes nr_pages
>   instead of lowering the memcg usage by nr_pages).
> - try_charge_memcg() will keep retrying the charge while
>   try_to_free_mem_cgroup_pages() is just demoting pages and not actually
>   making any room for the charge.
> - memory.reclaim has a wonky interface. It advertises to the user it
>   reclaims the provided amount but it will actually demote that amount.
>
> There may be more effects to this issue.
>
> To fix these issues I propose shrink_folio_list() to only count pages
> demoted from inside of sc->nodemask to outside of sc->nodemask as
> 'reclaimed'.
>
> For callers such as reclaim_high() or try_charge_memcg() that set
> sc->nodemask to NULL, try_to_free_mem_cgroup_pages() will try to
> actually reclaim nr_pages and return the number of pages reclaimed. No
> demoted pages would count towards the nr_pages requirement.
>
> For callers such as memory_reclaim() that set sc->nodemask,
> try_to_free_mem_cgroup_pages() will free nr_pages from that nodemask
> with either demotion or reclaim.
>
> Tested this change using memory.reclaim interface. With this change,
>
> 	echo "1m" > memory.reclaim
>
> Will cause freeing of 1m of memory from the cgroup regardless of the
> demotions happening inside.
>
> 	echo "1m nodes=0" > memory.reclaim
>
> Will cause freeing of 1m of node 0 by demotion if a demotion target is
> available, and by reclaim if no demotion target is available.
>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
>
> ---
>
> This is developed on top of mm-unstable largely to test with memory.reclaim
> nodes= arg and ensure the fix is compatible with that.
>
> v2:
> - Shortened the commit message a bit.
> - Fixed issue when demotion falls back to other allowed target nodes returned by
>   node_get_allowed_targets() as Wei suggested.
>
> Cc: weixugc@google.com
> ---
>  include/linux/memory-tiers.h |  7 +++++--
>  mm/memory-tiers.c            | 10 +++++++++-
>  mm/vmscan.c                  | 20 +++++++++++++++++---
>  3 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index fc9647b1b4f9..f3f359760fd0 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -38,7 +38,8 @@ void init_node_memory_type(int node, struct memory_dev_type *default_type);
>  void clear_node_memory_type(int node, struct memory_dev_type *memtype);
>  #ifdef CONFIG_MIGRATION
>  int next_demotion_node(int node);
> -void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets);
> +void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets,
> +			      nodemask_t *demote_from_targets);
>  bool node_is_toptier(int node);
>  #else
>  static inline int next_demotion_node(int node)
> @@ -46,7 +47,9 @@ static inline int next_demotion_node(int node)
>  	return NUMA_NO_NODE;
>  }
>
> -static inline void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
> +static inline void node_get_allowed_targets(pg_data_t *pgdat,
> +					    nodemask_t *targets,
> +					    nodemask_t *demote_from_targets)
>  {
>  	*targets = NODE_MASK_NONE;
>  }
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index c734658c6242..7f8f0b5de2b3 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -264,7 +264,8 @@ bool node_is_toptier(int node)
>  	return toptier;
>  }
>
> -void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
> +void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets,
> +			      nodemask_t *demote_from_targets)
>  {
>  	struct memory_tier *memtier;
>
> @@ -280,6 +281,13 @@ void node_get_allowed_targets(pg_data_t *pgdat, nodemask_t *targets)
>  	else
>  		*targets = NODE_MASK_NONE;
>  	rcu_read_unlock();
> +
> +	/*
> +	 * Exclude the demote_from_targets from the allowed targets if we're
> +	 * trying to demote from a specific set of nodes.
> +	 */
> +	if (demote_from_targets)
> +		nodes_andnot(*targets, *targets, *demote_from_targets);
>  }

Will this cause demotion to not work when we have memory policy like
MPOL_BIND with nodemask including demotion targets?


>
>  /**
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 2b42ac9ad755..97ca0445b5dc 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1590,7 +1590,8 @@ static struct page *alloc_demote_page(struct page *page, unsigned long private)
>   * Folios which are not demoted are left on @demote_folios.
>   */
>  static unsigned int demote_folio_list(struct list_head *demote_folios,
> -				     struct pglist_data *pgdat)
> +				      struct pglist_data *pgdat,
> +				      nodemask_t *demote_from_nodemask)
>  {
>  	int target_nid = next_demotion_node(pgdat->node_id);
>  	unsigned int nr_succeeded;
> @@ -1614,7 +1615,7 @@ static unsigned int demote_folio_list(struct list_head *demote_folios,
>  	if (target_nid == NUMA_NO_NODE)
>  		return 0;
>
> -	node_get_allowed_targets(pgdat, &allowed_mask);
> +	node_get_allowed_targets(pgdat, &allowed_mask, demote_from_nodemask);
>
>  	/* Demotion ignores all cpuset and mempolicy settings */
>  	migrate_pages(demote_folios, alloc_demote_page, NULL,
> @@ -1653,6 +1654,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	LIST_HEAD(free_folios);
>  	LIST_HEAD(demote_folios);
>  	unsigned int nr_reclaimed = 0;
> +	unsigned int nr_demoted = 0;
>  	unsigned int pgactivate = 0;
>  	bool do_demote_pass;
>  	struct swap_iocb *plug = NULL;
> @@ -2085,7 +2087,19 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>  	/* 'folio_list' is always empty here */
>
>  	/* Migrate folios selected for demotion */
> -	nr_reclaimed += demote_folio_list(&demote_folios, pgdat);
> +	nr_demoted = demote_folio_list(&demote_folios, pgdat, sc->nodemask);
> +
> +	/*
> +	 * Only count demoted folios as reclaimed if the caller has requested
> +	 * demotion from a specific nodemask. In this case pages inside the
> +	 * noedmask have been demoted to outside the nodemask and we can count
> +	 * these pages as reclaimed. If no nodemask is passed, then the caller
> +	 * is requesting reclaim from all memory, which should not count
> +	 * demoted pages.
> +	 */
> +	if (sc->nodemask)
> +		nr_reclaimed += nr_demoted;
> +
>  	/* Folios that could not be demoted are still in @demote_folios */
>  	if (!list_empty(&demote_folios)) {
>  		/* Folios which weren't demoted go back on @folio_list */
> --
> 2.39.0.rc0.267.gcb52ba06e7-goog
