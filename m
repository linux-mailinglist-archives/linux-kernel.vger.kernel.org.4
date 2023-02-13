Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABEF693ED7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjBMHQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:16:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjBMHQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:16:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F4AB1AC
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:16:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FC5C60DF7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:16:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EE40C433EF;
        Mon, 13 Feb 2023 07:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676272569;
        bh=NwTfRM0ZXSqWhKuOcF1omNmuw15S2QrWDzzOubo6gys=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zWrGRm3vihFOft206D160mF+KaRh7AVDbNqQ/qcPv1LIRYeHMhhMe9x2K79cOH8WS
         LN2kkBm1hzdtRza8dzOu/1rn2mJq4vOy9+NthFZvAkrKFQljzSamydFPNEhC/YxEg5
         4fHux3WNH1nxhkgCCETPiY1V0WAqWztG72E+bB44=
Date:   Mon, 13 Feb 2023 08:16:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] driver: core: Prevent NULL pointer dereference in device
 name functions
Message-ID: <Y+njtiyDAEJolpZU@kroah.com>
References: <20230212220441.258258-1-alexander.sverdlin@gmail.com>
 <Y+nhnauiUDspXwNM@kroah.com>
 <78b980a9e913cb6d98fd7f99218ccb815926c9f3.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <78b980a9e913cb6d98fd7f99218ccb815926c9f3.camel@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 08:12:08AM +0100, Alexander Sverdlin wrote:
> Hi Greg,
> 
> On Mon, 2023-02-13 at 08:07 +0100, Greg Kroah-Hartman wrote:
> > > Prevent similar scenarios:
> > > 
> > > Unable to handle kernel NULL pointer dereference at virtual address 00000038
> > > ...
> > > PC is at dev_driver_string+0x0/0x38
> > 
> > How did this "scenario" happen?  What in-tree code caused this?
> > 
> 
> such in-tree code is not known to me, I stubled upon this putting dev_info()
> all over the code in the platform we currently convert to DT (cirrus ep93xx).

Instead of using dev_info() for tracing, use ftrace instead, that's what
it is there for!  :)

thanks,

greg k-h
