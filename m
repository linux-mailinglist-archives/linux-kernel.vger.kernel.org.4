Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8B6E698DAF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 08:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjBPHTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 02:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBPHTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 02:19:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133982D14D;
        Wed, 15 Feb 2023 23:19:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C52761E4C;
        Thu, 16 Feb 2023 07:19:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BF40C433D2;
        Thu, 16 Feb 2023 07:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676531990;
        bh=4cOlQKhnkUYakVFHP70NRzk/2OLrwiPte5M4Y3+erf4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SfhmpwJ3vlOmoAOU5LIcz20o/WlcqLMWq8+GrcdKzUjRa4AE1PyUhRFq9MfXo+wEK
         MQ4rPztND1BVVKpAKNnHC+kxvNpcQJtJ0p5Vk2sMUFH8IVqAEmsj7BFYhpP6oM8DwV
         06VPnI+PazkceCIOWXIJp66mkSeXOXyg20/d+v/o=
Date:   Thu, 16 Feb 2023 08:19:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Feng <fengqi706@gmail.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        rydberg@bitmath.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, fengqi <fengqi@xiaomi.com>
Subject: Re: [PATCH v2] HID: add KEY_CAMERA_FOCUS event in HID
Message-ID: <Y+3ZE7Pv1JaMmh+E@kroah.com>
References: <20230131114632.14078-1-fengqi706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131114632.14078-1-fengqi706@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 07:46:32PM +0800, Qi Feng wrote:
> From: fengqi <fengqi@xiaomi.com>
> 
> Our HID device need KEY_CAMERA_FOCUS event to control camera, but this
> event is non-existent in current HID driver.we add this event in hid-input.c

Please read the section entitled "The canonical patch format" in the
kernel file, Documentation/process/submitting-patches.rst for what is
needed in order to properly describe the change.

> We committed this v2 version following your previous suggestion

This line is not needed in a changelog text.

> 
> Signed-off-by: fengqi <fengqi@xiaomi.com>
> ---
>  drivers/hid/hid-input.c | 7 +++++++
>  include/linux/hid.h     | 1 +
>  2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> index 9b59e436df0a..05fa3e191574 100644
> --- a/drivers/hid/hid-input.c
> +++ b/drivers/hid/hid-input.c
> @@ -1221,6 +1221,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
>  			return;
>  		}
>  		goto unknown;
> +	case HID_UP_CAMERA:
> +		switch (usage->hid & HID_USAGE){
> +		case 0x020: map_key_clear(KEY_CAMERA_FOCUS);	break;
> +		case 0x021: map_key_clear(KEY_CAMERA);		break;
> +		default: 	goto ignore;
> +		}
> +		break;		

Always run checkpatch.pl on your submission before sending it out,
otherwise it obviously can not be accepted.

thanks,

greg k-h
