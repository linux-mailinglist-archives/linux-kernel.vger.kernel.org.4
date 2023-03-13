Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCEB56B8474
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 23:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjCMWDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 18:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCMWDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 18:03:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226674DEE;
        Mon, 13 Mar 2023 15:02:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5E61022A43;
        Mon, 13 Mar 2023 22:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1678744956; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xA+zTTPoWvlR/egxj2ZKEaa5D9M1RLGPHFRhE5wTJYs=;
        b=ddvr7vTQvZPOgCaj3EsTEjt1bRZC5HtsRt91QHx9A6/OrljKcUeuKeihUQz5gZ09SzdUir
        tHgyoC+M4Qa7le80oGCB8g5+SGjOhLh+IjwgpS3OdTaQvChvJDD2/DSyiir/uOPiMCCM1K
        Z1Vws2e3pDYuZIkWJfw3aRVc1tIClnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1678744956;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xA+zTTPoWvlR/egxj2ZKEaa5D9M1RLGPHFRhE5wTJYs=;
        b=5XSgjw4YMeF5/eXmf3JO8dcMfDHM7MxbibcSjeUmCgXVR/J4+tssmbsS0ukOo/0h8ZmbnF
        WhVvZkU+j1t/4GDw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8C1122C141;
        Mon, 13 Mar 2023 22:02:35 +0000 (UTC)
Date:   Mon, 13 Mar 2023 23:02:34 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Joel Stanley <joel@jms.id.au>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org,
        Guo Zhengkui <guozhengkui@vivo.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] modpost: support arbitrary symbol length in modversion
Message-ID: <20230313220234.GZ19419@kitsune.suse.cz>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 10:53:34PM +0100, Andrea Righi wrote:
> On Mon, Mar 13, 2023 at 10:48:53PM +0100, Michal Suchánek wrote:
> > Hello,
> > 
> > On Mon, Mar 13, 2023 at 09:32:16PM +0100, Andrea Righi wrote:
> > > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> > > > Currently modversion uses a fixed size array of size (64 - sizeof(long))
> > > > to store symbol names, thus placing a hard limit on length of symbols.
> > > > Rust symbols (which encodes crate and module names) can be quite a bit
> > > > longer. The length limit in kallsyms is increased to 512 for this reason.
> > > > 
> > > > It's a waste of space to simply expand the fixed array size to 512 in
> > > > modversion info entries. I therefore make it variably sized, with offset
> > > > to the next entry indicated by the initial "next" field.
> > > > 
> > > > In addition to supporting longer-than-56/60 byte symbols, this patch also
> > > > reduce the size for short symbols by getting rid of excessive 0 paddings.
> > > > There are still some zero paddings to ensure "next" and "crc" fields are
> > > > properly aligned.
> > > > 
> > > > This patch does have a tiny drawback that it makes ".mod.c" files generated
> > > > a bit less easy to read, as code like
> > > > 
> > > > 	"\x08\x00\x00\x00\x78\x56\x34\x12"
> > > > 	"symbol\0\0"
> > > > 
> > > > is generated as opposed to
> > > > 
> > > > 	{ 0x12345678, "symbol" },
> > > > 
> > > > because the structure is now variable-length. But hopefully nobody reads
> > > > the generated file :)
> > > > 
> > > > Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
> > > > Link: https://github.com/Rust-for-Linux/linux/pull/379
> > > > 
> > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > 
> > > Is there any newer version of this patch?
> > > 
> > > I'm doing some tests with it, but I'm getting boot failures on ppc64
> > > with this applied (at boot kernel is spitting out lots of oops'es and
> > > unfortunately it's really hard to copy paste or just read them from the
> > > console).
> > 
> > Are you using the ELF ABI v1 or v2?
> > 
> > v1 may have some additional issues when it comes to these symbol tables.
> > 
> > Thanks
> > 
> > Michal
> 
> I have CONFIG_PPC64_ELF_ABI_V2=y in my .config, so I guess I'm using v2.
> 
> BTW, the issue seems to be in dedotify_versions(), as a silly test I
> tried to comment out this function completely to be a no-op and now my
> system boots fine (but I guess I'm probably breaking something else).

Probably not. You should not have the extra leading dot on ABI v2. So if
dedotify does something that means something generates and then expects
back symbols with a leading dot, and this workaround for ABI v1 breaks
that. Or maybe it is called when it shouldn't.

Thanks

Michal
