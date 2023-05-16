Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2457055A0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 20:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232065AbjEPSFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 14:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjEPSFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 14:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D135B9A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 11:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684260305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y5EOypxgbZDRGvVwT5KvydBJmWedm0p4xvCj98nOYvY=;
        b=b88OzNZXTHp+y6uuB23Jr4W8x5jlYfQ2OO6+I4S40YqCVxG5aQGYU5LiR6Cmw7FSVfKpXU
        0JWiMRvNyGbnepTx5PqRsxFVcXzsx87wovUC9WXHzK7wPIlD8WG5t9lmL9P9/ARg64991X
        +RPdRbqvEjz/RlSjYLUuf7LuS1o8NQI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-C0cacgM5PRuPUxecaQIZTw-1; Tue, 16 May 2023 14:05:02 -0400
X-MC-Unique: C0cacgM5PRuPUxecaQIZTw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 080E3101A557;
        Tue, 16 May 2023 18:05:01 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B1C435453;
        Tue, 16 May 2023 18:05:00 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 53BA84013A22A; Tue, 16 May 2023 15:02:21 -0300 (-03)
Date:   Tue, 16 May 2023 15:02:21 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Christoph Lameter <cl@gentwo.de>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Russell King <linux@armlinux.org.uk>,
        Huacai Chen <chenhuacai@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, x86@kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v8 00/13] fold per-CPU vmstats remotely
Message-ID: <ZGPFLSa8Xt23oMSo@tpad>
References: <20230515180015.016409657@redhat.com>
 <b1f75dca-5d86-125f-bbba-7b575b62d21@gentwo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f75dca-5d86-125f-bbba-7b575b62d21@gentwo.de>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Tue, May 16, 2023 at 10:09:02AM +0200, Christoph Lameter wrote:
> The patchset still modifies the semantics of this_cpu operations semantics
> replacing the lockless RMV operations with locked ones. 

It does that to follow the pre-existing kernel convention:

function-name			LOCK prefix
cmpxchg				YES
cmpxchg_local			NO

So the patchset introduces:

function-name			LOCK prefix
this_cpu_cmpxchg		YES
this_cpu_cmpxchg_local		NO

> One of the
> rationales for the use  this_cpu operations is their efficiency since
> locked RMV atomics are avoided. 

And there is the freedom to choose between this_cpu_cmpxchg and
this_cpu_cmpxchg_local (depending on intended usage).

> This patchset destroys that functionality.

Patch 6 is

Subject: [PATCH v8 06/13] add this_cpu_cmpxchg_local and asm-generic definitions

Which adds this_cpu_cmpxchg_local

Patch 7 converts all other this_cmpxchg users
(except the vmstat ones)

[PATCH v8 07/13] convert this_cpu_cmpxchg users to this_cpu_cmpxchg_local

So the non-LOCK'ed behaviour is maintained for existing users.

> If you want locked RMV semantics then use them through cmpxchg() and
> friends. Do not modify this_cpu operations by changing the implementation
> in the arch code.

But then it would be necessary to disable preemption here:

static inline void mod_zone_state(struct zone *zone, enum zone_stat_item item,
                                  long delta, int overstep_mode)
{
        struct per_cpu_zonestat __percpu *pcp = zone->per_cpu_zonestats;
        s32 __percpu *p = pcp->vm_stat_diff + item;
        long o, n, t, z;

        do {
                z = 0;  /* overflow to zone counters */

                /*
                 * The fetching of the stat_threshold is racy. We may apply
                 * a counter threshold to the wrong the cpu if we get
                 * rescheduled while executing here. However, the next
                 * counter update will apply the threshold again and
                 * therefore bring the counter under the threshold again.
                 *
                 * Most of the time the thresholds are the same anyways
                 * for all cpus in a zone.
                 */
                t = this_cpu_read(pcp->stat_threshold);

                o = this_cpu_read(*p);
                n = delta + o;

                if (abs(n) > t) {
                        int os = overstep_mode * (t >> 1);

                        /* Overflow must be added to zone counters */
                        z = n + os;
                        n = -os;
                }
        } while (this_cpu_cmpxchg(*p, o, n) != o);
		 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

        if (z)
                zone_page_state_add(z, zone, item);
}

Earlier you objected to disabling preemption on this codepath
(which is what led to this patchset in the first place):

"Using preemption is a way to make this work correctly. However, 
doing so would sacrifice the performance, low impact and the
scalability of the vm counters."

So it seems a locked, this_cpu function which does lock cmxpchg
is desired.

Perhaps you disagree with the this_cpu_cmpxchg_local/this_cpu_cmpxchg
naming?

