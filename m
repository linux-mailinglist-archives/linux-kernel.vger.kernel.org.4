Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A72F6BBE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:01:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbjCOVBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjCOVAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:00:47 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F9EA3B72
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:00:14 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 32EEF3F22A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 21:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1678914008;
        bh=zdwx6M/JbknSrZOPuUmX+X1ZToD3o5X5kpbZBrzkyfo=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=MCLA24rNkmaGoliI7XqYqG/76mJTrrA731yICcnTvaM27mHzZqLL+Mn68rVmqLT7K
         usRvhLNRnaxRbFMaUg8EK764dJKx5pfv/XxEy5MtUd3bPlarCelMmpDE/o8Lfmct4G
         L8QBiIJKDnfwa2GSK5g6hx5w4Z34kFzTKYahwGZ6cFD2DOnMhU1FTJRptpM/IBxvTX
         VuAx4rs+tBCrqOxzt2dNHBPcUXZNlbTz4TA0Ul+SHSx4QaZpyaomUTiiSow8A9uxe/
         oCirKhkdJOqvItGo5pLp6dPaEy3sSTssDa3+cWOV4iX1fKMnhp7uI7x7bDpto46ULE
         eRK15YpfPt7pQ==
Received: by mail-ed1-f70.google.com with SMTP id z14-20020a05640235ce00b004e07ddbc2f8so28474217edc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:00:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678914007;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zdwx6M/JbknSrZOPuUmX+X1ZToD3o5X5kpbZBrzkyfo=;
        b=6metGRrwWhQHB6T9IXQI0A+zFRj6pYmPDboCUBDvk7O529bIoaNEeGYLvt+AeSSMwe
         7T4Xomr4Z2vBvxi51980ez5rP+YOdKJXG7ppXj+qs96soEQd3Jccr/zKa3DbzQTFcnxR
         AXIlToQQc3CwyOxm6YmxZF6uyDEQgZfcsJ0dN9GG1SbCZCTCK/hVX3OZxUlswkOqQ2F1
         6L8n9vSNKG032mdJ3RlkXqEbBoDUQSPyItlQDJd9wQdvaW59lgedtvfeRqb66Qfxq7/5
         BvQ3zXCtpsEdWMJDNEo0HqjSF66oM4tEq0iaBPXnjcNZMtez8E25uMVcQcznMaaUJcVE
         fymw==
X-Gm-Message-State: AO0yUKW/hO44weFHJS3hr+K4GFyW11ATIhAWy3BMoE18i+z94WVl7w4A
        j2dhp8N7Sw2yoNXaivqw7QH5kxZzqX2oVIoV14ud90STVg9JIkbWTHMJJsWy6aC3kPAzlkazJKm
        buOMFp8x43TPz4A7a/DaEtCgMj5XOQ7WQXz3mFZ9/Hw==
X-Received: by 2002:a17:907:8b8a:b0:92e:d6e6:d8a4 with SMTP id tb10-20020a1709078b8a00b0092ed6e6d8a4mr3867315ejc.44.1678914007547;
        Wed, 15 Mar 2023 14:00:07 -0700 (PDT)
X-Google-Smtp-Source: AK7set9mB9S8xRvnBB1zzDi9BW9rOiWn+ziEourEALOSEnHHImACZMzByaelkYeqiR2FofMxj4kAzQ==
X-Received: by 2002:a17:907:8b8a:b0:92e:d6e6:d8a4 with SMTP id tb10-20020a1709078b8a00b0092ed6e6d8a4mr3867282ejc.44.1678914007175;
        Wed, 15 Mar 2023 14:00:07 -0700 (PDT)
Received: from localhost (host-79-53-23-214.retail.telecomitalia.it. [79.53.23.214])
        by smtp.gmail.com with ESMTPSA id lm15-20020a170906980f00b0093034e71b94sm85310ejb.65.2023.03.15.14.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 14:00:06 -0700 (PDT)
Date:   Wed, 15 Mar 2023 22:00:06 +0100
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        Gary Guo <gary@garyguo.net>, Kees Cook <keescook@chromium.org>,
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
Message-ID: <ZBIx1mgA8n7Z28Aa@righiandr-XPS-13-7390>
References: <20230111161155.1349375-1-gary@garyguo.net>
 <ZA+IUIOAgrWH2oZ0@righiandr-XPS-13-7390>
 <20230313214853.GY19419@kitsune.suse.cz>
 <ZA+bXi0o27XPx3nz@righiandr-XPS-13-7390>
 <20230313220234.GZ19419@kitsune.suse.cz>
 <ZA+fGpAdnvB5VwKW@righiandr-XPS-13-7390>
 <ZBCG3ykG1q4GEcIf@righiandr-XPS-13-7390>
 <CAK7LNASSxfEPp+e1=sP0FAYLMXjyT7T5iqe8=UJB+XNYMt6ogQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASSxfEPp+e1=sP0FAYLMXjyT7T5iqe8=UJB+XNYMt6ogQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 01:18:23AM +0900, Masahiro Yamada wrote:
> On Tue, Mar 14, 2023 at 11:38 PM Andrea Righi
> <andrea.righi@canonical.com> wrote:
> >
> > On Mon, Mar 13, 2023 at 11:09:31PM +0100, Andrea Righi wrote:
> > > On Mon, Mar 13, 2023 at 11:02:34PM +0100, Michal Suchánek wrote:
> > > > On Mon, Mar 13, 2023 at 10:53:34PM +0100, Andrea Righi wrote:
> > > > > On Mon, Mar 13, 2023 at 10:48:53PM +0100, Michal Suchánek wrote:
> > > > > > Hello,
> > > > > >
> > > > > > On Mon, Mar 13, 2023 at 09:32:16PM +0100, Andrea Righi wrote:
> > > > > > > On Wed, Jan 11, 2023 at 04:11:51PM +0000, Gary Guo wrote:
> > > > > > > > Currently modversion uses a fixed size array of size (64 - sizeof(long))
> > > > > > > > to store symbol names, thus placing a hard limit on length of symbols.
> > > > > > > > Rust symbols (which encodes crate and module names) can be quite a bit
> > > > > > > > longer. The length limit in kallsyms is increased to 512 for this reason.
> > > > > > > >
> > > > > > > > It's a waste of space to simply expand the fixed array size to 512 in
> > > > > > > > modversion info entries. I therefore make it variably sized, with offset
> > > > > > > > to the next entry indicated by the initial "next" field.
> > > > > > > >
> > > > > > > > In addition to supporting longer-than-56/60 byte symbols, this patch also
> > > > > > > > reduce the size for short symbols by getting rid of excessive 0 paddings.
> > > > > > > > There are still some zero paddings to ensure "next" and "crc" fields are
> > > > > > > > properly aligned.
> > > > > > > >
> > > > > > > > This patch does have a tiny drawback that it makes ".mod.c" files generated
> > > > > > > > a bit less easy to read, as code like
> > > > > > > >
> > > > > > > >     "\x08\x00\x00\x00\x78\x56\x34\x12"
> > > > > > > >     "symbol\0\0"
> > > > > > > >
> > > > > > > > is generated as opposed to
> > > > > > > >
> > > > > > > >     { 0x12345678, "symbol" },
> > > > > > > >
> > > > > > > > because the structure is now variable-length. But hopefully nobody reads
> > > > > > > > the generated file :)
> > > > > > > >
> > > > > > > > Link: b8a94bfb3395 ("kallsyms: increase maximum kernel symbol length to 512")
> > > > > > > > Link: https://github.com/Rust-for-Linux/linux/pull/379
> > > > > > > >
> > > > > > > > Signed-off-by: Gary Guo <gary@garyguo.net>
> > > > > > >
> > > > > > > Is there any newer version of this patch?
> > > > > > >
> > > > > > > I'm doing some tests with it, but I'm getting boot failures on ppc64
> > > > > > > with this applied (at boot kernel is spitting out lots of oops'es and
> > > > > > > unfortunately it's really hard to copy paste or just read them from the
> > > > > > > console).
> > > > > >
> > > > > > Are you using the ELF ABI v1 or v2?
> > > > > >
> > > > > > v1 may have some additional issues when it comes to these symbol tables.
> > > > > >
> > > > > > Thanks
> > > > > >
> > > > > > Michal
> > > > >
> > > > > I have CONFIG_PPC64_ELF_ABI_V2=y in my .config, so I guess I'm using v2.
> > > > >
> > > > > BTW, the issue seems to be in dedotify_versions(), as a silly test I
> > > > > tried to comment out this function completely to be a no-op and now my
> > > > > system boots fine (but I guess I'm probably breaking something else).
> > > >
> > > > Probably not. You should not have the extra leading dot on ABI v2. So if
> > > > dedotify does something that means something generates and then expects
> > > > back symbols with a leading dot, and this workaround for ABI v1 breaks
> > > > that. Or maybe it is called when it shouldn't.
> > >
> > > Hm.. I'll add some debugging to this function to see what happens exactly.
> >
> > Alright I've done more tests across different architectures. My problem
> > with ppc64 is that this architecture is evaluating sechdrs[i].sh_size
> > using get_stubs_size(), that apparently can add some extra padding, so
> > doing (vers + vers->next < end) isn't a reliable check to determine the
> > end of the variable array, because sometimes "end" can be greater than
> > the last "vers + vers->next" entry.
> 
> 
> I am not familiar enough with ppc, so I may be misundering.
> 
> Checking the for-loop in module_frob_arch_sections(),
> they seem to be orthogonal to me.
> 
> dedotify_versions() is only called for the "__versions" section.
> get_stubs_size() only affects the ".stubs" section.
> I did not get how they are related to each other.
> 
> 
> BTW, we decided to not go in this direction in the former discussion.
> I am not sure how much effort is needed to track down the issue
> in this version.
> 
> If we add new sections to keep the backward compatibility
> for the current "__versions", this issue may not exist.

I think need to investigate more on this. But according to the results
(and some extra printk()'s that I added) it seems that sechdrs[].sh_size
is bigger than expected, so using that to determine the end of the array
is not reliable and it systematically breaks the boot on the ppc64
system that I'm currently using.

Anyway, I know that we decided to drop this approach, I'm actually using
this patch to see if we can enable CONFIG_MODVERSIONS with CONFIG_RUST
enabled, that's why I'm exploring the possibility to have a variable
length for module symbols.

Hopefully we'll come up with a proper approach/solution, because it'd be
really useful to have MODVERSIONS and RUST both enabled.

Thanks,
-Andrea
