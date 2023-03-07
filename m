Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA1A6AF3F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjCGTLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:11:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjCGTK5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:57 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD3CAAF2A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:32 -0800 (PST)
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327HE63r007707;
        Tue, 7 Mar 2023 18:54:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=3wNfaWHo2zE/drXl/tvHtazme2/9B2jmHSqpKlVdO8I=;
 b=HNk1E9q+4UxFbIrhNNJMnIYmZwDmTXOrWEAsCdWgnsBAKF9vzaiLR+n1vQmg650BMieu
 EMT1r3Q3CGMRT2/zsgb27Pk3JUAZAreAohf4mCdA53qKJ4uKYLnRjva1XczcxM4CuRWb
 Oyu/Es5KO5h0bz6CfIHsS8hbGxd9zaO+y/2Yc5LwcE1JD8zAwjUMC9yuCU48F7yMvbaM
 bacbKhW0E2krD/ciLMYhr07jCqB1fA7pQzFPS2ueUu1l4CBRynRNf7XsyW7jRrNoEAvL
 VzU7HkCEF9l3Qc/1/Jx426A7I6L3pcCakZ8BbXqaAjK1s7/AXNfHCOfJIhmNWQyWguyv /Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p69g329gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:20 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327IUZDd000969;
        Tue, 7 Mar 2023 18:54:20 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p69g329fx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:20 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327Egsqm005738;
        Tue, 7 Mar 2023 18:54:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3p41brcpys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:18 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsFdH25821836
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B250B20043;
        Tue,  7 Mar 2023 18:54:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 23C5A20040;
        Tue,  7 Mar 2023 18:54:15 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:15 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:24:21 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 1/6] ksm: abstract the function
 try_to_get_old_rmap_item
Message-ID: <20230307192421.30ab869c@p-imbrenda>
In-Reply-To: <202302100916423431376@zte.com.cn>
References: <202302100916423431376@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: VQcmfk-8XpoWKet4l_wQubSe0VGakhGw
X-Proofpoint-ORIG-GUID: vbnfNrNwNVvBDS2BhWFoeVluqct5PeDB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_14,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1011 phishscore=0 suspectscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=749 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:16:42 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> A new function try_to_get_old_rmap_item is abstracted from
> get_next_rmap_item. This function will be reused by the subsequent
> patches about counting ksm_zero_pages.
> 
> The patch improves the readability and reusability of KSM code.
> 
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Reviewed-by: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
> 
> v5->v6:
> Modify some comments according to David's suggestions.
> ---
>  mm/ksm.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 83e2f74ae7da..905a79d213da 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -2214,23 +2214,38 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
>  	}
>  }
> 
> -static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
> -					    struct ksm_rmap_item **rmap_list,
> -					    unsigned long addr)
> +static struct ksm_rmap_item *try_to_get_old_rmap_item(unsigned long addr,
> +					 struct ksm_rmap_item **rmap_list)
>  {
> -	struct ksm_rmap_item *rmap_item;
> -
>  	while (*rmap_list) {
> -		rmap_item = *rmap_list;
> +		struct ksm_rmap_item *rmap_item = *rmap_list;

why are you declaring this here? I think it's more clear if you
declare the variable at the beginning of the function, like it was
before

> +
>  		if ((rmap_item->address & PAGE_MASK) == addr)
>  			return rmap_item;
>  		if (rmap_item->address > addr)
>  			break;
>  		*rmap_list = rmap_item->rmap_list;
> +		/*
> +		 * If we end up here, the VMA is MADV_UNMERGEABLE or its page
> +		 * is ineligible or discarded, e.g. MADV_DONTNEED.
> +		 */
>  		remove_rmap_item_from_tree(rmap_item);
>  		free_rmap_item(rmap_item);
>  	}
> 
> +	return NULL;
> +}
> +
> +static struct ksm_rmap_item *get_next_rmap_item(struct ksm_mm_slot *mm_slot,
> +					    struct ksm_rmap_item **rmap_list,
> +					    unsigned long addr)
> +{
> +	struct ksm_rmap_item *rmap_item;
> +
> +	rmap_item = try_to_get_old_rmap_item(addr, rmap_list);
> +	if (rmap_item)
> +		return rmap_item;
> +
>  	rmap_item = alloc_rmap_item();
>  	if (rmap_item) {
>  		/* It has already been zeroed */

