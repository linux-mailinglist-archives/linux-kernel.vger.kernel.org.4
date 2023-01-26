Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5B67CF57
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjAZPKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjAZPKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:10:23 -0500
Received: from outbound-smtp18.blacknight.com (outbound-smtp18.blacknight.com [46.22.139.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F69E173F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:10:21 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp18.blacknight.com (Postfix) with ESMTPS id 816071C3F8F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:10:19 +0000 (GMT)
Received: (qmail 15379 invoked from network); 26 Jan 2023 15:10:19 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 15:10:18 -0000
Date:   Thu, 26 Jan 2023 15:10:15 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, michel@lespinasse.org,
        jglisse@google.com, mhocko@suse.com, vbabka@suse.cz,
        hannes@cmpxchg.org, dave@stgolabs.net, willy@infradead.org,
        liam.howlett@oracle.com, peterz@infradead.org,
        ldufour@linux.ibm.com, paulmck@kernel.org, mingo@redhat.com,
        will@kernel.org, luto@kernel.org, songliubraving@fb.com,
        peterx@redhat.com, david@redhat.com, dhowells@redhat.com,
        hughd@google.com, bigeasy@linutronix.de, kent.overstreet@linux.dev,
        punit.agrawal@bytedance.com, lstoakes@gmail.com,
        peterjung1337@gmail.com, rientjes@google.com,
        axelrasmussen@google.com, joelaf@google.com, minchan@google.com,
        jannh@google.com, shakeelb@google.com, tatashin@google.com,
        edumazet@google.com, gthelen@google.com, gurua@google.com,
        arjunroy@google.com, soheil@google.com, hughlynch@google.com,
        leewalsh@google.com, posk@google.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v3 4/7] mm: replace vma->vm_flags direct modifications
 with modifier calls
Message-ID: <20230126151015.ru2m26jkhwib6x6u@techsingularity.net>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-5-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230125233554.153109-5-surenb@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:35:51PM -0800, Suren Baghdasaryan wrote:
> Replace direct modifications to vma->vm_flags with calls to modifier
> functions to be able to track flag changes and to keep vma locking
> correctness.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

Minor comments that are safe to ignore.

I think a better name for mod_vm_flags is set_clear_vm_flags to hint that
the first flags are to be set and the second flags are to be cleared.
For this patch, it doesn't matter, but it might avoid accidental swapping
in the future.

reset_vm_flags might also be better named as reinit_vma_flags (or
vma_flags_reinit). Maybe also encourage the use of [set|clear_mod]_vm_flags
where possible in the comment to track exactly what is changing and
why. Some cases like userfaultfd just want to clear __VM_UFFD_FLAGS but
altering the flow in this patch is inappropriate and error prone. Others
such as the infiniband changes and madvise are a lot more complex.

-- 
Mel Gorman
SUSE Labs
