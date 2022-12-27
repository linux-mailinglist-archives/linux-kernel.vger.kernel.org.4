Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E904F656B9F
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 15:17:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiL0ORJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 09:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbiL0ORB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 09:17:01 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88D7C03;
        Tue, 27 Dec 2022 06:16:54 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EF4B71EC050B;
        Tue, 27 Dec 2022 15:16:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672150613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=kBEHov8GiuHZVSRwmfZJ+i0lEmdIM4JWeBRhJ7yjCN8=;
        b=k7bwio6FGvQaEIvfQs0wpX3K3TssYGLCN05DJRTiDz2Ql+2FB3gdWJoqZGVDSN1z/7h7co
        hp6LPYyjfs+EcooeqV4SQqLBPgHiVKKJZJUQ0NuvtYMthp1hYSypol6FFm7TizNj0bQ7+n
        lwL+hOJfcSl7oWZelKbjtvH/TJzgBoo=
Date:   Tue, 27 Dec 2022 15:16:49 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     kernel test robot <lkp@intel.com>
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        rust-for-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bp:tip-x86-alternatives 1/1] error[E0588]: packed type cannot
 transitively contain a `#[repr(align)]` type
Message-ID: <Y6r+UbfkXruwHU2v@zn.tnic>
References: <202212272003.rgQDX8DQ-lkp@intel.com>
 <Y6r4mXz5NS0+HVXo@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y6r4mXz5NS0+HVXo@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Resending because rust ML doesn't like big messages:

From: rust-for-linux-owner@vger.kernel.org
To: rust-for-linux-approval@vger.kernel.org, bp@alien8.de
Subject: BOUNCE rust-for-linux@vger.kernel.org:     Message too long (>100000 chars)

Rust folks, you can check out the whole thing here:

https://lore.kernel.org/all/202212272003.rgQDX8DQ-lkp@intel.com/

(and maybe raise the limit on that ML of yours :))

Thx.

On Tue, Dec 27, 2022 at 02:52:25PM +0100, Borislav Petkov wrote:
> On Tue, Dec 27, 2022 at 08:36:11PM +0800, kernel test robot wrote:
> > Hi Borislav,
> > 
> > FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.
> > 
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git tip-x86-alternatives
> > head:   82db736201e76889825efe8899ad55976111691a
> > commit: 82db736201e76889825efe8899ad55976111691a [1/1] x86/alternatives: Add alt_instr.flags
> > config: x86_64-rhel-8.3-rust
> > compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git/commit/?id=82db736201e76889825efe8899ad55976111691a
> >         git remote add bp https://git.kernel.org/pub/scm/linux/kernel/git/bp/bp.git
> >         git fetch --no-tags bp tip-x86-alternatives
> >         git checkout 82db736201e76889825efe8899ad55976111691a
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 olddefconfig
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 prepare
> 
> These reproduction instructions look insufficient to me. The env needs a
> rust compiler installed. Which I don't have:
> 
> ./scripts/rust_is_available.sh -v
> ***
> *** Rust compiler '' could not be found.
> ***
> 
> Or does some of that make.cross magic install one? I don't see a "rustc"
> mentioned there at all but I see
> 
> CONFIG_RUSTC_VERSION_TEXT="rustc 1.62.0 (a8314ef7d 2022-06-27)"
> 
> in the .config so apparently that rustc thing has come from somewhere...
> 
> > If you fix the issue, kindly add following tag where applicable
> > | Reported-by: kernel test robot <lkp@intel.com>
> > 
> > All errors (new ones prefixed by >>):
> > 
> > >> error[E0588]: packed type cannot transitively contain a `#[repr(align)]` type
> 
> -ENOPARSE this error.
> 
> Lemme add rust and toolchain MLs to Cc and leave the rest for them with
> the hope that they can translate this linenoise for me.

Well, not leaving it because rust ML can't take such big emails.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
