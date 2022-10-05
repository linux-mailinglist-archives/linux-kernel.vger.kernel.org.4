Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE235F4D6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 03:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJEBhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 21:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiJEBhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 21:37:36 -0400
Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [IPv6:2a0c:5a00:149::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B96206F540
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 18:37:33 -0700 (PDT)
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
        by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.v.b@runbox.com>)
        id 1oftLj-00FUOw-M0; Wed, 05 Oct 2022 03:37:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID;
        bh=O9KbrdN6Sv+jKKGOZ8bbe4wvldYZw53ghGEW82CqbRY=; b=DsvfWcJYzTkSWMnZCNR8TC9gG1
        GjqnEO+Z9mre5oLVpHhzb514dVMUZk8oYJVFLZxL/M5fbJkpSC3j2rMoh02rSF2TbYyfn2pbo59kd
        M7YwgZHDf4bWt2xZpJwZkOwAq3B/aHAft1TLf1ZGnLosZKIGX4GMGQPAam6go2gpYy7EmAwJNJC/d
        oLpLHAzvXZQnvvY7IoYcQDJ0vsg4p3rFBY+Gq/eq0eo+tOlauSp8bn4c4xLclRB69USOKuY7i4prP
        K0vuBYz42wpYyEFUmAAVs+Ivijgf9+1niVZzwUzhbBxxUb8XyPshkHtAgECoGaCj6FyCGP4NjmNvw
        Gtvu2jsw==;
Received: from [10.9.9.74] (helo=submission03.runbox)
        by mailtransmit03.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1oftLi-0003QS-O0; Wed, 05 Oct 2022 03:37:26 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1oftLg-0004oN-CR; Wed, 05 Oct 2022 03:37:24 +0200
Message-ID: <fdc85c53-4025-bbf9-5ec6-f767f7521217@runbox.com>
Date:   Tue, 4 Oct 2022 21:37:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH v2 1/2] xen/gntdev: Prevent leaking grants
Content-Language: en-CA
To:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20221002222006.2077-1-m.v.b@runbox.com>
 <20221002222006.2077-2-m.v.b@runbox.com> <YzotDube4gTn7r9b@itl-email>
 <41d15ac1-7977-db49-f8e9-df642616c745@runbox.com>
 <YzuRuD/t4/rZAkGG@itl-email>
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
In-Reply-To: <YzuRuD/t4/rZAkGG@itl-email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-03 21:51, Demi Marie Obenour wrote:
> On Mon, Oct 03, 2022 at 09:31:25PM -0400, M. Vefa Bicakci wrote:
>> On 2022-10-02 20:29, Demi Marie Obenour wrote:
>>> On Sun, Oct 02, 2022 at 06:20:05PM -0400, M. Vefa Bicakci wrote:
>>>> Prior to this commit, if a grant mapping operation failed partially,
>>>> some of the entries in the map_ops array would be invalid, whereas all
>>>> of the entries in the kmap_ops array would be valid. This in turn would
>>>> cause the following logic in gntdev_map_grant_pages to become invalid:
>>>>
>>>>     for (i = 0; i < map->count; i++) {
>>>>       if (map->map_ops[i].status == GNTST_okay) {
>>>>         map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>>         if (!use_ptemod)
>>>>           alloced++;
>>>>       }
>>>>       if (use_ptemod) {
>>>>         if (map->kmap_ops[i].status == GNTST_okay) {
>>>>           if (map->map_ops[i].status == GNTST_okay)
>>>>             alloced++;
>>>>           map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>>>         }
>>>>       }
>>>>     }
>>>>     ...
>>>>     atomic_add(alloced, &map->live_grants);
>>>>
>>>> Assume that use_ptemod is true (i.e., the domain mapping the granted
>>>> pages is a paravirtualized domain). In the code excerpt above, note that
>>>> the "alloced" variable is only incremented when both kmap_ops[i].status
>>>> and map_ops[i].status are set to GNTST_okay (i.e., both mapping
>>>> operations are successful).  However, as also noted above, there are
>>>> cases where a grant mapping operation fails partially, breaking the
>>>> assumption of the code excerpt above.
>>>>
>>>> The aforementioned causes map->live_grants to be incorrectly set. In
>>>> some cases, all of the map_ops mappings fail, but all of the kmap_ops
>>>> mappings succeed, meaning that live_grants may remain zero. This in turn
>>>> makes it impossible to unmap the successfully grant-mapped pages pointed
>>>> to by kmap_ops, because unmap_grant_pages has the following snippet of
>>>> code at its beginning:
>>>>
>>>>     if (atomic_read(&map->live_grants) == 0)
>>>>       return; /* Nothing to do */
>>>>
>>>> In other cases where only some of the map_ops mappings fail but all
>>>> kmap_ops mappings succeed, live_grants is made positive, but when the
>>>> user requests unmapping the grant-mapped pages, __unmap_grant_pages_done
>>>> will then make map->live_grants negative, because the latter function
>>>> does not check if all of the pages that were requested to be unmapped
>>>> were actually unmapped, and the same function unconditionally subtracts
>>>> "data->count" (i.e., a value that can be greater than map->live_grants)
>>>> from map->live_grants. The side effects of a negative live_grants value
>>>> have not been studied.
>>>>
>>>> The net effect of all of this is that grant references are leaked in one
>>>> of the above conditions. In Qubes OS v4.1 (which uses Xen's grant
>>>> mechanism extensively for X11 GUI isolation), this issue manifests
>>>> itself with warning messages like the following to be printed out by the
>>>> Linux kernel in the VM that had granted pages (that contain X11 GUI
>>>> window data) to dom0: "g.e. 0x1234 still pending", especially after the
>>>> user rapidly resizes GUI VM windows (causing some grant-mapping
>>>> operations to partially or completely fail, due to the fact that the VM
>>>> unshares some of the pages as part of the window resizing, making the
>>>> pages impossible to grant-map from dom0).
>>>>
>>>> The fix for this issue involves counting all successful map_ops and
>>>> kmap_ops mappings separately, and then adding the sum to live_grants.
>>>> During unmapping, only the number of successfully unmapped grants is
>>>> subtracted from live_grants. The code is also modified to check for
>>>> negative live_grants values after the subtraction and warn the user.
>>>>
>>>> Link: https://github.com/QubesOS/qubes-issues/issues/7631
>>>> Fixes: dbe97cff7dd9 ("xen/gntdev: Avoid blocking in unmap_grant_pages()")
>>>
>>> Looks like this patch has been pretty buggy, sorry.  This is the second
>>> time there has been a problem with it.  Thanks for the fix.
>>
>> Hi,
>>
>> No problem! :-) Debugging this issue and coming up with a fix was a
>> nice challenge for me.
> 
> You’re welcome!  I’m glad you were able to do this.
> 
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
>>>> ---
>>>>
>>>> Changes since v1:
>>>> - To determine which unmap operations were successful, the previous
>>>>     version of this patch set the "unmap_ops[i].status" and
>>>>     "kunmap_ops[i].status" fields to the value "1" prior to passing these
>>>>     data structures to the hypervisor. Instead of doing that, the code now
>>>>     checks whether the "handle" fields in the same data structures were
>>>>     *not* set to "INVALID_GRANT_HANDLE". (Suggested by Juergen Gross.)
>>>> ---
>>>>    drivers/xen/gntdev.c | 22 +++++++++++++++++-----
>>>>    1 file changed, 17 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>>>> index 84b143eef395..eb0586b9767d 100644
>>>> --- a/drivers/xen/gntdev.c
>>>> +++ b/drivers/xen/gntdev.c
>>>> @@ -367,8 +367,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
>>>>    	for (i = 0; i < map->count; i++) {
>>>>    		if (map->map_ops[i].status == GNTST_okay) {
>>>>    			map->unmap_ops[i].handle = map->map_ops[i].handle;
>>>> -			if (!use_ptemod)
>>>> -				alloced++;
>>>> +			alloced++;
>>>>    		} else if (!err)
>>>>    			err = -EINVAL;
>>>> @@ -377,8 +376,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
>>>>    		if (use_ptemod) {
>>>>    			if (map->kmap_ops[i].status == GNTST_okay) {
>>>> -				if (map->map_ops[i].status == GNTST_okay)
>>>> -					alloced++;
>>>> +				alloced++;
>>>>    				map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>>>    			} else if (!err)
>>>>    				err = -EINVAL;
>>>> @@ -394,8 +392,14 @@ static void __unmap_grant_pages_done(int result,
>>>>    	unsigned int i;
>>>>    	struct gntdev_grant_map *map = data->data;
>>>>    	unsigned int offset = data->unmap_ops - map->unmap_ops;
>>>> +	int successful_unmaps = 0;
>>>> +	int live_grants;
>>>>    	for (i = 0; i < data->count; i++) {
>>>> +		if (map->unmap_ops[offset + i].status == GNTST_okay &&
>>>> +		    map->unmap_ops[offset + i].handle != INVALID_GRANT_HANDLE)
>>>> +			successful_unmaps++;
>>>> +
>>>>    		WARN_ON(map->unmap_ops[offset + i].status != GNTST_okay &&
>>>>    			map->unmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
>>>>    		pr_debug("unmap handle=%d st=%d\n",
>>>> @@ -403,6 +407,10 @@ static void __unmap_grant_pages_done(int result,
>>>>    			map->unmap_ops[offset+i].status);
>>>>    		map->unmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
>>>>    		if (use_ptemod) {
>>>> +			if (map->kunmap_ops[offset + i].status == GNTST_okay &&
>>>> +			    map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE)
>>>> +				successful_unmaps++;
>>>> +
>>>>    			WARN_ON(map->kunmap_ops[offset + i].status != GNTST_okay &&
>>>>    				map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
>>>>    			pr_debug("kunmap handle=%u st=%d\n",
>>>> @@ -411,11 +419,15 @@ static void __unmap_grant_pages_done(int result,
>>>>    			map->kunmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
>>>>    		}
>>>>    	}
>>>> +
>>>>    	/*
>>>>    	 * Decrease the live-grant counter.  This must happen after the loop to
>>>>    	 * prevent premature reuse of the grants by gnttab_mmap().
>>>>    	 */
>>>> -	atomic_sub(data->count, &map->live_grants);
>>>> +	live_grants = atomic_sub_return(successful_unmaps, &map->live_grants);
>>>> +	if (WARN_ON(live_grants < 0))
>>>> +		pr_err("%s: live_grants became negative (%d) after unmapping %d pages!\n",
>>>> +		       __func__, live_grants, successful_unmaps);
>>>>    	/* Release reference taken by __unmap_grant_pages */
>>>>    	gntdev_put_map(NULL, map);
>>>> -- 
>>>> 2.37.3
>>>
>>> Is there a possibility that live_grants could overflow, as it is now
>>> set to a value twice as large as what it had been previously?
>>
>> Good point! My answer in summary: I think that the code could be improved,
>> but with reasonable values for the "limit" module parameter, there should
>> not be issues.
>>
>> Grant mappings are set up via ioctl calls, and the structure field that
>> holds the number of grant references has u32 type:
>>
>> (Quoting from kernel v5.15.71 for convenience)
>> include/uapi/xen/gntdev.h
>> === 8< ===
>> struct ioctl_gntdev_map_grant_ref {
>> 	/* IN parameters */
>> 	/* The number of grants to be mapped. */
>> 	__u32 count;
>> === >8 ===
>>
>> However, the number of grant references is further limited in the actual
>> ioctl handler function gntdev_ioctl_map_grant_ref(), which calls
>> gntdev_test_page_count() to ensure that the number of granted pages
>> requested to be mapped does not exceed "limit". "limit" defaults to 64K,
>> which should be okay to use with an atomic_t type (i.e., a 32-bit signed
>> integer type) like "live_grants", assuming that the system administrator
>> does not go overboard and set "limit" to a very large value:
>>
>> drivers/xen/gntdev.c
>> === 8< ===
>> static unsigned int limit = 64*1024;
>> module_param(limit, uint, 0644);
>> MODULE_PARM_DESC(limit,
>> 	"Maximum number of grants that may be mapped by one mapping request");
>>
>> /* trimmed */
>>
>> bool gntdev_test_page_count(unsigned int count)
>> {
>> 	return !count || count > limit;
>> }
>>
>> /* trimmed */
>>
>> static long gntdev_ioctl_map_grant_ref(struct gntdev_priv *priv,
>> 				       struct ioctl_gntdev_map_grant_ref __user *u)
>> {
>> 	/* trimmed */
>>
>> 	pr_debug("priv %p, add %d\n", priv, op.count);
>> 	if (unlikely(gntdev_test_page_count(op.count)))
>> 		return -EINVAL;
>>
>> 	/* trimmed */
>> }
>> === >8 ===
>>
>> To be fair, the "count" field of the gndev_grant_map structure is a signed
>> integer, so very large values of count could overflow live_grants, as
>> live_grants needs to accommodate values up to and including 2*count.
> 
> Could this be replaced by an unsigned and/or 64-bit integer?
> Alternatively, one could use module_param_cb and param_set_uint_minmax
> to enforce that the limit is something reasonable.  That said, one needs
> almost 8TiB to trigger this problem, so while it ought to be fixed it
> isn’t a huge deal.  Certainly should not block getting this merged.

Thank you for the continued feedback.

I agree that these can be implemented to prevent overflowing "live_grants".
"live_grants" could be made an atomic64_t, and/or a to-be-chosen maximum
value less than or equal to INT_MAX/2 can be imposed on "limit" using the
approach you suggested.

I think that the latter option could be better, as the driver uses signed
integers in a number of places (including the gntdev_grant_map structure),
but the requested number of mappings (i.e., "count" in
ioctl_gntdev_map_grant_ref, provided by user-space) and "limit" are
unsigned integers.

> 
>> drivers/xen/gntdev-common.h
>> === 8< ===
>> struct gntdev_grant_map {
>> 	atomic_t in_use;
>> 	struct mmu_interval_notifier notifier;
>> 	bool notifier_init;
>> 	struct list_head next;
>> 	int index;
>> 	int count;
>> 	/* trimmed */
>> }
>> === >8 ===
>>
>>> If not, you can add:
>>>
>>> Acked-by: Demi Marie Obenour <demi@invisiblethingslab.com>
>>
>> Thank you! I hope that the explanation and rationale above are satisfactory.
>> Please let me know what you think.
> 
> They are indeed.

Thanks!

Vefa
