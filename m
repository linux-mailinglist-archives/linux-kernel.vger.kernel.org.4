Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD586DE6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 23:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjDKVzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 17:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDKVzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 17:55:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DF2449E;
        Tue, 11 Apr 2023 14:55:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E85560B5C;
        Tue, 11 Apr 2023 21:55:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D82C433EF;
        Tue, 11 Apr 2023 21:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681250120;
        bh=a6oFke0MV3KOivGNZjjk4aO8C1K1yyG4osJBFMYEFpM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VE+wc58qY3ZcnrsGUTPa0TaDQbHvLW38zZxzXWEo+uTraZSaWNW4rto9QubnQqptH
         690I5Hab6A1pEYghyTTLNjVXQrjYxXpUEk84Ow6FK81+CSFwNmmW2VyT4A6YAGqQnT
         FVViuol/d/yPz663sI2HRDaoq+AyEEjDL7pLiuDlHs9iPJ6iKvi4PM88Onon6dVOGE
         kmdy2IxalYanFCGDqv2Ro6OwOOkVQhn1NFBdmhAmLdcVTWJ32F6aIBDah12fjQXZwn
         XQjEGKN15FhffvucWpUd6Fwfq4j6gbbnaEj49ygT2ozActj+ooxwX05+3PFC8bcdvr
         0m3QbGgUUIeWA==
Date:   Tue, 11 Apr 2023 14:55:18 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230411215518.u2fgi7napfcwyuce@treble>
References: <20230327120017.6bb826d7@canb.auug.org.au>
 <20230327162630.wmxpycxhllt4clpt@treble>
 <20230328104719.65133586@canb.auug.org.au>
 <20230412073416.73a8ea1a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230412073416.73a8ea1a@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 07:34:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Tue, 28 Mar 2023 10:47:19 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Mon, 27 Mar 2023 09:26:30 -0700 Josh Poimboeuf <jpoimboe@kernel.org> wrote:
> > >
> > > On Mon, Mar 27, 2023 at 12:00:17PM +1100, Stephen Rothwell wrote:  
> > > > 
> > > > After merging the block tree, today's linux-next build (x86_64
> > > > allnoconfig) produced these warnings:
> > > > 
> > > > lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS d
> > > > isable
> > > > lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_comp
> > > > at_iovec_from_user.part.0() with UACCESS enabled
> > > > lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
> > > > 
> > > > Presumably introduced by commit
> > > > 
> > > >   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")    
> > > 
> > > I'm not able to recreate.  What's your compiler version?  
> > 
> > $ x86_64-linux-gnu-gcc --version
> > x86_64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0
> 
> Any progress?

I still wasn't able to recreate with gcc version 12.2.1 20221121 (Red
Hat 12.2.1-4) (GCC) .

Is it a cross-compile?

Can you share the .o file?

-- 
Josh
