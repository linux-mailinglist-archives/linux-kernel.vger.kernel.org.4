Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0202A6605CA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 18:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234279AbjAFRj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 12:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjAFRjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 12:39:25 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25B47D9DC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:39:24 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id s66so971998oib.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4OGdzRsnsgcIRm6FiVcM30qmoD/VjHz+6+Th5gll9lk=;
        b=mzDUAzs4cx0ARO+0UMIH2tF1EyP8ycEVSqmz0vxgfpmVk3C7jprtdw4dSxPoJQc9T0
         EY8PFBc3D/IbyBz6yTa/OvaQ2l2XrpYdgXNS9cyb5pkubu99ldU+0j9i6leWCHD60lz/
         P10BDhQgqSrioYwaL1LwSbU4hiiqtS9CJt6Uhd8lC4k9Zs6S9MiTBU9tBe5jDgBOVeQY
         PrYiqFVdmpf3zHi+eRV62r985fA/sqYPD24q12Rw0zTw/Fc3NVm7xSESqM3tkse2/u3R
         p91yfsT8Sih6nK+JGdHvuNE4XM6PsoBovsQIgZCTBO7Z5WgROhDqRJd2bcyk5gV9a1U9
         cNzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OGdzRsnsgcIRm6FiVcM30qmoD/VjHz+6+Th5gll9lk=;
        b=8EKhEStiOaRcIE+j4CRz8GhuWAGiJQ4/uYEERo9bjufjtU6y8KWAKI/RSHlz62gCto
         lxLJf2nBZ1CBT6lpi89Td2n2eMPLOIhgws0iT1d29u/FDuAZLhL/WWV39wyQNShl1zm3
         M2Lt47i1GN1QeKOBaDVxAPyQLJdvfGXXShsxo4a8RjHuOIkBiDb4gRbr1I4SMy/wY5cV
         JobuW49QQeOCDzgY9XvLy5o208ciYdgYK907bcup9jaL3Fs5xc9gbjye/jr0MIbeSPDB
         cLAUTreIeWaWPirIE65DjZcs5QqoW2gxXbmxY/C0Z9ngGYNmNKrPlInx+RIh26y/a5yS
         dMew==
X-Gm-Message-State: AFqh2koS3S2/+14wWAn28LkvB36Zft4t4bAL8S2onMNtGuRM6lcY6vHq
        G7LrgFaomxo6RN+tC3iA/PJlxpbDps3PvSfm8tU=
X-Google-Smtp-Source: AMrXdXsG3KHcYsKS9EN756ILgXcCI983jgaNgB9xFxkc0wYdxFIqGcn0jyf44WWTYylT8UitT3WqOQb0IHxpvHLs+oM=
X-Received: by 2002:a05:6808:c:b0:35d:ff69:49c0 with SMTP id
 u12-20020a056808000c00b0035dff6949c0mr3695550oic.146.1673026764297; Fri, 06
 Jan 2023 09:39:24 -0800 (PST)
MIME-Version: 1.0
References: <20221229064153.23511-1-zh.nvgt@gmail.com> <182d36d5-df77-2479-882a-5bb588c5f170@kernel.org>
 <CAO2zrtaGnfH2yYttq4WqeD40Gt9_gerR7sy1szZotbOP+muW5A@mail.gmail.com> <Y7gGUPuoQ/vdGVl6@kroah.com>
In-Reply-To: <Y7gGUPuoQ/vdGVl6@kroah.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Fri, 6 Jan 2023 12:39:13 -0500
Message-ID: <CAO2zrtY=zfx4asJ5nuU0RsziTnWV_8vXp7MkbLG_rWGQ5-1YpA@mail.gmail.com>
Subject: Re: [PATCH] tty: vt: add some NULL checks for vc_data
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 6:30 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Jan 03, 2023 at 10:01:15PM -0500, Hang Zhang wrote:
> > On Tue, Jan 3, 2023 at 4:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> > >
> > > On 29. 12. 22, 7:41, Hang Zhang wrote:
> > > > vc_selection(), do_blank_screen() and scrollfront() all access "vc_data"
> > > > structures obtained from the global "vc_cons[fg_console].d", which can
> > > > be freed and nullified (e.g., in the error path of vc_allocate()). But
> > > > these functions don't have any NULL checks against the pointers before
> > > > dereferencing them, causing potentially use-after-free or null pointer
> > > > dereference.
> > >
> > > Could you elaborate under what circumstances is fg_console set to a
> > > non-allocated console?
> >
> > Hi, Jiri, thank you for your reply! I am not a developer for tty
> > subsystem, so the reasoning here is based on my best-effort code
> > reading. Please correct me if I am wrong.
> >
> > This patch is based on several observations:
> >
> > (1) at the beginning of vc_selection() (where one NULL check is
> > inserted in this patch), poke_blanked_console() is invoked, which
> > explicitly checks whether "vc_cons[fg_console].d" is NULL, suggesting
> > the possibility of "fg_console" associated with an unallocated console
> > at this point. However, poke_blanked_console() returns "void", so
> > even if "fg_console" is NULL, after returning to vc_selection(),
> > it will just keep executing, resulting in the possible NULL pointer
> > dereference later ("vc" in vc_selection() can be "vc_cons[fg_console].d"
> > if called from set_selection_kernel()). So this patch actually tries
> > to make the already existing NULL check take effect on the control
> > flow (e.g., early return if NULL).
>
> But again, how can that value ever be NULL?
>
> And why are you returning "success" if it is?

Hi, Greg. Thank you for your reply. When writing this patch, we didn't have
many special considerations for the return value - the main purpose is to make
it return early to prevent the later potential null pointer
dereference. The return
value is borrowed from other early return branches within
vc_selection() that all
return 0. We can certainly change it to a specific error code according to
developers' comments.

Sure, we will try to put more effort into investigating the
possibility of the NULL
pointer. Due to our limited domain knowledge, any help/insight from the
developers and maintainers is highly appreciated. Thank you very much!

Thanks,
Hang
