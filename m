Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7859962ED47
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 06:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240994AbiKRFo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 00:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240980AbiKRFo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 00:44:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D6E781B7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 21:44:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3E7BDB82289
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 05:44:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ECFAC433C1;
        Fri, 18 Nov 2022 05:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668750263;
        bh=8UNw72vtePNuy20elDajpRx7jkdEzL8qsaeAcoAR8ek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDq8eAj3Nll5jTlojaUiSRDcXaiN7HkW8LUDs34SL9AtYFtqvI9v9Y0Zo2kl1yxEH
         L9BkmmbObqF6HlyNvtcB1Obz1///wLymPuEdqjA99tDqDj2TRXlbCvlFHRlwkMSD72
         q1qlplhb4dWNFX6F3HMBROkcYdpQfAvNj+0vIf3qFJXWevy1RoVoDEru9oWC4vb+Dx
         g8c/98vF+Gm83JNxF749L/INMVgWoDijb26uj7qT0YIPv8FwrpxhyVIjo6q3SBCcB5
         NhSndHJ7nKDg3JBS2nlu/vHgIuk/Bf+JR8L1BSIUlMyhAoXLrisoFX0Ds8MpBNcq/q
         OZitTh9v8iHAg==
Date:   Fri, 18 Nov 2022 13:44:19 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Mark Hasemeyer <markhas@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev
Subject: Re: [PATCH v7 3/3] platform/chrome: cros_ec_uart: Add DT enumeration
 support
Message-ID: <Y3cbswXxTKWhMjKT@google.com>
References: <20221117114818.v7.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
 <20221117114818.v7.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117114818.v7.3.Ie23c217d69ff25d7354db942613f143bbc8ef891@changeid>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 11:48:48AM -0700, Mark Hasemeyer wrote:
> @@ -392,6 +393,12 @@ static int __maybe_unused cros_ec_uart_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
>  			 cros_ec_uart_resume);
>  
> +static const struct of_device_id cros_ec_uart_of_match[] = {
> +	{ .compatible = "google,cros-ec-uart" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_uart_of_match);

It would need a guard for checking CONFIG_OF.  Similar to what
`cros_ec_uart_acpi_id` does.

> @@ -405,6 +412,7 @@ static struct serdev_device_driver cros_ec_uart_driver = {
>  	.driver	= {
>  		.name	= "cros-ec-uart",
>  		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
> +		.of_match_table = cros_ec_uart_of_match,

It would need be wrapped by `of_match_ptr()`.  Similar to what
`ACPI_PTR()` does.
