Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5172A65FC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjAFIK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 03:10:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjAFIK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 03:10:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFAF378E99;
        Fri,  6 Jan 2023 00:10:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F33661D4C;
        Fri,  6 Jan 2023 08:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FA2C433D2;
        Fri,  6 Jan 2023 08:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672992621;
        bh=lFl3l56T6EeKmFd7eKwb8kpBaqgT6RyrMDeq/Q/+4Hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zhd2tDSE2dS6kqJ117QE2moXaS3KRy0sIGlRXifPKdSnsN+0KWeLyGd2mB/d7g8C1
         OOPg8qAZkV7e1qXCwdGklizF4+r2RHlUPFQkxxvMnP0ioLJjIu9HvZ6fHDXfTTDMNt
         SKfHmhBci+es9br3kqixq+QPn3/V/ktha/xNV0vM=
Date:   Fri, 6 Jan 2023 09:10:18 +0100
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
Subject: Re: [PATCH v3] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <Y7fXapwb5yJNbM3G@kroah.com>
References: <20230103081531.423017-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230103081531.423017-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 04:15:31PM +0800, Haotien Hsu wrote:
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
> ---
> V1->V2
> - Fix uninitialized symbol 'cci'
> v2->v3
> - Remove wrong Reported-by tags
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 86 ++++++++++++++++++++++++++++---
>  1 file changed, 79 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index eab3012e1b01..b35a3a97c9fb 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
>  	bool checked;
>  } __packed;
>  
> +#define CCGX_MESSAGE_IN_MAX 4
> +struct op_region {
> +	u32 cci;
> +	u32 message_in[CCGX_MESSAGE_IN_MAX];
> +};
> +
>  struct ucsi_ccg {
>  	struct device *dev;
>  	struct ucsi *ucsi;
> @@ -222,6 +228,9 @@ struct ucsi_ccg {
>  	bool has_multiple_dp;
>  	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
>  	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
> +
> +	spinlock_t op_lock;

What does this lock protect?  Please document that so that we can verify
if this really is a correct change _AND_ so we know what future changes
need to take the lock or not.

> +	struct op_region op_data;
>  };
>  
>  static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
> @@ -305,12 +314,57 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
>  	return 0;
>  }
>  
> +static void ccg_op_region_read(struct ucsi_ccg *uc, unsigned int offset,
> +		void *val, size_t val_len)
> +{
> +	struct op_region *data = &uc->op_data;
> +
> +	spin_lock(&uc->op_lock);
> +	if (offset == UCSI_CCI)
> +		memcpy(val, &data->cci, val_len);
> +	else if (offset == UCSI_MESSAGE_IN)
> +		memcpy(val, &data->message_in, val_len);
> +	spin_unlock(&uc->op_lock);
> +}
> +
> +static void ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
> +{
> +	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
> +	struct op_region *data = &uc->op_data;
> +	u32 message_in[CCGX_MESSAGE_IN_MAX];
> +
> +	if (UCSI_CCI_LENGTH(cci))
> +		if (ccg_read(uc, reg, (void *)&message_in,
> +					sizeof(message_in))) {
> +			dev_err(uc->dev, "failed to read MESSAGE_IN\n");

What can userspace do with this error?  Will it be repeated a lot?

thanks,

greg k-h
