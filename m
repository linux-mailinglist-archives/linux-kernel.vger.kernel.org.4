Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC76BDD39
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCPXzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjCPXzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:55:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075C5E1905;
        Thu, 16 Mar 2023 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=o4VKGHtMLIsNcRq2nh4u13n34vSOYL+N0AYU3Pn2Mu0=; b=OE7Yv31bvLSGuHkbYiRalX5rVv
        3qyZHSL2Zh7TTr+1wwpDESE9EPIGKhUZxXnBRhmFqghJ+XuEQI+iQnc6rBiECjehQzpdbnxLYMAf4
        YUiIms2Kpl9n5938TgTxBFJhZFpgr0oJH8rp7B43gTVhRM2VG+u/8VFBI+SdqAl8BrOVyp/jkzIy7
        X7vOZK/O6utx+z+1NNNeWxe9df5INGITWsGqT3D3kqvMww5OAIRgJtXGSdAaWie1t0Or56aVdd8xQ
        rSFjFBGf5hNHj8E91OyorD5W7q8HzjrQPE3VW4tryJtTcYoaBCaGgatYzDSE7BKLnqQ1vzp5rQbaH
        Az0WBvVw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcxRT-000N6o-1A;
        Thu, 16 Mar 2023 23:55:31 +0000
Date:   Thu, 16 Mar 2023 16:55:31 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
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

On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
> On 15.03.23 17:10, Luis Chamberlain wrote:
> > On Wed, Mar 15, 2023 at 01:24:41PM +0100, David Hildenbrand wrote:
> > > On 11.03.23 06:17, Luis Chamberlain wrote:
> > > > A long time ago we had some issues with userspace doing stupid stuff.
> > > > Well, it turns out even the kernel and do stupid stuff too, as we're
> > > > learning with the ACPI modules aliaes and that hammering tons of loads.
> > > > 
> > > > So add a bit of code which gets us a bit more in the defensive about
> > > > these situations.
> > > > 
> > > > To experiment, this also adds in-kernel alias support to see if this helps
> > > > with some larger systems.
> > > > 
> > > > This is all based on some old code which tried to add defensive
> > > > mechanisms the last of which was here and I had dropped the ball:
> > > > 
> > > > https://lore.kernel.org/all/20171208001540.23696-1-mcgrof@kernel.org/
> > > > 
> > > > I've only compile tested this for now. Will need to stress to test
> > > > with kmod tests 0008 and 0009 to see if there's any differences.
> > > > I'll have to re-test and re-gnuplot stuff there. But early feedback
> > > > is appreciated, hence the RFC.
> > > > 
> > > > David Hildenbrand had reported a while ago issues with userspace
> > > > doing insane things with allocations bringing a system down to
> > > > its knees. This is part of the motivation for this series.
> > > 
> > > 
> > > I'll try to grab a system where I can reproduce the issue and give your
> > > patches a churn.
> > 
> > Great, then please wait for v2 RFC as the first patch was missing an
> > obvious mutex grab / release, I already have some memory pressure data
> > that shows gains. Hope to post soon.
> 
> I expect to have a machine (with a crazy number of CPUs/devices) available
> in a couple of days (1-2), so no need to rush.
> 
> The original machine I was able to reproduce with is blocked for a little
> bit longer; so I hope the alternative I looked up will similarly trigger the
> issue easily.

OK give this a spin:

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts

I'm seeing about ~86 MiB saving on the upper bound on memory usage
while hammering on kmod test 0008, and this is on a small system.

Probably won't help *that* much but am curious... if it helps somewhat.

  Luis
