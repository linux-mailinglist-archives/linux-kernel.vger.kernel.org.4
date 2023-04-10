Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859076DC24C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 03:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjDJB0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 21:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjDJB0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 21:26:12 -0400
Received: from emcscan.emc.com.tw (emcscan.emc.com.tw [192.72.220.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14ABE35A8
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 18:26:10 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.98,332,1673884800"; 
   d="scan'208";a="2457880"
Received: from unknown (HELO webmail.emc.com.tw) ([192.168.10.1])
  by emcscan.emc.com.tw with ESMTP; 10 Apr 2023 09:26:06 +0800
Received: from 192.168.10.23
        by webmail.emc.com.tw with MailAudit ESMTP Server V5.0(80155:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 10 Apr 2023 09:26:08 +0800 (CST)
Received: from 192.168.33.11
        by webmail.emc.com.tw with Mail2000 ESMTP Server V7.00(2470:0:AUTH_RELAY)
        (envelope-from <jingle.wu@emc.com.tw>); Mon, 10 Apr 2023 09:26:06 +0800 (CST)
From:   "Jingle.Wu" <jingle.wu@emc.com.tw>
To:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        <phoenix@emc.com.tw>, <josh.chen@emc.com.tw>,
        <dave.wang@emc.com.tw>
References: <20230320011456.986321-1-jingle.wu@emc.com.tw> <ZDBKwo4UMUm+TSnj@penguin>
In-Reply-To: <ZDBKwo4UMUm+TSnj@penguin>
Subject: RE: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit functions.
Date:   Mon, 10 Apr 2023 09:26:04 +0800
Message-ID: <000001d96b4b$6b30cda0$419268e0$@emc.com.tw>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJF62IY79PwBMHzbH32rexKKwKtngJcjz5NrjfYmYA=
Content-Language: zh-tw
x-dg-ref: PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcMDYwMTFcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZiODRiYTI5ZTM1Ylxtc2dzXG1zZy1hODdmNzhhYi1kNzNlLTExZWQtYTg1Zi1mMDc5NTk2OWU3NWVcYW1lLXRlc3RcYTg3Zjc4YWMtZDczZS0xMWVkLWE4NWYtZjA3OTU5NjllNzVlYm9keS50eHQiIHN6PSIzNDkxIiB0PSIxMzMyNTU2MzU2NDM3OTEwMjUiIGg9Ik9CVTBrYmlxazBIaEpCcWRjYVA0U00rS0VnUT0iIGlkPSIiIGJsPSIwIiBibz0iMSIvPjwvbWV0YT4=
x-dg-rorf: true
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dmitry:

> +static void elan_close(struct input_dev *input_dev) {
> +	if ((input_dev->users) && (!input_dev->inhibited))
> +		elan_inhibit(input_dev);

This check is for "only inhibit request", and elan_open() its check is for
"only uninhibit request".
Because input_dev-> open() close() will be executed 2-3 times when initial.

Thanks
Jingle

-----Original Message-----
From: Dmitry Torokhov [mailto:dmitry.torokhov@gmail.com] 
Sent: Saturday, April 8, 2023 12:57 AM
To: jingle.wu <jingle.wu@emc.com.tw>
Cc: linux-kernel@vger.kernel.org; linux-input@vger.kernel.org;
phoenix@emc.com.tw; josh.chen@emc.com.tw; dave.wang@emc.com.tw
Subject: Re: [PATCH] Input: elan_i2c - Implement inhibit/uninhibit
functions.

Hi Jingle,

On Mon, Mar 20, 2023 at 09:14:56AM +0800, jingle.wu wrote:
> Add inhibit/uninhibit functions.
> 
> Signed-off-by: Jingle.wu <jingle.wu@emc.com.tw>
> ---
>  drivers/input/mouse/elan_i2c_core.c | 86 
> +++++++++++++++++++++++++++++
>  1 file changed, 86 insertions(+)
> 
> diff --git a/drivers/input/mouse/elan_i2c_core.c 
> b/drivers/input/mouse/elan_i2c_core.c
> index 5f0d75a45c80..b7100945c9cc 100644
> --- a/drivers/input/mouse/elan_i2c_core.c
> +++ b/drivers/input/mouse/elan_i2c_core.c
> @@ -329,6 +329,89 @@ static int elan_initialize(struct elan_tp_data *data,
bool skip_reset)
>  	return error;
>  }
>  
> +static int elan_reactivate(struct elan_tp_data *data) {
> +	struct device *dev = &data->client->dev;
> +	int ret;

Please call this variable and other similar ones "error".

> +
> +	ret = elan_set_power(data, true);
> +	if (ret)
> +		dev_err(dev, "failed to restore power: %d\n", ret);
> +
> +	ret = data->ops->sleep_control(data->client, false);
> +	if (ret) {
> +		dev_err(dev,
> +			"failed to wake device up: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return ret;

return 0;

> +}
> +
> +static void elan_inhibit(struct input_dev *input_dev) {
> +	struct elan_tp_data *data = input_get_drvdata(input_dev);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	if (data->in_fw_update)
> +		return;

Simply and silently ignoring inhibit request is not great. Can we wait for
firmware update to complete?

> +
> +	dev_dbg(&client->dev, "inhibiting\n");
> +	/*
> +	 * We are taking the mutex to make sure sysfs operations are
> +	 * complete before we attempt to bring the device into low[er]
> +	 * power mode.
> +	 */
> +	ret = mutex_lock_interruptible(&data->sysfs_mutex);
> +	if (ret)
> +		return;
> +
> +	disable_irq(client->irq);
> +
> +	ret = elan_set_power(data, false);
> +	if (ret)
> +		enable_irq(client->irq);
> +
> +	mutex_unlock(&data->sysfs_mutex);
> +
> +}
> +
> +static void elan_close(struct input_dev *input_dev) {
> +	if ((input_dev->users) && (!input_dev->inhibited))
> +		elan_inhibit(input_dev);

I am not sure why you need these checks. Input core will only call
input_dev->close() when device is powered up st (i.e. it is not inhibited
and there are users of it) and when either:

- there is inhibit request or
- the last user is letting go of the device

Similarly elan_open() will be called when first user opens device if device
is not inhibited, or when request to uninhibit comes for inhibited device
that has users.

But you need to make sure you start in a low power state.

Thanks.

--
Dmitry

