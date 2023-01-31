Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6914682082
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 01:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjAaAS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 19:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjAaASV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 19:18:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E0193E8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 16:18:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DA0FA6131D
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 00:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD241C433D2;
        Tue, 31 Jan 2023 00:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1675124298;
        bh=D6HuYaK6uFnV+17yJgYm6A0P1hNUhkEhRQI956sTQig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KKWH2oafy4OGC2F1B+a5QAZv1h157wMz1o9xpDNbQex3QUGmmkgkuSZnnqB1OYSCU
         tx0ssl1nlNZsjAgeike36lhd5q+3fr2gPqHsnTCDwghWY+Fa5fvMrWmHLGUEc6YJJT
         Dqy7GUFTPvN7SkaLrs5pMPEsvl8rwv/UQ6FVZPk4=
Date:   Mon, 30 Jan 2023 16:18:17 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     andrey.konovalov@linux.dev
Cc:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 01/18] lib/stackdepot: fix setting next_slab_inited in
 init_stack_slab
Message-Id: <20230130161817.a13365bca60543e34da27f48@linux-foundation.org>
In-Reply-To: <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
References: <cover.1675111415.git.andreyknvl@google.com>
        <9fbb4d2bf9b2676a29b120980b5ffbda8e2304ee.1675111415.git.andreyknvl@google.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 21:49:25 +0100 andrey.konovalov@linux.dev wrote:

> In commit 305e519ce48e ("lib/stackdepot.c: fix global out-of-bounds in
> stack_slabs"), init_stack_slab was changed to only use preallocated
> memory for the next slab if the slab number limit is not reached.
> However, setting next_slab_inited was not moved together with updating
> stack_slabs.
> 
> Set next_slab_inited only if the preallocated memory was used for the
> next slab.

Please provide a full description of the user-visible runtime effects
of the bug (always always).

I'll add the cc:stable (per your comments in the [0/N] cover letter),
but it's more reliable to add it to the changelog yourself.

As to when I upstream this: don't know - that depends on the
user-visible-effects thing.

