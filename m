Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAE270EE5F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbjEXGq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbjEXGpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:45:47 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7684172C;
        Tue, 23 May 2023 23:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8hIfpBZo4uHhlxea9AKSLxE7i5cEVMRbEHxPZhvoC8w=; b=TZ98BR4jenjzt+JKfKBLVFHzQ4
        TtA0qIDdQ6GMs7qDA/Aw0kUUo359rO13LZdOFfwfafMxs/vWYVX3ojJWgBKo/DlbAuFsGQ1eSu2Os
        sMq9rUnWIXoZmPUkXki7peoyyAPfMqR9GNeZyUBll065KpgfMUqh3axtpVyc9w24svUdxUNbdXyCK
        9FeWp+8R3ocZ/oTpvBcMyxsbDf8UrugWWdXXxtMy8Kkoaj97B+hcJwVqHrLwNLqYuJM71CZbj3EyA
        r8J7nQcssJvyUUtC7WjO0K1AlyXTnuVZPAXKHfKW2+HqgNqHrvYyjA5yuDzJabWSzgwkOPnedU/aG
        wu/cWq6A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1q1iEV-00CWTX-1C;
        Wed, 24 May 2023 06:44:27 +0000
Date:   Tue, 23 May 2023 23:44:27 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        nick.alcock@oracle.com
Subject: Re: [PATCH v10 04/11] module.h: MODULE_DEVICE_TABLE for built-in
 modules
Message-ID: <ZG2yS0sj0EgGoFYf@bombadil.infradead.org>
References: <20221219204619.2205248-1-allenwebb@google.com>
 <20230406190030.968972-1-allenwebb@google.com>
 <20230406190030.968972-5-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406190030.968972-5-allenwebb@google.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 02:00:23PM -0500, Allen Webb wrote:
> Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
> to generate a builtin.alias file to complement modules.alias.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  include/linux/module.h | 36 +++++++++++++++++++++++++++++-------
>  1 file changed, 29 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 4435ad9439ab..b1cb12e06996 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -237,14 +237,36 @@ extern void cleanup_module(void);
>  /* What your module does. */
>  #define MODULE_DESCRIPTION(_description) MODULE_INFO(description, _description)
>  
> -#ifdef MODULE
> -/* Creates an alias so file2alias.c can find device table. */
> +/*
> + * Creates an alias so file2alias.c can find device table.
> + *
> + * Use this in cases where a device table is used to match devices because it
> + * surfaces match-id based module aliases to userspace for:
> + *   - Automatic module loading through modules.alias.
> + *   - Tools like USBGuard which block devices based on policy such as which
> + *     modules match a device.
> + *
> + * The only use-case for built-in drivers today is to enable userspace to
> + * prevent / allow probe for devices on certain subsystems even if the driver is
> + * already loaded. An example is the USB subsystem with its authorized_default
> + * sysfs attribute. For more details refer to the kernel's Documentation for USB
> + * about authorized_default.
> + *
> + * The module name is included in the alias for two reasons:
> + *   - It avoids creating two aliases with the same name for built-in modules.
> + *     Historically MODULE_DEVICE_TABLE was a no-op for built-in modules, so
> + *     there was nothing to stop different modules from having the same device
> + *     table name and consequently the same alias when building as a module.
> + *   - The module name is needed by files2alias.c to associate a particular
> + *     device table with its associated module for built-in modules since
> + *     files2alias would otherwise see the module name as `vmlinuz.o`.
> + */
>  #define MODULE_DEVICE_TABLE(type, name)					\
> -extern typeof(name) __mod_##type##__##name##_device_table		\
> -  __attribute__ ((unused, alias(__stringify(name))))
> -#else  /* !MODULE */
> -#define MODULE_DEVICE_TABLE(type, name)
> -#endif
> +extern void *CONCATENATE(						\
> +	CONCATENATE(__mod_##type##__##name##__,				\
> +		__KBUILD_MODNAME),					\
> +	_device_table)							\
> +	__attribute__ ((unused, alias(__stringify(name))))

Why does it seem like we're changing extern typeof(name) to a void *?
Also the addition of CONCATENATE() makes it not clear if you are
modifying the definition before, so it would be good to first add
CONCATENATE() to replace the old way without making any functional
changes first. Then a secondary patch which extends the world for
built-in.

  Luis
