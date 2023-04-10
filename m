Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9B916DCAE6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjDJSpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJSpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:45:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E5E10C7;
        Mon, 10 Apr 2023 11:45:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F1F7614B3;
        Mon, 10 Apr 2023 18:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E21C433D2;
        Mon, 10 Apr 2023 18:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681152349;
        bh=0n4eaHIxt403lbgomlAGAL123JZ2zK8IK+30XDNzj8Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6r13krDEDJEGWRefoOLT3kEnwfW2FpoNaRNtSbXyPwyPDVpS8vkoJS2IssSSPuIm
         ZHhVLn7Uj49zY/sThsvBPPJ02qxK7OEBBf42tjAMosD/yWsl6KFbsMie6IliwxlGpY
         I/0+W+cIrt2AW1Y8RpFV6jlT7X1XRFaS/wy8bAZ8=
Date:   Mon, 10 Apr 2023 20:45:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     John Moon <quic_johmoo@quicinc.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Todd Kjos <tkjos@google.com>,
        Matthias Maennich <maennich@google.com>,
        Giuliano Procida <gprocida@google.com>,
        kernel-team@android.com, libabigail@sourceware.org,
        Jordan Crouse <jorcrous@amazon.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Satya Durga Srinivasu Prabhala <quic_satyap@quicinc.com>,
        Elliot Berman <quic_eberman@quicinc.com>,
        Guru Das Srinagesh <quic_gurus@quicinc.com>
Subject: Re: [PATCH v5 1/2] check-uapi: Introduce check-uapi.sh
Message-ID: <2023041015-lunar-dandelion-1b4e@gregkh>
References: <20230407203456.27141-1-quic_johmoo@quicinc.com>
 <20230407203456.27141-2-quic_johmoo@quicinc.com>
 <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNAQQmoyUx+0Jk3c7iqY20KokrHEOPwHNb2doZOOA8RWBDA@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 07:03:05PM +0900, Masahiro Yamada wrote:
> On Sat, Apr 8, 2023 at 5:35 AM John Moon <quic_johmoo@quicinc.com> wrote:
> >
> > While the kernel community has been good at maintaining backwards
> > compatibility with kernel UAPIs, it would be helpful to have a tool
> > to check if a commit introduces changes that break backwards
> > compatibility.
> >
> > To that end, introduce check-uapi.sh: a simple shell script that
> > checks for changes to UAPI headers using libabigail.
> >
> > libabigail is "a framework which aims at helping developers and
> > software distributors to spot some ABI-related issues like interface
> > incompatibility in ELF shared libraries by performing a static
> > analysis of the ELF binaries at hand."
> >
> > The script uses one of libabigail's tools, "abidiff", to compile the
> > changed header before and after the commit to detect any changes.
> >
> > abidiff "compares the ABI of two shared libraries in ELF format. It
> > emits a meaningful report describing the differences between the two
> > ABIs."
> >
> > The script also includes the ability to check the compatibility of
> > all UAPI headers across commits. This allows developers to inspect
> > the stability of the UAPIs over time.
> >
> > Signed-off-by: John Moon <quic_johmoo@quicinc.com>
> 
> 
> 
> BTW, is there anybody (except the submitters) who loves this tool?
> (or anybody who has ever evaluated this?)

I evaluated the first one, and yes, I do want this, but I haven't tested
it out yet, sorry.

I get patches for header files all the time and hand-verifying that they
don't break the abi is a pain at times

> According to this tool, it looks like we broke a lot of UAPI
> headers in the previous MW (between v6.2 and v6.3-rc1).

That's not ok, and needs to be fixed, otherwise this is useless as no
one can rely on it at all.

> The script takes some time because it builds many objects
> internally.
> 
> However, once this script starts running, you must not hit Ctrl-C.
> If you do it, your repository will be sprinkled with a ton
> of untracked files.

That needs to be unwound and fixed.

> CAVEAT
> This tool runs 'git checkout' a couple of times internally.
> If you interrupt it, your worktree might be messed up.

ctrl-c can be properly caught and the git state needs to be restored for
this to be able to be accepted.

thanks,

greg k-h
