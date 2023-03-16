Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB9C6BDD3D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:57:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjCPX5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPX45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:56:57 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4303E2747;
        Thu, 16 Mar 2023 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=32FKTXbYQ8r+yPB7drjz07EGlswDQyUktTskL54MxVQ=; b=Cx1kOSvEAH4Exgvlm+Z9DpnM+N
        5fc72SPkhOqWLxDuiiulDj1j67c9X2zb8+HDsXu8aEpuh6QBEYtp3gmn1pIzoVsECxFDrz+O6CsnM
        448PstZh1OqARUUr5CBZnXuw3mT9JqMmdVEnamoDwZ0/nEBhHL+AkeWSscEmZNzXNUrLQji6vPqlp
        EX829ybSAi9MNv+flvrpCPr9VMbqM/m0Dd6MwrkTS20hLxy3UjM5xdrD44B+N48M1ygF94CJ9R+QA
        kZFE/VG4M/PTpbcjuZI6MBVI2MXOXoscNhVvOfmXeyBm7PaL7ZwwRaugfwr6VpY4TNb7aQqOJpL1P
        D6tdEo6Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pcxSq-000NHM-0b;
        Thu, 16 Mar 2023 23:56:56 +0000
Date:   Thu, 16 Mar 2023 16:56:56 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
References: <20230311051712.4095040-1-mcgrof@kernel.org>
 <3b25ed5c-8fb9-82d3-2296-fadbbb4db7e4@redhat.com>
 <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
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

On Thu, Mar 16, 2023 at 04:55:31PM -0700, Luis Chamberlain wrote:
> On Wed, Mar 15, 2023 at 05:41:53PM +0100, David Hildenbrand wrote:
> > I expect to have a machine (with a crazy number of CPUs/devices) available
> > in a couple of days (1-2), so no need to rush.
> > 
> > The original machine I was able to reproduce with is blocked for a little
> > bit longer; so I hope the alternative I looked up will similarly trigger the
> > issue easily.
> 
> OK give this a spin:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230316-module-alloc-opts
> 
> I'm seeing about ~86 MiB saving on the upper bound on memory usage
> while hammering on kmod test 0008, and this is on a small system.
> 
> Probably won't help *that* much but am curious... if it helps somewhat.

How much cpu count BTW?

  Luis
