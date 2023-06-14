Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766F07305B9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjFNRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjFNRNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 13:13:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64C7D193;
        Wed, 14 Jun 2023 10:13:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 014416440C;
        Wed, 14 Jun 2023 17:13:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EE42C433C0;
        Wed, 14 Jun 2023 17:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686762812;
        bh=DghLN/GWkWPUCJuJI14dr3JoWgkabHO9cq9SRz14ZvU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LLeipFXIhCUYnnW3nhiV2EFtGLNuwGLln398EBaW99tw+NIrOMZyNVC+EKdMIy7OG
         /mRWJ/Em7C4FHnwfnjRd3pen55zKD4lYzAnqXQX4gZhyMNLTCgVK1fYgIvffxVWJS4
         Gigm1CoQN6oDRp7Foa2pjDDZEUzH9txK0Ikr0lcAKadGabIyb3CNLBCveaNFTfSr1t
         CDxk0Q9juuKm9HlbrjvVH7Hsfcnf/++Ao/fvlVM9MhX1eh8i30rZUb/KebF7huJEGI
         1de1q4zD5I35VSo8sbAnuVTn8I+sw2RM7oQ6ZVChX2nUGNMWbsekAMVDnYjftktnJO
         FublxFBFKH2iw==
Date:   Wed, 14 Jun 2023 10:13:30 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/boot: Replace strlcpy with strscpy
Message-ID: <20230614171330.GA1146@sol.localdomain>
References: <20230613004125.3539934-1-azeemshaikh38@gmail.com>
 <202306131227.26F90584F7@keescook>
 <CADmuW3WeRG-_WsFVCogRzRNXoqtVr+gA84ryqDZ2URUu3wh6Tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADmuW3WeRG-_WsFVCogRzRNXoqtVr+gA84ryqDZ2URUu3wh6Tg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 10:01:57AM -0400, Azeem Shaikh wrote:
> On Tue, Jun 13, 2023 at 3:27 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Tue, Jun 13, 2023 at 12:41:25AM +0000, Azeem Shaikh wrote:
> > > strlcpy() reads the entire source buffer first.
> > > This read may exceed the destination size limit.
> > > This is both inefficient and can lead to linear read
> > > overflows if a source string is not NUL-terminated [1].
> > > In an effort to remove strlcpy() completely [2], replace
> > > strlcpy() here with strscpy().
> > >
> > > Direct replacement is safe here since return value of -E2BIG
> > > is used to check for truncation instead of sizeof(dest).
> >
> > This looks technically correct, but I wonder if "< 0" is a better test?
> 
> Agreed. "< 0" might more generically represent -errno. Happy to send
> over a v2 if you prefer that instead of sticking with this patch.

Please go with "< 0", since it's easier to read and less error-prone.  (It would
be easy to mistype -E2BIG as -EFBIG, or E2BIG, for example...)

- Eric
