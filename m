Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5901071541D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjE3DHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 23:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjE3DHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 23:07:45 -0400
Received: from out-29.mta1.migadu.com (out-29.mta1.migadu.com [95.215.58.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A82489F
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 20:07:43 -0700 (PDT)
Message-ID: <26da75a6-115f-a17a-73bb-381a6b4a3a75@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685416060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hhVCqVUhvZRjlBrxLBQaFs82AfnvT+az3ouF0P0dHAo=;
        b=mlTKSDp327yaErwS5wPyUOFLhylZtOXgmCsi5D/Ahv65c8fdvz5AEvKl8wwzngX+XQyxB7
        3xb9bQMv30BmVUREfvhaXsc5w+Js7ZPspdMxeFle/O48tfkrlr7T8waiZphxSHAtfQN4C0
        /8vG5h5z2wHuFeuJA+FakXDh+Wquthg=
Date:   Tue, 30 May 2023 11:07:29 +0800
MIME-Version: 1.0
Subject: Re: [linus:master] [mm] f95bdb700b: stress-ng.ramfs.ops_per_sec
 -88.8% regression
Content-Language: en-US
To:     paulmck@kernel.org, Kirill Tkhai <tkhai@ya.ru>
Cc:     RCU <rcu@vger.kernel.org>, Yujie Liu <yujie.liu@intel.com>,
        oe-lkp@lists.linux.dev, lkp@intel.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Hildenbrand <david@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>, linux-mm@kvack.org,
        ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com
References: <202305230837.db2c233f-yujie.liu@intel.com>
 <eba38fce-2454-d7a4-10ef-240b4686f23d@linux.dev>
 <ZG29ULGNJdErnatI@yujie-X299>
 <896bbb09-d400-ec73-ba3a-b64c6e9bbe46@linux.dev>
 <e5fb8b34-c1ad-92e0-e7e5-f7ed1605dbc6@linux.dev>
 <bfb36563-fac9-4c84-96db-87dd28892088@linux.dev>
 <be04dc3e-a671-ec70-6cf6-70dc702f4184@linux.dev>
 <44407892-b7bc-4d6c-8e4a-6452f0ee88b9@paulmck-laptop>
 <d4b1599d-14c1-071c-6205-09fe60f2ed8b@linux.dev>
 <095806f1-f7f0-4914-b04b-c874fb25bb83@paulmck-laptop>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <095806f1-f7f0-4914-b04b-c874fb25bb83@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/29 20:51, Paul E. McKenney wrote:
> On Mon, May 29, 2023 at 10:39:21AM +0800, Qi Zheng wrote:

[...]

>>
>> Thanks for such a detailed explanation.
>>
>> Now I think we can continue to try to complete the idea[1] from
>> Kirill Tkhai. The patch moves heavy synchronize_srcu() to delayed
>> work, so it doesn't affect on user-visible unregistration speed.
>>
>> [1]. https://lore.kernel.org/lkml/153365636747.19074.12610817307548583381.stgit@localhost.localdomain/
> 
> A blast from the past!  ;-)
> 
> But yes, moving the long-latency synchronize_srcu() off the user-visible
> critical code path can be even better.

Yeah, I applied these patches  ([PATCH RFC 04/10]~[PATCH RFC 10/10],
with few conflicts), the ops/s does get back to the previous levels.

I'll continue updating this patchset after doing more testing.

Thanks,
Qi

> 
> 							Thanx, Paul
