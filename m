Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3D756DE86F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 02:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjDLAPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 20:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLAPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 20:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB69412B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 519B86268F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 00:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 752C0C433EF;
        Wed, 12 Apr 2023 00:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1681258537;
        bh=+4+26YeShVOy7ToR1aCgF4tHlAF/edewLYy1hsvDreo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kPrR+RF5l0d0OtWpJ2ln+3K16rNYnnm9appIm0pPLkOrKrtPpX7uY9XtzB4q36I0w
         9MUqIW/lhNIWqUu9X7f3GRzjNW9J0kADvH4gj3/q6g1AZt0KIOIsFfkn7OhLifbzTX
         thgoN+JVF7F6bcsWpbTmT+CTZ6NahIcSOXkrkVPw=
Date:   Tue, 11 Apr 2023 17:15:36 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "xiaosong.ma" <Xiaosong.Ma@unisoc.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        yuming.han@unisoc.com, ke.wang@unisoc.com
Subject: Re: [PATCH V2] fs: perform the check when page without mapping but
 page->mapping contains junk or random bitscribble
Message-Id: <20230411171536.2e53b4b7507304d5618aa24e@linux-foundation.org>
In-Reply-To: <ZDVPkljntjCr9/nX@casper.infradead.org>
References: <1681091102-31907-1-git-send-email-Xiaosong.Ma@unisoc.com>
        <ZDVPkljntjCr9/nX@casper.infradead.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 13:16:18 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Mon, Apr 10, 2023 at 09:45:02AM +0800, xiaosong.ma wrote:
> > perform the check in dump_mapping() to print warning info and avoid crash with invalid non-NULL page->mapping.
> > For example, a panic with following backtraces show dump_page will show wrong info and panic when the bad page
> > is non-NULL mapping and page->mapping is 0x80000000000.
> > 
> >     crash_arm64> bt
> >     PID: 232    TASK: ffffff80e8c2c340  CPU: 0   COMMAND: "Binder:232_2"
> >      #0 [ffffffc013e5b080] sysdump_panic_event$b2bce43a479f4f7762201bfee02d7889 at ffffffc0108d7c2c
> >      #1 [ffffffc013e5b0c0] atomic_notifier_call_chain at ffffffc010300228
> >      #2 [ffffffc013e5b2c0] panic at ffffffc0102c926c
> >      #3 [ffffffc013e5b370] die at ffffffc010267670
> >      #4 [ffffffc013e5b3a0] die_kernel_fault at ffffffc0102808a4
> >      #5 [ffffffc013e5b3d0] __do_kernel_fault at ffffffc010280820
> >      #6 [ffffffc013e5b410] do_bad_area at ffffffc01028059c
> >      #7 [ffffffc013e5b440] do_translation_fault$4df5decbea5d08a63349aa36f07426b2 at ffffffc0111149c8
> >      #8 [ffffffc013e5b470] do_mem_abort at ffffffc0100a4488
> >      #9 [ffffffc013e5b5e0] el1_ia at ffffffc0100a6c00
> >      #10 [ffffffc013e5b5f0] __dump_page at ffffffc0104beecc
> 
> This doesn't show a crash in dump_mapping(), it shows a crash in
> __dump_page().

um, yes.

But if page->mapping is corrupted, where does __dump_page() dereference it?

The initial patch
(https://lkml.kernel.org/r/1680587425-4683-1-git-send-email-Xiaosong.Ma@unisoc.com)
prevented __dump_page() from calling dump_mapping() if page->mapping is
bad, and that presumably fixed things.


> > diff --git a/fs/inode.c b/fs/inode.c
> > index f453eb5..c9021e5 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -564,7 +564,8 @@ void dump_mapping(const struct address_space *mapping)
> >  	 * If mapping is an invalid pointer, we don't want to crash
> >  	 * accessing it, so probe everything depending on it carefully.
> >  	 */
> > -	if (get_kernel_nofault(host, &mapping->host) ||
> > +	if (get_kernel_nofault(mapping, &mapping) ||
> > +	    get_kernel_nofault(host, &mapping->host) ||
> 
> This patch makes no sense.  Essentially, you're saying
> 	mapping = &mapping
> which is obviously wrong.

We're checking for mapping==junk, so this could be 

	get_kernel_nofault(tmp, mapping)

or go direct to copy_from_kernel_nofault().  We used to have a
probe_kernel_address() for this...

So confusion reigns.  I think making dump_mapping() tolerant of a wild
mapping pointer makes sense, but I don't think we actually know why the
reporter's kernel crashed.
