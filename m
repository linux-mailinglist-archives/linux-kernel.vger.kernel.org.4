Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BD2625361
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232608AbiKKGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232607AbiKKGIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:08:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A10020F6D;
        Thu, 10 Nov 2022 22:08:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8009561E8B;
        Fri, 11 Nov 2022 06:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 934C1C433C1;
        Fri, 11 Nov 2022 06:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668146918;
        bh=/aaxms1L+zBzl7Dc4li2cF9DjOohT+MBQeM76oTWvVA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OULyLVatI27zp3pE2nJmF6EYqX611skhtOxVsfw4dPmhpgT72u+tLu7RczhoibZDl
         DlEJdWiHZF6Rw4MKelf8IrD45/Dlu63UF/i0kX3gHnOmxr0fNjWe8bJ9LIPESgIX51
         wWC2GxPulHm5QkcozDkx0u+ASwofnaYU/aF7f0+g=
Date:   Fri, 11 Nov 2022 07:08:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ferry Toth <ftoth@exalondelft.nl>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Ferry Toth <fntoth@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/2] usb: ulpi: defer ulpi_register on ulpi_read_id
 timeout
Message-ID: <Y23m5H5zRbv5fwcF@kroah.com>
References: <20221110211132.297512-1-ftoth@exalondelft.nl>
 <20221110211132.297512-2-ftoth@exalondelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110211132.297512-2-ftoth@exalondelft.nl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 10:11:31PM +0100, Ferry Toth wrote:
> Since commit 0f010171
> Dual Role support on Intel Merrifield platform broke due to rearranging
> the call to dwc3_get_extcon().

Please see the kernel documentation for how to refer to commits.  This
should be written as:

	Since commit 0f0101719138 ("usb: dwc3: Don't switch OTG -> peripheral if
	extcon is present"), Dual role....

> It appears to be caused by ulpi_read_id() on the first test write failing
> with -ETIMEDOUT. Currently ulpi_read_id() expects to discover the phy via
> DT when the test write fails and returns 0 in that case even if DT does not
> provide the phy. As a result usb probe completes without phy.
> 
> Signed-off-by: Ferry Toth <ftoth@exalondelft.nl>

What commit does this fix?

Should this also get a cc: stable?

thanks,

greg k-h
