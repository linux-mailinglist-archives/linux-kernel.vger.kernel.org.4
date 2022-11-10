Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E55462499E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiKJSjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:39:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKJSjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:39:09 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 83C8F1CFC9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 10:39:08 -0800 (PST)
Received: (qmail 10244 invoked by uid 1000); 10 Nov 2022 13:39:07 -0500
Date:   Thu, 10 Nov 2022 13:39:07 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: Check !irq instead of irq == NO_IRQ
Message-ID: <Y21FS6q9AW2ioGjw@rowland.harvard.edu>
References: <13feefdf6b240817944e6441e26a8ddc1d81ced1.1668102802.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13feefdf6b240817944e6441e26a8ddc1d81ced1.1668102802.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 06:54:35PM +0100, Christophe Leroy wrote:
> NO_IRQ is a relic from the old days. It is not used anymore in core
> functions. By the way, function irq_of_parse_and_map() returns value 0
> on error.
> 
> In some drivers, NO_IRQ is erroneously used to check the return of
> irq_of_parse_and_map().
> 
> It is not a real bug today because the only architectures using the
> drivers being fixed by this patch define NO_IRQ as 0, but there are
> architectures which define NO_IRQ as -1. If one day those
> architectures start using the non fixed drivers, there will be a
> problem.
> 
> Long time ago Linus advocated for not using NO_IRQ, see
> https://lkml.org/lkml/2005/11/21/221 . He re-iterated the same view
> recently in https://lkml.org/lkml/2022/10/12/622
> 
> So test !irq instead of tesing irq == NO_IRQ.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/usb/host/ehci-grlib.c  | 2 +-
>  drivers/usb/host/ehci-ppc-of.c | 2 +-
>  drivers/usb/host/fhci-hcd.c    | 2 +-
>  drivers/usb/host/ohci-ppc-of.c | 2 +-
>  drivers/usb/host/uhci-grlib.c  | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

For the [eou]hci-* files:

Acked-by: Alan Stern <stern@rowland.harvard.edu>

Alan Stern
