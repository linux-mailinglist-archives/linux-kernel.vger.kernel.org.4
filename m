Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 813096C04F6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 21:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCSUwX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjCSUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 16:52:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437D711E96
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 13:52:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFA5EB80CBE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 20:52:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D874CC4339B;
        Sun, 19 Mar 2023 20:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679259137;
        bh=jnSlMSfVmw1ZnOv7z43vykdjA41NROrY6Ktk8ZZdvgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vL+lCRr/8yA9n6R335G8ETSlzA+Iya5cMCEPNJvRcqEPiFgqOma3Fh6T0QcN2dxJZ
         Zrpu9585Uh7pN7mMdnUagUOknvK0kxkP4p9BWpRWLX58fCzyUuWadjkjp7Z9/A30Ct
         CLJWsZS7ZWkvp/9SvV1uAv54pIq3mjs27hch/WkzEAWFumfE2mZxK8nB1Vu1FtbwkK
         fH2ebFFKvA4NQgfLBfrXyx5y7tqd2IFLEdW1vyztFVasZFatFGnVACLuAFs2DYPYcI
         0aCgnKzpArQIWuyKNHX5daKJ07T5oE4dL8SRQOHU52XJU0P7/iRHXhFoQIx2F8NTmW
         dfzKZJJbdotjw==
Date:   Sun, 19 Mar 2023 22:52:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Lorenzo Stoakes <lstoakes@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: move get_page_from_free_area() to mm/page_alloc.c
Message-ID: <ZBd19XXlT/9ZvBN9@kernel.org>
References: <20230319114214.2133332-1-rppt@kernel.org>
 <0020b728-724d-4206-8768-ec94d5628b34@lucifer.local>
 <ZBdu9oOyWP+NdO4P@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBdu9oOyWP+NdO4P@casper.infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 19, 2023 at 08:22:14PM +0000, Matthew Wilcox wrote:
> On Sun, Mar 19, 2023 at 12:07:43PM +0000, Lorenzo Stoakes wrote:
> > On Sun, Mar 19, 2023 at 01:42:14PM +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (IBM)" <rppt@kernel.org>
> > >
> > > The get_page_from_free_area() helper is only used in mm/page_alloc.c so
> > > move it there to reduce noise in include/linux/mmzone.h
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> > Good catch, I wonder if there are more functions like this that can be dropped
> > from headers?
> 
> I don't think anything outside mm/ has any reason to see 'struct
> free_area'.  Unfortunately, it's a field in struct zone, so moving
> it out of mmzone.h will be hard (unless we can move struct zone out of
> mmzone.h?)

Seems possible but not trivial.
 
> free_area_empty() can move to mm/internal.h though

Yes.

-- 
Sincerely yours,
Mike.
