Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE396F44CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 15:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjEBNMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 09:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbjEBNMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 09:12:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0AD93
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 06:12:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 32F121F8BE;
        Tue,  2 May 2023 13:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1683033139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e34lyARZ09HKGFIQlEiAF8THiXo5avHNPJpnG3uakEc=;
        b=XA+fhfRdy1PVdokPNUnoo6eiG0HPFk9vPe17qeEuWqGZOV0d5f1CF7K2wwdCVsR4g+8CiM
        uzy9Rdh8/ntLrkaGAvy6HyfbDug2JW1840Gf1Qp+U1Wya0zG8lJUONVwTXyPt/x0RoWNZX
        A7sCN047xeZMeL85BgJI5rf61u1ztXk=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1404E134FB;
        Tue,  2 May 2023 13:12:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nO7aATMMUWTeUgAAMHmgww
        (envelope-from <mhocko@suse.com>); Tue, 02 May 2023 13:12:19 +0000
Date:   Tue, 2 May 2023 15:12:18 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Lorenzo Stoakes <lstoakes@gmail.com>
Subject: Re: mbind MPOL_INTERLEAVE existing pages
Message-ID: <ZFEMMg7gP7hJzIvl@dhcp22.suse.cz>
References: <20230501185836.GA85110@monkey>
 <c8d21c1e-1bcb-e995-9b58-01ea3320085e@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8d21c1e-1bcb-e995-9b58-01ea3320085e@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 02-05-23 09:45:40, Vlastimil Babka wrote:
> On 5/1/23 20:58, Mike Kravetz wrote:
> > I received a question from a customer that was trying to move pages via
> > the mbind system call.  In this specific case, the system had two nodes
> > and all pages in the range were already present on node 0.  They then
> > called mbind with mode MPOL_INTERLEAVE and the MPOL_MF_MOVE_ALL flag.  Their
> > expectation was that half the pages in the range would be moved to node 1
> > in an interleaved pattern.
> > 
> > In the above situation, no pages actually get moved.  This is because mbind
> > creates a list of pages to be moved via:
> > 
> > 	ret = queue_pages_range(mm, start, end, nmask,
> >                           flags | MPOL_MF_INVERT, &pagelist);
> > 
> > No page will be added to the list as queue_folio_required is called for each
> > page to determine if it resides within the set of nodes.  And, all page are
> > within the set.
> > 
> > I have reread the mbind man page several times and agree that one might
> > expect MPOL_INTERLEAVE with MPOL_MF_MOVE_ALL to move pages and create an
> > interleaved pattern.  My question is should we:
> > - Change mbind so that pages are moved to an interleaved pattern?
> 
> I guess it could be worth trying, if there's a use case. And hope nobody
> else is depending on the current behavior and will complain afterwards :)

I am not sure this is worth it wrt. complexity. Essentially it would
require to build up the distribution for the whole range first so 2
passes. Also it could become more tricky if the final node mask has
nodes of difference distances (it would be a reasonable expectation to
distribute withe minimum total distances right ;)).
 
> > - Update the documentation to be more explicit?

Yes, please. I do not think. While this sounds like a neat feature I
think the additional complexity is likely not worth it. A strong usecase
might make a difference though.
-- 
Michal Hocko
SUSE Labs
