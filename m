Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8555F669057
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240961AbjAMIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:14:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbjAMINz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:13:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2948259F91;
        Fri, 13 Jan 2023 00:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA78AB820CA;
        Fri, 13 Jan 2023 08:13:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42048C433EF;
        Fri, 13 Jan 2023 08:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673597588;
        bh=e82KldTW+22fw/XcEjwHA5r/L+QWcGUnApIZctnI2r8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pFvAD7+HgskunVyZIJftYy/Kr42SX8kJb0fTZB/CsxX9m2hooZbzHnMhQZyF+P/Gj
         /6RfuJHBOWfRbgjC2azK7UPHY3pACMMi6L2jHHiDc78WhTrBtL4wcKougRh2GvJu4E
         hKcr5lHt0qG0AQfCTDUQiU2ZW5jqpU5h5xGsW5cL/sWE6Pwxd++yIdJyVYglkPKiHP
         2x5xOb4r9vtqmDNJdorQSwN6OMKy9wH7l9znXClPEqLCDzn8vCxZmPMY2LgKT9Hl44
         fV3dq07IsQKZRhQmYF2t+4Ibt3wrMEaW9Cfh4n3MuyXB9ktCcyaUyWHF+2h5mv9PyQ
         YA279FKhJBPTQ==
Message-ID: <a4bb91b5-a0c9-a81f-cdf8-7ce75552eacb@kernel.org>
Date:   Fri, 13 Jan 2023 09:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LINUX PATCH 3/3] pwm: pwm-cadence: Add support for TTC PWM
Content-Language: en-US
To:     Mubin Sayyed <mubin.sayyed@amd.com>, robh+dt@kernel.org,
        treding@nvidia.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, mubin10@gmail.com
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-4-mubin.sayyed@amd.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230112071526.3035949-4-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 08:15, Mubin Sayyed wrote:
> Cadence TTC timer can be configured as clocksource/clockevent
> or PWM device. Specific TTC device would be configured as PWM
> device, if pwm-cells property is present in the device tree
> node.
> 

(...)

> +
> +static const struct of_device_id ttc_pwm_of_match[] = {
> +	{ .compatible = "cdns,ttc"},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, ttc_pwm_of_match);
> +
> +static struct platform_driver ttc_pwm_driver = {
> +	.probe = ttc_pwm_probe,
> +	.remove = ttc_pwm_remove,
> +	.driver = {
> +		.name = "ttc-pwm",
> +		.of_match_table = of_match_ptr(ttc_pwm_of_match),

This leads to warnings. Drop it or use maybe_unused.

Best regards,
Krzysztof

