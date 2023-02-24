Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014EE6A1E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjBXPZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:25:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBXPZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:25:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF4F1515F;
        Fri, 24 Feb 2023 07:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 22942B81BEE;
        Fri, 24 Feb 2023 15:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6020FC433EF;
        Fri, 24 Feb 2023 15:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677252313;
        bh=q8uFT+Zib9fXB7CLOrkzVCuFOpx6Cw/p3OvF/WF7BaQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L5nG+aDW3T9iMesh3e6yXeWiV6pfifQvf88GoylAyIsHui9+N5PffPeKLNPxBw91I
         P/rdj4Qq0lC71zrgDEyV8qIPBlvjzzlnlVVOPo5jwTupno6ZG3eMX2bkCK9V/RswlN
         /PJjEacyrfzIqeTSIF+78+7PWBhCJxRc47MrW49Y=
Date:   Fri, 24 Feb 2023 16:25:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Message-ID: <Y/jW161RuT7OtlSf@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com>
 <Y/jHeP4LileLYxO8@kroah.com>
 <bbc824ee-ef4e-40cb-f009-0d693d757869@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc824ee-ef4e-40cb-f009-0d693d757869@asahilina.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 11:44:59PM +0900, Asahi Lina wrote:
> On 2023/02/24 23:19, Greg Kroah-Hartman wrote:>> Can we see some users
> of this code posted so I can see how struct device
> >> is going to work in a rust driver?  That's the thing I worry most about
> >> the rust/C interaction here as we have two different ways of thinking
> >> about reference counts from the two worlds and putting them together is
> >> going to be "interesting", as can be seen here already.
> > 
> > Also, where are you getting your 'struct device' from in the first
> > place?  What bus is createing it and giving it to your rust driver?
> 
> That would be platform for my GPU driver, matched via OF compatible.

Ick, a platform device?  The GPU isn't on the PCI bus?  Wow, that's
horrid...
