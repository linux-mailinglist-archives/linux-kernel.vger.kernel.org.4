Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711DF6B7035
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:41:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjCMHlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:41:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CD3C7AD;
        Mon, 13 Mar 2023 00:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E074BB80E25;
        Mon, 13 Mar 2023 07:41:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D0E3C433D2;
        Mon, 13 Mar 2023 07:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678693307;
        bh=yTeihFG8pDtEUq7KvcYgGilqQ8Naw5EVygloJBWMFns=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rpo8t6A153b8oMrae0bb9b6EYPVjnws/zAFfMR1HjcWdEorvLo+cwdFYNgKBAHHGZ
         Twf0dRjN6gT/UhH4psYnM8NOciif/YPo8eOlCHUvDkOUhvmxfBC5PLwZAfwOOEFWsq
         ekknSxBo1CARMU1+g/Beo7TWpckHdJwMKWg0VHtxQonVbU1HOoeTpzMafDMp3J6ml0
         PuYEiFiCz/UmuQph+L3s00XYk0T4rJc8JR1G5j6gIOCi55wzd9fqCtpJWF/Ye6MjBP
         7gjMViHdYvKAZla3agMDhLG6XLzM7w9/vqkZxLUnOovhPppSWYD0DXQc7ZwMSOgcVc
         SGQAspwnmPIig==
Message-ID: <d173d6d2-b9e6-b385-4685-301fc15e2675@kernel.org>
Date:   Mon, 13 Mar 2023 08:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] spi: mpc5xxx-psc: Fix compile error
To:     Andi Shyti <andi.shyti@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20230312133959.256855-1-andi.shyti@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230312133959.256855-1-andi.shyti@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/03/2023 14:39, Andi Shyti wrote:
> Commit 9e21720a4958 ("spi: mpc5xxx-psc: use
> devm_clk_get_enabled() for core clock") has made use of the
> devm_clk_get_enabled(), but it actually forgot to remove a couple
> of goto's, triggering the following compile error:
> 
> drivers/spi/spi-mpc512x-psc.c: In function ‘mpc512x_psc_spi_of_probe’:
> drivers/spi/spi-mpc512x-psc.c:518:17: error: label ‘free_ipg_clock’ used but not defined
>   518 |                 goto free_ipg_clock;
> 
> Replace those goto's with actual returns.

https://lore.kernel.org/all/20230310111544.57342-1-andriy.shevchenko@linux.intel.com/

Best regards,
Krzysztof

