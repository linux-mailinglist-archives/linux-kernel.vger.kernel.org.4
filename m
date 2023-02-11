Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE53069328B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 17:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjBKQkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 11:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBKQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 11:40:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 074151B335
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 08:40:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75FF160B60
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 16:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E429C433EF;
        Sat, 11 Feb 2023 16:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676133625;
        bh=Uha+P4PhIb4YOtL9aeudGoAjNXpwH88uCbfBBvksCjM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WRRxqCc2dpKSAUpWga+mNdBkBqa9BDpltitsaLTfLmbiigdbFT7p5Dj6Sd7T+575i
         sU1GL9uj6SVzcHWYNoP1Tb5+zsTEHmGRatXiCJ9cXRllhVMsSrBKkVC+Vf6fKrKlXY
         5/Iz85ky0JM+b6mx9c2gmxGv75gcbOx0DRTHno9E=
Date:   Sat, 11 Feb 2023 17:40:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     philipp.g.hortmann@gmail.com, dragan.m.cvetic@gmail.com,
        wjsota@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: set dm_rx_path_sel_table
 storage-class-specifier to static
Message-ID: <Y+fE9kpVMdcW6EZ1@kroah.com>
References: <20230211152856.2129062-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230211152856.2129062-1-trix@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2023 at 07:28:56AM -0800, Tom Rix wrote:
> smatch reports
> drivers/staging/rtl8192e/rtl8192e/rtl_dm.c:147:21:
>   warning: symbol 'dm_rx_path_sel_table' was not declared. Should it be static?
> 
> dm_rx_path_sel_table is only used in rtl_dm.c, so it should be static
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> index d8455b23e555..3bc5dabf2e2c 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/rtl_dm.c
> @@ -144,7 +144,7 @@ const u8 dm_cck_tx_bb_gain_ch14[CCK_TX_BB_GAIN_TABLE_LEN][8] = {
>  /*------------------------Define global variable-----------------------------*/
>  struct dig_t dm_digtable;
>  
> -struct drx_path_sel dm_rx_path_sel_table;
> +static struct drx_path_sel dm_rx_path_sel_table;

So now you have a local variable in the chunk that says "global
variable" :(

Please always be aware of the context of the code you are changing.

thanks,

greg k-h
