Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B56326646ED
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 18:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjAJREN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 12:04:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237888AbjAJREA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 12:04:00 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 843373FA1F
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 09:03:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=bflhSmUIrRVFiOnmU5LNTa+a0t1eNM/Sovf9pm5L23E=; b=oPUdZmaIE/6drQcbq8AI4Qs/4E
        QsBKDCv/RNzrN06gftqIGf8t/xlBIJ45Y4VD3+SCUYmGk1H6/n3salV8ABmw3iom2duyY1FqAjp5y
        l2Gicn0jibTcg6tcc119YWpGQqPozHA37pj7pu9AeSnDvh8kZ7ZRpRaVZYTRyE1B+tQKKSsZjQ9yO
        KsGGZhVDPFLb1w5GlhjAwM5B0KmBDyzZWu5+aMos2XzBh/0p3y9LF40e4iDN1nRdChIHnKBDUNin3
        w0q4t9giNs6wOpJg7brdeQZVFgWmC4YyBH/SSFaYGnsJ4kTPke7IcBhU2hRG3HickyOyppLrOR538
        SQ/pZX4Q==;
Received: from [2601:1c2:d80:3110::9307]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pFI2T-007uNK-PL; Tue, 10 Jan 2023 17:03:53 +0000
Message-ID: <968101fe-2306-dbef-81f1-6b5864778b7a@infradead.org>
Date:   Tue, 10 Jan 2023 09:03:52 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 1/2] driver core: bus.h: document bus notifiers better
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>
References: <20230110145303.2087563-1-gregkh@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230110145303.2087563-1-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 1/10/23 06:53, Greg Kroah-Hartman wrote:
> The bus notifier values are not documented all that well, so clean this
> up and make a real enumerated type for them and document them much
> better.  Also change the values from being in hex to just decimal as it
> didn't make any sense to have them in hex.
> 
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> v2: move the values to decimal from hex as pointed out by Rafael.
> 
>  include/linux/device/bus.h | 43 +++++++++++++++++++++++++-------------
>  1 file changed, 29 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
> index d529f644e92b..fbec1c7c34c0 100644
> --- a/include/linux/device/bus.h
> +++ b/include/linux/device/bus.h
> @@ -257,21 +257,36 @@ extern int bus_register_notifier(struct bus_type *bus,
>  extern int bus_unregister_notifier(struct bus_type *bus,
>  				   struct notifier_block *nb);
>  
> -/* All 4 notifers below get called with the target struct device *
> - * as an argument. Note that those functions are likely to be called
> - * with the device lock held in the core, so be careful.

If you want this to be kernel-doc format with no warnings,
(a) all of the " * BUS_NOTIFY_..." lines should be " * @BUS_NOTIFY_...";
(b) all of the " * @BUS_NOTIFY_..." lines should be immediately after the
second ("enum") line. (at [1])
(c) In the heading "enum" line, s/: / - /, but that's just for consistency
and to follow kernel-doc documented format; it seems that kernel-doc takes
that separator either way.

The patch below (on top of this one) makes all of these changes.

> +/**
> + * enum bus_notifier_event: Bus Notifier events that have happened
[1]
> + *
> + * These are the value passed to a bus notifier when a specific event happens.
> + *
> + * Note that bus notifiers are likely to be called with the device lock already
> + * held by the driver core, so be careful in any notifier callback as to what
> + * you do with the device structure.
> + *
> + * All bus notifiers are called with the target struct device * as an argument.
> + *
> + * BUS_NOTIFY_ADD_DEVICE: device is added to this bus
> + * BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
> + * BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
> + * BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
> + * BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
> + * BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
> + * BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
> + * BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
>   */
> -#define BUS_NOTIFY_ADD_DEVICE		0x00000001 /* device added */
> -#define BUS_NOTIFY_DEL_DEVICE		0x00000002 /* device to be removed */
> -#define BUS_NOTIFY_REMOVED_DEVICE	0x00000003 /* device removed */
> -#define BUS_NOTIFY_BIND_DRIVER		0x00000004 /* driver about to be
> -						      bound */
> -#define BUS_NOTIFY_BOUND_DRIVER		0x00000005 /* driver bound to device */
> -#define BUS_NOTIFY_UNBIND_DRIVER	0x00000006 /* driver about to be
> -						      unbound */
> -#define BUS_NOTIFY_UNBOUND_DRIVER	0x00000007 /* driver is unbound
> -						      from the device */
> -#define BUS_NOTIFY_DRIVER_NOT_BOUND	0x00000008 /* driver fails to be bound */
> +enum bus_notifier_event {
> +	BUS_NOTIFY_ADD_DEVICE =		1,
> +	BUS_NOTIFY_DEL_DEVICE =		2,
> +	BUS_NOTIFY_REMOVED_DEVICE =	3,
> +	BUS_NOTIFY_BIND_DRIVER =	4,
> +	BUS_NOTIFY_BOUND_DRIVER =	5,
> +	BUS_NOTIFY_UNBIND_DRIVER =	6,
> +	BUS_NOTIFY_UNBOUND_DRIVER =	7,
> +	BUS_NOTIFY_DRIVER_NOT_BOUND =	8,
> +};
>  
>  extern struct kset *bus_get_kset(struct bus_type *bus);
>  

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
 include/linux/device/bus.h |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff -- a/include/linux/device/bus.h b/include/linux/device/bus.h
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -271,7 +271,15 @@ extern int bus_unregister_notifier(struc
 				   struct notifier_block *nb);
 
 /**
- * enum bus_notifier_event: Bus Notifier events that have happened
+ * enum bus_notifier_event - Bus Notifier events that have happened
+ * @BUS_NOTIFY_ADD_DEVICE: device is added to this bus
+ * @BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
+ * @BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
+ * @BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
+ * @BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
+ * @BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
+ * @BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
+ * @BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
  *
  * These are the value passed to a bus notifier when a specific event happens.
  *
@@ -280,15 +288,6 @@ extern int bus_unregister_notifier(struc
  * you do with the device structure.
  *
  * All bus notifiers are called with the target struct device * as an argument.
- *
- * BUS_NOTIFY_ADD_DEVICE: device is added to this bus
- * BUS_NOTIFY_DEL_DEVICE: device is about to be removed from this bus
- * BUS_NOTIFY_REMOVED_DEVICE: device is successfully removed from this bus
- * BUS_NOTIFY_BIND_DRIVER: a driver is about to be bound to this device on this bus
- * BUS_NOTIFY_BOUND_DRIVER: a driver is successfully bound to this device on this bus
- * BUS_NOTIFY_UNBIND_DRIVER: a driver is about to be unbound from this device on this bus
- * BUS_NOTIFY_UNBOUND_DRIVER: a driver is successfully unbound from this device on this bus
- * BUS_NOTIFY_DRIVER_NOT_BOUND: a driver failed to be bound to this device on this bus
  */
 enum bus_notifier_event {
 	BUS_NOTIFY_ADD_DEVICE =		1,


-- 
~Randy
