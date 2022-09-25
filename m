Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0795E90F2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 06:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiIYEUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 00:20:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiIYEUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 00:20:52 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 929123B96F
        for <linux-kernel@vger.kernel.org>; Sat, 24 Sep 2022 21:20:50 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 28P4KVjR009882;
        Sun, 25 Sep 2022 06:20:31 +0200
Date:   Sun, 25 Sep 2022 06:20:31 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Unable bisect issue because kernel not building from old commits
Message-ID: <20220925042031.GA9845@1wt.eu>
References: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 03:22:10AM +0500, Mikhail Gavrilov wrote:
> Hi!
> I want to make bisect between commits fdaf9a5840ac and babf0bb978e3,
> because after commit babf0bb978e3 Wi-Fi (mt7921e) upload speed became
> limited to 170Mbps. On commit fdaf9a5840ac upload speed was 784Mbps.
> 
> But I ran into a problem that the gcc-12.2.1 compiler on my
> distribution (Fedora) can't build the kernel from old commits. The
> build fails with the following error:
> ld: warning: arch/x86/power/hibernate_asm_64.o: missing
> .note.GNU-stack section implies executable stack
(...)

Note that this looks more related to binutils here. Regardless, there
are pre-built toolchains including compiler+binutils for various gcc
versions from 4.9 and up here, for all supported architectures:

   https://mirrors.edge.kernel.org/pub/tools/crosstool/

These ones are sufficient to build a kernel and are likely easier to
deal with than trying to port a patch over a bisect session. For example
you could have luck with 7.5 which has been supported for a very long
time and still is supported.

Hoping this helps,
Willy
