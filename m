Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7815632EA0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 22:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKUVSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 16:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiKUVRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 16:17:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3641741D;
        Mon, 21 Nov 2022 13:17:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95AB261470;
        Mon, 21 Nov 2022 21:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C50C433D7;
        Mon, 21 Nov 2022 21:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669065467;
        bh=9rMZqi6MTAkHx1NSuetSTwbMG0Y1rlHqENVtRTUctaw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=fDqgZeSgtwgMon/Junx9uN/u4GZU8c2wrXcuS6T7AdMjTP3iMsAA4rgRspN/+7MhH
         PtbLnF2hW975S53Aa5cYEbr3npQclxWlNNuTn64EW/guzlRFchtPPVVU7ZmyvzXWLZ
         qz9H8WQLOsfwsg7Iu9nCpar24sQjWUtJgqk4QfGvRFFRN6mqGfjK8Ah7rNgG8DADT8
         s6SDfWBXYNbo2K3wSmolQqF7PZrqPb9FqFoR+LQCQX6sDhZcHlsjZJ2pRhS7dpZTJ5
         w1Eeic7/IHnjcNk6i2c78sICghvrjgWVqUAQxnl1PxmNpb1AVQgReof/KocSacf/JS
         vmV0bqx6xJTrA==
Date:   Mon, 21 Nov 2022 22:17:45 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH RESEND] HID: hid-alps: use default remove for hid
 device
In-Reply-To: <20221117121322.5608-1-marcus.folkesson@gmail.com>
Message-ID: <nycvar.YFH.7.76.2211212217390.6045@cbobk.fhfr.pm>
References: <20221117121322.5608-1-marcus.folkesson@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Nov 2022, Marcus Folkesson wrote:

> hid_device_remove() will call hid_hw_stop() as default .remove function
> if no function is specified.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/hid/hid-alps.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/hid/hid-alps.c b/drivers/hid/hid-alps.c
> index 2b986d0dbde4..9abaff6f3afb 100644
> --- a/drivers/hid/hid-alps.c
> +++ b/drivers/hid/hid-alps.c
> @@ -820,11 +820,6 @@ static int alps_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	return 0;
>  }
>  
> -static void alps_remove(struct hid_device *hdev)
> -{
> -	hid_hw_stop(hdev);
> -}
> -
>  static const struct hid_device_id alps_id[] = {
>  	{ HID_DEVICE(HID_BUS_ANY, HID_GROUP_ANY,
>  		USB_VENDOR_ID_ALPS_JP, HID_DEVICE_ID_ALPS_U1_DUAL) },
> @@ -840,7 +835,6 @@ static struct hid_driver alps_driver = {
>  	.name = "hid-alps",
>  	.id_table		= alps_id,
>  	.probe			= alps_probe,
> -	.remove			= alps_remove,
>  	.raw_event		= alps_raw_event,
>  	.input_mapping		= alps_input_mapping,
>  	.input_configured	= alps_input_configured,

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

