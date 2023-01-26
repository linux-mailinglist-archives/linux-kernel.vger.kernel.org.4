Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD8A67C9DF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbjAZL3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:29:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237038AbjAZL3X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:29:23 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12B25C0C9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 03:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1674732529; bh=MjeJA3NTnp7VBIpasqh8v6gjDuTw3unVXYc5oF/te00=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=hTW/HzhEHDw08AypQ8JO9SLQYHba1iZboqg7mongU/LCdGcy0LIkDnwxRwdy88v5U
         AmZAYk5TgR1OzOJg3RZVHwZkhgctKYX6DXKBJJpJpCANkqDnUIa3xl1Ew61e38Gutx
         sbJo2/hEv5HKK3xPURdyQ26pqKLpKFJsQvfcw+8o166pz3utFATNO5GSdOxt6bzUMe
         j4XnwUVjjsnigx1yIiH7xer/waHNiSXAfj3nBHLOTFBpqgPN9DYLyL/M6hdYq1DHch
         +Y64B9NTk8zLbPf93dc25uqzGQYObUlC8jGWecVfp6f1bh97w2GM43Z8rUoyLvAVLG
         0Vh3uLv4I1bCA==
Received: by gentwo.de (Postfix, from userid 1001)
        id 1165AB0028E; Thu, 26 Jan 2023 12:28:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 0E4FDB00137;
        Thu, 26 Jan 2023 12:28:49 +0100 (CET)
Date:   Thu, 26 Jan 2023 12:28:49 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     George Prekas <george@enfabrica.net>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 7/9] mm: kmemleak: erase page->s_mem in slab_destroy
In-Reply-To: <20230123170419.7292-8-george@enfabrica.net>
Message-ID: <73309bf-ca5b-b0ba-8ac-4be7dcc278b7@gentwo.de>
References: <20230123170419.7292-1-george@enfabrica.net> <20230123170419.7292-8-george@enfabrica.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023, George Prekas wrote:

> The field s_mem of struct page is initialized with the virtual address
> of the page in function alloc_slabmgmt. If kmalloc allocates an object
> that starts on this page, then kmemleak knows that this object has 2
> references. On slab_destroy, s_mem should not continue referring to any
> allocated object in the future.

Nope.

s_mem is a pointer to an array of objects. It is not a pointer to a page.

If a slab-caches is used for slabmanagement then these objects
contain slab metadata which may be a bit confusing.

