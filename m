Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A88B361636D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 14:11:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbiKBNLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 09:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKBNLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 09:11:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D219C2A278;
        Wed,  2 Nov 2022 06:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71E1761961;
        Wed,  2 Nov 2022 13:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9765BC433D7;
        Wed,  2 Nov 2022 13:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667394697;
        bh=PwLPF38SQ68KPHSo/edAK/nii2BZZ+nmTOGG5coVmB4=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=drDLJ2FAAU//GqeOW1L5uJ5HL16Z31tGhov+yjPeAr3vwGAKNg3f/a3Ri6EqwZR6r
         GKIzIAXsko4/sVpm7A91yY7fcvopL1uGew7iGtIkp5J1ozT1w8opCT0Tf4fuvlMJkn
         +s57pI+4JJJET51S68KnZisP6hN4jCNzwRCdhx6BNcv2gPPql8tDu8F9hL5jjgH3hn
         dXjaTyvxmRUD5r19kj3qYe5DJWvlzJkRlpTbL0VGZwSNu3jGRhhw+dLF9enMQpMZ50
         sylSvRAxvrvH5gkQ2yYqIInPHw4tIztWARFFP7zonhfhuK7VjvcDB4eizQGQZwWhbR
         DIyTFCyfmyjYA==
Date:   Wed, 2 Nov 2022 14:11:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: asus: Remove variable count
In-Reply-To: <20221024161102.2171702-1-colin.i.king@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211021411290.29912@cbobk.fhfr.pm>
References: <20221024161102.2171702-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Oct 2022, Colin Ian King wrote:

> Variable count is just being incremented and it's never used
> anywhere else. The variable and the increment are redundant so
> remove it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/hid/hid-asus.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index b59c3dafa6a4..f99752b998f3 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -219,14 +219,13 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
>  {
>  	struct input_mt *mt = drvdat->input->mt;
>  	struct input_mt_slot *oldest;
> -	int oldid, count, i;
> +	int oldid, i;
>  
>  	if (drvdat->tp->contact_size < 5)
>  		return;
>  
>  	oldest = NULL;
>  	oldid = mt->trkid;
> -	count = 0;
>  
>  	for (i = 0; i < mt->num_slots; ++i) {
>  		struct input_mt_slot *ps = &mt->slots[i];
> @@ -238,7 +237,6 @@ static void asus_report_tool_width(struct asus_drvdata *drvdat)
>  			oldest = ps;
>  			oldid = id;
>  		}
> -		count++;
>  	}

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

