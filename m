Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03721705951
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 23:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbjEPVMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 17:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEPVMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 17:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D595F5BAB
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:12:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 732AD63D3D
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 21:12:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B744C433EF;
        Tue, 16 May 2023 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1684271566;
        bh=eFhJ5E/uyPdBbrpIyoaIwOP1sjzJ+IF88TEW3wCH5Dk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vh5YLJ8WBQ/6v9t45z6wl0Mu2wiNfyM5sOAw3yBJFzd19PoMsMRS+FdbWpusC5gOL
         XQAK4mofTchsm0wMyfl7MMGBhSkChZ3MlFSWVAPklW11B3C8Xq1tRt7N/FPGc7dOr2
         S18JfVhf6NmaVH+xw8LoVw1LQUjoFYGPW5lgM+qY=
Date:   Tue, 16 May 2023 14:12:45 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v5 0/3] page_owner: print stacks and their counter
Message-Id: <20230516141245.356200756ff3750ef4f12094@linux-foundation.org>
In-Reply-To: <20230516182537.3139-1-osalvador@suse.de>
References: <20230516182537.3139-1-osalvador@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 May 2023 20:25:34 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> 
> ...
>
> page_owner is a great debug functionality tool that gets us to know
> about all pages that have been allocated/freed and their stacktrace.
> This comes very handy when e.g: debugging leaks, as with some scripting
> we might be able to see those stacktraces that are allocating pages
> but not freeing theme.
> 
> ...
> 
>  include/linux/stackdepot.h |   8 +++
>  lib/stackdepot.c           | 128 ++++++++++++++++++++++++++++++++++---
>  mm/page_owner.c            |  54 ++++++++++++++++
>  3 files changed, 180 insertions(+), 10 deletions(-)

Documentation/mm/page_owner.rst is feeling very sad.

I'll toss it in there for some testing for now.  The changelogs would
benefit from a bit of proofreading, please - quite a few typos and
grammaros.
