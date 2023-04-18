Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E246E593A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 08:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDRGRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 02:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjDRGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 02:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD64C02
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 23:17:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 57CCF62120
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:17:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49987C433D2;
        Tue, 18 Apr 2023 06:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681798669;
        bh=nqidHXv6ILSq69xfot9dCKAiN14YUM8TTkLugS/sXR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fWW9LEj2tcDjD1rXsRHaF6X3bPRL4QNL3gPZzu19VZUA1qudoAVrhPcDsPG0ic8yw
         Z9Ct/VWdGoXp2xwX3drmIAiqVWYMNCR/4cgaXhrt+88O6L00M2WgIV1cTJpcer/6CA
         /ZcKmwLr+RJyj2Sxab9leqYiP27z52ManLb4q7Yo=
Date:   Tue, 18 Apr 2023 08:17:46 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Fix W_DISABLE# does not work after
 stop/start
Message-ID: <ZD42Cn9OkovF5bho@kroah.com>
References: <20230417185723.GA11245@matrix-ESPRIMO-P710>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230417185723.GA11245@matrix-ESPRIMO-P710>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2023 at 08:57:23PM +0200, Philipp Hortmann wrote:
> When loading the driver for rtl8192e, the W_DISABLE# switch is working as
> intended. But when the WLAN is turned off in software and then turned on
> again the W_DISABLE# does not work anymore. Reason for this is that in
> the function _rtl92e_dm_check_rf_ctrl_gpio() the bfirst_after_down is
> checked and returned when true. bfirst_after_down is set true when
> switching the WLAN off in software. But it is not set to false again
> when WLAN is turned on again.
> 
> Add bfirst_after_down = false in _rtl92e_sta_up to reset bit and fix
> above described bug.
> 
> Fixes: https://lore.kernel.org/linux-staging/248ec330-b4c3-aa7b-61eb-69ce8d333b69@gmail.com/
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> v1->v2: Added Fixes Tag

"Fixes:" needs to point to a git commit id, not a url.

thanks,

greg k-h
