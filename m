Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71966CAA89
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 18:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjC0Q0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 12:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjC0Q0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 12:26:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C661BE8;
        Mon, 27 Mar 2023 09:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 01F0BB8170C;
        Mon, 27 Mar 2023 16:26:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80DC2C433EF;
        Mon, 27 Mar 2023 16:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679934392;
        bh=4pIuc9A52G9w0T0G5dmVhtnXgoYMhwTan2323fMt7Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJBNAQI7hUUfZvr3HqpZUDiESll5GYalC0D1MjvZfRLn+J/I1TYxg9MNKBW9A1ICV
         RzxSHjgBpimysipDCQjrxW7R/oGCp8P6fqYgmzeYySKjZEs2DxHTG4LZasBAcK90SQ
         SR3egae/XnNHtO5Xaf7+aJ07j1f0hRcVfleHK16qXMOWuWncZc80tWku2rRQfAbNvV
         NplrroNp3Za1HoCNspaoWqB+3lMkDpLBK6FGKCEkZLfVA+53yHuGJzJh+tRNzqGEhU
         zLGjlqTXmkB2RXpkXHWMBYUCYOR7cfiJaGCiNOCLxdeDcBHK/VR3STp4lqPo6wqxky
         6b7YBfNzxCwjw==
Date:   Mon, 27 Mar 2023 09:26:30 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the block tree
Message-ID: <20230327162630.wmxpycxhllt4clpt@treble>
References: <20230327120017.6bb826d7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230327120017.6bb826d7@canb.auug.org.au>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 12:00:17PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (x86_64
> allnoconfig) produced these warnings:
> 
> lib/iov_iter.o: warning: objtool: .altinstr_replacement+0x0: redundant UACCESS d
> isable
> lib/iov_iter.o: warning: objtool: iovec_from_user.part.0+0xc7: call to copy_comp
> at_iovec_from_user.part.0() with UACCESS enabled
> lib/iov_iter.o: warning: objtool: __import_iovec+0x21d: call to copy_compat_iovec_from_user.part.0() with UACCESS enabled
> 
> Presumably introduced by commit
> 
>   6376ce56feb6 ("iov_iter: import single vector iovecs as ITER_UBUF")

I'm not able to recreate.  What's your compiler version?

It's complaining about a call to a "part.0" function, maybe the IPA
optimization is moving the STAC to before the call.

-- 
Josh
