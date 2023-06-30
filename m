Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABF7435ED
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjF3Hix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjF3Hir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:38:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA66111F;
        Fri, 30 Jun 2023 00:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40158616E3;
        Fri, 30 Jun 2023 07:38:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F3F4C433C0;
        Fri, 30 Jun 2023 07:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688110725;
        bh=QZkfT1eAKy1ISt5RPwIIR7ioUeuiNq5bvetFlRqftbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f0u/HQT0YmmvZ+MEi9Z+YABf4xPuysbROLSfLoteoB0vgqjV+IqmtvLPUDqdQVthh
         5ZiD906zIHcu9V0TuV8fO6pHddWfpnaOojJWpC4SIcYXmdu3OKR+WV2sfetlDmIrb8
         cmJOH16gwe45viFyYubd+GX57r9b28dmwPHXKdnucxevQTWQozggUaCBMM/e03uNGl
         sedeVJf1VIdb7maCgH2an8GctnkqGuu5fuCJHVmuU4WqO/aHLOl2NC9jmXfiYgBf/7
         wyoCxeul+QNZlWhmNe5jh2m29tZCApqNOMIC4pvoatVoQb5sweuphEIt5Fz/6w42hQ
         m9VOqkQWWjWOA==
Date:   Fri, 30 Jun 2023 09:38:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Tyler Hicks <code@tyhicks.com>,
        Dave Chinner <dchinner@redhat.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs/ecryptfs: Replace kmap{,_atomic}() with
 kmap_local_page()
Message-ID: <20230630-entkriminalisierung-girlanden-6bcaf5502f88@brauner>
References: <20230426172223.8896-1-fmdefrancesco@gmail.com>
 <23780760.ouqheUzb2q@suse>
 <20230630023107.GA1088@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230630023107.GA1088@sol.localdomain>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 07:31:07PM -0700, Eric Biggers wrote:
> On Wed, Jun 28, 2023 at 03:50:30PM +0200, Fabio M. De Francesco wrote:
> > On mercoledì 26 aprile 2023 19:22:20 CEST Fabio M. De Francesco wrote:
> > > kmap() and kmap_atomic() have been deprecated in favor of
> > > kmap_local_page().
> > > 
> > > Therefore, replace kmap() and kmap_atomic() with kmap_local_page().
> > 
> > After two months from submission, I haven't received any comments on this 
> > short series yet, except for a "Reviewed by" tag from Ira on patch 1/3 only.
> > 
> > I would appreciate any comments/reviews/acks and would especially like to know 
> > if anything is preventing these patches from being applied.
> > 
> 
> eCryptfs is in "Odd Fixes" status.  See the thread
> https://lore.kernel.org/ecryptfs/ZB4nYykRg6UwZ0cj@sequoia/T/#u
> 
> I would suggest that if Tyler is not responding, that Christian or Al take these
> patches through the VFS tree instead.
> 
> FWIW, I took a quick look at these three patches, and all look correct.  I'm not
> sure I want to give a formal R-b, as I don't want people to start bothering me
> about eCryptfs stuff because they saw my name on it :-)

Ah well, you saw right through that. :)
That usually means you've been doing kernel development for way too long...
