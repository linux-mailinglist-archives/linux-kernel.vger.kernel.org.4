Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02DF737B19
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbjFUGMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjFUGM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:12:28 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B819F;
        Tue, 20 Jun 2023 23:12:27 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35L6BUJW032265;
        Wed, 21 Jun 2023 06:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=0y8PgUzfkSCBAdm8cjFgV95f1jibdMlZeJxArc3waNM=;
 b=k5/skO+SlqzX2Rfys4RabqTh1V5lphr8pJlTa2zHMbckXawt9NYY6PD47nlqt0Az8ju1
 IUxGZB97p07440vgNJlo07Hroiqu875KTD1Ll+UILt7uMgJdAJHraczxuTIbixrjyRCy
 +98tdV6YC04z95XUKHDQRitaDs7YU/cmzYnAX/lvu8aaoDV5pJXJhE6wJlgCaYfWWvLu
 r0nyI3ETbRaGQyejkfq+UHKoD1+gn+w3sj4FIaJ2IKjKGIsSa98b68FCl/HFkZkjCTsB
 q//ouqf2vjy4KNF7dm30FQg4WDqoAed0lG5C+gbSCmx6BLFT5/joir3HsqpBebhznR+a Rg== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rbuj40hau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:12:10 +0000
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35L4utO3012008;
        Wed, 21 Jun 2023 06:07:07 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma04fra.de.ibm.com (PPS) with ESMTPS id 3r94f59x4j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 21 Jun 2023 06:07:07 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35L674fm37159548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jun 2023 06:07:04 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E83182004B;
        Wed, 21 Jun 2023 06:07:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9159220043;
        Wed, 21 Jun 2023 06:07:01 +0000 (GMT)
Received: from tarunpc (unknown [9.199.157.25])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 21 Jun 2023 06:07:01 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com
Subject: Re: [PATCH] dax/kmem: Pass valid argument to
 memory_group_register_static
In-Reply-To: <ZJIz07hQiXr/MghO@aschofie-mobl2>
References: <20230620140332.30578-1-tsahu@linux.ibm.com>
 <ZJIz07hQiXr/MghO@aschofie-mobl2>
Date:   Wed, 21 Jun 2023 11:36:59 +0530
Message-ID: <87cz1p1h8c.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ZIRM5Sl2_gVfwJXkQomnEZVM3qu1T5_n
X-Proofpoint-ORIG-GUID: ZIRM5Sl2_gVfwJXkQomnEZVM3qu1T5_n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-21_03,2023-06-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 suspectscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306210051
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alison,

Alison Schofield <alison.schofield@intel.com> writes:

> On Tue, Jun 20, 2023 at 07:33:32PM +0530, Tarun Sahu wrote:
>> memory_group_register_static takes maximum number of pages as the argument
>> while dev_dax_kmem_probe passes total_len (in bytes) as the argument.
>
> This sounds like a fix. An explanation of the impact and a fixes tag
> may be needed. Also, wondering how you found it.
>
Yes, it is a fix, I found it during dry code walk-through.
There is not any impact as such. As,
memory_group_register_static just set the max_pages limit which
is used in auto_movable_zone_for_pfn to determine the zone.

which might cause these condition to behave differently,

This will be true always so jump will happen to kernel_zone
	if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
		goto kernel_zone;
---
kernel_zone:
	return default_kernel_zone_for_pfn(nid, pfn, nr_pages);

---

Here, In below, zone_intersects compare range will be larger as nr_pages
will be higher (derived from total_len passed in dev_dax_kmem_probe).

static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn,
		unsigned long nr_pages)
{
	struct pglist_data *pgdat = NODE_DATA(nid);
	int zid;

	for (zid = 0; zid < ZONE_NORMAL; zid++) {
		struct zone *zone = &pgdat->node_zones[zid];

		if (zone_intersects(zone, start_pfn, nr_pages))
			return zone;
	}

	return &pgdat->node_zones[ZONE_NORMAL];
}

In Mostly cases, ZONE_NORMAL will be returned. But there is no
crash/panic issues involved here, only decision making on selecting zone
is affected.



> Alison
>
>> 
>> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>> ---
>>  drivers/dax/kmem.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
>> index 7b36db6f1cbd..898ca9505754 100644
>> --- a/drivers/dax/kmem.c
>> +++ b/drivers/dax/kmem.c
>> @@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>>  	if (!data->res_name)
>>  		goto err_res_name;
>>  
>> -	rc = memory_group_register_static(numa_node, total_len);
>> +	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
>>  	if (rc < 0)
>>  		goto err_reg_mgid;
>>  	data->mgid = rc;
>> -- 
>> 2.31.1
>> 
