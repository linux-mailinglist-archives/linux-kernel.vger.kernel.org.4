Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABE6651AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiLTGpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 01:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiLTGpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 01:45:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1802D49;
        Mon, 19 Dec 2022 22:45:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54ACFB8105C;
        Tue, 20 Dec 2022 06:45:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2C8C433EF;
        Tue, 20 Dec 2022 06:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1671518741;
        bh=uBxVPPiKIxl2zKxQo9JeGq/snpbnz80BzLLwDGOX550=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WD9QJBCzdxepXwvsFQnMgLlWrv4LJT1hNp9b42nu7wv9rxIkLwd6YiwxeqOO5rQXF
         hL9aa1sOWJY99zS4ZL3APco4oUu6r1ytdBuvdDyt4tFpUevu528+duPMBahpQUHrmp
         7fg5/kfc52nIk12UmoJvoB5SM/nNk5Vh0KCa9SDs=
Date:   Tue, 20 Dec 2022 07:45:38 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v9 05/10] module.h: MODULE_DEVICE_TABLE for built-in
 modules
Message-ID: <Y6FaEoAAFFP0WqK3@kroah.com>
References: <20221219191855.2010466-1-allenwebb@google.com>
 <20221219204619.2205248-1-allenwebb@google.com>
 <20221219204619.2205248-6-allenwebb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219204619.2205248-6-allenwebb@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:46:13PM -0600, Allen Webb wrote:
> Implement MODULE_DEVICE_TABLE for build-in modules to make it possible
> to generate a builtin.alias file to complement modules.alias.
> 
> Signed-off-by: Allen Webb <allenwebb@google.com>
> ---
>  include/linux/module.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index ec61fb53979a..3d1b04ca6350 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -243,7 +243,20 @@ extern void cleanup_module(void);
>  extern typeof(name) __mod_##type##__##name##_device_table		\
>    __attribute__ ((unused, alias(__stringify(name))))
>  #else  /* !MODULE */
> -#define MODULE_DEVICE_TABLE(type, name)
> +/*
> + * The names may not be unique for built-in modules, so include the module name
> + * to guarantee uniqueness.

What "names" are you referring to here with the words, "The names"?

And built-in modules have the same rules as external names, they have to
be unique so I do not understand the problem you are trying to solve
here, which means you need to describe it better in both the changelog
text and the comment.

> + *
> + * Note that extern is needed because modpost reads these symbols to generate
> + * modalias entries for each match id in each device table. They are not used
> + * at runtime.

This comment isn't explaining much about what the #define is to be used
for, is it?

confused,

greg k-h
