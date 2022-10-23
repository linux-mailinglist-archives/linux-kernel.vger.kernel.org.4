Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B97576092AA
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 14:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJWMdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiJWMds (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 08:33:48 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4FF6DFBC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 05:33:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 821CECE090C
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 12:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7648FC433C1;
        Sun, 23 Oct 2022 12:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666528423;
        bh=QWW7kCYzn3NOSSHYoZswrahpAfEd86j5MSp0yxPTDGQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y3pA9JphVIofEHhPAiIWWLmoUA2kAkIlV47dCfh84+W7HChQ6bj/vuK8czSomh9GG
         tfoOvdRDbmYFNi+W5+sbKf1hL5sRSEgYYdSHALygCoWnvvHn/H5vVrUaSMVk6aZsCw
         7giKse+6xliJ9zWyov2XPq1gMEEzzi2lXM1KzlnA=
Date:   Sun, 23 Oct 2022 14:33:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     kernel test robot <lkp@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [driver-core:driver-core-testing] BUILD SUCCESS
 59789f3418dd3c0a187490d49e900a59a5c8d732
Message-ID: <Y1U0pINWo5yjUdc2@kroah.com>
References: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <635484ed.ADi+2sBza+UlAhjj%lkp@intel.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 08:03:57AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git driver-core-testing
> branch HEAD: 59789f3418dd3c0a187490d49e900a59a5c8d732  device property: Constify parameter in device_dma_supported() and device_get_dma_attr()
> 
> Unverified Warning (likely false positive, please contact us if interested):
> 
> drivers/hwmon/iio_hwmon.c:155 iio_hwmon_probe() warn: could not determine type of argument 4

Andy, this is due to your changes, here's the offending code:

	sname = devm_kasprintf(dev, GFP_KERNEL, "%pfwP", dev_fwnode(dev));

Now that dev_fwnode() is an inline function, the compiler is confused as
to what function to select?  Maybe, I don't know, it seems odd, can you
look into it?

thanks,

greg k-h
