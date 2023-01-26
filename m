Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C248A67D095
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbjAZPrs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjAZPrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:47:47 -0500
Received: from outbound-smtp35.blacknight.com (outbound-smtp35.blacknight.com [46.22.139.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686E449D
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:47:46 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id B26781F95
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 15:47:44 +0000 (GMT)
Received: (qmail 28996 invoked from network); 26 Jan 2023 15:47:44 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 26 Jan 2023 15:47:44 -0000
Date:   Thu, 26 Jan 2023 15:47:40 +0000
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
Subject: Re: [PATCH v3 6/7] mm: introduce mod_vm_flags_nolock and use it in
 untrack_pfn
Message-ID: <20230126154740.j3a3lu4x557c56yi@techsingularity.net>
References: <20230125233554.153109-1-surenb@google.com>
 <20230125233554.153109-7-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230125233554.153109-7-surenb@google.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 03:35:53PM -0800, Suren Baghdasaryan wrote:
> In cases when VMA flags are modified after VMA was isolated and mmap_lock
> was downgraded, flags modifications would result in an assertion because
> mmap write lock is not held.

Add note that it's also used during exit when the locking of the VMAs
becomes irrelevant (mm users is 0, should be no VMA modifications taking
place other than zap).

The typical naming pattern when a caller either knows it holds the necessary
lock or knows it does not matter is __mod_vm_flags()

> Introduce mod_vm_flags_nolock to be used in such situation, when VMA is
> not part of VMA tree and locking it is not required.

Instead of such situations, describe in as "used when the caller takes
responsibility for the required locking".

> Pass a hint to untrack_pfn to conditionally use mod_vm_flags_nolock for
> flags modification and to avoid assertion.
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Patch itself looks ok. It strays close to being "conditional locking"
though which might attract some complaints.

-- 
Mel Gorman
SUSE Labs
