Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F02710BCE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 14:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbjEYMLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 08:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239674AbjEYMLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 08:11:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4C1B3
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 05:11:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2735B21D6E;
        Thu, 25 May 2023 12:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1685016693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkGheDbBXp2iDi36N2GwA3cdvzxEHyIFFGeJJC67HBg=;
        b=Bf2dksY98IF7baKzvdlQlv2rEGnCJzyLAlRugMaBcPPdSQeu+hZQKtd8P+f3bXWadlENTJ
        xWN/3hytzVQbFsqQiJcjOMVqrWiOtQq3pkP3c62z+OJI6ivkPtl9FQaZq1MH+5V4mxpz84
        mTCpKFu0FdhQt7IL83u593YUAtpH5r8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1685016693;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WkGheDbBXp2iDi36N2GwA3cdvzxEHyIFFGeJJC67HBg=;
        b=wN+0hgnH4sIxIiyVOgnFfM4c2LnNvHFBhmZbQX5LNcOKmExAmr+aQfPDX6Xdn51t8LtaRj
        OzPeb2COwVFLibDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DB1FE134B2;
        Thu, 25 May 2023 12:11:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mktqNHRQb2ScLQAAMHmgww
        (envelope-from <dsterba@suse.cz>); Thu, 25 May 2023 12:11:32 +0000
Date:   Thu, 25 May 2023 14:05:25 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        David Sterba <dsterba@suse.com>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH] mm/slab: add new flag SLAB_NO_MERGE to avoid merging per
 slab
Message-ID: <20230525120524.GH30909@suse.cz>
Reply-To: dsterba@suse.cz
References: <20230524101748.30714-1-dsterba@suse.com>
 <ZG4JYr14RpNQb8li@debian-BULLSEYE-live-builder-AMD64>
 <70763661-b2a2-4bf2-f589-e0d71083f1bd@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70763661-b2a2-4bf2-f589-e0d71083f1bd@suse.cz>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:53:11PM +0200, Vlastimil Babka wrote:
> On 5/24/23 14:56, Hyeonggon Yoo wrote:
> > On Wed, May 24, 2023 at 12:17:48PM +0200, David Sterba wrote:
> > work for your use case? (there are some boot-time slub_debug options described in
> > Documentation/mm/slub.rst)
> 
> Yeah, it supports globbing so it would be e.g. slub_debug=N,btrfs*
> That would deal with the "too coarse" aspect slab_nomerge. As for "need to
> be enabled on all testing hosts", is it more convenient to deploy a debug
> kernel build on them? Might be because you do that for other reasons
> already? Just want to clarify.

Yeah, agreed.

> BTW this was proposed as RFC few months ago but not pursued:
> https://lore.kernel.org/all/167396280045.539803.7540459812377220500.stgit@firesoul/
> 
> I have no big objections, just wouldn't like to see its usage proliferate
> unconditionally into non-debug builds.

It would be fine for me to make it conditionally available, e.g.
depending on SLUB_DEBUG.
