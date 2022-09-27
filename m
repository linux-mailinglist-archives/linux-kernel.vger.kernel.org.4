Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB765EB6B0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 03:13:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbiI0BM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 21:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiI0BM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 21:12:57 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F849B872;
        Mon, 26 Sep 2022 18:12:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 30E0ACE13E7;
        Tue, 27 Sep 2022 01:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2CBC433C1;
        Tue, 27 Sep 2022 01:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664241172;
        bh=LkKSel0RdldqvXm8rwrJJuPghKrZg2g8e51qKRvCa9k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ikeX8zDYwKANctxavY3Xo8m9v4ulsS7NLH6QPpipbfZnVOBKLejB7PZtHoNvc2GU9
         3Fg79+ZbcF6jJCl2fIbNXxvnMXemfCUWaFzZmCqqmuHwRynROEbBMBdAnK+/N7pJ9b
         Yc7EhieMbTSzsbAspIizPiXXTbifuyzDK+kCmsWzA0S84at0ocXTM6VHHNRpaIJzRA
         YLj6roYKVcvTTde9IEF+WmeBR7qmcealnWrwGzpQ75gi0/b3ADzcZW/mwlxhpMBzjh
         ItIL6Sx4f86ssi9SO+nQ4a/ghKbHpt0Y0X596DXbfSE/UTXXlVVosYVPHkoZ25m0kC
         Gd1mH+kraml8A==
Date:   Mon, 26 Sep 2022 20:12:46 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] platform/surface: Split memcpy() of struct ssam_event
 flexible array
Message-ID: <YzJODnTl1M/48zg0@work>
References: <20220927004011.1942739-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927004011.1942739-1-keescook@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 05:40:11PM -0700, Kees Cook wrote:
> To work around a misbehavior of the compiler's ability to see into
> composite flexible array structs (as detailed in the coming memcpy()
> hardening series[1]), split the memcpy() of the header and the payload
> so no false positive run-time overflow warning will be generated.
> 
> [1] https://lore.kernel.org/linux-hardening/20220901065914.1417829-2-keescook@chromium.org
> 
> Cc: Maximilian Luz <luzmaximilian@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Mark Gross <markgross@kernel.org>
> Cc: platform-driver-x86@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  drivers/platform/surface/surface_acpi_notify.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/surface/surface_acpi_notify.c b/drivers/platform/surface/surface_acpi_notify.c
> index 44e317970557..50500e562963 100644
> --- a/drivers/platform/surface/surface_acpi_notify.c
> +++ b/drivers/platform/surface/surface_acpi_notify.c
> @@ -355,7 +355,8 @@ static u32 san_evt_bat_nf(struct ssam_event_notifier *nf,
>  	INIT_DELAYED_WORK(&work->work, san_evt_bat_workfn);
>  	work->dev = d->dev;
>  
> -	memcpy(&work->event, event, sizeof(struct ssam_event) + event->length);
> +	work->event = *event;
> +	memcpy(work->event.data, event->data, event->length);
>  
>  	queue_delayed_work(san_wq, &work->work, delay);
>  	return SSAM_NOTIF_HANDLED;
> -- 
> 2.34.1
> 
