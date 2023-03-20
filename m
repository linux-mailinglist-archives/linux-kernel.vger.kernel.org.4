Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7851A6C2366
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229749AbjCTVKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjCTVKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:10:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52133244B3;
        Mon, 20 Mar 2023 14:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H/qOpxJSYYttiL8kdGhH8cAfmJXj4r9p9pVbZ3fMPyw=; b=yBdj960yO9hqnQH43eEV6LOrfG
        aQothLPxQu4PfAr5UVKfrYVUYrWtR91Ez/O7CqlI3WXSBz2ZsizhhL7jotrK05CT/l6Uiogf4vX6v
        H8mcYVvJ9IQxOGEXnTSE4+AhGq/VpdEWyAsy5sQuTDqdJMN51gtWU3tG0tdUxqqTUTbc0VPPnzmLC
        M7S1YYDrWeksTtLgeH9Xys8xMNaAw6Bnlk5Ho+h/A2MAquWwok9RUy4YhU77CwRM+ljX3ZSrdOpp0
        nss1WOUymVxcgS/2Rb9JHL9RwSwoQJEDzwWhsfXRJBgWcpV3AwdSyJhjbKwXQ2dTwNF7c6104rge+
        w2QdPYbA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peMlT-00AVE1-25;
        Mon, 20 Mar 2023 21:09:59 +0000
Date:   Mon, 20 Mar 2023 14:09:59 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 08:40:07PM +0100, David Hildenbrand wrote:
> On 20.03.23 10:38, David Hildenbrand wrote:
> > On 18.03.23 01:11, Luis Chamberlain wrote:
> > > On Thu, Mar 16, 2023 at 04:56:56PM -0700, Luis Chamberlain wrote:
> > > > On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
> > > > > On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
> > > > > > I expect to have a machine (with a crazy number of CPUs/devices) available
> > > > > > in a couple of days (1-2), so no need to rush.
> > > > > > 
> > > > > > The original machine I was able to reproduce with is blocked for a little
> > > > > > bit longer; so I hope the alternative I looked up will similarly trigger the
> > > > > > issue easily.
> > > > > 
> > > > > OK give this a spin:
> > > > > 
> > > > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
> > > 
> > > Today I am up to here:
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230317-module-alloc-opts
> > > 
> > > The last patch really would have no justification yet at all unless it
> > > does help your case.
> > 
> > Still waiting on the system (the replacement system I was able to grab
> > broke ...).
> > 
> > I'll let you know once I succeeded in reproducing + testing your fixes.
> 
> Okay, I have a system where I can reproduce.
> 
> Should I give
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts
> 
> from yesterday a churn?

Yes please give that a run.

Please collect systemd-analyze given lack of any other tool to evaluate
any deltas. Can't think of anything else to gather other than seeing if
it booted.

If that boots works then try removing the last patch "module: add a
sanity check prior to allowing kernel module auto-loading" to see if
that last patch helped or was just noise. As it stands I'm not convinced
yet if it did help, if it *does* help we probably need to rethink some
finit_module() allocations things.

If you *still* can't boot the system, well, we should re-think
finit_module() allocation path a bit more too.

  Luis
