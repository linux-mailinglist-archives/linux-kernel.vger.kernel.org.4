Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B100F5B6B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 11:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbiIMJ5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiIMJ5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 05:57:31 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B744B4B5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 02:57:29 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1663063047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r1q0gozH1CGMtQTZP+/A3s5oBG5/juquDr/kG+a4ih4=;
        b=da/832vr+4+Fd+hy0AkN9SdxZMSHXrOgsCZHiwKPf7uMt1bYrtaPJg+zJ/SdI1Om0GFoLL
        Z5OcdzG6MQyNXKplyutHDK4i9El5HLaEYnXKKU58ceANILY5hEJe+MzD65FawiHRkJ4uqK
        qznlprmsxFJ24juSypky/pVg0PgLF3I=
MIME-Version: 1.0
Subject: Re: [PATCH v3] mm: hugetlb: eliminate memory-less nodes handling
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <b8d2fe17-93e6-743a-73c4-e8b22964704b@redhat.com>
Date:   Tue, 13 Sep 2022 17:57:15 +0800
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>, ying.huang@intel.com,
        aneesh.kumar@linux.ibm.com, David Rientjes <rientjes@google.com>,
        linux-kernel@vger.kernel.org, Linux MM <linux-mm@kvack.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BC89CDF2-D3BA-42DF-B73B-9E765A865F10@linux.dev>
References: <20220908075826.37094-1-songmuchun@bytedance.com>
 <b8d2fe17-93e6-743a-73c4-e8b22964704b@redhat.com>
To:     David Hildenbrand <david@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 8, 2022, at 20:21, David Hildenbrand <david@redhat.com> wrote:
>=20
> On 08.09.22 09:58, Muchun Song wrote:
>> The memory-notify-based approach aims to handle meory-less nodes, =
however, it just adds
>> the complexity of code as pointed by David in thread [1].  The =
handling of memory-less
>> nodes is introduced by commit 4faf8d950ec4 ("hugetlb: handle memory =
hot-plug events").
>> =46rom its commit message, we cannot find any necessity of handling =
this case. So, we can
>> simply register/unregister sysfs entries in =
register_node/unregister_node to simlify the
>> code.
>> BTW, hotplug callback added because in hugetlb_register_all_nodes() =
we register sysfs
>> nodes only for N_MEMORY nodes, seeing commit 9b5e5d0fdc91, which said =
it was a preparation
>> for handling memory-less nodes via memory hotplug. Since we want to =
remove memory hotplug,
>> so make sure we only register per-node sysfs for online (N_ONLINE) =
nodes in
>> hugetlb_register_all_nodes().
>> =
https://lore.kernel.org/linux-mm/60933ffc-b850-976c-78a0-0ee6e0ea9ef0@redh=
at.com/ [1]
>> Suggested-by: David Hildenbrand <david@redhat.com>
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>> ---
>> v3:
>>  - Fix 'struct node' is not declared reported by LTP.
>> v2:
>>  - Move declaration of function related to hugetlb to hugetlb.h =
(David).
>>  - Introduce hugetlb_sysfs_initialized() and call it from =
hugetlb_sysfs_init() (David).
>>  - Move hugetlb_register_all_nodes() into hugetlb_sysfs_init() =
(David).
>>  - Fix implicit-function-declaration reported by LKP.
>>  - Register per-node sysfs for online (N_ONLINE) nodes instead of =
N_MEMORY (Aneesh).
>>  drivers/base/node.c     |  8 +++--
>>  include/linux/hugetlb.h | 14 +++++++++
>>  mm/hugetlb.c            | 81 =
++++++++++++++++++++++---------------------------
>>  3 files changed, 57 insertions(+), 46 deletions(-)
>=20
>=20
>=20
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
>> @@ -3880,24 +3880,14 @@ static int hugetlb_sysfs_add_hstate(struct =
hstate *h, struct kobject *parent,
>>  	return 0;
>>  }
>>  -static void __init hugetlb_sysfs_init(void)
>> -{
>> -	struct hstate *h;
>> -	int err;
>> -
>> -	hugepages_kobj =3D kobject_create_and_add("hugepages", mm_kobj);
>> -	if (!hugepages_kobj)
>> -		return;
>> +#ifdef CONFIG_NUMA
>> +static bool hugetlb_sysfs_initialized __ro_after_init;
>>  -	for_each_hstate(h) {
>> -		err =3D hugetlb_sysfs_add_hstate(h, hugepages_kobj,
>> -					 hstate_kobjs, =
&hstate_attr_group);
>> -		if (err)
>> -			pr_err("HugeTLB: Unable to add hstate %s", =
h->name);
>> -	}
>> +static inline void hugetlb_mark_sysfs_initialized(void)
>> +{
>> +	hugetlb_sysfs_initialized =3D true;
>>  }
>=20
> Do we really need a separate function for this? Why not simply always =
set that from hugetlb_sysfs_init() ?

I can remove this helper.

>=20
> I'm also not sure if we really want to optimize out one variable for =
!CONFIG_NUMA.

Either is fine to me. I think the optimization does not bring any =
complexity.
So I=E2=80=99ll keep it the same in the next version unless anyone is =
against this.

>=20
> Anyhow, in general
>=20
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks David.

>=20
>=20
> --=20
> Thanks,
>=20
> David / dhildenb
>=20

