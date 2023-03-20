Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701EC6C23AA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 22:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbjCTV3S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 17:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCTV3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 17:29:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2416A46;
        Mon, 20 Mar 2023 14:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7+GIdFmD772nNedNSRkfi5ehiQ4I311T7kzgXJ4QrMI=; b=sdd+uQCb3+gOEFA3jSVzOgU6wv
        r451TRpy2eQjyp394rh+54wTxOC6aLhl0S6J6sSsU0PCS5zhjDUxBFHfVcbdVv+Q623IBv174WKiO
        x3L592ne+u4C4CH9TRoCQh3s/cmaeNvMLM10N9jWD5LxoUWHeK5nRsEjlzJ2p6pThTdAHtie+oJYU
        DA0fdvptbbwpgow7G9Hhgs6kAUakCHhIhQJEuWyNon7uFu96TjLPKDkpw/rAiiScV7/QIb724sA96
        fGxw6LmJu/RXsb1b4qMtNbBsypPwzM7FvRnMnwAAANlki5VtvkX/ZYE59h6O5q5CIf9tBLtfOrRu+
        hqPqzFmA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1peN2D-00AXVD-1m;
        Mon, 20 Mar 2023 21:27:17 +0000
Date:   Mon, 20 Mar 2023 14:27:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Hildenbrand <david@redhat.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org,
        torvalds@linux-foundation.org
Subject: Re: [RFC 00/12] module: avoid userspace pressure on unwanted
 allocations
Message-ID: <ZBjPtV7xrAQ/l9nD@bombadil.infradead.org>
References: <ZBHuBgUQFbsd6l+J@bombadil.infradead.org>
 <f18ec4d3-be63-7e86-1951-f3d460acd7a7@redhat.com>
 <ZBOsc8dc0Mhvh/vv@bombadil.infradead.org>
 <ZBOsyBu68d4vh6yU@bombadil.infradead.org>
 <ZBUBsUx9++Ksl91w@bombadil.infradead.org>
 <c1375bdc-401b-308a-d931-80a95897dbc3@redhat.com>
 <2bd995a7-5b7f-59a1-751e-c56e76a7d592@redhat.com>
 <ZBjLp4YvN1m/cR4G@bombadil.infradead.org>
 <c0b2d9d0-ef5e-8c46-109e-742dbec8a07b@redhat.com>
 <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBjO2LqBkayxG+Sd@bombadil.infradead.org>
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

On Mon, Mar 20, 2023 at 02:23:36PM -0700, Luis Chamberlain wrote:
> On Mon, Mar 20, 2023 at 10:15:23PM +0100, David Hildenbrand wrote:
> > Not able to reproduce with 20230319-module-alloc-opts so far (2 tries).
> 
> Oh wow, so to clarify, it boots OK?
> 

Now that we know that tree works, I'm curious also now if you can
confirm just re-ordering the patches still works (it should)

https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/log/?h=20230319-module-alloc-opts-adjust

And although it's *probably* just noise, but I'm very curious how much,
if any difference there is if you just revert "module: use
list_add_tail_rcu() when adding module".

The data on that commit log is pretty small as I have a low end system,
and I'm not yet done beating the hell out of a system with stress-ng,
but getting some data froma  pretty large system would be great.
Specially if this series seems to prove fixing boot on them.

  Luis
