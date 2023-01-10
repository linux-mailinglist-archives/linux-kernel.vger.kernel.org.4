Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39FA4664FF1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbjAJX0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjAJXZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:25:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94894E40D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:25:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 73D89B81A07
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:25:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 042C4C433EF;
        Tue, 10 Jan 2023 23:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673393133;
        bh=WgtCtfLuwYiDuoh7TNoyHB+vCe9fN558duUfvgaF3Yw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bu3OT7DS7oq2rnBxcbUKoOC7omsp7pl+aG21lq0ziECOw04lojlobWm/+cBcgNXqy
         eYyGjWKgqDAWNJ9LY41S4ThzRfeqv3FrPE5wnoPr/tV4tEModvmDvhX4OYb4MzvRBZ
         L377iHH3WLd4VjIWaatP8eGI9QYvgN+rJ54Kn5NM=
Date:   Tue, 10 Jan 2023 15:25:32 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] mm: compaction: Remove redundant VM_BUG_ON() in
 compact_zone()
Message-Id: <20230110152532.8b2d34bf04d7b8e9a4e39130@linux-foundation.org>
In-Reply-To: <Y71qNeLNeiBB5a/+@casper.infradead.org>
References: <cover.1673342761.git.baolin.wang@linux.alibaba.com>
        <740a2396d9b98154dba76e326cba5e798b640ead.1673342761.git.baolin.wang@linux.alibaba.com>
        <Y71qNeLNeiBB5a/+@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
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

On Tue, 10 Jan 2023 13:37:57 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Tue, Jan 10, 2023 at 09:36:18PM +0800, Baolin Wang wrote:
> > The compaction_suitable() will never return values other than COMPACT_SUCCESS,
> > COMPACT_SKIPPED and COMPACT_CONTINUE, so after validation of COMPACT_SUCCESS
> > and COMPACT_SKIPPED, we will never hit other unexpected case. Thus remove
> > the redundant VM_BUG_ON() validation for the return values of compaction_suitable().
> 
> I don't understand why we'd remove this check.

Well, just from code inspection it serves no purpose.

Such an assertion might be useful during early code development, but I
think we can consider compaction_suitable() to adequately debugged by
now?
