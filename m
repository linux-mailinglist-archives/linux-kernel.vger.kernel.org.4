Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 505F7743343
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 05:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjF3DmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 23:42:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjF3DmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 23:42:04 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A721FE3;
        Thu, 29 Jun 2023 20:42:03 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U3XO0v022754;
        Fri, 30 Jun 2023 03:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=B1CW1DrvWrT1T4qGGfA0jnCPLsgt+8lZqZbPxtbBKe4=;
 b=Q199RAYkh0GWA3nzuO29PoKN/jao/SbWBZHUJpXrFwFl95B2jo9emr7Zphh9T8Hu0W4/
 KTW8G3DLkVB87HByfLJWV/ve/wdxHJrYzO7LiYT3YF3wIyw1j6IZAVUhn2+LR6yXVSjL
 ydQ1cVZaYyn8WH6m1xsHksQE5+CZffXTYuBLqtaLsKZBgHjXEmJj7ncOLxfNdFRMI/IN
 vQk0aw4LH++MtvAjiyTYyWFA2l9p8XXMToYd2vdxPooMkCUzehBjXLhXMrUH9CQR24Kz
 mqbTCN1WIvyHvHVqNW/HGMfYLV0gC0o5SnrS6dvb9RgM5f6obY1yQtkmRhTlHOUWqz+T kg== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rhq8108u0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 03:41:53 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 35U2fQUQ029312;
        Fri, 30 Jun 2023 03:41:51 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3rdr453wua-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 30 Jun 2023 03:41:51 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 35U3flat18743834
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Jun 2023 03:41:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 878BF2004B;
        Fri, 30 Jun 2023 03:41:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADD1F20043;
        Fri, 30 Jun 2023 03:41:45 +0000 (GMT)
Received: from tarunpc (unknown [9.199.157.25])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 30 Jun 2023 03:41:45 +0000 (GMT)
From:   Tarun Sahu <tsahu@linux.ibm.com>
To:     nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.jiang@intel.com,
        dan.j.williams@intel.com, vishal.l.verma@intel.com,
        aneesh.kumar@linux.ibm.com, jaypatel@linux.ibm.com
Subject: Re: [PATCH v3] dax/kmem: Pass valid argument to
 memory_group_register_static
In-Reply-To: <20230621155025.370672-1-tsahu@linux.ibm.com>
References: <20230621155025.370672-1-tsahu@linux.ibm.com>
Date:   Fri, 30 Jun 2023 09:11:43 +0530
Message-ID: <87cz1daa6g.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 91-uvh5JY-SRRCM4OE5_Vua_DkZ2dQkZ
X-Proofpoint-GUID: 91-uvh5JY-SRRCM4OE5_Vua_DkZ2dQkZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-29_10,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 clxscore=1011 bulkscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 spamscore=0 mlxscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300029
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

This is just a gentle reminder, If any other information is needed.

Tarun Sahu <tsahu@linux.ibm.com> writes:

> memory_group_register_static takes maximum number of pages as the argument
> while dev_dax_kmem_probe passes total_len (in bytes) as the argument.
>
> IIUC, I don't see any crash/panic impact as such. As,
> memory_group_register_static just set the max_pages limit which is used in
> auto_movable_zone_for_pfn to determine the zone.
>
> which might cause these condition to behave differently,
>
> This will be true always so jump will happen to kernel_zone
>     ...
>     if (!auto_movable_can_online_movable(NUMA_NO_NODE, group, nr_pages))
>         goto kernel_zone;
>
>     ...
>     kernel_zone:
>         return default_kernel_zone_for_pfn(nid, pfn, nr_pages);
>
> Here, In below, zone_intersects compare range will be larger as nr_pages
> will be higher (derived from total_len passed in dev_dax_kmem_probe).
>
>     ...
>     static struct zone *default_kernel_zone_for_pfn(int nid, unsigned long start_pfn,
>     		unsigned long nr_pages)
>     {
>     	struct pglist_data *pgdat = NODE_DATA(nid);
>     	int zid;
>
>     	for (zid = 0; zid < ZONE_NORMAL; zid++) {
>     		struct zone *zone = &pgdat->node_zones[zid];
>
>     		if (zone_intersects(zone, start_pfn, nr_pages))
>     			return zone;
>     	}
>
>     	return &pgdat->node_zones[ZONE_NORMAL];
>     }
>
> Incorrect zone will be returned here, which in later time might cause bigger
> problem.
>
> Fixes: eedf634aac3b ("dax/kmem: use a single static memory group for a single probed unit")
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
> V3<-V2
> 1. Removed skip characters.
>
> V2<-V1
> 1. Added more details to commit message
>
>
>  drivers/dax/kmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
> index 7b36db6f1cbd..898ca9505754 100644
> --- a/drivers/dax/kmem.c
> +++ b/drivers/dax/kmem.c
> @@ -99,7 +99,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
>  	if (!data->res_name)
>  		goto err_res_name;
>  
> -	rc = memory_group_register_static(numa_node, total_len);
> +	rc = memory_group_register_static(numa_node, PFN_UP(total_len));
>  	if (rc < 0)
>  		goto err_reg_mgid;
>  	data->mgid = rc;
> -- 
> 2.31.1


~Tarun
