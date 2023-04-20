Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28A726E8DCD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 11:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233926AbjDTJTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 05:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjDTJTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 05:19:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96C4269E;
        Thu, 20 Apr 2023 02:19:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 841CF60E0B;
        Thu, 20 Apr 2023 09:19:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C25C433EF;
        Thu, 20 Apr 2023 09:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681982347;
        bh=qHtD05I9DtIrXUEFY7Dd2mg96rya3mStGLAMHcaWnkI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IMfeE1uNF2zfbsEa21IAv4i35TjuQe0x5Tr6cqyfq3qLxCJqjYAgfJOBZ4VMnj6pg
         64GQeVA8g4YRKlM7SDDszc81DCvKz4bq1P2qO5cMLXLb4yrmYWsVHjII9gCmp5MMQR
         Db0wX+T6+3DZkYWEJ7Yosa4ELiZcYW+FBuAFGRVThawBgJ4gX039gTkxVFvN+UAMIP
         jSZKPK/de9ccdxmUnw3w2/V8KTDTJJgsBMJYcTo/QVUaRnN3LJYWg2hFfL8+hUbOUL
         0O4wpX7m6t9xBcG921DVntHBGt0OPpAx28aqJh2INtvn5VtItf1VcgkQ8231o92RUQ
         E83WNTASUEx2g==
Date:   Thu, 20 Apr 2023 12:19:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     Nicolas Schier <n.schier@avm.de>,
        Tariq Toukan <ttoukan.linux@gmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nick Terrell <terrelln@fb.com>, dalevi@nvidia.com,
        Gal Pressman <gal@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Tariq Toukan <tariqt@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] kbuild: do not create intermediate *.tar for tar
 packages
Message-ID: <20230420091903.GB4423@unreal>
References: <20230407101629.1298051-1-masahiroy@kernel.org>
 <20230407101629.1298051-3-masahiroy@kernel.org>
 <20230407181223.GD1018455@dev-arch.thelio-3990X>
 <a42a2dc4-bcbc-7a19-b036-8722606a5eaf@gmail.com>
 <ZEEAfkOGyVs1KD5Z@buildd.core.avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEEAfkOGyVs1KD5Z@buildd.core.avm.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 11:06:06AM +0200, Nicolas Schier wrote:
> On Thu, Apr 20, 2023 at 11:54:34AM +0300, Tariq Toukan wrote:
> > 
> > 
> > On 07/04/2023 21:12, Nathan Chancellor wrote:
> > > On Fri, Apr 07, 2023 at 07:16:29PM +0900, Masahiro Yamada wrote:
> > > > Commit 05e96e96a315 ("kbuild: use git-archive for source package
> > > > creation") split the compression as a separate step to factor out
> > > > the common build rules.
> > > > 
> > > > With the previous commit, we got back to the situation where
> > > > compressed source tarballs are created by a single rule.
> > > > There is no reason to keep the separate compression rules.
> > > > 
> > > > Generate the comressed tar packages directly.
> > > > 
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > 
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > > 
> > 
> > Hi,
> > 
> > We started seeing the failure below in rc7.
> > We narrowed it down to your patches:
> > 
> > 3c65a2704cdd kbuild: do not create intermediate *.tar for tar packages
> > f8d94c4e403c kbuild: do not create intermediate *.tar for source tarballs
> > f6d8283549bc kbuild: merge cmd_archive_linux and cmd_archive_perf
> > aa7d233f45b4 kbuild: give up untracked files for source package builds

<...>

> > RPM build errors:
> >     Bad exit status from /var/tmp/rpm-tmp.yDFEga (%prep)
> > make[1]: *** [scripts/Makefile.package:69: rpm-pkg] Error 1
> > make: *** [Makefile:1656: rpm-pkg] Error 2
> 
> Thanks for the report.  It should/will be fixed with 
> https://lore.kernel.org/linux-kbuild/20230419170424.78688-1-masahiroy@kernel.org/

Thanks for the prompt response.

I have a general question, why commits listed by Tariq were not delayed to merge window?

Only one of them has Fixes line, but even that patch doesn't talk about
error, but code refactoring "To simplify the code, ...".

Thanks

> 
> Kind regards,
> Nicolas
