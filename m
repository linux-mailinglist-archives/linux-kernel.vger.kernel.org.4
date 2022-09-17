Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18C395BB876
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 15:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbiIQNZX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 09:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiIQNZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 09:25:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22BF26119;
        Sat, 17 Sep 2022 06:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D1DD60E75;
        Sat, 17 Sep 2022 13:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CFBC433D6;
        Sat, 17 Sep 2022 13:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663421114;
        bh=ppWAv9KdCNYGZslmkybA3attMp8lGeI43yrrtw1qkQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LpoZ9clhC3OGzLsTjzAOJVm8ZJUt9zd4BDohT0yykTRP2wXEG7J0rCRY/EQNDGKtD
         U+8x5vJgBSxc/a+e054ALVFIJSmJvvRb7HpMntbdigSlDemxiZw90O1IeqiAG9ol0L
         ykfMsjLhQQdDV4M6rD6zSdl7s8rizpj3tqnneliJINXtGpz1pWfAb5d2ML1O3uHmjX
         +oT7VkbQrEHKA32OEi+VaWJjBZ3g46mMF6tkNXGiLezO4BF4c5T/t4dyXSaZsnutjA
         pHeXyxXl9iu9jGMFP00xVaOvxIDhRnpiEPq1Mg3mXpNXTTjJYh39mHNI0o4qWx+Lrr
         nl3edG2+aPuWA==
Date:   Sat, 17 Sep 2022 14:25:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 7/9] iio: pressure: bmp280: Add support for BMP380
 sensor family
Message-ID: <20220917142516.3fc145b6@jic23-huawei>
In-Reply-To: <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
References: <cover.1663025017.git.ang.iglesiasg@gmail.com>
        <f1da2a2f1bc5bb083f318335c23b4f3d9bb8e536.1663025017.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 01:52:13 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Adds compatibility with the new generation of this sensor, the BMP380.
> 
> Includes basic sensor initialization to do pressure and temp
> measurements and allows tuning oversampling settings for each channel.
> 
> The compensation algorithms are adapted from the device datasheet and
> the repository https://github.com/BoschSensortec/BMP3-Sensor-API.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>
There is one place (around the reset handing) in here where I
suspect we'll end up revisiting it because the matching by
device ID is not particularly extensible to new devices.

Anyhow, can handle that at the time.

I had to hand apply parts of this because of the clash Andy
raised.  As a general rule it's better to keep one linear
flow of patches unless they are on well separate parts of
a driver.  Saves me effort :)  Here it was just one line to
cut and paste, but you still get to now check I didn't mess
that up ;)

Applied - please check result in testing branch of iio.git.

Note I plan to rebase that branch after the first pull request
is accepted as I have some dependencies blocking other
patches and a fast forward rebase is the easiest way to deal
with those cleanly.

Jonathan
