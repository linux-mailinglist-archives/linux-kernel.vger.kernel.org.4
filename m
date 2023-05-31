Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 075F1718468
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbjEaOMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237593AbjEaOMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:12:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25521734;
        Wed, 31 May 2023 07:09:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A593F63C92;
        Wed, 31 May 2023 14:07:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599D1C433EF;
        Wed, 31 May 2023 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685542078;
        bh=SNA8PC9y1d+n9WF0UenW10ec6loxUWvYSsbXu5Xkf1o=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=YWlcFLb7CaKAD+0uGaeCYW8rBb5SJOhk99cAQRFcYi2djCn0n9uuTP3OtnuVq56h2
         JAuYWwVlqIp2kFzO51ijELrgaIHuDTGV1g8CjuDZHH3SFKJc2TvHyZdjA6LRHuhAW2
         M8D729bvxPRDfoQsirfczowHN9OxHDiSLoczUGh4N608VWazZXgFyGahHhA2vHo4iJ
         pnEHjIMl2hIWeRCX2uXFpsHxBdfDAID8oXdJLGRnE7o9AQiISQ71Fnc2q8Vw07r6mA
         ZmrY4+jNEEwKlm4/zaE7DJJtdL7O8sxZS0vYUA6NimsygWYQ6StBuMfP5z1mvRTBHe
         CSPw2Iun56zZQ==
Date:   Wed, 31 May 2023 16:07:54 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Bastien Nocera <hadess@hadess.net>
cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        Mark Lord <mlord@pobox.com>
Subject: Re: [PATCH] HID: logitech-hidpp: Handle timeout differently from
 busy
In-Reply-To: <20230531082428.21763-1-hadess@hadess.net>
Message-ID: <nycvar.YFH.7.76.2305311606160.29760@cbobk.fhfr.pm>
References: <20230531082428.21763-1-hadess@hadess.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023, Bastien Nocera wrote:

> If an attempt at contacting a receiver or a device fails because the
> receiver or device never responds, don't restart the communication, only
> restart it if the receiver or device answers that it's busy, as originally
> intended.
> 
> This was the behaviour on communication timeout before commit 586e8fede795
> ("HID: logitech-hidpp: Retry commands when device is busy").
> 
> This fixes some overly long waits in a critical path on boot, when
> checking whether the device is connected by getting its HID++ version.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> Suggested-by: Mark Lord <mlord@pobox.com>
> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217412
> ---
>  drivers/hid/hid-logitech-hidpp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 0fcfd85fea0f..2246044b1639 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -314,6 +314,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
>  			dbg_hid("%s:timeout waiting for response\n", __func__);
>  			memset(response, 0, sizeof(struct hidpp_report));
>  			ret = -ETIMEDOUT;
> +			goto exit;
>  		}
>  

I have applied this even before getting confirmation from the reporters in 
bugzilla, as it's the right thing to do anyway.

Thanks,

-- 
Jiri Kosina
SUSE Labs

