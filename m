Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5FA71112F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239774AbjEYQmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbjEYQmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:42:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DBFF189;
        Thu, 25 May 2023 09:42:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B60EA60FA0;
        Thu, 25 May 2023 16:42:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA6F1C433EF;
        Thu, 25 May 2023 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685032933;
        bh=Y3G8k59J+vGHwssXzbrGUk2YAbv5aVOZNNFBpJdJe4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiRHfVrMvzzP1JE3LMScpOW2d9JCxyHoeLmakmesqZzwnwEOCzmF5sAA0H0oZs5A8
         GOb9nruULIhwfOj3inOTpKVj2A4eX04/bz69TwE7rqHU6B+w+I3+ErxT2viK6kQXZL
         +q+Hl2oB//jPKpVj8Z7AGwg9yFmshvdFnhHxvqM4=
Date:   Thu, 25 May 2023 17:42:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     rafael@kernel.org, song@kernel.org, lucas.de.marchi@gmail.com,
        lucas.demarchi@intel.com, christophe.leroy@csgroup.eu,
        peterz@infradead.org, rppt@kernel.org, dave@stgolabs.net,
        willy@infradead.org, vbabka@suse.cz, mhocko@suse.com,
        dave.hansen@linux.intel.com, colin.i.king@gmail.com,
        jim.cromie@gmail.com, catalin.marinas@arm.com, jbaron@akamai.com,
        rick.p.edgecombe@intel.com, yujie.liu@intel.com, david@redhat.com,
        tglx@linutronix.de, hch@lst.de, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, prarit@redhat.com,
        lennart@poettering.net
Subject: Re: [PATCH 2/2] module: add support to avoid duplicates early on load
Message-ID: <2023052518-unable-mortician-4365@gregkh>
References: <20230524213620.3509138-1-mcgrof@kernel.org>
 <20230524213620.3509138-3-mcgrof@kernel.org>
 <8fc5b26b-d2f6-0c8f-34a1-af085dbef155@suse.com>
 <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiPjcPL_50WRWOi-Fmi9TYO6yp_oj63a_N84FzG-rxGKQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2023 at 09:07:23AM -0700, Linus Torvalds wrote:
> > It means that these and similarly organized distributions end up using
> > init_module(), and adding complexity to optimize finit_module() wouldn't
> > actually help in their case.
> 
> Yeah, I think the real bug is absolutely in udev, and trying to load
> the same module hundreds of times is very very wrong. So I think the
> "mitigate it in the kernel" is at most a quick hack to fix user-space
> brokenness.

I totally agree.  I also agree that this doesn't really seem to be any
sort of "bug" in that no memory leaks, and when userspace calms down,
all goes back to normal.  So hacks in the vfs layer for this is not
good, let's not paper over userspace code that we have control over with
kernel changes.

Luis, I asked last time what modules are being asked by the kernel to be
loaded thousands of times at boot and can't seem to find an answer
anywhere, did I miss that?  This should be very easy to handle in
userspace if systems need it, so that begs the questions, what types of
systems need this?  We have handled booting with tens of thousands of
devices attached for decades now with no reports of boot/udev/kmod
issues before, what has recently changed to cause issues?

thanks,

greg k-h
