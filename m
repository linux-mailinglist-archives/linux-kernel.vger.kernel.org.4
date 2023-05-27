Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49087132DC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 09:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbjE0HE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 03:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0HEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 03:04:53 -0400
Received: from out-16.mta1.migadu.com (out-16.mta1.migadu.com [95.215.58.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12505EB
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 00:04:51 -0700 (PDT)
Date:   Sat, 27 May 2023 03:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1685171090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iou0GTPq4Ljp/eKRqegKeRywXowmKecKWFtCM8AzuyE=;
        b=vaqBn89cvOB6cMJpgVHg8c9LyrFKdkyl6wiaHAmBzmvw/5hJ3K7b2CFzuKlroi18Gt2y87
        9A5XRCQIl6o2dJEOPbDlTOqFs3MkIgYM/WKORNr10fKe9m7Inp7yE3R8RsDuDj518bJBPj
        ymlbbkFW7ZnF6yfDkkv8vgKc5h9Z7SQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     Song Liu <song@kernel.org>
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        mcgrof@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        x86@kernel.org, rppt@kernel.org
Subject: Re: [PATCH 0/3] Type aware module allocator
Message-ID: <ZHGrjJ8PqAGN9OZK@moria.home.lan>
References: <20230526051529.3387103-1-song@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526051529.3387103-1-song@kernel.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 10:15:26PM -0700, Song Liu wrote:
> This set implements the second part of module type aware allocator
> (module_alloc_type), which was discussed in [1]. This part contains the
> interface of the new allocator, as well as changes in x86 code to use the
> new allocator (modules, BPF, ftrace, kprobe).
> 
> The set does not contain a binpack allocator to enable sharing huge pages
> among different allocations. But this set defines the interface used by
> the binpack allocator. [2] has some discussion on different options of the
> binpack allocator.

I'm afraid the more I look at this patchset the more it appears to be
complete nonsense.

The exposed interface appears to be both for specifying architecture
dependent options (which should be hidden inside the allocator
internals!) _and_ a general purpose interface for module/bpf/kprobes -
but it's not very clear, and the rational appears to be completely
missing.

I think this needs to back to the drawing board and we need something
simpler just targeted at executable memory; architecture specific
options should definitely _not_ be part of the exposed interface.

The memory protection interface also needs to go, we've got a better
interface to model after (text_poke(), although that code needs work
too!). And the instruction fill features need a thorough justification
if they're to be included.
