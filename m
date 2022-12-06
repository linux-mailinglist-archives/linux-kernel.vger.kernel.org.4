Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5E26447CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235426AbiLFPSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232046AbiLFPRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:17:16 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC11115
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=H1//nXXWnd3IvEA/8K9+DU2/XNjGt8vXcnTNixiMSsA=; b=cTQGLedKj7KCb3zTVHCalu8qZp
        3pdAoq0g9kalvf44twAyr6WMgZ99d5YsjkHW2dF9UNnt0UvrsbXJFhFykQ1If42VLyRr1GUlUyTqv
        9NuKpaLbz6YDVWRCM0GkNhXqSado52ubd0wJfdKVnkwrYzjkSfFDvpYVbvkN8V7TgSV2I0w5+Cmx+
        ClWLFvitbUXHvJX+7ncycj/ltmtEprQq/AzET/JbCYip8qJYAIpAmZnn3+hHZ/MQBEHnS5gwLaIq9
        QulTv7fD0/Fd/p0SzZ/5RrOcU/6ygwh3/W9W6995NopZwLlP7qKm7YOCQcvLw4GxTuz6x99rJDmN5
        ASbCMWHA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p2ZdR-004XiZ-JO; Tue, 06 Dec 2022 15:13:29 +0000
Date:   Tue, 6 Dec 2022 15:13:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/4] container_of: add container_of_const() that
 preserves const-ness of the pointer
Message-ID: <Y49cGRDBVP3bHJuT@casper.infradead.org>
References: <20221205121206.166576-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205121206.166576-1-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 01:12:03PM +0100, Greg Kroah-Hartman wrote:
> +/**
> + * container_of_const - cast a member of a structure out to the containing
> + *			structure and preserve the const-ness of the pointer
> + * @ptr:		the pointer to the member
> + * @type:		the type of the container struct this is embedded in.
> + * @member:		the name of the member within the struct.
> + */
> +#define container_of_const(ptr, type, member)				\
> +	_Generic(ptr,							\
> +		const typeof(*(ptr)) *: ((const type *)container_of(ptr, type, member)),\
> +		default: ((type *)container_of(ptr, type, member))	\
> +	)
> +

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

I tried doing this:

+++ b/include/linux/container_of.h
@@ -15,11 +15,17 @@
  *
  * WARNING: any const qualifier of @ptr is lost.
  */
-#define container_of(ptr, type, member) ({                             \
+#define _c_of(ptr, type, member) ({                                    \
        void *__mptr = (void *)(ptr);                                   \
        static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
                      __same_type(*(ptr), void),                        \
                      "pointer type mismatch in container_of()");       \
        ((type *)(__mptr - offsetof(type, member))); })

+#define container_of(ptr, type, m)                                     \
+       _Generic(ptr,                                                   \
+               const typeof(*(ptr)) *: (const type *)_c_of(ptr, type, m),\
+               default: ((type *)_c_of(ptr, type, m))                  \
+       )
+
 #endif /* _LINUX_CONTAINER_OF_H */

(whitespace damaged, yes the kernel-doc is now in the wrong place, etc)

It found a few problems; just building the mlx5 driver (I happened to be
doing some work on it in that tree).  We're definitely not ready to do
that yet, but I'll send a few patches to prepare for it.
