Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08DEA6A9F8B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:49:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjCCStO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbjCCStL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:49:11 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00DA05585
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 10:48:51 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 323Imihg032215
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Mar 2023 13:48:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677869325; bh=bDj2qFEVaDFepzsMbUQBiP7to8SePon9vUB3eBFG99U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=hyKDcdkrojaRaHfCgAmfrMRaL5IMF7i1NSDn7810f1ELBgeSTQ1pVkeDp7aoyWGws
         EluYbuXjauFsGVpSGRBouyNJ4cqjSGvXSW8yTKhzB8P5XM8d/BgbrrspWM6zsa1GPq
         tS0Ksp+vMPeZIgaTP4suxdACeHr1of8HkJBbWvJHLVK79I12zJLI6iMhR+bw0Q06+n
         Y270414MqqiAhGPUiEkgaz8Z9Sji3Z/r2szNtBDW8Vrf9z3lZWBFu27DzQskSIBpxi
         IHBSaOEwk2Cdc02fipT3DMxbVbOYVlYw20Tt4RbiiT0EbS9OAi8nj/P5d4nxPUDndN
         Dc6nM+vYKDTWQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0B18A15C33A7; Fri,  3 Mar 2023 13:48:44 -0500 (EST)
Date:   Fri, 3 Mar 2023 13:48:44 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Nick Terrell <terrelln@meta.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Terrell <nickrterrell@gmail.com>
Subject: Re: [GIT PULL] zstd changes for v6.3-rc1
Message-ID: <ZAJBDEQv+L6e0Ig4@mit.edu>
References: <C8C4DFDA-998F-48AD-93C9-DE16F8080A02@meta.com>
 <CAHk-=wghhViNZCj4ibSr42HjVGdHro_DWW7wCOQ61p2v59cciw@mail.gmail.com>
 <4BA6A759-F69C-406E-9D29-EDCC9B48F798@meta.com>
 <CAHk-=wjCNtTJ3DrG1266xXPZF=qH=GvpWApkYStJ9knskRnU3w@mail.gmail.com>
 <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B90FACE-74EB-47C8-91FD-62E3F77B95EC@meta.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 03, 2023 at 06:03:50PM +0000, Nick Terrell wrote:
> 
> What do you prefer I do with my current tree? I guess I can either:
> - Leave the merges in and keep a stable tree
> - Fix up my tree and clean up the merges, but break the stable tree

Do you have any downstream trees that depend on your tree?  If you
don't anyone who might be using your tree as a base for forther work
(linux-next doesn't count, since it rewinds every working day).

In general, for most "leaf" trees, rewinding your branches is not a
big deal.  There are some people who worship at the altar of "stable
git branches which never be rewound, forever and ever, Amen".  But
that is really a religious belief, and it's one that I don't subscribe
to.

Sure, if someone is depending on your git tree then rewinding the
branch can cause them problems.  But not all subsystem trees are used
by others as a basis for further work!  There are benefits to
rewinding / rebasing patches; sometimes I'll do rewind the ext4 dev
branch to add a "Tested-By", or to drop a patch which I had merged,
but then later on I discovered that it causes regressions.  In that
case, I'll drop the patch using git rebase -i since it can make life
easier who are doing git bisects.

Cheers,

					- Ted
