Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 445D66ED0E9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 17:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjDXPFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 11:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDXPFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 11:05:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0C261AB
        for <linux-kernel@vger.kernel.org>; Mon, 24 Apr 2023 08:05:00 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33OEpw63026614;
        Mon, 24 Apr 2023 15:04:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=zXZNAaV3TcxMva23Pt2AP6T/5jIfaIkKBgIk+PeIu5Y=;
 b=c3RiPhq/HtjEw62t6Ss19sZmUenUaImdeWsw9PVE+aMhETWYsn5xLI+X8q/O4JHAmM7h
 o9oIX4m1AIzkyKFw7DKkoIAMQl9hEP/AeCYnJloZR3uM6To5E3YAsSjMHAJpLdlry0MU
 V55WiFybfx6RWCsjTyxvZ3XWz1BvckYy26BRFZJtJtukDh6xUWGwL6sYHN2wBGQK+9ow
 ONmnw+Rvzk8fVXWd6zaspehGubZzWhZG2K+MlgN4ZSDkLTlQwMC1pSFsMlobfgE3BrzB
 vSX/UBQmUygz4iK68PIpw8g72AWvLlRebE+PxVeSKnkB3ivuZeSjktqB8+mR/pXkFG/9 bw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3q5kbus62e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:04:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 33OF4jft027225
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Apr 2023 15:04:45 GMT
Received: from [10.214.66.119] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.42; Mon, 24 Apr
 2023 08:04:41 -0700
Message-ID: <eeeba374-9247-96fd-c9f5-8cba8761f1b9@quicinc.com>
Date:   Mon, 24 Apr 2023 20:34:38 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH V7 2/2] mm: shmem: implement POSIX_FADV_[WILL|DONT]NEED
 for shmem
Content-Language: en-US
To:     Hugh Dickins <hughd@google.com>
CC:     <akpm@linux-foundation.org>, <willy@infradead.org>,
        <markhemm@googlemail.com>, <rientjes@google.com>,
        <surenb@google.com>, <shakeelb@google.com>, <fvdl@google.com>,
        <quic_pkondeti@quicinc.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <cover.1676378702.git.quic_charante@quicinc.com>
 <631e42b6dffdcc4b4b24f5be715c37f78bf903db.1676378702.git.quic_charante@quicinc.com>
 <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com>
From:   Charan Teja Kalla <quic_charante@quicinc.com>
In-Reply-To: <2d56e1dd-68b5-c99e-522f-f8dadf6ad69e@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: UPRhnIl3JnLC0repHjXToXMfkFPnoyq9
X-Proofpoint-GUID: UPRhnIl3JnLC0repHjXToXMfkFPnoyq9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-24_09,2023-04-21_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304240136
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Hugh for the valuable comments!!

On 4/21/2023 5:37 AM, Hugh Dickins wrote:
>> Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
> I'm sorry, but no, this is not yet ready for primetime. I came here
> expecting to be able just to add a patch on top with small fixes,
> but see today that it needs more than that, and my time has run out.
> 
> Though if Andrew is keen to go ahead with it in 6.4, and add fixes
> on top while it's in rc, that will be okay: except for one small bad
@Andrew: I should resend the patch soon with all these comments addressed.
> bug, which must be fixed immediately - "luckily" nobody appears to
> be using or testing this since v5, but it cannot go further as is>
> Willneed is probably fine, but dontneed is not.
> 
>> ---
>>  mm/shmem.c | 116 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 116 insertions(+)
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> index 448f393..1af8525 100644
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@ -40,6 +40,9 @@
>>  #include <linux/fs_parser.h>
>>  #include <linux/swapfile.h>
>>  #include <linux/iversion.h>
>> +#include <linux/mm_inline.h>
>> +#include <linux/fadvise.h>
>> +#include <linux/page_idle.h>
>>  #include "swap.h"
>>  
>>  static struct vfsmount *shm_mnt;
>> @@ -2344,6 +2347,118 @@ static void shmem_set_inode_flags(struct inode *inode, unsigned int fsflags)
>>  #define shmem_initxattrs NULL
>>  #endif
>>  
>> +static void shmem_isolate_pages_range(struct address_space *mapping, loff_t start,
>> +				loff_t end, struct list_head *list)
> loff_t? They are pgoff_t.
> 
>> +{
>> +	XA_STATE(xas, &mapping->i_pages, start);
>> +	struct folio *folio;
>> +
>> +	rcu_read_lock();
>> +	xas_for_each(&xas, folio, end) {
>> +		if (xas_retry(&xas, folio))
>> +			continue;
>> +		if (xa_is_value(folio))
>> +			continue;
>> +
>> +		if (!folio_try_get(folio))
>> +			continue;
>> +		if (folio_test_unevictable(folio) || folio_mapped(folio) ||
>> +				folio_isolate_lru(folio)) {
> There is the one small bad bug.  That should say !folio_isolate_lru(folio).
> In v5, it was isolate_lru_page(page), because isolate_lru_page() returned
> 0 for success or -EBUSY for unavailable; whereas folio_isolate_lru(folio)
> is a boolean, returning true if it successfully removed folio from LRU.
> 

Looks bad thing from my side:(.  Thanks a lot for catching it. This time
I will update the patch with unit tests too.

> The effect of that bug is that in v6 and v7, it has skipped all the folios
> it was expected to be reclaiming; except when one of them happened to be
> off LRU for other reasons (being reclaimed elsewhere, being migrated,
> whatever) - and precisely those folios which were not safe to touch,
> which have often been transferred to a private worklist, are the ones
> which the code below goes on to play with - corrupting either or both
> lists.  (I haven't tried to reproduce that in practice, just saw it
> in the code, and verified with a count that no pages were reclaimed.)

True.
> 
>> +			folio_put(folio);
>> +			continue;
>> +		}
>> +		folio_put(folio);
>> +
>> +		/*
>> +		 * Prepare the folios to be passed to reclaim_pages().
>> +		 * VM can't reclaim a folio unless young bit is
>> +		 * cleared in its flags.
>> +		 */
>> +		folio_clear_referenced(folio);
>> +		folio_test_clear_young(folio);
>> +		list_add(&folio->lru, list);
>> +		if (need_resched()) {
>> +			xas_pause(&xas);
>> +			cond_resched_rcu();
>> +		}
>> +	}
>> +	rcu_read_unlock();
>> +}
>> +
>> +static int shmem_fadvise_dontneed(struct address_space *mapping, loff_t start,
>> +				loff_t end)
> loff_t? They are pgoff_t. And why return an int which is always 0?
> 
>> +{
>> +	LIST_HEAD(folio_list);
>> +
>> +	if (!total_swap_pages || mapping_unevictable(mapping))
>> +		return 0;
>> +
>> +	lru_add_drain();
>> +	shmem_isolate_pages_range(mapping, start, end, &folio_list);
>> +	reclaim_pages(&folio_list);
>> +
>> +	return 0;
>> +}
>> +
>> +static int shmem_fadvise_willneed(struct address_space *mapping,
>> +				 pgoff_t start, pgoff_t long end)
> pgoff_t long? That's a new type to me! Again, why return an int always 0?
> 
Will remove this in the next patch.
>> +{
>> +	struct folio *folio;
>> +	pgoff_t index;
>> +
>> +	xa_for_each_range(&mapping->i_pages, index, folio, start, end) {
>> +		if (!xa_is_value(folio))
>> +			continue;
>> +		folio = shmem_read_folio(mapping, index);
>> +		if (!IS_ERR(folio))
>> +			folio_put(folio);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int shmem_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
>> +{
>> +	loff_t endbyte;
>> +	pgoff_t start_index;
>> +	pgoff_t end_index;
>> +	struct address_space *mapping;
>> +	struct inode *inode = file_inode(file);
>> +	int ret = 0;
>> +
>> +	if (S_ISFIFO(inode->i_mode))
>> +		return -ESPIPE;
>> +
>> +	mapping = file->f_mapping;
>> +	if (!mapping || len < 0 || !shmem_mapping(mapping))
>> +		return -EINVAL;
>> +
>> +	endbyte = fadvise_calc_endbyte(offset, len);
>> +
>> +	start_index = offset >> PAGE_SHIFT;
>> +	end_index   = endbyte >> PAGE_SHIFT;
>> +	switch (advice) {
>> +	case POSIX_FADV_DONTNEED:
> This is where I ran out of time.  I'm afraid all the focus on
> fadvise_calc_endbyte() has distracted you from looking at the DONTNEED
> in mm/fadvise.c: where there are detailed comments on why and how it
> then narrows the DONTNEED range.  And aside from needing to duplicate
> that here for shmem (or put it into another or combined helper), it
> implies to me that shmem_isolate_pages_range() needs to do a similar
> narrowing, when it finds that the range overlaps part of a large folio.
> 
Sure, will include those range calculations for shmem pages too.

> Something that has crossed my mind as a worry, but I've not had time
> to look further into (maybe it's no concern at all) is the question
> of this syscall temporarily isolating a very large number of folios,
> whether they need to be (or perhaps already are) counted in
> NR_ISOLATED_ANON, whether too many isolated needs to be limited.

They are _not_ counted as ISOLATED_ANON now as this operation is for a
small duration. I do see there exists too_many_isolated() checks in
direct reclaim/compaction logic where it is necessary to stop the
multiple processes in the direct reclaim from isolating too many pages.

I am not able to envisage such problem here, where usually single
process doing the fadvise operation on a file. Even If the file is
opened by multiple processes and do fadvise, the operation is limited
only to the pages of this file and doesn't impact the system.

Please let me know if I'm missing something where I should be counting
these as NR_ISOLATED.

> 
>> +		ret = shmem_fadvise_dontneed(mapping, start_index, end_index);
>> +		break;
>> +	case POSIX_FADV_WILLNEED:
>> +		ret = shmem_fadvise_willneed(mapping, start_index, end_index);
>> +		break;
>> +	case POSIX_FADV_NORMAL:
>> +	case POSIX_FADV_RANDOM:
>> +	case POSIX_FADV_SEQUENTIAL:
>> +	case POSIX_FADV_NOREUSE:
>> +		/*
>> +		 * No bad return value, but ignore advice.
>> +		 */
>> +		break;
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>>  static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block *sb,
>>  				     struct inode *dir, umode_t mode, dev_t dev,
>>  				     unsigned long flags)
>> @@ -3942,6 +4057,7 @@ static const struct file_operations shmem_file_operations = {
>>  	.splice_write	= iter_file_splice_write,
>>  	.fallocate	= shmem_fallocate,
>>  #endif
>> +	.fadvise	= shmem_fadvise,
> I'd say posix_fadvise() is an operation on an fd, and shmem_fadvise() and
> all its helpers should be under CONFIG_TMPFS (but oftentimes I do think
Sure.
> CONFIG_TMPFS and CONFIG_SHMEM are more trouble than they are worth).
> 
> Hugh
> 
