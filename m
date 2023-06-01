Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D039C71F4E8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232767AbjFAVj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjFAVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:39:54 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B90E6B
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 14:39:27 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id c73ded7f-00c4-11ee-b972-005056bdfda7;
        Fri, 02 Jun 2023 00:39:25 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 2 Jun 2023 00:39:25 +0300
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v8 1/1] gpio: add sloppy logic analyzer using polling
Message-ID: <ZHkQDTvk6I2q-9CF@surfacebook>
References: <20220329091126.4730-1-wsa+renesas@sang-engineering.com>
 <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329091126.4730-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Mar 29, 2022 at 11:11:26AM +0200, Wolfram Sang kirjoitti:
> This is a sloppy logic analyzer using GPIOs. It comes with a script to
> isolate a CPU for polling. While this is definitely not a production
> level analyzer, it can be a helpful first view when remote debugging.
> Read the documentation for details.

One note since I have done recent review and realize one issue with debugfs.

...

> +	priv->debug_dir = debugfs_create_dir(devname, gpio_la_poll_debug_dir);

If this fails with NULL...

> +	debugfs_create_blob("meta_data", 0400, priv->debug_dir, &priv->meta);
> +	debugfs_create_ulong("delay_ns", 0600, priv->debug_dir, &priv->delay_ns);
> +	debugfs_create_ulong("delay_ns_acquisition", 0400, priv->debug_dir, &priv->acq_delay);
> +	debugfs_create_file_unsafe("buf_size", 0600, priv->debug_dir, priv, &fops_buf_size);
> +	debugfs_create_file_unsafe("capture", 0200, priv->debug_dir, priv, &fops_capture);
> +	debugfs_create_file_unsafe("trigger", 0200, priv->debug_dir, priv, &fops_trigger);

...and any of these is not, we will end up with the file in a root folder of debugfs...

> +	dev_info(dev, "initialized");

...

> +static int gpio_la_poll_remove(struct platform_device *pdev)
> +{
> +	struct gpio_la_poll_priv *priv = platform_get_drvdata(pdev);
> +
> +	mutex_lock(&priv->lock);
> +	debugfs_remove_recursive(priv->debug_dir);

...and this one won't remove it.

> +	mutex_unlock(&priv->lock);
> +	mutex_destroy(&priv->lock);
> +
> +	return 0;
> +}

...

However, I haven't checked if it's pure theoretical issue with the current code
base of debugfs or a potential problem. Easy fix is to check an error code and
skip the files creation. Not sure if driver will be useful in that case.

-- 
With Best Regards,
Andy Shevchenko


