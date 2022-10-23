Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D3F609476
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJWPlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiJWPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:41:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4297060503
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 08:41:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68DCEB80BFF
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 15:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9495BC433C1;
        Sun, 23 Oct 2022 15:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666539677;
        bh=+bj01iiwf+CdtRMBHGs4xgTOR7ZEf/SdTveVoJpgGC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gfDCCjs+ubGpwCh2Q8ohzzglaDs1XSxFZESKh9+P5paO+P+4W/Mfc6N3dCcSUZUjQ
         lhAM6pA0xfJ6wg4UaKId1Rj6n7KCikhYhqPCbzXZrj2FG74VRDme4+STL+fygkBA/i
         imIByMaK0D277uzGelt2LcCiarPf6Q9C+Jwm391U=
Date:   Sun, 23 Oct 2022 17:41:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.m.cvetic@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8192e: Rename Enable, cck_Rx_path and
 disabledRF
Message-ID: <Y1Vgms28JIPluZ45@kroah.com>
References: <20221022151506.63725-1-dragan.m.cvetic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022151506.63725-1-dragan.m.cvetic@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 04:15:06PM +0100, Dragan Cvetic wrote:
> Rename variable Enable to enable, cck_Rx_path to cck_rx_path and
> disabledRF to disabled_rf to avoid CamelCase which is not accepted
> by checkpatch.
> 
> Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>

Any reason you didn't cc: the staging tree maintainer?  :(

Anyway, this changelog is confusing, you just list some random variable
names that you have changed, without any explaining what ties them
together.

The code itself gives you a clue:

>  struct drx_path_sel {
> -	u8		Enable;
> +	u8		enable;
>  	u8		cck_method;
> -	u8		cck_Rx_path;
> +	u8		cck_rx_path;
>  
>  	u8		SS_TH_low;
>  	u8		diff_TH;
> -	u8		disabledRF;
> +	u8		disabled_rf;
>  	u8		reserved;
>  
>  	u8		rf_rssi[4];


Ah, you are fixing up the drx_path_sel structure.

But just some of the fields, not all of them, odd.

Please redo this and make the changelog more descriptive of what you are
doing, as well as the subject line (don't need the variable names in
there.)

Also do it for all the fields in the structure, not just 3 random ones.

thanks,

greg k-h
