Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2A6B972E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 15:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjCNOFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 10:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbjCNOE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 10:04:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38485359E;
        Tue, 14 Mar 2023 07:04:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2914B81975;
        Tue, 14 Mar 2023 14:04:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12379C433D2;
        Tue, 14 Mar 2023 14:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678802693;
        bh=B/P5wvnaGsZszKTry543mSnMtq8bm/XaJVjq6FrmLVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cdrW3swoE3j+NAatgo/UFQ2IwjczHYVqcE0AF9somKo10nuodMPAVynpPv90EF1rc
         WJZV0/WI0WiXBD7bIO1ILM4nxXHTI9NIxw86J+Nh+6zaR79U9ePY7eFM2m13PAWAd/
         DOeFGvbJn0DxuaKXiyJcC4KHbyhE06wAkP/R3AzraOsoo7/NjyoNMQxdFQ2s2NA5b7
         8SV1P+rzlbmdTdearD/WQIfYjfwhgWU1QHGxwOmTkYYFzKbLXPkAadsQGgD9Cd5Kjd
         aQK71mAQ7oLzgV/9LZpo/suXTfDcRntbYEE2FNNVCSun5k/biFSj25BUi5g2Yo5X9Y
         Kc3FVwXSJ3Jrg==
Date:   Tue, 14 Mar 2023 15:04:50 +0100
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Igor Artemiev <Igor.A.Artemiev@mcst.ru>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org
Subject: Re: [lvc-project] [PATCH] Input: synaptics - remove unreachable code
Message-ID: <20230314140450.2w3nhp7zpdolbngc@intel.intel>
References: <20230314124336.1494716-1-Igor.A.Artemiev@mcst.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314124336.1494716-1-Igor.A.Artemiev@mcst.ru>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

On Tue, Mar 14, 2023 at 03:43:36PM +0300, Igor Artemiev wrote:
> The synaptics_resolution() function always returnd 0.
> And there is no need to check its result.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: e839ffab0289 ("Input: synaptics - add support for Intertouch devices")
> Signed-off-by: Igor Artemiev <Igor.A.Artemiev@mcst.ru>
> ---
>  drivers/input/mouse/synaptics.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index fa021af8506e..4f1182bf9667 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -444,9 +444,7 @@ static int synaptics_query_hardware(struct psmouse *psmouse,
>  	if (error)
>  		return error;
>  
> -	error = synaptics_resolution(psmouse, info);
> -	if (error)
> -		return error;
> +	synaptics_resolution(psmouse, info);

Again, please make "synaptics_resolution()" void. As it is you
are just ignoring a return value, even if you are sure it's '0'.

Andi
