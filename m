Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD70637508
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 10:21:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiKXJVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Nov 2022 04:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbiKXJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Nov 2022 04:21:11 -0500
Received: from gentwo.de (gentwo.de [161.97.139.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9617211DA09
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 01:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.de; s=default;
        t=1669281665; bh=LYzb4SqFx0WhZ1vRL+bXoXsF0BRQn8llM6x37bry8nM=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=cp4mwkQulfGXBYU6K3n9nUTp69ODHRPLVKxXn/eRTtc5LbvaOVx4G5ydKNHmbe4ia
         KGiztbpS56FH5jpPwvtrPABSTdUxDlqqyzropimq6DMewVLivMHL3JOy0BgLyGj+am
         6d0OfiQWISFuvxSuV0N50HUqEGP1pzKPvPV+EYJcLC94/FJRdwVE+gCBJRIS6BThpa
         p93D7GsEkdh+qubt0OXekVnG+O43ngg7VqnB+wDCuwOVaeTjBTXDh6o2kC+bAj9m9K
         7v1bw3O68WH319loxKBNnO1BQQso/UR//thUs9HV+0pEJdv0osoQBiri+wSPkeJWz7
         gPiawhTImP1hQ==
Received: by gentwo.de (Postfix, from userid 1001)
        id 4BC2DB002AF; Thu, 24 Nov 2022 10:21:05 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.de (Postfix) with ESMTP id 472DDB00068;
        Thu, 24 Nov 2022 10:21:05 +0100 (CET)
Date:   Thu, 24 Nov 2022 10:21:05 +0100 (CET)
From:   Christoph Lameter <cl@gentwo.de>
To:     Vlastimil Babka <vbabka@suse.cz>
cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, patches@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/12] mm, slab: ignore SLAB_RECLAIM_ACCOUNT with
 CONFIG_SLUB_TINY
In-Reply-To: <23028c8a-7e53-6993-e076-6df8a6939313@suse.cz>
Message-ID: <79c1a3a1-f36e-3585-f470-6779f97e2dbd@gentwo.de>
References: <20221121171202.22080-1-vbabka@suse.cz> <20221121171202.22080-8-vbabka@suse.cz> <Y37GxICuaRbwK+tj@P9FQF9L96D.corp.robot.car> <23028c8a-7e53-6993-e076-6df8a6939313@suse.cz>
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

On Thu, 24 Nov 2022, Vlastimil Babka wrote:

> SLAB_RECLAIM_ACCOUNT is kinda misnomer these days, as the only thing it does
> is to add __GFP_RECLAIMABLE to cache's gfp flags for the page allocator's
> mobility grouping. I guess the "ACCOUNT" part comes from being counted
> towards SReclaimable (vs SUnreclaim) in /proc/meminfo.

Well these Sreclaimable etc counters visible in /proc/meminfo are used in
the reclaim logic and are quite important there.

