Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0C0680724
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 09:12:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbjA3IMM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 03:12:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235875AbjA3IMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 03:12:09 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B1118AA7;
        Mon, 30 Jan 2023 00:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BDB08CE11EA;
        Mon, 30 Jan 2023 08:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A62C4C433EF;
        Mon, 30 Jan 2023 08:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675066201;
        bh=lkZCjdK1sw00gXcaKXHGXN34F8M5n4HX8wdCxMGrCiw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QS/3PAOCULM0n2uMOIr9j755LWg9e5mz5b6AvabQcCLyUO4E6GNEDnwifqLQj6OwL
         NqkdAIL+ss2LMwqM8kGuF261S76OZFViq8E2hzX71HmhsgROQSnE/f3FkZpiAATIIn
         HfTID4rV3qr/pfvHZxiaRXlCbaXB62yzKimmXC+zvTc5Ys2ns74RSVi8fdkp866b0W
         ubjvjyAOlXuNNE+umFw9p4Y4m8ExQWf6BtxdNEIejAZaZd2LPUMQPN67zlZVQErE5t
         gylqRWbTU8a4+Cm5yU6U3mCi0QDc2lSowQP2mAbstBzPLtqjMUk5hciBODtDUAuA7A
         egsL35xdmXh2g==
Date:   Mon, 30 Jan 2023 09:09:56 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian@brauner.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20230130080956.ikb3w5cjkhtxqzcr@wittgenstein>
References: <20230130161414.25a71a87@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230130161414.25a71a87@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 04:14:14PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
> 
> kernel/sys.c: In function '__do_sys_prctl':
> kernel/sys.c:2664:9: error: duplicate case value
>  2664 |         case PR_SET_HIDE_SELF_EXE:
>       |         ^~~~
> kernel/sys.c:2655:9: note: previously used here
>  2655 |         case PR_SET_MDWE:
>       |         ^~~~
> kernel/sys.c:2669:9: error: duplicate case value
>  2669 |         case PR_GET_HIDE_SELF_EXE:
>       |         ^~~~
> kernel/sys.c:2658:9: note: previously used here
>  2658 |         case PR_GET_MDWE:
>       |         ^~~~
> 
> Caused by commit
> 
>   ab30677b499c ("mm: implement memory-deny-write-execute as a prctl")
> 
> interacting with commit
> 
>   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> 
> from the pidfd tree.
> 
> I have applied the following merge fix patch.
> 
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 30 Jan 2023 16:08:34 +1100
> Subject: [PATCH] mm: fixup for "mm: implement memory-deny-write-execute as a prctl"
> 
> interacting with
> 
>   966eb1ba050d ("exec: add PR_HIDE_SELF_EXE prctl")
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---

Thanks Stephen,

I'm moving this out of -next for now until we've settled a few more
details.

Christian
