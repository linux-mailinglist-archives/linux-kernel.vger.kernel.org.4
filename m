Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F546673898
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 13:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbjASMbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 07:31:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbjASM2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 07:28:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EBA5DC35;
        Thu, 19 Jan 2023 04:28:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E992600BE;
        Thu, 19 Jan 2023 12:28:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D2FEC43398;
        Thu, 19 Jan 2023 12:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674131295;
        bh=0ZwU3ll6yCQEYeTrv7/BPkLSK2FHjtCf0ety5Px9ILI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BogfNdNVixEaRfHwT5Kx6XFgl4eGUVZ4am0BsUogC/LMAeksnbVueN2ks7RE42zIi
         0pCYB56gCstxxHKSxT+V6NoNFdCsNHCklOrd+PmnUcpHHVu1oBRH8x7M3G2xj0+Gzc
         zf+tUsp7SCT8IycMZkcJKdL0dvoUmuXU6m5cDYgY=
Date:   Thu, 19 Jan 2023 13:28:12 +0100
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
Subject: Re: [PATCH v4] ucsi_ccg: Refine the UCSI Interrupt handling
Message-ID: <Y8k3XB53iHeE0XZF@kroah.com>
References: <20230118061523.1537992-1-haotienh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118061523.1537992-1-haotienh@nvidia.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 02:15:23PM +0800, Haotien Hsu wrote:
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
> - Remove misusing Reported-by tags
> v3->v4
> - Add comments for op_lock
> ---
>  drivers/usb/typec/ucsi/ucsi_ccg.c | 90 ++++++++++++++++++++++++++++---
>  1 file changed, 83 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/usb/typec/ucsi/ucsi_ccg.c b/drivers/usb/typec/ucsi/ucsi_ccg.c
> index eab3012e1b01..532813a32cc1 100644
> --- a/drivers/usb/typec/ucsi/ucsi_ccg.c
> +++ b/drivers/usb/typec/ucsi/ucsi_ccg.c
> @@ -192,6 +192,12 @@ struct ucsi_ccg_altmode {
>  	bool checked;
>  } __packed;
>  
> +#define CCGX_MESSAGE_IN_MAX 4
> +struct op_region {
> +	u32 cci;

This is coming from hardware so you have to specify the endian-ness of
it, right?

> +	u32 message_in[CCGX_MESSAGE_IN_MAX];

Same here.

> +};
> +
>  struct ucsi_ccg {
>  	struct device *dev;
>  	struct ucsi *ucsi;
> @@ -222,6 +228,13 @@ struct ucsi_ccg {
>  	bool has_multiple_dp;
>  	struct ucsi_ccg_altmode orig[UCSI_MAX_ALTMODES];
>  	struct ucsi_ccg_altmode updated[UCSI_MAX_ALTMODES];
> +
> +	/*
> +	 * This spinlock protects op_data which includes CCI and MESSAGE_IN that
> +	 * will be updated in ISR
> +	 */
> +	spinlock_t op_lock;
> +	struct op_region op_data;
>  };
>  
>  static int ccg_read(struct ucsi_ccg *uc, u16 rab, u8 *data, u32 len)
> @@ -305,12 +318,57 @@ static int ccg_write(struct ucsi_ccg *uc, u16 rab, const u8 *data, u32 len)
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

What happens if the offset is neither of these?

You seem to be only calling this if that value is set correctly, but
this seems very fragile.  You are also only calling this in one place,
so why is this a function at all?  Just do the copy under the lock as
needed in the calling location instead.

> +	spin_unlock(&uc->op_lock);
> +}
> +
> +static void ccg_op_region_update(struct ucsi_ccg *uc, u32 cci)
> +{
> +	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(UCSI_MESSAGE_IN);
> +	struct op_region *data = &uc->op_data;
> +	u32 message_in[CCGX_MESSAGE_IN_MAX];

Are you sure you can put this big of a buffer on the stack?

> +
> +	if (UCSI_CCI_LENGTH(cci))
> +		if (ccg_read(uc, reg, (void *)&message_in,
> +					sizeof(message_in))) {

Are you allowed to copy in into stack memory?  This ends up being an i2c
message, right?  Can that be transferred into non-dma-able memory?

> +			dev_err(uc->dev, "failed to read MESSAGE_IN\n");

Why can you not fail this function?  You are throwing away the error
here, that's not good.

> +			return;
> +		}
> +
> +	spin_lock(&uc->op_lock);
> +	memcpy(&data->cci, &cci, sizeof(cci));

Perhaps just:
	data->cci = cci;
as this is only a 32bit value.

> +	if (UCSI_CCI_LENGTH(cci))
> +		memcpy(&data->message_in, &message_in, sizeof(message_in));
> +	spin_unlock(&uc->op_lock);
> +}
> +
> +static void ccg_op_region_clean(struct ucsi_ccg *uc)
> +{
> +	struct op_region *data = &uc->op_data;
> +
> +	spin_lock(&uc->op_lock);
> +	memset(&data->cci, 0, sizeof(data->cci));

	data->cci = 0;

> +	memset(&data->message_in, 0, sizeof(data->message_in));

Or better yet, do it all at once:
	memset(&data, 0, sizeof(*data));

> +	spin_unlock(&uc->op_lock);

But why do you need to do this at all?  Why "clean" the whole buffer
out, why not just set cci to 0 and be done with it?

Or why even clean this out at all, what happens if you do not?

> +}
> +
>  static int ucsi_ccg_init(struct ucsi_ccg *uc)
>  {
>  	unsigned int count = 10;
>  	u8 data;
>  	int status;
>  
> +	spin_lock_init(&uc->op_lock);
> +
>  	data = CCGX_RAB_UCSI_CONTROL_STOP;
>  	status = ccg_write(uc, CCGX_RAB_UCSI_CONTROL, &data, sizeof(data));
>  	if (status < 0)
> @@ -520,9 +578,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>  	struct ucsi_capability *cap;
>  	struct ucsi_altmode *alt;
> -	int ret;
> +	int ret = 0;
> +
> +	if ((offset == UCSI_CCI) || (offset == UCSI_MESSAGE_IN))
> +		ccg_op_region_read(uc, offset, val, val_len);
> +	else
> +		ret = ccg_read(uc, reg, val, val_len);
>  
> -	ret = ccg_read(uc, reg, val, val_len);
>  	if (ret)
>  		return ret;
>  
> @@ -559,9 +621,13 @@ static int ucsi_ccg_read(struct ucsi *ucsi, unsigned int offset,
>  static int ucsi_ccg_async_write(struct ucsi *ucsi, unsigned int offset,
>  				const void *val, size_t val_len)
>  {
> +	struct ucsi_ccg *uc = ucsi_get_drvdata(ucsi);
>  	u16 reg = CCGX_RAB_UCSI_DATA_BLOCK(offset);
>  
> -	return ccg_write(ucsi_get_drvdata(ucsi), reg, val, val_len);
> +	if (offset == UCSI_CONTROL)
> +		ccg_op_region_clean(uc);

Why is this needed?  You have not documented it the need for this.

thanks,

greg k-h
