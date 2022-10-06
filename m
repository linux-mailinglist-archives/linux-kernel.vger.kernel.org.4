Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8F35F688F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 15:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiJFNvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 09:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbiJFNuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 09:50:52 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 9127B56B95
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:50:35 -0700 (PDT)
Received: (qmail 785245 invoked by uid 1000); 6 Oct 2022 09:50:27 -0400
Date:   Thu, 6 Oct 2022 09:50:27 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: Replace NO_IRQ by 0
Message-ID: <Yz7dI5iTaguhn73K@rowland.harvard.edu>
References: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63f6d2e7ea17f6522f36abd6cf5e6a7f25f215c6.1665033267.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2022 at 07:15:44AM +0200, Christophe Leroy wrote:
> NO_IRQ is used to check the return of irq_of_parse_and_map().
> 
> On some architecture NO_IRQ is 0, on other architectures it is -1.
> 
> irq_of_parse_and_map() returns 0 on error, independent of NO_IRQ.

This isn't clear.  Does absence of an irq count as an error?  In other 
words, will irq_of_parse_and_map() sometimes return 0 and other times 
return NO_IRQ?  What about architectures on which 0 is a valid irq 
number?

> So use 0 instead of using NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/usb/host/ehci-grlib.c  | 2 +-
>  drivers/usb/host/ehci-ppc-of.c | 2 +-
>  drivers/usb/host/fhci-hcd.c    | 2 +-
>  drivers/usb/host/ohci-ppc-of.c | 2 +-
>  drivers/usb/host/uhci-grlib.c  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/host/ehci-grlib.c b/drivers/usb/host/ehci-grlib.c
> index a2c3b4ec8a8b..0717f2ccf49d 100644
> --- a/drivers/usb/host/ehci-grlib.c
> +++ b/drivers/usb/host/ehci-grlib.c
> @@ -99,7 +99,7 @@ static int ehci_hcd_grlib_probe(struct platform_device *op)
>  	hcd->rsrc_len = resource_size(&res);
>  
>  	irq = irq_of_parse_and_map(dn, 0);
> -	if (irq == NO_IRQ) {
> +	if (!irq) {
>  		dev_err(&op->dev, "%s: irq_of_parse_and_map failed\n",
>  			__FILE__);
>  		rv = -EBUSY;

Since NO_IRQ is sometimes set to -1, shouldn't this test (and all the 
other ones you changed) really be doing:

	if (!irq || irq == NO_IRQ) { ...

?

Alan Stern
