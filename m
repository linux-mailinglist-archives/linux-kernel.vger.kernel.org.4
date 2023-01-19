Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADD9673D4E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjASPTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbjASPTD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:19:03 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69228102C;
        Thu, 19 Jan 2023 07:19:01 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 159C13FBA6;
        Thu, 19 Jan 2023 15:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1674141540; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blyh4F6YIPd83bc9ZsTz1gC1AOEbrks+HSyE4iFGx9k=;
        b=MP2LDF3yx8TEIh3fADMhFa+a/auaOINU/0J1rlhw3mzqPqwt3QK6fI7Ucmcs3y9B/UJKXB
        eMp5Z7mxxODX6k2cUmcH/sxC3RMT7trXy2YVADUDk7T1eBXqjhB2y6F48r9HWG7FuG8sHZ
        Edlma/sE8KtTqSuBov5qRz/dpMR53RM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1674141540;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=blyh4F6YIPd83bc9ZsTz1gC1AOEbrks+HSyE4iFGx9k=;
        b=BwEy8wu90TO0wfPnVi88AKZO2d3X2n2DpfGeZufKFrGknIf0EVn8zMTjxhFHsxeLLbabqj
        Q0//Yl8rqHyrGCAA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CD2442C141;
        Thu, 19 Jan 2023 15:18:58 +0000 (UTC)
Date:   Thu, 19 Jan 2023 16:18:57 +0100
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Gary Guo <gary@garyguo.net>
Cc:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Kees Cook <keescook@chromium.org>,
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
Message-ID: <20230119151857.GQ16547@kitsune.suse.cz>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <20230112214059.o4vq474c47edjup6@ldmartin-desk2>
 <20230113181841.4d378a24.gary@garyguo.net>
 <20230117175144.GI16547@kitsune.suse.cz>
 <20230117192059.z5v5lfc2bzxk4ad2@ldmartin-desk2.lan>
 <20230119150936.30811312.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119150936.30811312.gary@garyguo.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:09:36PM +0000, Gary Guo wrote:
> On Tue, 17 Jan 2023 11:22:45 -0800
> Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> 
> > On Tue, Jan 17, 2023 at 06:51:44PM +0100, Michal Suchánek wrote:
> > >Hello,
> > >
> > >On Fri, Jan 13, 2023 at 06:18:41PM +0000, Gary Guo wrote:  
> > >> On Thu, 12 Jan 2023 14:40:59 -0700
> > >> Lucas De Marchi <lucas.demarchi@intel.com> wrote:
> > >>  
> > >> > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:  
> > >> > >
> > >> > > struct modversion_info {
> > >> > >-	unsigned long crc;
> > >> > >-	char name[MODULE_NAME_LEN];
> > >> > >+	/* Offset of the next modversion entry in relation to this one. */
> > >> > >+	u32 next;
> > >> > >+	u32 crc;
> > >> > >+	char name[0];  
> > >> >
> > >> > although not really exported as uapi, this will break userspace as this is
> > >> > used in the  elf file generated for the modules. I think
> > >> > this change must be made in a backward compatible way and kmod updated
> > >> > to deal with the variable name length:
> > >> >
> > >> > kmod $ git grep "\[64"
> > >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint32_t)];
> > >> > libkmod/libkmod-elf.c:  char name[64 - sizeof(uint64_t)];
> > >> >
> > >> > in kmod we have both 32 and 64 because a 64-bit kmod can read both 32
> > >> > and 64 bit module, and vice versa.
> > >> >  
> > >>
> > >> Hi Lucas,
> > >>
> > >> Thanks for the information.
> > >>
> > >> The change can't be "truly" backward compatible, in a sense that
> > >> regardless of the new format we choose, kmod would not be able to decode
> > >> symbols longer than "64 - sizeof(long)" bytes. So the list it retrieves
> > >> is going to be incomplete, isn't it?
> > >>
> > >> What kind of backward compatibility should be expected? It could be:
> > >> * short symbols can still be found by old versions of kmod, but not
> > >>   long symbols;  
> > >
> > >That sounds good. Not everyone is using rust, and with this option
> > >people who do will need to upgrade tooling, and people who don't care
> > >don't need to do anything.  
> > 
> > that could be it indeed. My main worry here is:
> > 
> > "After the support is added in kmod, kmod needs to be able to output the
> > correct information regardless if the module is from before/after the
> > change in the kernel and also without relying on kernel version."
> > Just changing the struct modversion_info doesn't make that possible.
> > 
> > Maybe adding the long symbols in another section?
> 
> Yeah, that's what I imagined how it could be implemented when I said
> "short symbols can still be found by old versions of kmod, but not long
> symbols".
> 
> > Or ble just increase to 512 and add the size to a
> > "__versions_hdr" section. If we then output a max size per module,
> > this would offset a little bit the additional size gained for the
> > modules using rust.
> 
> That format isn't really elegant IMO. And symbol length can vary a lot,
> having all symbols dictated by the longest symbol doesn't sound a good
> approach.
> 
> > And the additional 0's should compress well
> > so I'm not sure the additional size is that much relevant here.
> 
> I am not sure why compression is mentioned here. I don't think section
> in .ko files are compressed.

There is the option to compress the whole .ko files, and it's commonly
used.

Thanks

Michal
