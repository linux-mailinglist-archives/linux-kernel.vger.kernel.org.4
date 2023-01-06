Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86AE65FF8E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 12:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjAFLag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 06:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjAFLad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 06:30:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9585FFC
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 03:30:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E50661D93
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 11:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CE9C433EF;
        Fri,  6 Jan 2023 11:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673004627;
        bh=9eD0m84lTiwXGIY4mwU2neZ/1BkaOZj8Akj1zYIJJ0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HAPu6+lL3woLdtod2IyCAmiIQ+xp1h5820d4H+f8l2WHKunXF+AinYH/4xDqYJeMl
         QvkdDnOEnSf6KGImlvP0cS/birdJ+1BZYf+twkM16FOAxc7lPvPtkm5aMm/HzX3x2e
         p/4sbt+1hgtdEHNDSle7X9MtcWtFY5VG37PVCyOc=
Date:   Fri, 6 Jan 2023 12:30:24 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hang Zhang <zh.nvgt@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Yangxi Xiang <xyangxi5@gmail.com>,
        Xuezhi Zhang <zhangxuezhi1@coolpad.com>,
        Helge Deller <deller@gmx.de>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: add some NULL checks for vc_data
Message-ID: <Y7gGUPuoQ/vdGVl6@kroah.com>
References: <20221229064153.23511-1-zh.nvgt@gmail.com>
 <182d36d5-df77-2479-882a-5bb588c5f170@kernel.org>
 <CAO2zrtaGnfH2yYttq4WqeD40Gt9_gerR7sy1szZotbOP+muW5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO2zrtaGnfH2yYttq4WqeD40Gt9_gerR7sy1szZotbOP+muW5A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:01:15PM -0500, Hang Zhang wrote:
> On Tue, Jan 3, 2023 at 4:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
> >
> > On 29. 12. 22, 7:41, Hang Zhang wrote:
> > > vc_selection(), do_blank_screen() and scrollfront() all access "vc_data"
> > > structures obtained from the global "vc_cons[fg_console].d", which can
> > > be freed and nullified (e.g., in the error path of vc_allocate()). But
> > > these functions don't have any NULL checks against the pointers before
> > > dereferencing them, causing potentially use-after-free or null pointer
> > > dereference.
> >
> > Could you elaborate under what circumstances is fg_console set to a
> > non-allocated console?
> 
> Hi, Jiri, thank you for your reply! I am not a developer for tty
> subsystem, so the reasoning here is based on my best-effort code
> reading. Please correct me if I am wrong.
> 
> This patch is based on several observations:
> 
> (1) at the beginning of vc_selection() (where one NULL check is
> inserted in this patch), poke_blanked_console() is invoked, which
> explicitly checks whether "vc_cons[fg_console].d" is NULL, suggesting
> the possibility of "fg_console" associated with an unallocated console
> at this point. However, poke_blanked_console() returns "void", so
> even if "fg_console" is NULL, after returning to vc_selection(),
> it will just keep executing, resulting in the possible NULL pointer
> dereference later ("vc" in vc_selection() can be "vc_cons[fg_console].d"
> if called from set_selection_kernel()). So this patch actually tries
> to make the already existing NULL check take effect on the control
> flow (e.g., early return if NULL).

But again, how can that value ever be NULL?

And why are you returning "success" if it is?

> (2) a similar NULL check for "vc_cons[fg_console].d" can also be found
> in do_unblank_screen() ("if (!vc_cons_allocated(fg_console))") before
> accessing the corresponding "vc_data". I do notice that the NULL check
> has a comment "/* impossible */", but the check has not been removed so
> far. My guess is that there might still be a chance that it can be
> unallocated at that point.

Please verify that this really ever could be NULL or not.

thanks,

greg k-h
