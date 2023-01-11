Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D84826665DB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjAKVwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:52:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbjAKVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:51:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07298FCE4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:51:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1696B81D7B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 21:51:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3698DC433F0;
        Wed, 11 Jan 2023 21:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673473905;
        bh=+OfZtfTdE74E7blmuwAGQ+f3T0X1sTkTFqYAYP7v5i4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SrwvmvHrm0EBhfIXjoDykaRMSRRF/SysDM/qJ42+ux+XFHp6m0aPPdTV8D1wMpTOM
         K6Ah/sNM4guX1bQasSao3FG/a296nhmzj/bvXYbIP/sSB+Cs47USLhclRQLF3Wm3pX
         dJBYHn+cl+nu526OqClft4oTu4C9dQb2nCzB0pmg=
Date:   Wed, 11 Jan 2023 13:51:44 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in
 compact_zone()
Message-Id: <20230111135144.5be220426ef4c0cae0a3429d@linux-foundation.org>
In-Reply-To: <3c7c722d-e8d0-f52b-e0ea-7994bd6b55bb@linux.alibaba.com>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
        <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
        <Y71qNeLNeiBB5a/+@casper.infradead.org>
        <20230110152532.8b2d34bf04d7b8e9a4e39130@linux-foundation.org>
        <Y732taMH+r/QGcgD@casper.infradead.org>
        <3c7c722d-e8d0-f52b-e0ea-7994bd6b55bb@linux.alibaba.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 14:40:20 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> 
> 
> On 1/11/2023 7:37 AM, Matthew Wilcox wrote:
> > On Tue, Jan 10, 2023 at 03:25:32PM -0800, Andrew Morton wrote:
> >> On Tue, 10 Jan 2023 13:37:57 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> >>
> >>> On Tue, Jan 10, 2023 at 09:36:18PM +0800, Baolin Wang wrote:
> >>>> The compaction_suitable() will never return values other than COMPACT_SUCCESS,
> >>>> COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
> >>>> and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
> >>>> the redundant VM_BUG_ON() validation for the return values of compaction_suitable().
> >>>
> >>> I don't understand why we'd remove this check.
> >>
> >> Well, just from code inspection it serves no purpose.
> >>
> >> Such an assertion might be useful during early code development, but I
> >> think we can consider compaction_suitable() to adequately debugged by
> >> now?
> > 
> > What if compaction_suitable() is modified to return another value?
> 
> Then this will be an expected value which should be handled by caller, 
> and IMO we can not make such assumption for future to keep this 
> unhelpful check.

One way of looking at this: if the assertion wasn't there and someone
sent a patch which added it, would we merge the patch?

"[patch] add check for compaction_suitable() return value"

"why"

"it might be wrong"

"it isn't"

"but we might make it wrong later"

"the same can be said of every function in the kernel"


And if we wouldn't merge a hypothetical patch which adds some code, we
shouldn't retain that code, no?

