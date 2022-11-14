Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C144C628207
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 15:09:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbiKNOJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 09:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbiKNOJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 09:09:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE8D2AE0;
        Mon, 14 Nov 2022 06:09:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF03E611BE;
        Mon, 14 Nov 2022 14:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D01C433C1;
        Mon, 14 Nov 2022 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668434942;
        bh=nc57LEG5jYTS9ueM1mkZq7Psxs0hzm5AUlc0Xu2jMjw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=lvmTPGJP+pq6k8dwEaDeV5llMxQi20DQNpDeff+eY54E0HuuxHX2PQuPXq5XaE0KS
         ZQyzGXiE+m8FPm8f+BWk2EwHE6o1Ib+5Qo1kL2bRfzqffdbYEBVaKhZ1MAePUzmzfy
         ZKzyAHtg9tjb1g3zlYKWyuhLxe8XHEWHFo2iyr5ERXF1QvWRnFI2syCDuhDaGMdVpO
         sk+OpZZ2nWzpcNidIeCwckjlYoa0EIwugQSUCACCyRz5GAbHDH73/VvUjNKw4zCvPs
         Zqiv2tjqbFomwTjvxWD5Sr67RqB+9S+Dxg3NXjw0ND39PwRZXO/l2ELK1Dh8E0i4DZ
         eXfDmylS+0t6g==
Date:   Mon, 14 Nov 2022 15:09:00 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Andreas Bergmeier <abergmeier@gmx.net>
cc:     lains@riseup.net, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] HID: Print specific timeout error in probe
In-Reply-To: <20221110204131.1354704-1-abergmeier@gmx.net>
Message-ID: <nycvar.YFH.7.76.2211141507380.6045@cbobk.fhfr.pm>
References: <20221110204131.1354704-1-abergmeier@gmx.net>
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

On Thu, 10 Nov 2022, Andreas Bergmeier wrote:

> When -ETIMEOUT gets reported ensure that the error message mentiones
> timeout.
> 
> Signed-off-by: Andreas Bergmeier <abergmeier@gmx.net>
> ---
>  drivers/hid/hid-logitech-hidpp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 20ae7f73ef08..a0c148a8df6c 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -4438,12 +4438,16 @@ static int hidpp_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  	if (hidpp->quirks & HIDPP_QUIRK_UNIFYING)
>  		hidpp_unifying_init(hidpp);
> 
> -	connected = hidpp_root_get_protocol_version(hidpp) == 0;
> +	ret = hidpp_root_get_protocol_version(hidpp);
> +	connected = ret == 0;
>  	atomic_set(&hidpp->connected, connected);
>  	if (!(hidpp->quirks & HIDPP_QUIRK_UNIFYING)) {
>  		if (!connected) {
> +			if (ret == -ETIMEDOUT)
> +				hid_err(hdev, "Device connection timed out");
> +			else
> +				hid_err(hdev, "Device not connected");
>  			ret = -ENODEV;
> -			hid_err(hdev, "Device not connected");

Printing as specific error as possible makes sense to me.

I am however wondering whether the better aproach (covering all the cases, 
not just ETIMEDOUT specifically) wouldn't be to convert all the dbg_hid() 
in hidpp_send_message_sync() to be proper error messages instead? That 
would cover also your case, as ETIMEDOUT is handled there as well with 
debugging message.

Thanks,

-- 
Jiri Kosina
SUSE Labs

