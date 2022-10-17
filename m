Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9220600487
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 02:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiJQA2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 20:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiJQA2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 20:28:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000AC32B8E;
        Sun, 16 Oct 2022 17:28:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 904B460AF5;
        Mon, 17 Oct 2022 00:28:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D909C433C1;
        Mon, 17 Oct 2022 00:28:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1665966496;
        bh=8WWs9l2qmGMghweN7Ckgt8DaX3cG0OZdXxkM6TKYH6g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XvguAicoL8TSob5RaCJ1spC8fTW535GDGPGmIeJqsUbMegUQgUfIZqKLGN8doPap6
         rlQcttXjKZaERBO515DWE+A4kKsh18wQ4rFtJj6yPsLVghtZ8l21QGuWZNDBiY6bxl
         ticivMkLffHyBnxcxWZes4OauqiUkqBsk9jAXjGc=
Date:   Sun, 16 Oct 2022 17:28:15 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>, linux-kbuild@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, llvm@lists.linux.dev
Subject: Re: [PATCH v2] lib/Kconfig.debug: Add check for non-constant
 .{s,u}leb128 support to DWARF5
Message-Id: <20221016172815.f5a5f1f86af7ff1937a2e273@linux-foundation.org>
In-Reply-To: <20221014204210.383380-1-nathan@kernel.org>
References: <20221014204210.383380-1-nathan@kernel.org>
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

On Fri, 14 Oct 2022 13:42:11 -0700 Nathan Chancellor <nathan@kernel.org> wrote:

> When building with a RISC-V kernel with DWARF5 debug info using clang
> and the GNU assembler, several instances of the following error appear:
> 
>   /tmp/vgettimeofday-48aa35.s:2963: Error: non-constant .uleb128 is not supported

hm, which kernels want this?

I could merge it for 6.1, which seems suitable.  If we want it
backported into earlier kernels then a Fixes: would be nice, to prevent
it from being ported back further than necessary.

