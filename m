Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EA4265FD4D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:08:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAFJIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAFJId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:08:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895361C436
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:08:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 276A061D58
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 09:08:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF9FC433D2;
        Fri,  6 Jan 2023 09:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672996110;
        bh=4nrv9O5BL94tk4LE5kqrTpUjmT36drfqRc0Gut7k0Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oLlpw6LEV0dblqDXr3O/S1T62dg7UWg6nKDlN+8BR9WVU6e8wOqiSSasHqHIiGxic
         Kh3G7TryqAgaVRzgxW8Rh4ao8/v4uz+mOas57N8AD66f6NCKVnal6IUQIQGT8KGc5F
         4L+N25tk9uCGwv+WDe1BkdXDbqSyKgl0TzVIhiAHzcrz8Vrao5HQWepbI8BXIjJS45
         KdBmKo8awvKXjHnVpBT1Ncv3L3vaiv1NevdKbkM0+kKqHKCl2SqKjdntbHtnPm9pHm
         lNxIfPeibrrTfqg4G3t5mESWSOoFbcVTNwUjEFfO8MarBjfDRjbJEPg4Jg661yUFPb
         IyagTS2kWBc9w==
Date:   Fri, 6 Jan 2023 17:08:27 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chromeos: cros_ec: Use per-device lockdep key
Message-ID: <Y7flCydDtLVwsXIJ@google.com>
References: <20230106045537.1243887-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106045537.1243887-1-wenst@chromium.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2023 at 12:55:37PM +0800, Chen-Yu Tsai wrote:
> Lockdep reports a bogus possible deadlock on MT8192 Chromebooks due to
> the following lock sequences:
> 
> 1. lock(i2c_register_adapter) [1]; lock(&ec_dev->lock)
> 2. lock(&ec_dev->lock); lock(prepare_lock);
> 
> The actual dependency chains are much longer. The shortened version
> looks somewhat like:
> 
> 1. cros-ec-rpmsg on mtk-scp
>    ec_dev->lock -> prepare_lock
> 2. In rt5682_i2c_probe() on native I2C bus:
>    prepare_lock -> regmap->lock -> (possibly) i2c_adapter->bus_lock
> 3. In rt5682_i2c_probe() on native I2C bus:
>    regmap->lock -> i2c_adapter->bus_lock
> 4. In sbs_probe() on cros-ec-i2c (passthrough) I2C bus on cros-ec
>    i2c_adapter->bus_lock -> ec_dev->lock
> 
> While lockdep is correct that the shared lockdep classes have a circular
> dependency, it is bogus because
> 
>   a) 2+3 happen on a native I2C bus
>   b) 4 happens on the actual EC on ChromeOS devices
>   c) 1 happens on the SCP coprocessor on MediaTek Chromebooks that just
>      happen to expose a cros-ec interface, but do not have a passthrough
>      I2C bus
> 
> In short, the "dependencies" are actually on different devices.

Path of 4 looks weird to me.

Could you point out where sbs_probe() gets to acquire ec_dev->lock?

I may misunderstand: I thought there is no such I2C bus for passthrough
from kernel's point of view (as the bus and devices behind the EC).
See also [2].

[2]: https://elixir.bootlin.com/linux/v6.2-rc2/source/drivers/platform/chrome/cros_ec.c#L241


On a related note, for the commit title: s/chromeos/chrome/ if it gets
chance to have next version.
