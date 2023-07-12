Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25290750032
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 09:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjGLHif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 03:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjGLHiY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 03:38:24 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2B01987;
        Wed, 12 Jul 2023 00:38:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F3DDE225A4;
        Wed, 12 Jul 2023 07:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689147499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haszkyxt6U9I4qJOD2FSTDPcnP+kRqUlAiag7JbTgA4=;
        b=RNE4FWJrak2AX66RAbfeLRsBsvGzBpfea8WKV8QtEDBxTN8T53olIOb9pWNQnDqunOBiav
        xy4dJwUY9IZ+BBsvWHGSQ4uzaSgTPFbICqAprflcrBigmSzHN3D9VPC55te7UI9hZm6Pee
        n+O+EORlSB26dU6cL30IFpNWnsIkaYs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689147499;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=haszkyxt6U9I4qJOD2FSTDPcnP+kRqUlAiag7JbTgA4=;
        b=Rc5UN3qAe5VIs3n2Nq5Sctxt/v0pLuAjXYc5vKvTT1HRZGn6Twvn1jGdlJxO0unupY3ebK
        ivcfaZRjLpX+IHAg==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A59EA2C142;
        Wed, 12 Jul 2023 07:38:18 +0000 (UTC)
Date:   Wed, 12 Jul 2023 09:38:17 +0200
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
Subject: Re: [PATCH] depmod: Handle installing modules under a prefix
Message-ID: <20230712073817.GE9196@kitsune.suse.cz>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230711153457.29497-1-msuchanek@suse.de>
 <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da2fdd15-fae1-2bf6-04e7-568c715372ce@kernel.org>
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

On Wed, Jul 12, 2023 at 07:47:13AM +0200, Jiri Slaby wrote:
> On 11. 07. 23, 17:34, Michal Suchanek wrote:
> > Some distributions aim at not shipping any files in / ustside of usr.
> > 
> > The path under which kernel modules are instaleld is hardcoded to /lib
> > which conflicts with this goal.
> > 
> > When kmod provides the config command use it to determine the correct
> > module installation prefix.
> > 
> > On kmod that does not provide the command / is used as before.
> > 
> > Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> > ---
> >   Makefile          | 4 +++-
> >   scripts/depmod.sh | 8 ++++----
> >   2 files changed, 7 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Makefile b/Makefile
> > index 47690c28456a..b05d696f06bd 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -1165,7 +1165,9 @@ export INSTALL_DTBS_PATH ?= $(INSTALL_PATH)/dtbs/$(KERNELRELEASE)
> >   # makefile but the argument can be passed to make if needed.
> >   #
> > -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
> > +export KERNEL_MODULE_PREFIX := $(shell kmod config | jq -r .module_prefix)
> 
> echo -e 'KERNEL_MODULE_PREFIX := $(shell kmod config | jq -r
> .module_prefix)\nall:'|make -f -
> invalid command 'config'
> parse error: Invalid numeric literal at line 1, column 5
> 
> I think you should pipe kmod's 2> /dev/null to support older kmod. Ah, but
> you'd need 2> /dev/null for jq too. That would not be good as jq might not
> be installed and a user wouldn't see the error. So instead, I would do:
> 
> $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)

Yes, that sounds reasonable. Also would cover the potential problem of
kmod changing the error output into something that is a valid JSON in
the future.

Thanks

Michal
