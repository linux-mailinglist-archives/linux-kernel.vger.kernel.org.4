Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403C65BB42
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjACHcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236918AbjACHcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:32:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB7DEC2;
        Mon,  2 Jan 2023 23:32:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE85B611B1;
        Tue,  3 Jan 2023 07:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD685C433EF;
        Tue,  3 Jan 2023 07:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672731126;
        bh=H24tvaVsrQoX2ADT0MUXQLccLC7C362GsTZw5z5q+kE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1KeNQy42WiuWE0X+nRN77v/lkFfxwl/YxDyC5GYqHm9PvkfAtxe08eW/z042CMnO
         DDvNm3x7fWhMTS0Cx05ZO2lB/7u3QPy+yRmMC2d/T+y3pBilqy2aL3ir+H6m8oOOlE
         TAMsG1AiCR6eiGmrNnli6sfdIFJN23UPwiZHqjmM=
Date:   Tue, 3 Jan 2023 08:32:03 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haotien Hsu <haotienh@nvidia.com>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Sanket Goswami <Sanket.Goswami@amd.com>,
        Wayne Chang <waynec@nvidia.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <Y7PZ81G1LI20eGeq@kroah.com>
References: <20230103024023.235098-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103024023.235098-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:40:23AM +0800, Haotien Hsu wrote:
> From: Sing-Han Chen <singhanc@nvidia.com>
> 
> For the CCGx, when the OPM field in the INTR_REG is cleared, then the
> CCI data in the PPM is reset.
> 
> To align with the CCGx UCSI interface guide, this patch updates the
> driver to copy CCI and MESSAGE_IN before clearing UCSI interrupt.
> When a new command is sent, the driver will clear the old CCI and
> MESSAGE_IN copy.
> 
> Finally, clear UCSI_READ_INT before calling complete() to ensure that
> the ucsi_ccg_sync_write() would wait for the interrupt handling to
> complete.
> It prevents the driver from resetting CCI prematurely.
> 
> Signed-off-by: Sing-Han Chen <singhanc@nvidia.com>
> Signed-off-by: Haotien Hsu <haotienh@nvidia.com>
> Reported-by: kernel test robot <lkp@intel.com>

The test robot reported this whole issue?  If not, it should not be
here.

thanks,

greg k-h
