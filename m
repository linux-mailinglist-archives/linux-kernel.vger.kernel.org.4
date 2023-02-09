Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C06B690C33
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 15:51:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjBIOvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 09:51:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBIOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 09:51:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489365CBCE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 06:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L4yTUnJjj5yNQaPuaWP1MAaLGbI8BIcCVhl7i47algY=;
        b=crJHst3reXBbmgZNJYw0KSKsWSOjJ4HejDEI4zAmJpYg1EJUxb1TWkajZqg+QrOFwgihy5
        MZTxaQ5wVs+nSihPp7Dzx6+ayL7Q2bKjgp3zrm2lLRr0ahOFXvG0GR7xxqOlx6XRvmwaPq
        QLalv8q0vBAbQIsqxnnV0wvraKgHW4c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-390-o_NwIScfMbSEDLDWdHMMxQ-1; Thu, 09 Feb 2023 09:51:00 -0500
X-MC-Unique: o_NwIScfMbSEDLDWdHMMxQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C47821C0419F;
        Thu,  9 Feb 2023 14:50:59 +0000 (UTC)
Received: from mail.corp.redhat.com (ovpn-192-232.brq.redhat.com [10.40.192.232])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 37CE52026D4B;
        Thu,  9 Feb 2023 14:50:57 +0000 (UTC)
Date:   Thu, 9 Feb 2023 15:50:50 +0100
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Bastien Nocera <hadess@hadess.net>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        "Peter F . Patel-Schneider" <pfpschneider@gmail.com>,
        Filipe =?utf-8?B?TGHDrW5z?= <lains@riseup.net>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>
Subject: Re: [PATCH v2 2/3] HID: logitech-hidpp: Retry commands when device
 is busy
Message-ID: <20230209145050.54ewn3zhjneium2h@mail.corp.redhat.com>
References: <20230206221256.129198-1-hadess@hadess.net>
 <20230206221256.129198-2-hadess@hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230206221256.129198-2-hadess@hadess.net>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 06 2023, Bastien Nocera wrote:
> Handle the busy error coming from the device or receiver. The
> documentation says a busy error can be returned when:
> "
> Device (or receiver) cannot answer immediately to this request
> for any reason i.e:
> - already processing a request from the same or another SW
> - pipe full
> "
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> 
> Same as v1
> 
>  drivers/hid/hid-logitech-hidpp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index 1952d8d3b6b2..9e94026de437 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -295,6 +295,7 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
>  	 */
>  	*response = *message;
>  
> +retry:
>  	ret = __hidpp_send_report(hidpp->hid_dev, message);
>  
>  	if (ret) {
> @@ -321,6 +322,10 @@ static int hidpp_send_message_sync(struct hidpp_device *hidpp,
>  			response->report_id == REPORT_ID_HIDPP_VERY_LONG) &&
>  			response->fap.feature_index == HIDPP20_ERROR) {
>  		ret = response->fap.params[1];
> +		if (ret == HIDPP20_ERROR_BUSY) {
> +			dbg_hid("%s:got busy hidpp 2.0 error %02X, retrying\n", __func__, ret);
> +			goto retry;

I must confess, I blocked a little bit there to decide whether or not
using goto here was OK.

But then I reliazed that there is no way to leave that function if the
device is buggy and constantly sends back ERROR_BUSY. So I am not very
found of the idea of having that got after all.

Would you mind respinning that patch with a bounded loop for the retries
instead of using a goto? I'd like the driver to give up after a few
retries if the device is not fair.

Cheers,
Benjamin

> +		}
>  		dbg_hid("%s:got hidpp 2.0 error %02X\n", __func__, ret);
>  		goto exit;
>  	}
> -- 
> 2.39.1
> 

