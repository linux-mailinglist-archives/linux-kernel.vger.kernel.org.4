Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C43600493
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbiJQAlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbiJQAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:41:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9F336092;
        Sun, 16 Oct 2022 17:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 91393B80DAC;
        Mon, 17 Oct 2022 00:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90075C433D6;
        Mon, 17 Oct 2022 00:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665967265;
        bh=FUOUlzt5BRDqsXFWN6sPJsKiLvmj3iudLIpob+Peo9Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qHaTopcfle+C0cDQbHIVhD1HZXN96LdC2zMl/WExOPuLpGQhgAaUz1xxNaVoimx+L
         sDiqv+gNM/fNkBu6CYltMt640zCVmeXR0mil75LQOdwIlGPOlIrTyZLa3LQzJ37im1
         JVlTyDLENjVmpAc49NdqZBGMUVYV319B9hwgsn+KEuPuESJgBUkk0mbGXrOeIHlOhu
         dAIrG+vsiN9VTSjEl+EUZ0By53/0+D26AzpvL/1m7XpHJ+zGmWdE0PCnZ7QEwq+X3i
         EHw2etxSN5Ebg6dDngLrccbHn8pKXdcI6/SqUOXErclb6bTqk4lOtCTSsMaOwGtdc5
         P6DJ+YasqLPkg==
Date:   Sun, 16 Oct 2022 17:41:02 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev
Subject: Re: [PATCH v2] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
Message-ID: <Y0yknpUJn5K2uhw1@dev-arch.thelio-3990X>
References: <20221014204210.383380-1-nathan@kernel.org>
 <20221016172815.f5a5f1f86af7ff1937a2e273@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221016172815.f5a5f1f86af7ff1937a2e273@linux-foundation.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Sun, Oct 16, 2022 at 05:28:15PM -0700, Andrew Morton wrote:
> On Fri, 14 Oct 2022 13:42:11 -0700 Nathan Chancellor <nathan@kernel.org> wrote:
> 
> > When building with a RISC-V kernel with DWARF5 debug info using clang
> > and the GNU assembler, several instances of the following error appear:
> > 
> >   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported
> 
> hm, which kernels want this?
> 
> I could merge it for 6.1, which seems suitable.  If we want it
> backported into earlier kernels then a Fixes: would be nice, to prevent
> it from being ported back further than necessary.

Masahiro took this for 6.1 via the kbuild tree, it is now in mainline as
commit 0a6de78cff60 ("lib/Kconfig.debug: Add check for non-constant
.{s,u}leb128 support to DWARF5"). It does need to go to stable but it
needs a few prerequisite changes to cover all cases and I did not want
to try and describe those dependencies in the patch itself. I should be
able to handle the backports manually tomorrow.

Cheers,
Nathan
