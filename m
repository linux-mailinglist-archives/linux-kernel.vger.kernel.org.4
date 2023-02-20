Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC16A69D576
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 21:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjBTU6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 15:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjBTU6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 15:58:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E99912F16;
        Mon, 20 Feb 2023 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=tSEs9ht0iaoG7yWtyGM3oIpGa4Q834m/lzRPmNUenPM=; b=P70RpSPdOwsJJCNEvNL96B9dbQ
        2ry6UEWVKemTiXJUvKBFX7mFl8R6Ss7NmtVASjgDDpWAODVgkqyHEYy2chdF6JSLwELZFM3Z0s/pg
        +aHvcT7b/ZG1hvxml3x/qtzkCl29OqEOXY9AhEpqJ73KDYpcRMdUeAtfCvRW9VC4mbdYra3I6uXgo
        iHmgxQ7G0S18FD99bppKicS8uFglD642Mk0rf1kzAh4PZfVZI9v55iVJEwlgY3rLO4KfjJTxeK9g7
        fayoQxIyrUGwlSMQ2oT+0gM2P5JQxRHC/ymIJs8vs1PWgQ39CjS1ceX+3Vd9Vs/TEhR/MGKqEmAgx
        kqLzS1Qw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUDEZ-00C1OQ-VY; Mon, 20 Feb 2023 20:58:04 +0000
Date:   Mon, 20 Feb 2023 20:58:03 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Subject: Re: linux-next: manual merge of the mm-stable tree with the cifs tree
Message-ID: <Y/Pe2xHklSr1hDtz@casper.infradead.org>
References: <20230220152933.1ab8fa4a@canb.auug.org.au>
 <Y/N8hVWeR3AjssUC@casper.infradead.org>
 <20230220190157.3b43b9a7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220190157.3b43b9a7@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 07:01:57PM +1100, Stephen Rothwell wrote:
> Hi Matthew,
> 
> On Mon, 20 Feb 2023 13:58:29 +0000 Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Mon, Feb 20, 2023 at 03:29:33PM +1100, Stephen Rothwell wrote:
> > > 
> > > Today's linux-next merge of the mm-stable tree got a conflict in:
> > > 
> > >   fs/cifs/file.c
> > > 
> > > between commit:
> > > 
> > >   c8859bc0c129 ("cifs: Remove unused code")
> > > 
> > > from the cifs tree and commits:
> > > 
> > >   4cda80f3a7a5 ("cifs: convert wdata_alloc_and_fillpages() to use filemap_get_folios_tag()")
> > >   d585bdbeb79a ("fs: convert writepage_t callback to pass a folio")
> > > 
> > > from the mm-stable tree.
> > > 
> > > This is a real mess :-(  
> > 
> > Doesn't look too bad to me.  Dave's commit is just removing the
> > functions, so it doesn't matter how they're being changed.
> 
> The problem I see is that an earlier commit in the cifs tree moves the
> use of find_get_pages_range_tag() to another function and 4cda80f3a7a5
> then removes find_get_pages_range_tag().

Ah.  Just removing all traces of it should be fine.  As long as there
are no remaining callers of find_get_pages_range_tag() after the merge,
it's good from my point of view.

