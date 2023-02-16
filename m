Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71396990F3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBPKS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:18:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjBPKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:18:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567D42100;
        Thu, 16 Feb 2023 02:18:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 79932CE2A4B;
        Thu, 16 Feb 2023 10:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6B5C433EF;
        Thu, 16 Feb 2023 10:18:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676542700;
        bh=B/4fB4zbHoqR0LO1WLY5EPDbcPw6sQOKYbHTACv8Pi4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ckLrCOFFomB6H0D+Cgw3GB99dbdAlhxnf06ROWLm6qtzwX6hO20qh0/LVvq5PajqL
         JC2lKqAOGZ9W+W/mFIGkBXJWwqn8URxVu71TvMmzjLvo/TxGEEPKxZVV5CNzQCMov1
         gvWtVnMfOfcUi+7tTja/2p8iNbYMylT6zEp0tkks=
Date:   Thu, 16 Feb 2023 11:18:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Feng <fengqi706@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        fengqi <fengqi@xiaomi.com>
Subject: Re: [PATCH v4] HID: add KEY_CAMERA_FOCUS event in HID
Message-ID: <Y+4C6srdFygrWsLr@kroah.com>
References: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f8627d20de711d08b8cafe0a11481a2b9ca941e.1676537236.git.fengqi@xiaomi.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:48:30PM +0800, Qi Feng wrote:
> From: fengqi <fengqi@xiaomi.com>
> 
> Our HID device need KEY_CAMERA_FOCUS event to control camera,
> but this event is non-existent in current HID driver.
> So we add this event in hid-input.c.
> 
> Signed-off-by: fengqi <fengqi@xiaomi.com>
> 
> ---
> changes in v4:
> 
> -add HID_UP_CAMERA in HID usage tables , Then add the mapping under HID_UP_CAMERA
> -modify the commit log of patch
> -Link to v3:https://lore.kernel.org/linux-input/9a85b268c7636ef2e4e3bbbe318561ba2842a591.1676536357.git.fengqi@xiaomi.com/T/#u
> -Link to v2:https://lore.kernel.org/linux-input/CACOZ=ZU0zgRmoRu8X5bMUzUrXA9x-qoDJqrQroUs=+qKR58MQA@mail.gmail.com/T/#t
> -Link to v1:https://lore.kernel.org/linux-input/CACOZ=ZWB3grJKn7wAZEZ0BDyN7KJF4VWUTNs-mPxeoW_oiR7=g@mail.gmail.com/T/#t
> ---
>  drivers/hid/hid-input.c | 10 ++++++++++
>  include/linux/hid.h     |  1 +
>  2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 77c8c49852b5..c6098ae2fac7 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1225,6 +1225,16 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  			return;
>  		}
>  		goto unknown;
> +	case HID_UP_CAMERA:
> +		switch (usage->hid & HID_USAGE) {
> +		case 0x020:
> +			map_key_clear(KEY_CAMERA_FOCUS);	break;
> +		case 0x021:
> +			map_key_clear(KEY_CAMERA);		break;
> +		default:
> +			goto ignore;
> +		}
> +		break;
>  
>  	case HID_UP_HPVENDOR:	/* Reported on a Dutch layout HP5308 */
>  		set_bit(EV_REP, input->evbit);
> diff --git a/include/linux/hid.h b/include/linux/hid.h
> index 8677ae38599e..88793b77bd63 100644
> --- a/include/linux/hid.h
> +++ b/include/linux/hid.h
> @@ -155,6 +155,7 @@ struct hid_item {
>  #define HID_UP_DIGITIZER	0x000d0000
>  #define HID_UP_PID		0x000f0000
>  #define HID_UP_BATTERY		0x00850000
> +#define HID_UP_CAMERA		0x00900000
>  #define HID_UP_HPVENDOR         0xff7f0000
>  #define HID_UP_HPVENDOR2        0xff010000
>  #define HID_UP_MSVENDOR		0xff000000
> -- 
> 2.39.0
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
