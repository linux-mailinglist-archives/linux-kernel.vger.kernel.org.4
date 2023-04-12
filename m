Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC36DEA1A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 06:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDLEF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 00:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDLEFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 00:05:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAD4EE8;
        Tue, 11 Apr 2023 21:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jaf8TVcaCoY+gXRI/VJ8dcjLvYvyn0Wf6eDT01i5qTU=; b=gV/Q8PhBJfKEwrm7QUc3Nj/RkV
        SdSL5cwKeC0Plg0b6mwejcTDoMjZarfDiNAgQplXpqYWFesGNsx9Ly1iS6lsQsOGJ+pmFjNCyYBZf
        iTxAWnMJJISxhizo+817ILIZ4QnD9GsCTv7+ptWdl3GhN2mkaCUshKhLgpYXIWL6hRXulCkBhdaqR
        xAasSAx0b9s9kawlt7zz92GU+EBueFmLjNPSh92Ny2DYBUxQ8C626EYy8rD6dI2n+LAlqcCd2bwnj
        qtaTHNNsdcvpr+FmnPzCRFCLdstHHWMLyCna3D7TkKLo6UwdqvD2aTrs6jMv7YKU2iQnB2ZHFHxEy
        KNQzlAXw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pmRjM-001jmc-1R;
        Wed, 12 Apr 2023 04:05:12 +0000
Date:   Tue, 11 Apr 2023 21:05:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     david@redhat.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        torvalds@linux-foundation.org, gregkh@linuxfoundation.org,
        rafael@kernel.org, christophe.leroy@csgroup.eu, tglx@linutronix.de,
        peterz@infradead.org, song@kernel.org, rppt@kernel.org,
        dave@stgolabs.net, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com
Subject: Re: [PATCH v2 1/2] Change DEFINE_SEMAPHORE() to take a number
 argument
Message-ID: <ZDYt+PwRjr+BzeBz@bombadil.infradead.org>
References: <20230405203505.1343562-1-mcgrof@kernel.org>
 <20230405203505.1343562-2-mcgrof@kernel.org>
 <ZDB+zn3X4sac9DFU@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDB+zn3X4sac9DFU@casper.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023 at 09:36:30PM +0100, Matthew Wilcox wrote:
> Or this:
> 
> /*
>  * Unlike mutexes, binary semaphores do not have an owner, so up() can
>  * be called in a different thread from the one which called down().
>  * It is also safe to call down_trylock() and up() from interrupt
>  * context.
>  */

I went with that. Thanks for helping me paint this shed!

  Luis
