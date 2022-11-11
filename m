Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B1166251EF
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 04:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbiKKDxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 22:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbiKKDxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 22:53:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F66663D3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 19:53:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23200B81CE7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 03:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0342EC433D6;
        Fri, 11 Nov 2022 03:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668138790;
        bh=95ooF5RK0BvIj5js7FGC4kph04JH4S/VemwRpET9ZLE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OSMKMcczxB+kf4C9c1sW4ZPXRJzhqoVC0Z2F2Ubz/xNXGKTyEposzG1ZSLyQe8E8A
         nOjPV1JQ59N/tCSgpMd3q52FMELL2Ej114aVznVAsHqAI8F8HhlpRX/10z8U6KhgHP
         SvfgfPGT7RmUO1SlzSKTrzjLqSdWcP1JoL5GN/jzr4ak+oxsB0m0S0xoeiGsDHAAS/
         aw4oMX9d2ZY7/fVwVmWg8cJzuU41On3kUvY3NwIQUWmftLDiPRPb0zEcwrDGV4Lchz
         Tj6lvxzSRh1w7Lbr0kmQKDaG3AGnp+MZOWhIFO/wFWTHmxAfpdF8avS/VXWLjTHHwd
         MfPt/6F+mK5lA==
Date:   Fri, 11 Nov 2022 11:53:04 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Wang, Xiaolei" <xiaolei.wang@windriver.com>,
        l.stach@pengutronix.de
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: imx8m: Increase the clock enable before reading the
 register
Message-ID: <20221111035304.GL125525@dragon>
References: <20221028041418.4033261-1-xiaolei.wang@windriver.com>
 <20221111024607.GH125525@dragon>
 <f0e35731-07df-bd80-329f-a5ad9818e1e8@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0e35731-07df-bd80-329f-a5ad9818e1e8@windriver.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 11:01:15AM +0800, Wang, Xiaolei wrote:
> 
> On 11/11/2022 10:46 AM, Shawn Guo wrote:
> > CAUTION: This email comes from a non Wind River email account!
> > Do not click links or open attachments unless you recognize the sender and know the content is safe.
> > 
> > On Fri, Oct 28, 2022 at 12:14:18PM +0800, Xiaolei Wang wrote:
> > > When executing kdump to start the second kernel,
> > > since IMX-OCOTP has turned off the clock, the clock
> > > needs to be re-enabled, otherwise the system will hang.
> > > 
> > > Fixes: ac34de14ac30 ("Revert "soc: imx8m: change to use platform driver"")
> > Are you saying this fixes a regression caused by ac34de14ac30?
> 
> 
> Yes,
> 
> Although there is a problem with commit 7d981405d0fd, it also solves the
> kexec kernel hang, commit 7d981405d0fd is reverted, and the kexec kernel
> hang will also be introduced, so the clock needs to be enabled when the
> kexec kernel starts.

Ok.

Lucas,

Any comments here?

Shawn
