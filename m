Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE16E5E956F
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIYSnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiIYSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:43:46 -0400
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 675BE2B61E
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 11:43:45 -0700 (PDT)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 28PIhXrm013995;
        Sun, 25 Sep 2022 20:43:33 +0200
Date:   Sun, 25 Sep 2022 20:43:33 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     ast@kernel.org, yhs@fb.com, sean.wang@mediatek.com,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Unable bisect issue because kernel not building from old commits
Message-ID: <20220925184333.GA13967@1wt.eu>
References: <CABXGCsN8LHqz7=OSvBpKCqKdV4L_4FPXtQ32bgYveA9yP2_xiQ@mail.gmail.com>
 <20220925042031.GA9845@1wt.eu>
 <CABXGCsOsm_QtFjd9KCYOc3E_4Tn_EVDhWifOPMU7_PZ7MC2big@mail.gmail.com>
 <20220925152142.GA13116@1wt.eu>
 <CABXGCsN532FpFraXu_DiA4_SiRRXqy6zL0AD+oV0c5er4DJQJQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsN532FpFraXu_DiA4_SiRRXqy6zL0AD+oV0c5er4DJQJQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 25, 2022 at 09:13:13PM +0500, Mikhail Gavrilov wrote:
> On Sun, Sep 25, 2022 at 8:21 PM Willy Tarreau <w@1wt.eu> wrote:
> > Just add:
> >
> >    CROSS_COMPILE=/path/to/toolchain/bin/prefix-
> >
> > to your make command line and it will be fine.
> >
> > The makefile will append {gcc,ld,...} to this CROSS_COMPILE prefix to
> > construct the full pathname to the binaries.
> 
> It works!
> But I hit another build issue.
> 
> $ make clean &&
> CROSS_COMPILE=~/Downloads/x86_64-gcc-7.5.0-nolibc-x86_64-linux/gcc-7.5.0-nolibc/x86_64-linux/bin/x86_64-linux-
> make -j32 bzImage
> ***
>   GEN     modules.builtin
>   LD      .tmp_vmlinux.btf
>   BTF     .btf.vmlinux.bin.o
>   LD      .tmp_vmlinux.kallsyms1
>   KSYMS   .tmp_vmlinux.kallsyms1.S
>   AS      .tmp_vmlinux.kallsyms1.S
>   LD      .tmp_vmlinux.kallsyms2
>   KSYMS   .tmp_vmlinux.kallsyms2.S
>   AS      .tmp_vmlinux.kallsyms2.S
>   LD      vmlinux
>   BTFIDS  vmlinux
> FAILED: load BTF from vmlinux: Invalid argument
> make: *** [Makefile:1159: vmlinux] Error 255
> make: *** Deleting file 'vmlinux'

This was reported and addressed a month ago:

    https://lore.kernel.org/bpf/20220825171620.cioobudss6ovyrkc@altlinux.org/t/#m24a9de4b8cc11eb9c3bbed022487d6de0d42ea4b

In short if you don't need XDP you could possibly disable
CONFIG_DEBUG_INFO_BTF, otherwise you may have to rebuild the latest
pahole utility that seems to be involved in this. But I never faced
this issue so I can only recommend hints about things to look at,
and could be wrong.

Willy
