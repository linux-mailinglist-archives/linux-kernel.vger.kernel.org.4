Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2148F6C6E4F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 18:00:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjCWRAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 13:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjCWRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 13:00:50 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBE361AE
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 10:00:48 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230323170047euoutp026b4f2dc68e60f7810733b5e49e668120~PGvn8q76Z1604616046euoutp02T
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 17:00:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230323170047euoutp026b4f2dc68e60f7810733b5e49e668120~PGvn8q76Z1604616046euoutp02T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679590847;
        bh=KhR26IKDTGtCPfo2iRK0w4LATJSZVVan6rtbsXI97Xs=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=VhxwiY//HGoqIcdHDTpfynMA7hg9qJOJTPAfFOpnAi5DxSpZ7a6rftfp8V6o3BOwh
         N4VdfIrTuRX8j/RU5yRXC1i/SLxEt4KGipqmHCQ6D1TvbLYBlwuELi5XWtNIUcWJ7P
         EhgLGlglcHkor6vpJYwopfgMKrdF1b8Rt9sZh12Y=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230323170046eucas1p2be73fce85d27d3d549f951b73199b244~PGvnj7FQy0142501425eucas1p2Z;
        Thu, 23 Mar 2023 17:00:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 90.97.09503.EB58C146; Thu, 23
        Mar 2023 17:00:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda~PGvnR85750549005490eucas1p2V;
        Thu, 23 Mar 2023 17:00:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230323170046eusmtrp2c0784afec1c036d7224753fa3e4b1a78~PGvnRYlY83094130941eusmtrp2d;
        Thu, 23 Mar 2023 17:00:46 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-d1-641c85beb634
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DE.CA.08862.EB58C146; Thu, 23
        Mar 2023 17:00:46 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230323170045eusmtip21846d4d89acf39c5afeb3c4bbb617f52~PGvmwisT50260002600eusmtip2N;
        Thu, 23 Mar 2023 17:00:45 +0000 (GMT)
Message-ID: <a5d567b6-a067-c3e2-e500-e459cf47851f@samsung.com>
Date:   Thu, 23 Mar 2023 18:00:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
        Gecko/20100101 Thunderbird/102.9.0
Subject: Re: [PATCH v2 3/4] mm/mmap/vma_merge: extend invariants, avoid
 invalid res, vma
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, Vernon Yang <vernon2gm@gmail.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djP87r7WmVSDHqOyVrMWb+GzeLr+l/M
        FtsbHrBbXN41h83i3pr/rBZ3vs1jt9iwsoHJYnZjH6PF3ts32Cx+/5jD5sDlsXPWXXaPzSu0
        PDZ9msTucWLGbxaPzUvqPT4+vcXi8X7fVTaPMwuOsHt83iQXwBnFZZOSmpNZllqkb5fAldGz
        7BdrwW+Vik8PvrE3ME6R7WLk5JAQMJHYsn8jexcjF4eQwApGiWOHGpggnC+MEpcafjNCOJ8Z
        JXYs/cTSxcgB1vKigQ0ivpxRYuX/o1AdHxklOmY1s4HM5RWwkzh2cx4riM0ioCqx5e0XVoi4
        oMTJmU9YQGxRgRSJiTM2MIEMFRaIkpg3wx0kzCwgLnHryXywmSIC7YwSc5Z1MIM4zALPGSW+
        Ny5gBKliEzCU6HrbBbaMUyBSYtr/kywQ3fISzVtngzVICPRzSkzeOIEZ4mwXiWu/6iCeFpZ4
        dXwLO4QtI/F/J8Q2CZBtC37fh3ImMEo0PL/FCFFlLXHn3C82kEHMApoS63fpQ4QdJWa072aH
        mM8nceOtIMQNfBKTtk2HWssr0dEmBFGtJjHr+Dq4tQcvXGKewKg0CylYZiH5fxaSb2Yh7F3A
        yLKKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMI2d/nf80w7Gua8+6h1iZOJgPMQowcGs
        JMLrxiyRIsSbklhZlVqUH19UmpNafIhRmoNFSZxX2/ZkspBAemJJanZqakFqEUyWiYNTqoEp
        7uqHu5wJUhqnohieuv+9Ee+lMdncyLD4RodBwrPNcTO++obUdtSHPZNgmLZx58qru400Vr1Y
        fbPB5HvCtS2elyxT38tZvdp1IaN1Wccmsd+xtx/JT9TSumopsXPJxkSdXUx3Hh3PjqqLfBtb
        GycYp2wRXq+n/S3MyleuX/ypVvL/qFXL08I0RDcZK8z2LAm++2CR82IXvU0BRYd3mrMJyvzZ
        L+KWq7am9T5TcGYUd/mBSdvXdxWwHY31Ebs2N/fd3zvTeAIf5HQqn5RfmL5yrQDnBMeNiwT3
        cXMUz52t+EB3xdfi9wZH5/sdXT1nucbTNxO43b/OMJ6x/8RV7gtr9GzMhRUlU5vr9xp/4g1V
        YinOSDTUYi4qTgQA8xHO0dIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xe7r7WmVSDNbc5bOYs34Nm8XX9b+Y
        LbY3PGC3uLxrDpvFvTX/WS3ufJvHbrFhZQOTxezGPkaLvbdvsFn8/jGHzYHLY+esu+wem1do
        eWz6NInd48SM3ywem5fUe3x8eovF4/2+q2weZxYcYff4vEkugDNKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6Nn2S/Wgt8qFZ8efGNvYJwi28XI
        wSEhYCLxooGti5GTQ0hgKaPEmaMFILaEgIzEyWkNrBC2sMSfa11ANVxANe8ZJU6sb2cGSfAK
        2EkcuzkPrIhFQFViy9svrBBxQYmTM5+wgNiiAikSE5deZgPZJSwQJTFvhjtImFlAXOLWk/lM
        IDNFBNoZJZY9O8UGkXjOKPFmJTvEshZGifdPZjGBJNgEDCW63naBFXEKREpM+3+SBaLBTKJr
        axcjhC0v0bx1NvMERqFZSO6YhWThLCQts5C0LGBkWcUoklpanJueW2yoV5yYW1yal66XnJ+7
        iREYtduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8LoxS6QI8aYkVlalFuXHF5XmpBYfYjQFBsZE
        ZinR5Hxg2sgriTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamA6xsHW
        ZbXZgbWyT4v98ZUNs1sWFcYriTN1uh/fLfjc40dIQfEjgwwv3nVSdpELrz1WWPYs78fmL9fj
        RT0fTf0YJHY76ei+/RF1urue1a91582543f9WaRyxMQddhyhXR/2Js320XnZu6/ddPWeH9Od
        xDI0Ny7wr0+ukcsJLVauWfPvxEttXyOjhy+YnjAt8mKOKA//u0CLU8DFpHDNagdr6XPCjgfv
        s60ve1PQkKOX+eTL3F+n36U3dZ2xuaR0NdzPf4vwnLSZe6Uv33nFf8WkMMa6S+6Yf6F3i15m
        7bTXK1oehYu6cnC+fThhvr22cFDpnBXzFQX8tEUOdHv9X/jT2qPBs+xWAd8JjrKPqkosxRmJ
        hlrMRcWJAIjFDMNjAwAA
X-CMS-MailID: 20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda
References: <cover.1679431180.git.lstoakes@gmail.com>
        <17b6fc3edc46c4b33aa93b9ef17a63a3a76f4b5f.1679431180.git.lstoakes@gmail.com>
        <CGME20230323170046eucas1p2483ab0fcc3d6bc56d4b6d09143bbadda@eucas1p2.samsung.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21.03.2023 21:45, Lorenzo Stoakes wrote:
> Previously, vma was an uninitialised variable which was only definitely
> assigned as a result of the logic covering all possible input cases - for
> it to have remained uninitialised, prev would have to be NULL, and next
> would _have_ to be mergeable.
>
> We now reuse vma to assign curr and next, so to be absolutely explicit,
> ensure this variable is _always_ assigned, and while we're at it remove the
> redundant assignment of both res and vma (if prev is NULL then we simply
> assign to NULL).
>
> In addition, we absolutely do rely on addr == curr->vm_start should curr
> exist, so assert as much.
>
> Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>

This patch has been merged into today's linux next-20230323 as commit 
6426bbcc76be ("mm/mmap/vma_merge: extend invariants, avoid invalid res, 
vma").

Unfortunately it breaks booting of some ARM 32bit machines, like Samsung 
Exynos5422-based Odroid XU3 board. This shortened log shows the issue:

Run /sbin/init as init process
   with arguments:
     /sbin/init
   with environment:
     HOME=/
     TERM=linux
8<--- cut here ---
Unhandled fault: page domain fault (0x01b) at 0xb6f03010
[b6f03010] *pgd=b5e84835
Internal error: : 1b [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 2 PID: 1 Comm: init Not tainted 6.3.0-rc1-00296-g6426bbcc76be #6445
Hardware name: Samsung Exynos (Flattened Device Tree)
PC is at vma_merge+0xa0/0x728
LR is at vma_merge+0x294/0x728
pc : [<c02b08a8>]    lr : [<c02b0a9c>]    psr: a0000013
...
Flags: NzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4f11406a  DAC: 00000051
...
Process init (pid: 1, stack limit = 0x5219a5c7)
Stack: (0xf0835e30 to 0xf0836000)
...
  vma_merge from mprotect_fixup+0xc8/0x290
  mprotect_fixup from do_mprotect_pkey.constprop.0+0x210/0x338
  do_mprotect_pkey.constprop.0 from ret_fast_syscall+0x0/0x1c
Exception stack(0xf0835fa8 to 0xf0835ff0)
...
---[ end trace 0000000000000000 ]---
note: init[1] exited with irqs disabled
Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b

Reverting it on top of linux-next, together with 183b2bced4c9 
("mm/mmap/vma_merge: init cleanup, be explicit about the non-mergeable 
case"), which depends on this patch, fixes the boot issue.


> ---
>   mm/mmap.c | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 6361baf75601..7aec49c3bc74 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -911,7 +911,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   {
>   	pgoff_t pglen = (end - addr) >> PAGE_SHIFT;
>   	pgoff_t vma_pgoff;
> -	struct vm_area_struct *curr, *next, *res = NULL;
> +	struct vm_area_struct *curr, *next, *res;
>   	struct vm_area_struct *vma, *adjust, *remove, *remove2;
>   	int err = -1;
>   	bool merge_prev = false;
> @@ -940,14 +940,18 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   		/* Is there a VMA next to a hole (case 1 - 3) or prev (4)? */
>   		next = vma_lookup(mm, end);
>   
> -	/* verify some invariant that must be enforced by the caller */
> +	/*
> +	 * By default, we return prev. Cases 3, 4, 8 will instead return next
> +	 * and cases 3, 8 will also update vma to point at next.
> +	 */
> +	res = vma = prev;
> +
> +	/* Verify some invariant that must be enforced by the caller. */
>   	VM_WARN_ON(prev && addr <= prev->vm_start);
> -	VM_WARN_ON(curr && end > curr->vm_end);
> +	VM_WARN_ON(curr && (addr != curr->vm_start || end > curr->vm_end));
>   	VM_WARN_ON(addr >= end);
>   
>   	if (prev) {
> -		res = prev;
> -		vma = prev;
>   		vma_start = prev->vm_start;
>   		vma_pgoff = prev->vm_pgoff;
>   		/* Can we merge the predecessor? */
> @@ -958,6 +962,7 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   			vma_prev(vmi);
>   		}
>   	}
> +
>   	/* Can we merge the successor? */
>   	if (next && mpol_equal(policy, vma_policy(next)) &&
>   	    can_vma_merge_before(next, vm_flags,
> @@ -998,6 +1003,10 @@ struct vm_area_struct *vma_merge(struct vma_iterator *vmi, struct mm_struct *mm,
>   			adj_start = -(prev->vm_end - addr);
>   			err = dup_anon_vma(next, prev);
>   		} else {
> +			/*
> +			 * Note that cases 3 and 8 are the ONLY ones where prev
> +			 * is permitted to be (but is not necessarily) NULL.
> +			 */
>   			vma = next;			/* case 3 */
>   			vma_start = addr;
>   			vma_end = next->vm_end;

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

