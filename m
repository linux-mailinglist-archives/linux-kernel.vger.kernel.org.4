Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2676AF3E4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbjCGTLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:11:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjCGTKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:18 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F147CAF294
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:06 -0800 (PST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327IWQGH026106;
        Tue, 7 Mar 2023 18:54:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=g7YT0+ElDMXCaFF7eK5zZ2nZNlTQEZZP7BVQ34gPmio=;
 b=ETjLdDYyEZz8VHEnjLeR3dtYa4aDdYNUpCeL+cKnysw9ueBlmrQWNqpSacdlYsp6uLgI
 B3S75SfDgkKZ8jZ/12fUpv8pXIAh/RjYrzV+nzT9iFWbk0OgPqxi0AOz9G+raWaJWPCN
 ExDlXd2cZ65mTzC2KiClZFwqUmY67SSGhYlMEBINWNIa1PZSF+S4d1iczA+ZHnjV21rM
 FtrKQfLbkzKZXqANCmo/bak2BVDEs9w7yBASwtx61jWA1fZ28LJYYzKcRgdQqJrY38IR
 r5cApx0hwSQhonj+9jkq1FxAe2Zjq7sC05R3kCpxGWlrk4gpul3+J4l1U0r9pbA1PPTs fg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p68k2455f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:23 +0000
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327Hg37U028724;
        Tue, 7 Mar 2023 18:54:22 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p68k2454t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:22 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327FjDk5030497;
        Tue, 7 Mar 2023 18:54:20 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3p418cvpd1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsHMY30605592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:17 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CF5B72004B;
        Tue,  7 Mar 2023 18:54:17 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4963820040;
        Tue,  7 Mar 2023 18:54:17 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:17 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:45:41 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 3/6] ksm: count all zero pages placed by KSM
Message-ID: <20230307194541.11a36cb0@p-imbrenda>
In-Reply-To: <202302100918524481474@zte.com.cn>
References: <202302100918524481474@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7Emyg1iLKvicamys-LflQtMZRVQgp8UR
X-Proofpoint-ORIG-GUID: mZFyfI_bY4FZGW1Q5ACFyQdj3iQJJH0l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_12,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:18:52 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> As pages_sharing and pages_shared don't include the number of zero pages
> merged by KSM, we cannot know how many pages are zero pages placed by KSM
> when enabling use_zero_pages, which leads to KSM not being transparent with
> all actual merged pages by KSM. In the early days of use_zero_pages,
> zero-pages was unable to get unshared by the ways like MADV_UNMERGEABLE so
> it's hard to count how many times one of those zeropages was then unmerged.
> 
> But now, unsharing KSM-placed zero page accurately has been achieved, so we
> can easily count both how many times a page full of zeroes was merged with
> zero-page and how many times one of those pages was then unmerged. and so,
> it helps to estimate memory demands when each and every shared page could
> get unshared.
> 
> So we add zero_pages_sharing under /sys/kernel/mm/ksm/ to show the number
> of all zero pages placed by KSM.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> 
>  v4->v5:
>  fix warning  mm/ksm.c:3238:9: warning: no previous prototype for
>  'zero_pages_sharing_show' [-Wmissing-prototypes].
> ---
>  mm/ksm.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index ab04b44679c8..1fa668e1fe82 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -276,6 +276,9 @@ static unsigned int zero_checksum __read_mostly;
>  /* Whether to merge empty (zeroed) pages with actual zero pages */
>  static bool ksm_use_zero_pages __read_mostly;
> 
> +/* The number of zero pages placed by KSM use_zero_pages */
> +static unsigned long ksm_zero_pages_sharing;
> +
>  #ifdef CONFIG_NUMA
>  /* Zeroed when merging across nodes is not allowed */
>  static unsigned int ksm_merge_across_nodes = 1;
> @@ -789,8 +792,10 @@ static struct page *get_ksm_page(struct ksm_stable_node *stable_node,
>   */
>  static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
>  {
> -	if (rmap_item->address & ZERO_PAGE_FLAG)
> +	if (rmap_item->address & ZERO_PAGE_FLAG) {
> +		ksm_zero_pages_sharing--;
>  		rmap_item->address &= PAGE_MASK;
> +	}
>  }
> 
>  /* Only called when rmap_item is going to be freed */
> @@ -2109,8 +2114,10 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
>  		if (vma) {
>  			err = try_to_merge_one_page(vma, page,
>  						ZERO_PAGE(rmap_item->address));
> -			if (!err)
> +			if (!err) {
>  				rmap_item->address |= ZERO_PAGE_FLAG;
> +				ksm_zero_pages_sharing++;
> +			}
>  		} else {
>  			/* If the vma is out of date, we do not need to continue. */
>  			err = 0;
> @@ -3230,6 +3237,13 @@ static ssize_t pages_volatile_show(struct kobject *kobj,
>  }
>  KSM_ATTR_RO(pages_volatile);
> 
> +static ssize_t zero_pages_sharing_show(struct kobject *kobj,
> +				struct kobj_attribute *attr, char *buf)
> +{
> +	return sysfs_emit(buf, "%ld\n", ksm_zero_pages_sharing);
> +}
> +KSM_ATTR_RO(zero_pages_sharing);
> +
>  static ssize_t stable_node_dups_show(struct kobject *kobj,
>  				     struct kobj_attribute *attr, char *buf)
>  {
> @@ -3285,6 +3299,7 @@ static struct attribute *ksm_attrs[] = {
>  	&pages_sharing_attr.attr,
>  	&pages_unshared_attr.attr,
>  	&pages_volatile_attr.attr,
> +	&zero_pages_sharing_attr.attr,
>  	&full_scans_attr.attr,
>  #ifdef CONFIG_NUMA
>  	&merge_across_nodes_attr.attr,

