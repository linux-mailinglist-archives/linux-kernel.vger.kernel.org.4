Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B73885E93E4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230379AbiIYPWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbiIYPV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:21:56 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE8632B268
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 08:21:54 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 28PFLgxA013152;
        Sun, 25 Sep 2022 17:21:42 +0200
Date:   Sun, 25 Sep 2022 17:21:42 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Unable bisect issue because kernel not building from old commits
Message-ID: <20220925152142.GA13116@1wt.eu>
References: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
 <20220925042031.GA9845@1wt.eu>
 <CABXGCsOsm_QtFjd9KCYOc3E_4Tn_EVDhWifOPMU7_PZ7MC2big@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsOsm_QtFjd9KCYOc3E_4Tn_EVDhWifOPMU7_PZ7MC2big@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 07:02:39PM +0500, Mikhail Gavrilov wrote:
> >
> > Note that this looks more related to binutils here. Regardless, there
> > are pre-built toolchains including compiler+binutils for various gcc
> > versions from 4.9 and up here, for all supported architectures:
> >
> >    https://mirrors.edge.kernel.org/pub/tools/crosstool/
> >
> > These ones are sufficient to build a kernel and are likely easier to
> > deal with than trying to port a patch over a bisect session. For example
> > you could have luck with 7.5 which has been supported for a very long
> > time and still is supported.
> 
> I don't quite understand how to switch to the downloaded binutils
> without breaking the distribution.
> I am building the kernel with the following command:
> $ make clean && make -j32 bzImage && make -j32 modules

Just add:

   CROSS_COMPILE=/path/to/toolchain/bin/prefix-

to your make command line and it will be fine.

The makefile will append {gcc,ld,...} to this CROSS_COMPILE prefix to
construct the full pathname to the binaries.

Willy
