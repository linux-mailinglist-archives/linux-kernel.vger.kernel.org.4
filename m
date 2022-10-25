Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB8B60C3A0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 08:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbiJYGJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 02:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiJYGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 02:09:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2F7F53D7;
        Mon, 24 Oct 2022 23:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666678157; x=1698214157;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4M4RG7e6KbnVlnMZy0nJZCHUEfnJaV+ADRTY0rAYgCc=;
  b=Yp5CeQUupmfzwAf2koxjzZAAdaWvhQs9Q99bG+iMofAWUuFcvgoRQrqA
   ag55nxFALiBqurw34LBE4R2gW+Ad2dnfY8T0FrsEHp4wbupu1dS4FTRqX
   wY8DDZU9zqo5xXP+zjNc1VYqCZOOmfMEo7BpqocVcakXPRNTFZdpclqDV
   qGPKfG/enGbGIOqMYREocv/E0zd8Slp4Nq090+phCiy15N78+aqVk3h5s
   T6skQ09Im+dA9AUkHQ7nI+0PTu8dWuqd4zJ3JqDyE1iIt+sraxWsF9IK5
   F1nxuuN49yxP4EIY1fuwAb5xdWiAj4EWIpY6sd68vPixBI+HlQO2O2Y8O
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="287993687"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="287993687"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 23:08:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="806552299"
X-IronPort-AV: E=Sophos;i="5.95,211,1661842800"; 
   d="scan'208";a="806552299"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 24 Oct 2022 23:08:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id B4D20107; Tue, 25 Oct 2022 09:09:06 +0300 (EEST)
Date:   Tue, 25 Oct 2022 09:09:06 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] intel-spi: Split hardware and software sequencing
Message-ID: <Y1d9glOgHsQlZe2L@black.fi.intel.com>
References: <20221020164508.29182-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020164508.29182-1-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Oct 20, 2022 at 01:45:06PM -0300, Mauro Lima wrote:
> Right now the only driver for Intel's spi has a DANGEROUS tag for
> a bug in the past on certain Lenovo platforms. It was cleared out
> that the bug was caused for the spi software sequencing mechanism
> and if we only use the driver with the hardware sequencing
> capabilities will be much safer[1].
> 
> This changes will remove all the software sequencing bits from
> the driver and left only the hardware sequencing functionality.
> If the software sequencing capabilities are needed, the old driver
> can be build using the DANGEROUS option from the menu.
> 
> [1] https://lkml.org/lkml/2021/11/11/468
> 
> Mauro Lima (2):
>   spi: intel-spi: Move software sequencing logic outside the core
>   spi: intel-spi: build the driver with hardware sequencing by default

I'be been thinking about this and I believe we can do something simpler
instead.

All the modern "Core" CPUs expose this as PCI device and that only
supports hardware sequencer which should be safe so I think we can do
something like this:

1. Make spi-intel-pci.c to set the type to INTEL_SPI_CNL for all the
   controllers it supports (and double check that this is the case for
   all these controllers).

As a side effect the ispi->sregs will be set to NULL so the core driver
does not even try to use the software seguencer.

2. Update Kconfig of SPI_INTEL_PCI to remove "DANGEROUS" and mention in
   the help text that this only supports the hardware sequencer and only
   the modern core hardware.

3. Update Kconfig of SPI_INTEL_PLATFORM help text to mention that most
   of these are using software sequencer, leave "DANGEROUS" there.

Does this make sense? Let me know what you think. I can do this myself
as well (might take some while though since busy with other things
usual).
