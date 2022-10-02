Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02CF65F2360
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJBNai (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJBNae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:30:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285E217E0F;
        Sun,  2 Oct 2022 06:30:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2A4D60EC4;
        Sun,  2 Oct 2022 13:30:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C53DDC433C1;
        Sun,  2 Oct 2022 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664717432;
        bh=us5hueHqD/j3wWOvKZqHtPA6xEsfRnpIDe6d2mNdKwQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OLs61fMBccvbuP12w2NwCeAWBlnxcV+LC94oS/rM9wA/jDJ33FQ22oXjaiAswgqc9
         rpD1i+/EYWBio1XsRnFSxrNNmSjv92qz2fk3gAC42TolBo75W4cpvH4Cve7XUfjp/c
         dJ67PRHXNGn6/rc6EGv9oWS8RGnNzL8CmyP7vhSvEpVNBs14Yfz7cAKRly76S6U0Ox
         Bn1wxOBHodc30YJ6l+Ku+59j/EDfelOuo/k3ssDXST64qFNJVRoeauY+l3/Mq/lPy/
         05FGXIvuHGC+hwDzWuW1QyJrRp9Gq5RRzxtRHGOs0SKktfQJr65R9rfW3uBys7A6Yi
         3/0EvQ4DJdS5A==
Date:   Sun, 2 Oct 2022 14:30:47 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: hid-sensor-custom: set fixed size for custom
 attributes
Message-ID: <20221002143047.7ab1dda5@jic23-huawei>
In-Reply-To: <20220928075913.64125-1-marcus.folkesson@gmail.com>
References: <20220928075913.64125-1-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Sep 2022 09:59:13 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> This is no bugfix (so no Fixes: tag is necessary) as it is
> taken care of in hid_sensor_custom_add_attributes().
> 
> The motivation for this patch is that:
> hid_sensor_custom_field.attr_name and
> hid_sensor_custom_field.attrs
> has the size of HID_CUSTOM_TOTAL_ATTRS and used in same context.
> 
> We compare against HID_CUSTOM_TOTAL_ATTRS when
> looping through hid_custom_attrs.
> 
> We will silent the smatch error:
> hid_sensor_custom_add_attributes() error: buffer overflow
> 'hid_custom_attrs' 8 <= 10
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Slightly ugly fix, but I guess it's the easiest solution.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 32c2306e240d..602465ad2745 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -62,7 +62,7 @@ struct hid_sensor_sample {
>  	u32 raw_len;
>  } __packed;
>  
> -static struct attribute hid_custom_attrs[] = {
> +static struct attribute hid_custom_attrs[HID_CUSTOM_TOTAL_ATTRS] = {
>  	{.name = "name", .mode = S_IRUGO},
>  	{.name = "units", .mode = S_IRUGO},
>  	{.name = "unit-expo", .mode = S_IRUGO},

