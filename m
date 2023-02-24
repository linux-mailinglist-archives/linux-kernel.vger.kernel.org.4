Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94BBA6A1C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 13:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjBXMtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 07:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjBXMtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 07:49:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E179552DD6;
        Fri, 24 Feb 2023 04:49:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A0556188D;
        Fri, 24 Feb 2023 12:49:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6432AC4339B;
        Fri, 24 Feb 2023 12:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677242958;
        bh=tuYHQ+XarG1U3xH8LjrMRpaLxwbZFcHeJ3I/p1szLFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bf4Iaj4iXDmYS0So4+Fal8DrBahuMVm6EKJXs2nvuZ4hMPWrFsb9G8tJf2JSDhezH
         HFpMRsHoAuTKXu1KGmfVH1gDRZMgMkGqveXnfKdH0gkJLff9TBToX1+SI6ZimmVPEs
         rzohnlKDKXbOOYavcCLY0apAoVSGHuK69DL53cqc=
Date:   Fri, 24 Feb 2023 13:49:16 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev, Finn Behrens <me@kloenk.dev>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>
Subject: Re: [PATCH 3/3] rust: macros: Allow specifying multiple module
 aliases
Message-ID: <Y/iyTA3Nl5yZ/eMA@kroah.com>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-3-b39fae46e102@asahilina.net>
 <Y/hpiWDLm0fB0Xp/@kroah.com>
 <5220876d-f226-117a-d8ed-1d380cd3f14e@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5220876d-f226-117a-d8ed-1d380cd3f14e@asahilina.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 09:41:08PM +0900, Asahi Lina wrote:
> On 24/02/2023 16.38, Greg KH wrote:
> > On Fri, Feb 24, 2023 at 04:25:57PM +0900, Asahi Lina wrote:
> >> Modules can (and usually do) have multiple alias tags, in order to
> >> specify multiple possible device matches for autoloading. Allow this by
> >> changing the alias ModuleInfo field to an Option<Vec<String>>.
> > 
> > Note, manually specifying the MODULE_ALIAS is only really ever done for
> > platform drivers today (and I would argue we need to fix that up),
> > otherwise the use of MODULE_DEVICE_TABLE() should really really be used
> > instead of having to manually specify aliases.
> 
> That's the plan, I just added this before adding support for
> MODULE_DEVICE_TABLE() when I first realized that it wasn't yet in there!
> We were briefly hardcoding the bus aliases for downstream kernels
> because the depmod stuff couldn't work with the way device ID tables
> were done in Rust downstream at the time (and I only noticed the first
> time I tried to build it as a module, since I always develop with
> monolithic kernels). That's fixed now ^^
> 
> However, the issue is that right now the module macro already takes a
> single optional alias, and that doesn't make sense as an API. We could
> remove support for this entirely (if I get my Rust MODULE_DEVICE_TABLE()
> implementation in, there will be zero users of the alias argument as far
> as I know), or add support for multiple aliases. But I think just
> leaving it as a single alias doesn't really make sense? It doesn't
> represent the way module aliases work, which is 0..N.
> 
> I'm fine with removing it if people prefer that, I just thought that for
> something as basic as module metadata we might as well do it properly
> even if there are no users right now, since it's already half in there...

How about just removing it so that people don't think it is something
that they really should be doing and adding real MODULE_DEVICE_TABLE()
support instead?

Although the first filesystem that gets written will need the
MODULE_ALIAS() logic added back, oh well.

Anyway, no objection for me for this for now, just trying to point out
that drivers really should not be using MODULE_ALIAS() at all.

thanks,

greg k-h
