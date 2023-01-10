Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BA6A664FD6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 00:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjAJXTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 18:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235154AbjAJXS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 18:18:59 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7578E59319
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 15:18:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A586190D
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 23:18:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42723C433EF;
        Tue, 10 Jan 2023 23:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673392722;
        bh=1FrDLc773XkQj+lO8Vh4muEBRRgPkXtE/hqrdxursgo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=syzxvEG3JVxdj2XSfnkR3ErqWix6EtLHHPHXoEY/wK4F97qafATMOvbdx3Ea0QrRH
         Lcd0PEYmHht3egw7ziC6S3WNl+V155qeZ898xCYFNWoTt3YcNwdQIDzHp66TEADkpJ
         6TmTTfGS24C0FPxVO7hgyADewLZp8f2A86FrpUF8=
Date:   Tue, 10 Jan 2023 15:18:41 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     SeongJae Park <sj@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>
Subject: Re: [PATCH] maple_tree: Fix handle of invalidated state in
 mas_wr_store_setup()
Message-Id: <20230110151841.149f2bd34dcc7ebcdd6bbaad@linux-foundation.org>
In-Reply-To: <20230110142109.gphhirh7jo67br6x@revolver>
References: <20230109154012.3342cbb91defbc485db641c1@linux-foundation.org>
        <20230109234317.1408-1-sj@kernel.org>
        <20230110142109.gphhirh7jo67br6x@revolver>
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

On Tue, 10 Jan 2023 14:21:15 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:

> * SeongJae Park <sj@kernel.org> [230109 18:43]:
> > Hi Andrew,
> > 
> > On Mon, 9 Jan 2023 15:40:12 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > On Mon,  9 Jan 2023 19:22:48 +0000 SeongJae Park <sj@kernel.org> wrote:
> > > 
> > > > On Mon, 9 Jan 2023 16:55:42 +0000 Liam Howlett <liam.howlett@oracle.com> wrote:
> > > > 
> > > > > If an invalidated maple state is encountered during write, reset the
> > > > > maple state to MAS_START.  This will result in a re-walk of the tree to
> > > > > the correct location for the write.
> > > 
> > > Can we think of a Fixes: for this?
> 
> It wasn't really an issue until I wrote the vma iterator store
> function.
> 
> You can put this before (mm-unstable git id..)
> 9df3d25a97ec ("mm: expand vma iterator interface")

I have dropped "mm: expand vma iterator interface"'s series.  Should we
retain this patch as a standalone thing and is the changelog still
appropriate?
