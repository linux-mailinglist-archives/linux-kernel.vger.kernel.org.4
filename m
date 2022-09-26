Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01B5EAE32
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiIZR3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiIZR3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:29:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C48D12EDB9;
        Mon, 26 Sep 2022 09:47:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EAB561046;
        Mon, 26 Sep 2022 16:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570B8C433D6;
        Mon, 26 Sep 2022 16:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664210823;
        bh=pllqmpbENCp1sBAaSJobpSEIC+YpKgpQi47z6PgaasU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYuMgLFP5IBHzKaNKaPJqy0L9us7bEOTbUiF77cEUtsP1gDW2eJtQJ2z2RHEMHaGt
         VakeALZqqpryzrZ4TrR1VhNvZaJwlUbc5qZ2b1YUIJ/juTrmtiTENpBp4IWnM/jRXm
         GvG/LYxfWTLyWBE4poiaGJmLNZ539Ntff8/PG2Cc=
Date:   Mon, 26 Sep 2022 18:47:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux MM <linux-mm@kvack.org>
Subject: Re: [PATCH v4 02/18] a.out: remove define-only CMAGIC, previously
 magic number
Message-ID: <YzHXhbO/UI3uHucA@kroah.com>
References: <YyMlovoskUcHLEb7@kroah.com>
 <9cbea062df7125ef43e2e0b2a67ede6ad1c5f27e.1663280877.git.nabijaczleweli@nabijaczleweli.xyz>
 <CAMuHMdWxf=+CnwXT61VvYhcHi093rz=0ftWQXKVviMunzE1HHw@mail.gmail.com>
 <20220926151554.7gxd6unp5727vw3c@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220926151554.7gxd6unp5727vw3c@tarta.nabijaczleweli.xyz>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:15:54PM +0200, наб wrote:
> Hi!
> 
> On Mon, Sep 26, 2022 at 10:16:02AM +0200, Geert Uytterhoeven wrote:
> > Thanks for your patch, which is now commit 53c2bd679017277f
> > ("a.out: remove define-only CMAGIC, previously magic number") in
> > driver-core/driver-core-next.
> > 
> > On Fri, Sep 16, 2022 at 12:40 AM наб <nabijaczleweli@nabijaczleweli.xyz> wrote:
> > > The last user was removed in 5.1 in
> > > commit 08300f4402ab ("a.out: remove core dumping support")
> > > but this is part of the UAPI headers, so this may want to either wait
> > > until a.out is removed entirely, or be removed from the magic number doc
> > > and silently remain in the header
> > 
> > Indeed. This is part of uapi, and might break some unknown
> > userspace, while the gain is limited.  Do we really want to reduce
> > include/uapi/linux/a.out.h piecewise (e.g. N_BADMAG() seems to be
> > unused, too), instead of keeping it until a.out support is removed
> > completely?
> 
> Not really, but it looked like a magic number in the magic-number.rst
> sense due to the field being "magic" and the unintuitive type naming:
> I hadn't realised it's part of the on-disk format
> re-examination shows that it very well may be (have been).
> 
> > Anyway, even at that point, it might be wise to keep the header file
> > around, as people have expressed the desire to run a.out binaries
> > through a userspace-compatibility wrapper.
> 
> Agreed. Scissor-patch that reverts the removal below.
> 
> > > A cursory glance on DCS didn't show any user code actually using this
> > > value
> > 
> > What is DCS?
> 
> Debian Code Search; in this case my query was:
>   https://codesearch.debian.net/search?q=%5CbCMAGIC%5Cb&literal=0
> 
> There's a few false positives here but all results that are using CMAGIC
> to mean this CMAGIC (and aren't hurd code copied from linux)
> just re-define it.
> 
> > >  Documentation/process/magic-number.rst                    | 1 -
> > >  Documentation/translations/it_IT/process/magic-number.rst | 1 -
> > >  Documentation/translations/zh_CN/process/magic-number.rst | 1 -
> > >  Documentation/translations/zh_TW/process/magic-number.rst | 1 -
> > >  include/uapi/linux/a.out.h                                | 3 ---
> > >  5 files changed, 7 deletions(-)
> > > 
> > > diff --git a/include/uapi/linux/a.out.h b/include/uapi/linux/a.out.h
> > > index 5fafde3798e5..bb15da96df2a 100644
> > > --- a/include/uapi/linux/a.out.h
> > > +++ b/include/uapi/linux/a.out.h
> > > @@ -70,9 +70,6 @@ enum machine_type {
> > >     The first page is unmapped to help trap NULL pointer references */
> > >  #define QMAGIC 0314
> > >
> > > -/* Code indicating core file.  */
> > > -#define CMAGIC 0421
> > > -
> > >  #if !defined (N_BADMAG)
> > >  #define N_BADMAG(x)      (N_MAGIC(x) != OMAGIC         \
> > >                         && N_MAGIC(x) != NMAGIC         \
> > 
> > Gr{oetje,eeting}s,
> >                         Geert
> 
> Best,
> наб
> 
> -- >8 --
> Subject: [PATCH] a.out: restore CMAGIC
> 
> Part of UAPI and the on-disk format:
> this means that it's not a magic number per magic-number.rst,
> and it's best to leave it untouched to avoid breaking userspace
> and suffer the same fate as a.out in general
> 
> Fixes: commit 53c2bd679017 ("a.out: remove define-only CMAGIC,
>  previously magic number")
> Signed-off-by: Ahelenia Ziemiańska <nabijaczleweli@nabijaczleweli.xyz>
> ---
>  include/uapi/linux/a.out.h | 3 +++
>  1 file changed, 3 insertions(+)

Thanks, I'll take this through my tree as it has the offending commit in
it.

greg k-h
