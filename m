Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182625E718F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 03:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbiIWBtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 21:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiIWBtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 21:49:07 -0400
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [IPv6:2a0c:5a00:149::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54CCEBD42
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 18:49:04 -0700 (PDT)
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
        by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <m.v.b@runbox.com>)
        id 1obXoM-002R66-5o
        for linux-kernel@vger.kernel.org; Fri, 23 Sep 2022 03:49:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
         s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References
        :Cc:To:Subject:From:MIME-Version:Date:Message-ID;
        bh=Zb+Ndi6hr3zgnjOrbLIzoHacaBvMqQUP3vkITYGJe5I=; b=Ewm7OpFGDPfREfqbSPGkFZa853
        MyMbGYi1Plb5bUsXOAxS3pnhGcDNyUSN6qSiQ6OhJdqZKDfuHm9LnEhpYrRlV9Jyzao6E8ZZMsjPa
        Qqa5bGRHKYlxWTxo0JxIYNxrN3eZfWap8f0sJNyQryFWZGPBqAb9nn1gd/myzmZ5BHYPAQSMA6TA4
        H7C3DbyGAeYg9/W5RfsOmA5zFrCItMibjd1t8JxX58pvqMLr6bE6pBKguLH3pn2aZWiOlkDJEB9Mr
        w8DzYQghq8/aKi9N93COsgZmoM7rO0jvaBF8yu+luFEVFLkkOhH+EzWOJ5cUkFnsSWEI0dyN94DJ+
        /H1TsaaA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
        by mailtransmit02.runbox with esmtp (Exim 4.86_2)
        (envelope-from <m.v.b@runbox.com>)
        id 1obXoL-0003T8-BT; Fri, 23 Sep 2022 03:49:01 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (536975)]  (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        id 1obXoI-0001g4-Ni; Fri, 23 Sep 2022 03:48:58 +0200
Message-ID: <1bc60f1c-2aa7-2d4a-a6a2-c8592ed83486@runbox.com>
Date:   Thu, 22 Sep 2022 21:48:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
From:   "M. Vefa Bicakci" <m.v.b@runbox.com>
Subject: Re: [PATCH 1/2] xen/gntdev: Prevent leaking grants
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org
Cc:     Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Demi Marie Obenour <demi@invisiblethingslab.com>,
        Gerd Hoffmann <kraxel@redhat.com>
References: <20220912040002.198191-1-m.v.b@runbox.com>
 <20220912040002.198191-2-m.v.b@runbox.com>
 <cd175db2-432d-af09-7634-fbedd7c4febb@suse.com>
Content-Language: en-CA
In-Reply-To: <cd175db2-432d-af09-7634-fbedd7c4febb@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-09-19 05:52, Juergen Gross wrote:
> On 12.09.22 06:00, M. Vefa Bicakci wrote:
>> Prior to this commit, if a grant mapping operation failed partially,
>> some of the entries in the map_ops array would be invalid, whereas all
>> of the entries in the kmap_ops array would be valid. This in turn would
>> cause the following logic in gntdev_map_grant_pages to become invalid:
>>
>>    for (i = 0; i < map->count; i++) {
>>      if (map->map_ops[i].status == GNTST_okay) {
>>        map->unmap_ops[i].handle = map->map_ops[i].handle;
>>        if (!use_ptemod)
>>          alloced++;
>>      }
>>      if (use_ptemod) {
>>        if (map->kmap_ops[i].status == GNTST_okay) {
>>          if (map->map_ops[i].status == GNTST_okay)
>>            alloced++;
>>          map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>        }
>>      }
>>    }
>>    ...
>>    atomic_add(alloced, &map->live_grants);
>>
>> Assume that use_ptemod is true (i.e., the domain mapping the granted
>> pages is a paravirtualized domain). In the code excerpt above, note that
>> the "alloced" variable is only incremented when both kmap_ops[i].status
>> and map_ops[i].status are set to GNTST_okay (i.e., both mapping
>> operations are successful).  However, as also noted above, there are
>> cases where a grant mapping operation fails partially, breaking the
>> assumption of the code excerpt above.
>>
>> The aforementioned causes map->live_grants to be incorrectly set. In
>> some cases, all of the map_ops mappings fail, but all of the kmap_ops
>> mappings succeed, meaning that live_grants may remain zero. This in turn
>> makes it impossible to unmap the successfully grant-mapped pages pointed
>> to by kmap_ops, because unmap_grant_pages has the following snippet of
>> code at its beginning:
>>
>>    if (atomic_read(&map->live_grants) == 0)
>>      return; /* Nothing to do */
>>
>> In other cases where only some of the map_ops mappings fail but all
>> kmap_ops mappings succeed, live_grants is made positive, but when the
>> user requests unmapping the grant-mapped pages, __unmap_grant_pages_done
>> will then make map->live_grants negative, because the latter function
>> does not check if all of the pages that were requested to be unmapped
>> were actually unmapped, and the same function unconditionally subtracts
>> "data->count" (i.e., a value that can be greater than map->live_grants)
>> from map->live_grants. The side effects of a negative live_grants value
>> have not been studied.
>>
>> The net effect of all of this is that grant references are leaked in one
>> of the above conditions. In Qubes OS v4.1 (which uses Xen's grant
>> mechanism extensively for X11 GUI isolation), this issue manifests
>> itself with warning messages like the following to be printed out by the
>> Linux kernel in the VM that had granted pages (that contain X11 GUI
>> window data) to dom0: "g.e. 0x1234 still pending", especially after the
>> user rapidly resizes GUI VM windows (causing some grant-mapping
>> operations to partially or completely fail, due to the fact that the VM
>> unshares some of the pages as part of the window resizing, making the
>> pages impossible to grant-map from dom0).
>>
>> The fix for this issue involves counting all successful map_ops and
>> kmap_ops mappings separately, and then adding the sum to live_grants.
>> During unmapping, only the number of successfully unmapped grants is
>> subtracted from live_grants. To determine which grants were successfully
>> unmapped, their status fields are set to an arbitrary positive number
>> (1), as was done in commit ebee0eab0859 ("Xen/gntdev: correct error
>> checking in gntdev_map_grant_pages()"). The code is also modified to
>> check for negative live_grants values after the subtraction and warn the
>> user.
>>
>> Link: https://github.com/QubesOS/qubes-issues/issues/7631
>> Fixes: dbe97cff7dd9 ("xen/gntdev: Avoid blocking in unmap_grant_pages()")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: M. Vefa Bicakci <m.v.b@runbox.com>
>> ---
>>   drivers/xen/gntdev.c | 32 +++++++++++++++++++++++++++-----
>>   1 file changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/xen/gntdev.c b/drivers/xen/gntdev.c
>> index 84b143eef395..485fa9c630aa 100644
>> --- a/drivers/xen/gntdev.c
>> +++ b/drivers/xen/gntdev.c
>> @@ -367,8 +367,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
>>       for (i = 0; i < map->count; i++) {
>>           if (map->map_ops[i].status == GNTST_okay) {
>>               map->unmap_ops[i].handle = map->map_ops[i].handle;
>> -            if (!use_ptemod)
>> -                alloced++;
>> +            alloced++;
>>           } else if (!err)
>>               err = -EINVAL;
>> @@ -377,8 +376,7 @@ int gntdev_map_grant_pages(struct gntdev_grant_map *map)
>>           if (use_ptemod) {
>>               if (map->kmap_ops[i].status == GNTST_okay) {
>> -                if (map->map_ops[i].status == GNTST_okay)
>> -                    alloced++;
>> +                alloced++;
>>                   map->kunmap_ops[i].handle = map->kmap_ops[i].handle;
>>               } else if (!err)
>>                   err = -EINVAL;
>> @@ -394,8 +392,13 @@ static void __unmap_grant_pages_done(int result,
>>       unsigned int i;
>>       struct gntdev_grant_map *map = data->data;
>>       unsigned int offset = data->unmap_ops - map->unmap_ops;
>> +    int successful_unmaps = 0;
>> +    int live_grants;
>>       for (i = 0; i < data->count; i++) {
>> +        if (map->unmap_ops[offset + i].status == GNTST_okay)
>> +            successful_unmaps++;
> 

Hi,

Sorry for the delay, and thank you for reviewing my patches!

> Shouldn't this test include "&& handle != INVALID_GRANT_HANDLE" ?
> 
> This should enable you to drop setting status to 1 below.

I had not thought of the approach you suggested. Just now, I applied
your suggestion to my local kernel tree, and I am building a new kernel
for testing now. I hope to publish a newer version of this patch set
over the weekend.

Thanks again,

Vefa

> 
>> +
>>           WARN_ON(map->unmap_ops[offset + i].status != GNTST_okay &&
>>               map->unmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
>>           pr_debug("unmap handle=%d st=%d\n",
>> @@ -403,6 +406,9 @@ static void __unmap_grant_pages_done(int result,
>>               map->unmap_ops[offset+i].status);
>>           map->unmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
>>           if (use_ptemod) {
>> +            if (map->kunmap_ops[offset + i].status == GNTST_okay)
>> +                successful_unmaps++;
>> +
>>               WARN_ON(map->kunmap_ops[offset + i].status != GNTST_okay &&
>>                   map->kunmap_ops[offset + i].handle != INVALID_GRANT_HANDLE);
>>               pr_debug("kunmap handle=%u st=%d\n",
>> @@ -411,11 +417,15 @@ static void __unmap_grant_pages_done(int result,
>>               map->kunmap_ops[offset+i].handle = INVALID_GRANT_HANDLE;
>>           }
>>       }
>> +
>>       /*
>>        * Decrease the live-grant counter.  This must happen after the loop to
>>        * prevent premature reuse of the grants by gnttab_mmap().
>>        */
>> -    atomic_sub(data->count, &map->live_grants);
>> +    live_grants = atomic_sub_return(successful_unmaps, &map->live_grants);
>> +    if (WARN_ON(live_grants < 0))
>> +        pr_err("%s: live_grants became negative (%d) after unmapping %d pages!\n",
>> +               __func__, live_grants, successful_unmaps);
>>       /* Release reference taken by __unmap_grant_pages */
>>       gntdev_put_map(NULL, map);
>> @@ -424,6 +434,8 @@ static void __unmap_grant_pages_done(int result,
>>   static void __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
>>                      int pages)
>>   {
>> +    int idx;
>> +
>>       if (map->notify.flags & UNMAP_NOTIFY_CLEAR_BYTE) {
>>           int pgno = (map->notify.addr >> PAGE_SHIFT);
>> @@ -436,6 +448,16 @@ static void __unmap_grant_pages(struct gntdev_grant_map *map, int offset,
>>           }
>>       }
>> +    /* Set all unmap/kunmap status fields to an arbitrary positive value,
>> +     * so that it is possible to determine which grants were successfully
>> +     * unmapped by inspecting the status fields.
>> +     */
>> +    for (idx = offset; idx < offset + pages; idx++) {
>> +        map->unmap_ops[idx].status = 1;
>> +        if (use_ptemod)
>> +            map->kunmap_ops[idx].status = 1;
>> +    }
>> +
>>       map->unmap_data.unmap_ops = map->unmap_ops + offset;
>>       map->unmap_data.kunmap_ops = use_ptemod ? map->kunmap_ops + offset : NULL;
>>       map->unmap_data.pages = map->pages + offset;
> 
> Juergen
