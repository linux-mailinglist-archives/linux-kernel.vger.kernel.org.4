Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 252C66146AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 10:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiKAJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKAJaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 05:30:09 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C32264F
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 02:30:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1667295005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TJnkLWBDb/g+EIJR+QCS7+bzQuK8KqDlxpwgbdmako0=;
        b=I3+tX0DGdXq93FnPXwK/TAd0YbWOlhvU00/OVLZZHIOaE1O/DlWDA+eZ0n1pfVOuWL6bmy
        Ru0lZ59Afj6AC8Rdr/lRYbAISG+aawR6lwiuIwF9HDyUTz9BPBYCbN/FK3m5HHrqohW/9h
        /NIPShIw5Owt6Zzx5xIAIOt8KZ2bdWc=
MIME-Version: 1.0
Subject: Re: [PATCH -next 1/1] mm: hugetlb_vmemmap: Fix WARN_ON in
 vmemmap_remap_pte
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <Y1v64lILNN2woIcu@arm.com>
Date:   Tue, 1 Nov 2022 17:29:49 +0800
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Wupeng Ma <mawupeng1@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <1FD8D6EF-B7E9-4200-931C-3CCD81605741@linux.dev>
References: <20221025014215.3466904-1-mawupeng1@huawei.com>
 <614E3E83-1EAB-4C39-AF9C-83C0CCF26218@linux.dev>
 <35dd51eb-c266-f221-298a-21309c17971a@arm.com>
 <3D6FDA43-A812-4907-B9C8-C2B25567DBBC@linux.dev>
 <3c545133-71aa-9a8d-8a13-09186c4fa767@arm.com> <Y1piguJXagcxiTpn@arm.com>
 <ED740104-0A97-44C1-839F-407F221070BB@linux.dev> <Y1v64lILNN2woIcu@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Oct 28, 2022, at 23:53, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>=20
> On Fri, Oct 28, 2022 at 10:45:09AM +0800, Muchun Song wrote:
>> On Oct 27, 2022, at 18:50, Catalin Marinas <catalin.marinas@arm.com> =
wrote:
>>> On Wed, Oct 26, 2022 at 02:06:00PM +0530, Anshuman Khandual wrote:
>>>> On 10/26/22 12:31, Muchun Song wrote:
>>>>>> On 10/25/22 12:06, Muchun Song wrote:
>>>>>>>> On Oct 25, 2022, at 09:42, Wupeng Ma <mawupeng1@huawei.com> =
wrote:
>>>>>>>> From: Ma Wupeng <mawupeng1@huawei.com>
>>>>>>>>=20
>>>>>>>> Commit f41f2ed43ca5 ("mm: hugetlb: free the vmemmap pages =
associated with
>>>>>>>> each HugeTLB page") add vmemmap_remap_pte to remap the tail =
pages as
>>>>>>>> read-only to catch illegal write operation to the tail page.
>>>>>>>>=20
>>>>>>>> However this will lead to WARN_ON in arm64 in =
__check_racy_pte_update()
>>>>>>>=20
>>>>>>> Thanks for your finding this issue.
>>>>>>>=20
>>>>>>>> since this may lead to dirty state cleaned. This check is =
introduced by
>>>>>>>> commit 2f4b829c625e ("arm64: Add support for hardware updates =
of the
>>>>>>>> access and dirty pte bits") and the initial check is as follow:
>>>>>>>>=20
>>>>>>>> BUG_ON(pte_write(*ptep) && !pte_dirty(pte));
>>>>>>>>=20
>>>>>>>> Since we do need to mark this pte as read-only to catch illegal =
write
>>>>>>>> operation to the tail pages, use set_pte  to replace set_pte_at =
to bypass
>>>>>>>> this check.
>>>>>>>=20
>>>>>>> In theory, the waring does not affect anything since the tail =
vmemmap
>>>>>>> pages are supposed to be read-only. So, skipping this check for =
vmemmap
>>>>>>=20
>>>>>> Tails vmemmap pages are supposed to be read-only, in practice but =
their
>>>>>> backing pages do have pte_write() enabled. Otherwise the =
VM_WARN_ONCE()
>>>>>> warning would not have triggered.
>>>>>=20
>>>>> Right.
>>>>>=20
>>>>>>=20
>>>>>>      VM_WARN_ONCE(pte_write(old_pte) && !pte_dirty(pte),
>>>>>>                   "%s: racy dirty state clearing: 0x%016llx -> =
0x%016llx",
>>>>>>                   __func__, pte_val(old_pte), pte_val(pte));
>>>>>>=20
>>>>>> Also, is not it true that the pte being remapped into a different =
page
>>>>>> as read only, than what it had originally (which will be freed =
up) i.e=20
>>>>>> the PFN in 'old_pte' and 'pte' will be different. Hence is there =
still
>>>>>=20
>>>>> Right.
>>>>>=20
>>>>>> a possibility for a race condition even when the PFN changes ?
>>>>>=20
>>>>> Sorry, I didn't get this question. Did you mean the PTE is changed =
from
>>>>> new (pte) to the old one (old_pte) by the hardware because of the =
update
>>>>> of dirty bit when a concurrent write operation to the tail vmemmap =
page?
>>>>=20
>>>> No, but is not vmemmap_remap_pte() reuses walk->reuse_page for all =
remaining
>>>> tails pages ? Is not there a PFN change, along with access =
permission change
>>>> involved in this remapping process ?
>>>=20
>>> For the record, as we discussed offline, changing the output address
>>> (pfn) of a pte is not safe without break-before-make if at least one =
of
>>> the mappings was writeable. The caller (vmemmap_remap_pte()) would =
need
>>> to be fixed to first invalidate the pte and then write the new pte. =
I
>>=20
>> Could you expose more details about what issue it will be caused? I =
am
>> not familiar with arm64.
>=20
> Well, it's not allowed by the architecture, so some CPU =
implementations
> may do weird things like accessing incorrect memory or triggering TLB
> conflict aborts if, for some reason, they end up with two entries in
> the TLB for the same VA but pointing to different pfns. The hardware
> expects an invalid PTE and TLB invalidation between such changes. In
> practice most likely nothing happens and this works fine but we need =
to
> stick to the architecture requirements in case some CPUs take =
advantage
> of this requirement.

Got it. Thanks for your nice explanation.

>=20
>>> assume no other CPU accesses this part of the vmemmap while the pte =
is
>>> being remapped.
>>=20
>> However, there is no guarantee that no other CPU accesses this pte.
>> E.g. memory failure or memory compaction, both can obtain head page
>> from any tail struct pages (only read) anytime.
>=20
> Oh, so we cannot safely go through a break-before-make sequence here
> (zero the PTE, flush the TLB, write the new PTE) as some CPU may =
access
> this pte.

Right.

Muchun

>=20
> --=20
> Catalin


