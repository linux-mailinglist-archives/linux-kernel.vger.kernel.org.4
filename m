Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BB075001C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjGLHfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjGLHfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:35:12 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FEE49;
        Wed, 12 Jul 2023 00:35:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CB0AD22594;
        Wed, 12 Jul 2023 07:35:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689147309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZ2bZ81Z3Yq2Og22w7MZ8KBK5/vLlKpOWbCzlQnvBgo=;
        b=fUOt+kc2pNRTHvtm9KJCQ9R4oVlVfMT8pBGzbpqaYVp4jKE5uBcl4jsooYLuez6Vi2zh2Y
        0PYKDmJwf86IyvqbIkPksI8zHIratqswd5Lo4uwBeLJQ5gMFYB/9pFWMvORxUDNFkcaJ6m
        9rN2/7iqiNzguwe703AczFWY/RtttYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689147309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZ2bZ81Z3Yq2Og22w7MZ8KBK5/vLlKpOWbCzlQnvBgo=;
        b=5kufGYXVf+Fg36xCOYKENxSaWoxVEIdSlp4TAO9rISt2g8vzs97fzLXWpGQOXyZSQkEW00
        hP+/G5l9WqvU0iBw==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 59CBE2C142;
        Wed, 12 Jul 2023 07:35:09 +0000 (UTC)
Date:   Wed, 12 Jul 2023 09:35:08 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] libkmod, depmod: Load modprobe.d, depmod.d from
 $prefix/lib.
Message-ID: <20230712073508.GD9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230711153126.28876-3-msuchanek@suse.de>
 <23779aa4-e1c1-c311-5f6b-8be652826cc7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23779aa4-e1c1-c311-5f6b-8be652826cc7@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Jul 12, 2023 at 08:47:20AM +0200, Jiri Slaby wrote:
> On 11. 07. 23, 17:31, Michal Suchanek wrote:
> > There is an ongoing effort to limit use of files outside of /usr (or
> > $prefix on general). Currently all modprobe.d paths are hardcoded to
> > outside of $prefix. Teach kmod to load modprobe.d from $prefix/lib.
> > 
> > On some distributions /usr/lib and /lib are the same directory because
> > of a compatibility symlink, and it is possible to craft configuration
> > files with sideeffects that would behave differently when loaded twice.
> > However, the override semantic ensures that one 'overrides' the other,
> > and only one configuration file of the same name is loaded from any of
> > the seach directories.
> 
> search
> 
> ...
> > --- a/man/Makefile.am
> > +++ b/man/Makefile.am
> > @@ -17,9 +17,14 @@ EXTRA_DIST = $(MAN5:%.5=%.xml) $(MAN8:%.8=%.xml)
> >   CLEANFILES = $(dist_man_MANS)
> >   %.5 %.8: %.xml
> > -	$(AM_V_XSLT)$(XSLT) \
> > +	$(AM_V_XSLT)if [ -n '$(prefix)' ] ; then \
> > +		sed -e 's|@PREFIX@|$(prefix)|g' $< ; \
> 
> Hmm, if prefix is empty, this will remove @PREFIX@. So why you need this
> 'if' at all?

It removes the whole duplicate line.

Thanks

Michal

> 
> > +	else \
> > +		sed -e '/@PREFIX@/d' $< ; \
> > +	fi | \
> 
> 
> -- 
> js
> suse labs
> 
