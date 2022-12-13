Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85C64B9FC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiLMQmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiLMQmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:42:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F2764E6;
        Tue, 13 Dec 2022 08:42:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D25526160D;
        Tue, 13 Dec 2022 16:42:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C5EC433D2;
        Tue, 13 Dec 2022 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670949729;
        bh=H/loUsa51Ym3ortfT1MNfYEs/AlpDljAaLTIMLqtEV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+QQfONcp6tuGfLtJYpM+7FuUSEYnSgji/3RK7ZPOXq08JHEe1DaV+yST6qsjLMhj
         RpLZ5DEObzsGYt56Le4oaxKGzrMSOx5CHVoo8SyuueO5uKY2ijEUkf36911OmGNNbX
         j0MsuPG/99W9KG1GYm54n6v63d63orluPpV/id7Jgk7QKif+WSmnXHNTvQ44GAFGBN
         Tjhp6EWrJe6fO4bdVAjvKPjKfv3zwebP9TGgjkCnxhTs6df9X9itR47R5YHMMk9YsX
         vvVecUymAa2X+ltthxlSyVvhWfO7FQPqfxQF/MLz26KMMsIsC+tIBLkO+tLFFS1ZYw
         bcj9/bj/NKHmw==
Date:   Tue, 13 Dec 2022 09:42:07 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Nicolas Schier <nicolas@fjasle.eu>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] kbuild: ensure Make >= 3.82 is used
Message-ID: <Y5irX4Uajdc6ngoc@dev-arch.thelio-3990X>
References: <20221211030352.2622425-1-masahiroy@kernel.org>
 <Y5djBr9rVhSq8+iK@dev-arch.thelio-3990X>
 <Y5f4ZgyK7QlqYu31@bergen.fjasle.eu>
 <Y5hOUYUYmwGioGiP@fjasle.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5hOUYUYmwGioGiP@fjasle.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 13, 2022 at 11:05:05AM +0100, Nicolas Schier wrote:
> On Tue, Dec 13, 2022 at 04:58:30AM +0100 Nicolas Schier wrote:
> > On Mon 12 Dec 2022 10:21:10 GMT, Nathan Chancellor wrote:
> > > On Sun, Dec 11, 2022 at 12:03:52PM +0900, Masahiro Yamada wrote:
> > > > Documentation/process/changes.rst notes the minimal GNU Make version,
> > > > but it is not checked anywhere.
> > > > 
> > > > We could check $(MAKE_VERSION), but another simple way is to check
> > > > $(.FEATURES) since the feature list always grows although this way
> > > > is not always possible. For example Make 4.0 through 4.2 have the
> > > > same set of $(.FEATURES).
> > > > 
> > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > 
> > > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > 
> > Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
> > 
> > > > ---
> > > > 
> > > > Changes in v3:
> > > >   - Check the version in a different way
> > > > 
> > > >  Makefile | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > > 
> > > > diff --git a/Makefile b/Makefile
> > > > index 2dda1e9a717a..66dfc5751470 100644
> > > > --- a/Makefile
> > > > +++ b/Makefile
> > > > @@ -11,6 +11,11 @@ NAME = Hurr durr I'ma ninja sloth
> > > >  # Comments in this file are targeted only to the developer, do not
> > > >  # expect to learn how to build the kernel reading this file.
> > > >  
> > > > +# Ensure Make >= 3.82
> > > > +ifeq ($(filter undefine,$(.FEATURES)),)
> > > > +$(error Make $(MAKE_VERSION) is too old)
> > > 
> > > Would it make sense to state what version is needed, similar to the
> > > Kconfig checks for compiler and binutils?
> > 
> > Checking against 'undefine' (introduced in make-3.82~38) is quite a 
> > nice way, I think.  Otherwise we needed something like
> > $(filter 3.82% 3.9% 4.% 5.% ..., $(MAKE_VERSION)).
> > 
> 
> Nathan, sorry, I somehow I read your question completely wrong.  I would also
> appreciate if the minimum make version would be shown in the error message.

No worries, I have done that many a time :) I see Masahiro updated this
to v4 with this feedback taken into consideration so I am glad to see
we are all in agreement.

Cheers,
Nathan
