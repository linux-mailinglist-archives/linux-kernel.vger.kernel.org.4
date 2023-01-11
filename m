Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79636661D3
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 18:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239110AbjAKR36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 12:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239865AbjAKR31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:27 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BCA395DF;
        Wed, 11 Jan 2023 09:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F1C02CE1B0D;
        Wed, 11 Jan 2023 17:27:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2100DC433EF;
        Wed, 11 Jan 2023 17:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673458059;
        bh=/miXrqCOjiG0Qs8BlvyFBFYxjZFoCwZzpXeOHMETUtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IqSpmuntV2Ie6MwaRXSZyBhgJd2+W2VU4+4PRmnt6xf0q7f27CkhVJ/nU80EI6XKA
         KSeU1+/3ZlmMmyEaNIDyRU5qzxRjwL4cHv2eFBK2ZIuh83g3l5yaTTAppf8ad5GXlK
         um4sPN8jlWoKgrxtru75myWH6z8HvqkJSvNK4ZnnClcQ4h3IoXd2wm2gUczs8g8Bgi
         JZd0udB4prUz3FfEQQxQa5S7AmPTCgBAT5hI7ahJxthMrhu3cFKfHF1gG3PNGT/It5
         j5vCVp+SQ+9igBlETn8PKZB5LvMKmb5p9v9vhEDcWyL30dm+Xad1Fygid/vZpK0ahF
         vJNcSydSbXp4g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pFet5-00049L-Vs; Wed, 11 Jan 2023 18:27:44 +0100
Date:   Wed, 11 Jan 2023 18:27:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Samuel Iglesias =?utf-8?Q?Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v3 08/13] tty/serial: Make
 ->dcd_change()+uart_handle_dcd_change() status bool active
Message-ID: <Y77xj6Lk06m27X8J@hovoldconsulting.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
 <20230111142331.34518-9-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230111142331.34518-9-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 04:23:26PM +0200, Ilpo Järvinen wrote:
> Convert status parameter for ->dcd_change() and
> uart_handle_dcd_change() to bool which matches to how the parameter is
> used.
> 
> Rename status to active to better describe what the parameter means.
> 
> Acked-by: Rodolfo Giometti <giometti@enneenne.com>
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pps/clients/pps-ldisc.c  |  6 +++---
>  drivers/tty/serial/serial_core.c |  8 ++++----
>  drivers/tty/serial/sunhv.c       |  8 ++++----
>  drivers/usb/serial/generic.c     | 10 +++++-----
>  include/linux/serial_core.h      |  3 +--
>  include/linux/tty_ldisc.h        |  4 ++--
>  include/linux/usb/serial.h       |  2 +-
>  7 files changed, 20 insertions(+), 21 deletions(-)

Same here, split out the USB serial changes in a separate series.

Johan
