Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70295713346
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 10:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjE0IUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 04:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE0IUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 04:20:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51138DE
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 01:20:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8DF860AC0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 08:20:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83405C433EF;
        Sat, 27 May 2023 08:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685175648;
        bh=yGXj/vsNJ1iEb/Lh6DCbMWxe66a+oLeNV5+w6Nt9qBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QSFUnZ2ez8FO3kEJiW2O9kPCmVgiSOIfnoR0/8zUmeqm1S+ExtQAfXBEyyGegtF8z
         TpQkTEC7qMZ5fSiERMMHr0MhI0CmHAPkmrBJI4xsmyjLPINvc9fWkZgjtEWB7HqvC4
         Dh6w05YT0vmryoth/mDOvQyfJr72F7QnailqV9wo3X5T1OWq1IARgw8QUvtSD4bjvi
         hO+BaQK1hjPFJjxWLvCHyoFpGZfgZ+tcLQJN9bS9+ZfZRoCsA+uUMyUGu0Svnkg8gH
         b2OPcmQdiZ0tJXi5cAQduy8JckbXk4L+WS/IHNTvQszYIh0tRqHAd0JoRtRnLu9zHy
         K1jtTyxOE7FvA==
Date:   Sat, 27 May 2023 16:20:37 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3] soc: imx: support i.MX93 soc device
Message-ID: <20230527082037.GB528183@dragon>
References: <20230515063730.2042715-1-peng.fan@oss.nxp.com>
 <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33d57180-aa13-4178-86e1-c4cf6ef29a6e@prevas.dk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 03:30:01PM +0200, Rasmus Villemoes wrote:
> On 15/05/2023 08.37, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> > 
> > i.MX93 Device Unique ID(UID) is in eFuse that could be read through
> > OCOTP Fuse Shadow Block. i.MX93 UID is 128 bits long, so introduce
> > soc_uid_high to indicate the higher 64bits.
> 
> So apparently, the imx8mp also has 128 bits, at least according to the
> reference manual, which mentions a "UNIQUE_ID[127:64]" at offset 0xe00 -
> 0xe10 (i.e. bank 40, words 0 and 1).
> 
> However, no further mention of these upper bits can be found anywhere in
> the RM, or in linux or u-boot, mainline or downstream NXP. Furthermore,
> quick experiments on both an imx8mp-evk and a custom imx8mp board
> reveals that those words are not locked down (they do seem to have some
> contents from the factory, but I can still set more bits in them).
> 
> Could someone from NXP please explain what exactly bank 40, words 0 and
> 1, on imx8mp are for? What do their initial value mean, why are they not
> locked down, and why does the RM indicate that they should be part of a
> unique_id?
> 
> Also, assuming that the RM is just wrong (wouldn't be the first time;
> the description of the lower 64 bits is also wonky in its own special
> way), an obvious follow-up question is: Are the currently exposed
> (lower) 64 bits unique among all imx8mp SOCs, i.e. does those 64 bits by
> themselves actually work as a uid?

Rasmus,

Are you fine with the patch itself?  Or do you expect more clarification
in the commit log?

Shawn
