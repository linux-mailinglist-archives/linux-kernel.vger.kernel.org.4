Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 858A772A5AA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 23:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbjFIVzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 17:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232643AbjFIVzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 17:55:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF283A95
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 14:55:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 238EB63ECC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 21:55:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188C0C433EF;
        Fri,  9 Jun 2023 21:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1686347706;
        bh=xBEn2YpovwsA2cUhcZdWW5mSGnDboc9RS0DFVKUKbVU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MMTTUELearoUJM5wv5+0Q0Qm5p+/CBLDe3v23EY4ysUMMRcbUIGHctKQADm0Lecfj
         G0QsIHWPfCT9dHhcSFQM2KFtBvp93bhNHNmdMjhpcqyoTfIeJrMQ+FXUTLaEys5BBx
         8Kcqa59yhXVblMMPQmPPqDWWScTDeUcUPkkVFEBA=
Date:   Fri, 9 Jun 2023 14:55:05 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Eric Dumazet <edumazet@google.com>,
        Waiman Long <longman@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>
Subject: Re: [PATCH v4 0/3] page_owner: print stacks and their counter
Message-Id: <20230609145505.dc30b7712779d990aba64372@linux-foundation.org>
In-Reply-To: <7718244879ff2b696ea9cbb744cb3805@suse.de>
References: <20230421101415.5734-1-osalvador@suse.de>
        <CAG_fn=UzFaHrM2X0_X=9aRPe5Wcmzj_snAbY=GJCj8__h9PxCg@mail.gmail.com>
        <7718244879ff2b696ea9cbb744cb3805@suse.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Apr 2023 05:54:59 +0200 Oscar Salvador <osalvador@suse.de> wrote:

> > Given that no other stackdepot user needs these counters, maybe it
> > should be cleaner to store an opaque struct along with the stack,
> > passing its size to stack_depot_save(), and letting users access it
> > directly using the stackdepot handler.
> > 
> > I am also wondering if a separate hashtable mapping handlers to
> > counters would solve the problem for you?
> 
> Let us see first if with the changes from above the code gets to a more
> generic and clean stage, if not we can explore further options.

Alexander, does this approach sound reasonable to you?

The overall feature seems useful, although I'm not seeing any positive
reviewer feedback.
