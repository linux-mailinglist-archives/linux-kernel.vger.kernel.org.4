Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16537380E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbjFUKwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231734AbjFUKvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:51:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4271BE6;
        Wed, 21 Jun 2023 03:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1062614E9;
        Wed, 21 Jun 2023 10:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB37BC433C8;
        Wed, 21 Jun 2023 10:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687344627;
        bh=cGQrS2SFrCOw8DMVAnIO4+fl2u2O+y02ZnnotmrAlDI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nG3Lb+8ZRwlReRXhUe9bnlJ/cH3779QLwSAvm9T8c0eCnkcx0Tp29YPVxvc0e7ep1
         CuuFRPqzXv9l6vDxBjyCHtNmW28F5Dcn0MDwAjKYv9PH4EFcwyeuoj+LSrcv45HeIx
         NYwy3qlt8J6UPcvqCfVQbyLjQigXKA94bB9yCJYc=
Date:   Wed, 21 Jun 2023 12:50:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        Bastien Nocera <hadess@hadess.net>,
        Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: rework one more time the retries
 attempts
Message-ID: <2023062156-trespass-pandemic-7f4f@gregkh>
References: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621-logitech-fixes-v1-1-32e70933c0b0@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 11:42:30AM +0200, Benjamin Tissoires wrote:
> Make the code looks less like Pascal.
> 
> Extract the internal code inside a helper function, fix the
> initialization of the parameters used in the helper function
> (`hidpp->answer_available` was not reset and `*response` wasn't too),
> and use a `do {...} while();` loop.
> 
> Fixes: 586e8fede795 ("HID: logitech-hidpp: Retry commands when device is busy")
> Cc: stable@vger.kernel.org
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> as requested by https://lore.kernel.org/all/CAHk-=wiMbF38KCNhPFiargenpSBoecSXTLQACKS2UMyo_Vu2ww@mail.gmail.com/
> This is a rewrite of that particular piece of code.
> ---
>  drivers/hid/hid-logitech-hidpp.c | 102 +++++++++++++++++++++++----------------
>  1 file changed, 61 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
> index dfe8e09a18de..3d1ffe199f08 100644
> --- a/drivers/hid/hid-logitech-hidpp.c
> +++ b/drivers/hid/hid-logitech-hidpp.c
> @@ -275,21 +275,20 @@ static int __hidpp_send_report(struct hid_device *hdev,
>  }
>  
>  /*
> - * hidpp_send_message_sync() returns 0 in case of success, and something else
> - * in case of a failure.
> - * - If ' something else' is positive, that means that an error has been raised
> - *   by the protocol itself.
> - * - If ' something else' is negative, that means that we had a classic error
> - *   (-ENOMEM, -EPIPE, etc...)
> + * Effectively send the message to the device, waiting for its answer.
> + *
> + * Must be called with hidpp->send_mutex locked
> + *
> + * Same return protocol than hidpp_send_message_sync():
> + * - success on 0
> + * - negative error means transport error
> + * - positive value means protocol error
>   */
> -static int hidpp_send_message_sync(struct hidpp_device *hidpp,
> +static int __do_hidpp_send_message_sync(struct hidpp_device *hidpp,
>  	struct hidpp_report *message,
>  	struct hidpp_report *response)

__must_hold(&hidpp->send_mutex)  ?

