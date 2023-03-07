Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048556AF3E3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 20:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjCGTK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 14:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233723AbjCGTKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 14:10:17 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F137AAF293
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 10:55:06 -0800 (PST)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 327IgA4k018425;
        Tue, 7 Mar 2023 18:54:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=EntbnNBkSygdAOficHEMGLjfMKqSwG8OKAU3pDo8wXg=;
 b=kFc8dYos9GE9stZ0/wk0NUg8WbjtNTbPZxjjZMO4XCvO+k8MElKTBLhK1D2AV/oIW9az
 4EOP+Xy0SY5oF4xs84lyHntNxw7ZG0YGwH3Y0b3IZCY9mm3XIyRphZMkdUR4c4zaMIFV
 F55fSKf+FAtXbdqffQapJCigTY1DE4Tgt83rurIThFW/p2fLOze6UgLjxVAR3O6NvxMz
 dXpH7bf38WiSmRilv/0gJBlRuy0RGa4lJ9I5UmH0AfQLuk64giNznbZB8N5ym2iNrWOn
 xtt533aNj6Zd/GzXnSA9Igr1Tc+0neqc9eebXNodqQpNtLQTqtNrBpLvoxrtE78jTsJn iQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6as887yh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:30 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 327IitaN030194;
        Tue, 7 Mar 2023 18:54:29 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3p6as887xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:29 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 327EqroU007330;
        Tue, 7 Mar 2023 18:54:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3p4188cq8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Mar 2023 18:54:26 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 327IsOtE16908946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Mar 2023 18:54:24 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FC8E20040;
        Tue,  7 Mar 2023 18:54:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22282004E;
        Tue,  7 Mar 2023 18:54:23 +0000 (GMT)
Received: from p-imbrenda (unknown [9.179.29.172])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with SMTP;
        Tue,  7 Mar 2023 18:54:23 +0000 (GMT)
Date:   Tue, 7 Mar 2023 19:45:57 +0100
From:   Claudio Imbrenda <imbrenda@linux.ibm.com>
To:     <yang.yang29@zte.com.cn>
Cc:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <jiang.xuexin@zte.com.cn>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>
Subject: Re: [PATCH v6 4/6] ksm: count zero pages for each process
Message-ID: <20230307194557.4a14e6c5@p-imbrenda>
In-Reply-To: <202302100919492571517@zte.com.cn>
References: <202302100919492571517@zte.com.cn>
Organization: IBM
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mNzZdnvETGjkNKmUcvMLlvQsZK3YNi1F
X-Proofpoint-ORIG-GUID: vrghOuUc5Sz39ekTJVN6rJMQFBiBLzM8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-07_14,2023-03-07_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 suspectscore=0 lowpriorityscore=0 mlxlogscore=895 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2303070164
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 09:19:49 +0800 (CST)
<yang.yang29@zte.com.cn> wrote:

> From: xu xin <xu.xin16@zte.com.cn>
> 
> As the number of ksm zero pages is not included in ksm_merging_pages per
> process when enabling use_zero_pages, it's unclear of how many actual
> pages are merged by KSM. To let users accurately estimate their memory
> demands when unsharing KSM zero-pages, it's necessary to show KSM zero-
> pages per process.
> 
> since unsharing zero pages placed by KSM accurately is achieved, then
> tracking empty pages merging and unmerging is not a difficult thing any
> longer.
> 
> Since we already have /proc/<pid>/ksm_stat, just add the information of
> zero_pages_sharing in it.
> 
> Cc: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Xuexin Jiang <jiang.xuexin@zte.com.cn>
> Cc: Xiaokai Ran <ran.xiaokai@zte.com.cn>
> Cc: Yang Yang <yang.yang29@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
>  fs/proc/base.c           | 1 +
>  include/linux/mm_types.h | 7 ++++++-
>  mm/ksm.c                 | 2 ++
>  3 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 9e479d7d202b..ac9ebe972be0 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -3207,6 +3207,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
>  	mm = get_task_mm(task);
>  	if (mm) {
>  		seq_printf(m, "ksm_rmap_items %lu\n", mm->ksm_rmap_items);
> +		seq_printf(m, "zero_pages_sharing %lu\n", mm->ksm_zero_pages_sharing);
>  		mmput(mm);
>  	}
> 
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4e1031626403..5c734ebc1890 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -776,7 +776,7 @@ struct mm_struct {
>  #ifdef CONFIG_KSM
>  		/*
>  		 * Represent how many pages of this process are involved in KSM
> -		 * merging.
> +		 * merging (not including ksm_zero_pages_sharing).
>  		 */
>  		unsigned long ksm_merging_pages;
>  		/*
> @@ -784,6 +784,11 @@ struct mm_struct {
>  		 * including merged and not merged.
>  		 */
>  		unsigned long ksm_rmap_items;
> +		/*
> +		 * Represent how many empty pages are merged with kernel zero
> +		 * pages when enabling KSM use_zero_pages.
> +		 */
> +		unsigned long ksm_zero_pages_sharing;
>  #endif
>  #ifdef CONFIG_LRU_GEN
>  		struct {
> diff --git a/mm/ksm.c b/mm/ksm.c
> index 1fa668e1fe82..42dbcc3ec90d 100644
> --- a/mm/ksm.c
> +++ b/mm/ksm.c
> @@ -794,6 +794,7 @@ static inline void clean_rmap_item_zero_flag(struct ksm_rmap_item *rmap_item)
>  {
>  	if (rmap_item->address & ZERO_PAGE_FLAG) {
>  		ksm_zero_pages_sharing--;
> +		rmap_item->mm->ksm_zero_pages_sharing--;
>  		rmap_item->address &= PAGE_MASK;
>  	}
>  }
> @@ -2117,6 +2118,7 @@ static int try_to_merge_with_kernel_zero_page(struct ksm_rmap_item *rmap_item,
>  			if (!err) {
>  				rmap_item->address |= ZERO_PAGE_FLAG;
>  				ksm_zero_pages_sharing++;
> +				rmap_item->mm->ksm_zero_pages_sharing++;
>  			}
>  		} else {
>  			/* If the vma is out of date, we do not need to continue. */

