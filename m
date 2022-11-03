Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B926178A5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 09:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbiKCI0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 04:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiKCI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 04:26:33 -0400
X-Greylist: delayed 402 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 01:26:31 PDT
Received: from honk.sigxcpu.org (honk.sigxcpu.org [24.134.29.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1055F46;
        Thu,  3 Nov 2022 01:26:31 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id C93CDFB03;
        Thu,  3 Nov 2022 09:19:46 +0100 (CET)
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id kSYW95dxwuxO; Thu,  3 Nov 2022 09:19:45 +0100 (CET)
Date:   Thu, 3 Nov 2022 09:19:41 +0100
From:   Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
To:     Sven Peter <sven@svenpeter.dev>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hector Martin <marcan@marcan.st>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] usb: typec: tipd: Prevent uninitialized event{1,2} in
 IRQ handler
Message-ID: <Y2N5ncIbvvsnI0r2@qwark.sigxcpu.org>
References: <20221102161542.30669-1-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102161542.30669-1-sven@svenpeter.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
On Wed, Nov 02, 2022 at 05:15:42PM +0100, Sven Peter wrote:
> If reading TPS_REG_INT_EVENT1/2 fails in the interrupt handler event1
> and event2 may be uninitialized when they are used to determine
> IRQ_HANDLED vs. IRQ_NONE in the error path.
> 
> Fixes: c7260e29dd20 ("usb: typec: tipd: Add short-circuit for no irqs")
> Fixes: 45188f27b3d0 ("usb: typec: tipd: Add support for Apple CD321X")
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  drivers/usb/typec/tipd/core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index b637e8b378b3..2a77bab948f5 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -474,7 +474,7 @@ static void tps6598x_handle_plug_event(struct tps6598x *tps, u32 status)
>  static irqreturn_t cd321x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event;
> +	u64 event = 0;
>  	u32 status;
>  	int ret;
>  
> @@ -519,8 +519,8 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
>  static irqreturn_t tps6598x_interrupt(int irq, void *data)
>  {
>  	struct tps6598x *tps = data;
> -	u64 event1;
> -	u64 event2;
> +	u64 event1 = 0;
> +	u64 event2 = 0;
>  	u32 status;
>  	int ret;

Reviewed-by: Guido Günther <agx@sigxcpu.org>

Cheers,
 -- Guido
