Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF1A68F2DB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbjBHQJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:09:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjBHQJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:09:01 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BD04B76F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=33D1nIkrj+rN/FJ9Mpc4yQD6ZwZtGPCUZ+/gfUeUh3I=; b=a81kvQn+6ghO6zYIKLH7k83DnK
        YscSh6eZWUG+TrCVkG6xavWF5wwN2WV3Hb+oZ6DzV0mSsR5aHyk18mpMKoM2zCnP2FI7QFx2KLSY5
        OXXkVgQM0dMmqcv1aQpkASL1NSdfL9P1AwlbbvA5vG6Dkg8GChY1bEmf9FKsdIiEHypys3gygoMji
        TmeCvEMdC++7iC+zALpC4dr6ecXJWZtNyjFkf4e0Se08yK+oJhYSPhk2cnWJFeINIQS9zVzjlME4k
        0/HQ+BplNo28wIUuOcXP1onvhEgMvoixALYZtYlPpzF9xU1c/f+1zydy13WcEJwLVpA7vxARtMBhA
        7YooThNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPn01-00GD00-IW; Wed, 08 Feb 2023 16:08:45 +0000
Date:   Wed, 8 Feb 2023 08:08:45 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     hughd@google.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        p.raghav@samsung.com, dave@stgolabs.net, a.manzanares@samsung.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] shmem: set shmem_writepage() variables early
Message-ID: <Y+PJDUo3jsH9WfmB@bombadil.infradead.org>
References: <20230207025259.2522793-1-mcgrof@kernel.org>
 <20230207025259.2522793-2-mcgrof@kernel.org>
 <Y+HLFWaHq11MQ91U@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+HLFWaHq11MQ91U@casper.infradead.org>
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

On Tue, Feb 07, 2023 at 03:52:53AM +0000, Matthew Wilcox wrote:
> On Mon, Feb 06, 2023 at 06:52:58PM -0800, Luis Chamberlain wrote:
> > shmem_writepage() sets up variables typically used *after* a possible
> > huge page split. However even if that does happen the address space
> > mapping should not change. So it should be safe to set that from
> > the beginning.
> 
> Yes, we can get mapping from the folio early.  It doesn't change
> on split.

Great.

> > The folio should always be locked from the start as well. It however
> > was not clear if the folio address can / should change, as well as
> > the first inode.
> > 
> > This commit makes no functional changes other a double check on the
> > folio locking which might be superflous. This change should help make
> > the subsequent patch easier to review.
> 
> You don't need to check that the folio's locked,

That BUG_ON() has been on shmem since linux-history days it's probably
best as a separate patch.

> and you don't
> need to reassign inode after the split.

Great! Thanks for this confirmation!

  Luis
