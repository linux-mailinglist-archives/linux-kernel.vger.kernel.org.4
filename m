Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FB3602C31
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiJRMxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiJRMw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:52:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24D70C4C32;
        Tue, 18 Oct 2022 05:52:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E5BDB81EE4;
        Tue, 18 Oct 2022 12:52:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16F0FC433C1;
        Tue, 18 Oct 2022 12:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666097574;
        bh=k45JZFCGaCH6bFVXWQWFi0IQ5tsT/DUTSSwPS8JG8+Q=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=t3yhhXyQWo5LjUJpbS1hdoDapaoybnZweSxrbLjP0jBiMWaanI4xHeN38L1nez2l8
         SHDg1bQbF+nXyiUkGIfeMlXdOrjMpgmANxM2Ic8ExREklVomZpqT4Zgqv/VmHOqdmU
         8s9WypGL+HmMYuryucAtQIPscht8sGtcTHzotKe2Z50uJYWBLeKd760PQ4+8l1mfBY
         PAMPJWlVVLZ88Tm7vtoCO4oOsKXn1dm4dQAjl9m6njU+8CLmihM/7ksVUNGHnwTE5W
         4q8Gg1sM/I2NbJlwTSzAhm8XaPjZc/cW0uyA5h0RaUsL7Nff+/HklwqceTv2Hzz1j0
         yWbTHqQLDiraQ==
Date:   Tue, 18 Oct 2022 14:52:50 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][V2] HID: lenovo: Make array tp10ubkbd_led static const
In-Reply-To: <20221005154216.319577-1-colin.i.king@gmail.com>
Message-ID: <nycvar.YFH.7.76.2210181452450.29912@cbobk.fhfr.pm>
References: <20221005154216.319577-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Oct 2022, Colin Ian King wrote:

> Don't populate the read-only array tp10ubkbd_led on the stack but instead
> make it static const. Also makes the object code a little smaller.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
> V2: Fix commit message, somehow I fat fingered the first one.
> ---
>  drivers/hid/hid-lenovo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 9dabd6323234..44763c0da444 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -985,7 +985,7 @@ static int lenovo_led_brightness_set(struct led_classdev *led_cdev,
>  	struct device *dev = led_cdev->dev->parent;
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
> -	u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
> +	static const u8 tp10ubkbd_led[] = { TP10UBKBD_MUTE_LED, TP10UBKBD_MICMUTE_LED };
>  	int led_nr = 0;
>  	int ret = 0;

Applied, thanks.

-- 
Jiri Kosina
SUSE Labs

