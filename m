Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA8DC671DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 14:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjARNe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 08:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231292AbjARNe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 08:34:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF435954A
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 05:01:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8858061779
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:01:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BF0C433F0;
        Wed, 18 Jan 2023 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674046874;
        bh=ZgQ8CROsrrA0JKuNgafiJuxHxPON516RTKLjH3PXmGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jchgMKXL2txBCPZtgHE3w48gwdGcMKyel5XFvma2R/6xf2pBLBg+MEmwiKAYaMtqe
         /Y72VOzfh9RZPBRay/hD0xB1Y5t5qQaayhkJnHvXpZ9KxbYtwMdADZnU3w5b4jcvKF
         0kIHCUwaN3+nHh/EZ2glMX9MwxuogOKloaUObKG0=
Date:   Wed, 18 Jan 2023 14:01:11 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, wleavitt@marvell.com,
        peter.hilber@opensynergy.com, nicola.mazzucato@arm.com,
        tarek.el-sherbiny@arm.com, quic_kshivnan@quicinc.com,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 09/17] debugfs: Export debugfs_create_str symbol
Message-ID: <Y8ftl31h2iTKNCwz@kroah.com>
References: <20230118121426.492864-1-cristian.marussi@arm.com>
 <20230118121426.492864-10-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118121426.492864-10-cristian.marussi@arm.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 12:14:18PM +0000, Cristian Marussi wrote:
> Needed by SCMI Raw mode support when compiled as a loadable module.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> Used by the following patch in this series:
> 
> "firmware: arm_scmi: Populate a common SCMI debugsfs root"
> 
> SCMI stack can be configured as module so export is needed.
> ---
>  fs/debugfs/file.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
> index b54f470e0d03..1f971c880dde 100644
> --- a/fs/debugfs/file.c
> +++ b/fs/debugfs/file.c
> @@ -899,6 +899,7 @@ ssize_t debugfs_read_file_str(struct file *file, char __user *user_buf,
>  
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(debugfs_create_str);
>  
>  static ssize_t debugfs_write_file_str(struct file *file, const char __user *user_buf,
>  				      size_t count, loff_t *ppos)
> -- 
> 2.34.1
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
