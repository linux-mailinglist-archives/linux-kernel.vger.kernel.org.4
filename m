Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDC68B75F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBFIab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 03:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBFIa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 03:30:29 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C3A7C1C7FA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 00:30:24 -0800 (PST)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3168UIbo006320;
        Mon, 6 Feb 2023 09:30:18 +0100
Date:   Mon, 6 Feb 2023 09:30:18 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Vincent Dagonneau <v@vda.io>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] tools/nolibc: Adding stdint.h, more integer types
 and tests
Message-ID: <Y+C6mj4F77U43atS@1wt.eu>
References: <20230206013248.471664-1-v@vda.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206013248.471664-1-v@vda.io>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent,

On Sun, Feb 05, 2023 at 08:32:45PM -0500, Vincent Dagonneau wrote:
> Hi,
> 
> This is version 3 of my patch to add stdint.h to nolibc. Previous
> versions of this patch are available here:
> 
> * v2: https://lore.kernel.org/all/20230202201101.43160-1-v@vda.io/
> * v1: https://lore.kernel.org/all/20230202160236.25342-1-v@vda.io/
> 
> This version should address most of the concerns raised by Willy on the
> previous version (missing LL, ULL suffixes, uintptr/size_max size).

OK thank you, that's much better already. I'm still having a few comments:
  - please avoid the present participle in the subjects of your commits,
    the imperative form is generally preferred (e.g: "add foo" instead of
    "adding foo").

  - do not forget your signed-off-by on patches.

  - 3rd commit had an empty message. There's always something to say
    about a change, at least why and what it provides.

  - You still have this definition which is only valid for 64-bit,
    you will need to move it to your ifdef __WORDSIZE block to adjust
    it based on the word size:

    #define         SIZE_MAX UINT64_MAX

    Maybe this one should also be part of the tests ?

> I tested it successfully on x86_64 and arm64 (on qemu). I have some
> trouble setting up my cross compilation chain for i386, arm and mips
> however.

What compilers do you use ? I'm using version 11.3 from these ones:

  https://mirrors.edge.kernel.org/pub/tools/crosstool/

All supported archs work fine for me. Usually on x86_64 you can even
start the i386 binaries locally (if your kernel has COMPAT or COMPAT_32
built in, which is most often the case). And very commonly arm64 support
armv7 binaries as well.

Just let me know if I can help you set up your environment, it's always
a good long-term investment!

Regards,
Willy
