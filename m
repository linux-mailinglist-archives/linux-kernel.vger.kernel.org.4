Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE845656107
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 09:12:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiLZIMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 03:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiLZIMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 03:12:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85FAD50
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 00:12:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2601460DC9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Dec 2022 08:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB59C433D2;
        Mon, 26 Dec 2022 08:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672042331;
        bh=wMuh9Av5x2EBeAbbJdx5ZXgId/edsEDT23jMjb6QRrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mud1JdpJrry9t6QgimWLSE7u7VqIuEx5iH8K20/BgWmkh3hfdl23iTfmg73cA955V
         U4gnPnJt96uJPfwEl/AfU0nmEvbsHKKlE4F7jxsBibfpnt5h1TFiVvTaSzKLsEEdMT
         hRlHmOAScwBgUz/qPEoEj5SYwO55seoaglnzldTc4txV1gmyUWFfwFrrjyx0yE6BZN
         awXmuMJCC4Yn3uGT6myeTJR6Gn3+2Pxx2mYg0lgDBbh5+PTINMEH09/X3e0YlNPz0g
         LiRyawGC92O/3DDdCQemmRjdHFwwfj9FMT1CXqqX2t1bR6ibGkbzNFmnzzdf+vKLlr
         9PhiBk9xjFiBw==
Date:   Mon, 26 Dec 2022 16:12:07 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        kernel test robot <lkp@intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v12 1/3] platform/chrome: cros_ec_uart: Add cros-ec-uart
 transport layer
Message-ID: <Y6lXV8Rhh1Da572l@google.com>
References: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209092619.v12.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 09:26:22AM -0700, Mark Hasemeyer wrote:
> diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
[...]
> +static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
> +				 const u8 *data,
> +				 size_t count)
> +{
> +	struct ec_host_response *response;

There are 2 "response" in the context: struct response_info vs.
struct ec_host_response.  The pointer `response` here is only used for
setting `exp_len`.

I would suggest to introduce another pointer:
    struct response_info *resp = &ec_uart->response;
So that most of the following "ec_uart->response." could simplify to
"resp->".

[...]
> +	/* Read data_len if we received response header and if exp_len was not read before. */
> +	if (ec_uart->response.size >= sizeof(*response) &&
> +	    ec_uart->response.exp_len == 0) {
> +		response = (struct ec_host_response *) ec_uart->response.data;

Please drop the extra space.

> +static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
> +				 struct cros_ec_command *ec_msg)
> +{
> +	struct cros_ec_uart *ec_uart = ec_dev->priv;
> +	struct serdev_device *serdev = ec_uart->serdev;
> +	struct ec_host_response *response;

Ditto, if using another pointer to struct response_info could simplify the
function a bit.

> +	unsigned int len;
> +	int ret, i;
> +	u8 sum = 0;

To make it clear, please drop the initialization and set it to 0 just right
before it is used.

[...]
> +	/* Validate checksum */
> +	for (i = 0; i < sizeof(*response) + response->data_len; i++)
> +		sum += ec_dev->din[i];

The function is long.  Setting sum to 0 before the loop improves the
readability.

> +static int cros_ec_uart_probe(struct serdev_device *serdev)
> +{
> +	struct device *dev = &serdev->dev;
> +	struct cros_ec_device *ec_dev;
> +	struct cros_ec_uart *ec_uart;
> +	int ret;
> +
> +	ec_uart = devm_kzalloc(dev, sizeof(*ec_uart), GFP_KERNEL);
> +	if (!ec_uart)
> +		return -ENOMEM;
> +
> +	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
> +	if (!ec_dev)
> +		return -ENOMEM;
> +
> +	ec_uart->serdev = serdev;

The assignment can move somewhere before calling cros_ec_uart_acpi_probe().

> +
> +	ret = devm_serdev_device_open(dev, ec_uart->serdev);

Using `ec_uart->serdev` here makes less sense.  Please use `serdev` directly.
