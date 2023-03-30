Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D0B6CFC20
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 09:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjC3HBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 03:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjC3HB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 03:01:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0721FE2;
        Thu, 30 Mar 2023 00:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BBEF61F0E;
        Thu, 30 Mar 2023 07:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78482C433EF;
        Thu, 30 Mar 2023 07:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680159686;
        bh=H3toqFQVNcpuGUTVQatxSq9QUFu7uhOw9AGmIacnjMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RbIfwNUYo6lNqcJnUmsRHqjAeehV12pNlEYbDi4Cu1UYYibz0ZSoqLAXT3AA8fpJI
         hbSxynNc2t0S8Fmqbdg951w0p8NeQX8DjcZRiBWMbV66HyCLOL9BWUquWB07w9cDS3
         8bK9seUy7ecfj152HB8nBW5OVSrOZ9s6QqHFiiKqNT+7OFs2VnpoBeUGGrbJeX3pRO
         MSJJiwnRP+KJMzpAqD6vdrivZuv5kUIcyvzoLhGw0q2h6raXKXsQOE1fvO208rNHkA
         b7k0hf4Yxf9+U9YBPhDQtEceMFPlYXw1Bofp+9IdQSTVmI7JxW6D931MM7jQ4O/QPW
         xK+mibakT364A==
Date:   Thu, 30 Mar 2023 15:01:23 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] platform/chrome: Fix -Warray-bounds warnings
Message-ID: <ZCUzw9epJig2rTIY@google.com>
References: <ZCTrutoN+9TiJM8u@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCTrutoN+9TiJM8u@work>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 07:54:02PM -0600, Gustavo A. R. Silva wrote:
> In this case, as only enough space for the op field is allocated,
> we can use an object of type uint32_t instead of a whole
> struct ec_params_vbnvcontext (for which not enough memory is
> allocated).

It doesn't make sense to me.  See comments below.

> Fix the following warning seen under GCC 13:
> drivers/platform/chrome/cros_ec_vbc.c: In function ‘vboot_context_read’:
> drivers/platform/chrome/cros_ec_vbc.c:36:15: warning: array subscript ‘struct ec_params_vbnvcontext[1]’ is partly outside array bounds of ‘unsigned char[36]’ [-Warray-bounds=]
>    36 |         params->op = EC_VBNV_CONTEXT_OP_READ;
>       |               ^~
> In file included from drivers/platform/chrome/cros_ec_vbc.c:12:
> In function ‘kmalloc’,
>     inlined from ‘vboot_context_read’ at drivers/platform/chrome/cros_ec_vbc.c:30:8:
> ./include/linux/slab.h:580:24: note: at offset 20 into object of size 36 allocated by ‘kmalloc_trace’
>   580 |                 return kmalloc_trace(
>       |                        ^~~~~~~~~~~~~~
>   581 |                                 kmalloc_caches[kmalloc_type(flags)][index],
>       |                                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   582 |                                 flags, size);
>       |                                 ~~~~~~~~~~~~

Please trim the commit message a bit and try to wrap at 75 columns as
[1] suggested.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#the-canonical-patch-format

> @@ -20,10 +20,14 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>  	struct device *dev = kobj_to_dev(kobj);
>  	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
>  	struct cros_ec_device *ecdev = ec->ec_dev;
> -	struct ec_params_vbnvcontext *params;
>  	struct cros_ec_command *msg;
> +	/*
> +	 * This should be a pointer to the same type as op field in
> +	 * struct ec_params_vbnvcontext.
> +	 */
> +	uint32_t *params_op;
>  	int err;
> -	const size_t para_sz = sizeof(params->op);
> +	const size_t para_sz = sizeof(*params_op);
>  	const size_t resp_sz = sizeof(struct ec_response_vbnvcontext);
>  	const size_t payload = max(para_sz, resp_sz);
>  
> @@ -32,8 +36,8 @@ static ssize_t vboot_context_read(struct file *filp, struct kobject *kobj,
>  		return -ENOMEM;
>  
>  	/* NB: we only kmalloc()ated enough space for the op field */
> -	params = (struct ec_params_vbnvcontext *)msg->data;
> -	params->op = EC_VBNV_CONTEXT_OP_READ;
> +	params_op = (uint32_t *)msg->data;
> +	*params_op = EC_VBNV_CONTEXT_OP_READ;

I don't see a good reason to partially allocate memory here.  Perhaps, just
let `para_sz = sizeof(struct ec_params_vbnvcontext)`?  If it also makes
sense to you, please remove the comment "NB: we only..." as well.
