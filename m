Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B77C6C5125
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbjCVQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjCVQrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:47:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C61637EE;
        Wed, 22 Mar 2023 09:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VQfC6WqHP5WXJW0gJKwhfRzMi6QjIB6591UcdGfmLSA=; b=SVZTD+OhIF84cg1RaHVxGlPIKw
        pLdTvsqcm5tXrqRrhlBKMxu0ynPvfPkCAXPiOMlAxAJZgyxgoIqDFqTrEtygrujiqzp/evl4LKCUv
        Yk7/+oIGzCDS2GJwTT7v+JtOoHp8pDPGJqBVLaDBXlu9nT2HCxVEZS2Ulp6d7PvazPOF1bLUOcIY5
        +Pp+C70bkARgrVO5IR4PnHWJfUHzW7I7mbjA+RkOjKJ5SY89SCEZ/cHYNGGuB0OTZ1sHAdUHRXB2S
        jow/+gmThtTHtmjA8K45BH5MshwnltnvbWNuIa0BbcmQXV2HO5yRTuk4aGgdzMWj+/5QIvgh44Va+
        i5fef7AA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pf1bq-003Ad1-LI; Wed, 22 Mar 2023 16:46:46 +0000
Date:   Wed, 22 Mar 2023 16:46:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        linux-mm@kvack.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] mm/slab: Fix undefined init_cache_node_node() for NUMA
 and !SMP
Message-ID: <ZBsw9lRbJU4c2wLD@casper.infradead.org>
References: <67261c513706241d479b8b4cf46eb4e6fb0417ba.1679387262.git.geert+renesas@glider.be>
 <ZBneELQuakjva1xa@casper.infradead.org>
 <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6320abf6-0898-361b-d5f6-bcc58306f55c@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 09:16:55AM -0700, Dave Hansen wrote:
> On 3/21/23 09:40, Matthew Wilcox wrote:
> > On Tue, Mar 21, 2023 at 09:30:59AM +0100, Geert Uytterhoeven wrote:
> >> -#if (defined(CONFIG_NUMA) && defined(CONFIG_MEMORY_HOTPLUG)) || defined(CONFIG_SMP)
> >> +#if defined(CONFIG_NUMA) || defined(CONFIG_SMP)
> > I'm amused by the thought of CONFIG_NUMA without CONFIG_SMP.
> > Is it possible to have one node with memory and a single CPU, then
> > another node with memory and no CPU?
> 
> It's _possible_ for sure, just unlikely.  The most likely place these
> days is probably a teensy tiny VM that just happens to have some
> performance-differentiated memory exposed to it for some reason.  Maybe
> it's got a slice of slow PMEM or fast High-Bandwidth memory for whatever
> reason.

Right, you can construct such a system, but do we support the CONFIG
options of NUMA enabled and SMP disabled?  It seems so niche that we
shouldn't be spending time testing that combination.
