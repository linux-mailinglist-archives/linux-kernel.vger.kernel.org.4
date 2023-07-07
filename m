Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891CE74B5C7
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 19:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGGR1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 13:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjGGR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:26:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81122683
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=YqH26Sn9y0zL/3WdNc/PCnXRHUQbKzei+dfuzKT49X0=; b=pYhqnPGolHUm+dexf585s0+35y
        WC6NfA9y9NOhvYaBagQyB91AWjyiBR2KrZwk1nsxaL0gfBUaMCeO8BAvyUWdGZ5a6iyvBElB4+6Q4
        uRhGpoCfD7ue7S9jY0piRKwvQAT0U7uf7XhQGHTtYSMxe4NymlBKHr7LomxsArLruGFu7RFKOPhli
        wyMvYm6KnaHA9ALKyIGTi4/SoVk22H4PvfbiigUb4YTiNNHaGCAQgL1e3qa17lipVVDcg0v1kJNO1
        1T1trOJyMghG39/zLgy4Gx6HJzvcDUMON6epSLDpQdRkRuNjAERLynuAMe8docVVENAXGN6EKWJq3
        PzhAZyEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qHpEC-00CDQu-Pn; Fri, 07 Jul 2023 17:26:44 +0000
Date:   Fri, 7 Jul 2023 18:26:44 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yuzhao@google.com, ryan.roberts@arm.com, shy828301@gmail.com,
        akpm@linux-foundation.org, david@redhat.com
Subject: Re: [RFC PATCH 0/3] support large folio for mlock
Message-ID: <ZKhK1Ic1KCdOLRYm@casper.infradead.org>
References: <20230707165221.4076590-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707165221.4076590-1-fengwei.yin@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 08, 2023 at 12:52:18AM +0800, Yin Fengwei wrote:
> This series identified the large folio for mlock to two types:
>   - The large folio is in VM_LOCKED VMA range
>   - The large folio cross VM_LOCKED VMA boundary

This is somewhere that I think our fixation on MUST USE PMD ENTRIES
has led us astray.  Today when the arguments to mlock() cross a folio
boundary, we split the PMD entry but leave the folio intact.  That means
that we continue to manage the folio as a single entry on the LRU list.
But userspace may have no idea that we're doing this.  It may have made
several calls to mmap() 256kB at once, they've all been coalesced into
a single VMA and khugepaged has come along behind its back and created
a 2MB THP.  Now userspace calls mlock() and instead of treating that as
a hint that oops, maybe we shouldn't've done that, we do our utmost to
preserve the 2MB folio.

I think this whole approach needs rethinking.  IMO, anonymous folios
should not cross VMA boundaries.  Tell me why I'm wrong.
