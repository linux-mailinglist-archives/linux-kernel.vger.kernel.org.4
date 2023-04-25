Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2895E6EE581
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 18:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjDYQRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 12:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234427AbjDYQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 12:17:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87284C17A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 09:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E851062FA6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 16:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2377C433EF;
        Tue, 25 Apr 2023 16:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1682439399;
        bh=7CkwzuZo9NzM+8W8fN6jirn/NF9+/aPfojykB49NBWM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/6I0TEHmSC5LPaLeLjYO3ktXjyG2qK895jjJvcKc2JOf9aELaeSuHCUfyULoLq7s
         XLmgwotdarnQahI71xlOdO6Y1pRAfEus9u/Jxc2o4jGFRgJPki7IDJD/qG+fOQDilU
         9cA7X+nVE6egBhr/N503T0sf7dxahtuXQf7tq1zQ=
Date:   Tue, 25 Apr 2023 18:16:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kilobyte@angband.pl
Cc:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mei: deduplicate X86 && PCI dependencies, make them
 apply to all subentries
Message-ID: <2023042519-spookily-vocalist-51d2@gregkh>
References: <20230425152720.GA4155584@angband.pl>
 <20230425154314.21728-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425154314.21728-1-kilobyte@angband.pl>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2023 at 05:43:14PM +0200, kilobyte@angband.pl wrote:
> From: Adam Borowski <kilobyte@angband.pl>
> 
> The Kconfig "depends on X86 && PCI" line was repeated for 4 out of 6 config
> symbols here -- which was both unnecessarily repetitive, and caused a
> dormant problem for the two remaining symbols lacking the dependency.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
>  v2: instead of adding new depends, wrap all of mei in "if..endif"
> 
>  drivers/misc/mei/Kconfig | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/mei/Kconfig b/drivers/misc/mei/Kconfig
> index d21486d69df2..f2ab2696fa78 100644
> --- a/drivers/misc/mei/Kconfig
> +++ b/drivers/misc/mei/Kconfig
> @@ -1,8 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2003-2019, Intel Corporation. All rights reserved.
> +if X86 && PCI

Please no, that's not a normal Kconfig thing to do at all, sorry.

greg k-h
