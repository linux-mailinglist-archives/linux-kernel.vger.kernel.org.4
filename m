Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5F55BF9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 10:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiIUI5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 04:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIUI52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 04:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ADD67A508
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 01:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663750647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rJ2ErdyQTAyiYTcLgq8sj/xj/vsAzmqF5/djLR4auwc=;
        b=c/QpkCJGVU+dFdCBz7hRB4Dysy4g0fMr+DhYo4i0w34gcJatbK34BRbBKlXpKnS3jAeEPq
        DXP0o/YqurvtsFY06e1I3PqxLLq8mLR7369c4CGaqMvqDhYIpH5GGxfKkSKJx1xzljrGIf
        c2zV3gh19dCGaKqOGXaivbLj62ZoCec=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-204-ct5KlvW2N5azvCKauDKB7A-1; Wed, 21 Sep 2022 04:57:23 -0400
X-MC-Unique: ct5KlvW2N5azvCKauDKB7A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C653862FDC;
        Wed, 21 Sep 2022 08:57:23 +0000 (UTC)
Received: from mail.corp.redhat.com (unknown [10.39.194.185])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 916DB1121339;
        Wed, 21 Sep 2022 08:57:22 +0000 (UTC)
Date:   Wed, 21 Sep 2022 10:57:20 +0200
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Icenowy Zheng <icenowy@aosc.io>
Cc:     "Daniel J . Ogorchock" <djogorchock@gmail.com>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: nintendo: deregister home LED when it fails
Message-ID: <20220921085720.xacimuggkdr5nmfd@mail.corp.redhat.com>
References: <20220415100432.23453-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415100432.23453-1-icenowy@aosc.io>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 15 2022, Icenowy Zheng wrote:
> Some Pro Controller compatible controllers do not support home LED, and
> will fail when setting it. Currently this leads to probe failure.
> 
> Change the code that fails probing to deregistering home LED.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/hid/hid-nintendo.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
> index 2204de889739..ed93287c3afc 100644
> --- a/drivers/hid/hid-nintendo.c
> +++ b/drivers/hid/hid-nintendo.c
> @@ -1900,9 +1900,8 @@ static int joycon_leds_create(struct joycon_ctlr *ctlr)
>  		/* Set the home LED to 0 as default state */
>  		ret = joycon_home_led_brightness_set(led, 0);
>  		if (ret) {
> -			hid_err(hdev, "Failed to set home LED dflt; ret=%d\n",
> -									ret);
> -			return ret;
> +			hid_warn(hdev, "Failed to set home LED dflt, unregistering home LED");

I have s/dflt/default/ and applied to for-6.1/nintendo in hid.git

FWIW, I wondered really hard if we should or not clean up led->name that
devm_kzalloc-ed just a few lines above, but in the end it doesn't add
much to do it now instead of at remove time.

Thanks for the patch and the reviews!

Cheers,
Benjamin

> +			devm_led_classdev_unregister(&hdev->dev, led);
>  		}
>  	}
>  
> -- 
> 2.35.1
> 

