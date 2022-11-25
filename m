Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF2A638DC5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 16:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiKYPvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 10:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiKYPvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 10:51:49 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE58423BE7;
        Fri, 25 Nov 2022 07:51:48 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id v81so4802884oie.5;
        Fri, 25 Nov 2022 07:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I+rzUabA+R+ClowpTx1fNfQ7ebnqEjXoJ9kJUWmt2bo=;
        b=bXvUiGNOzo6BZF7opuk08LbNx2t0x6W7jmjaevKXEXvU29ybCw1Du+XLTuneflt1zp
         XPpL5P+oM0I18N/Sqo8KHduZTCa3NI9DcqsXWF+8LxEzdKMrqCXWGiuXvgvouqyofiNT
         oAK4z8hj4HCiFtWFKSe1mmUQjCfKy1qOlRP/evNFS2iGYRzCyVf1bkFGUIAVRb2LNqmx
         oiWWH2CNFJqsW95v4GyLjR5ITsI+Wriz0ahpR7YuDoFZaPuD50Y78AM2hhrlrU3MPhYV
         /ddxVjbhf0m8SNAns2EbXb7OZjPwDi/TB1rfmGJG4LIudyuqo98w0y3lD82MB0sehavu
         wssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+rzUabA+R+ClowpTx1fNfQ7ebnqEjXoJ9kJUWmt2bo=;
        b=E3hXoZTgi1t97G08E94vY7iH/6Sm+9BbuqIc2DYx3TjGS5n87t9Csp6sLXD+OfxDX2
         ACqHPNRXtrxty0sKbDXfvc2WxQczOl4aVsAxsxnrNvcrCNgA0qsYoR2mdp7ZO3KDjwQw
         xLZ/9+6va2UDWRxlH/ELmiUM38FNV2JSvgS4hohvCiJcKz31+9Wjr0+C/tyI/TShqLLt
         0Ace6w1/2zJZA+adKyPHFgCe2OlLVB5fPHEbVrp9o3vJ55+o0kQVEH7IQ5KlCgdmZN6R
         ypqYOr/7DlFJor0dblXboq/Q3kNGkANlgYMEC3ejfaR/O2LbBtnN5VCCESeRBkxONEGW
         kMsg==
X-Gm-Message-State: ANoB5plHtJiQPL0Mwq4EQIsrpOpz0EuaqL6KVWmYKfNrBaRskiqPT2Rq
        N9U0QPMI3XJ+l7uiy13F6XCjrtgZZnY=
X-Google-Smtp-Source: AA0mqf5XPInWTtZURlWgM4gu8NVtw/5U1lbYyU4E61Zxnx4AWkfLGGNWsA+fMxksB+hTaYrkHx4lKQ==
X-Received: by 2002:aca:60d7:0:b0:359:e2f5:88a6 with SMTP id u206-20020aca60d7000000b00359e2f588a6mr10914884oib.181.1669391508034;
        Fri, 25 Nov 2022 07:51:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m4-20020a9d6ac4000000b00661a33883b8sm1757420otq.71.2022.11.25.07.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 07:51:47 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 25 Nov 2022 07:51:46 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] hwmon: (pmbus/core): Implement regulator get_status
Message-ID: <20221125155146.GA1169995@roeck-us.net>
References: <20221124193642.4081054-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221124193642.4081054-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2022 at 08:36:42PM +0100, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Add get_status for pmbus_regulator_ops.
> ---

Adding "---" into the commit description causes everything afterwards
to get lost when applying the patch, including the signatures.
I fixed it up and applied it, but please don't do that in the future.

Guenter

> Changes:
> - use lock throughout the function
> - Avoid line continuation upto 100 column
> - Optimize use of & and | operator
> - Check for VOUT, IOUT, TEMPERATURE bit in status word before checking
>   respective status register for fault.
> - Report regulator current status.
> - Utilize get_error_flag to check for regulator errors.
> - Check for return value of function get_error_flag
> - Use function pmbus_regulator_get_error_flags directly
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 44 ++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
> 
> 
> base-commit: 2c71b3246ec3246522e8cb7c8191dc7a5d62cc70
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 20ca26e19db7..95e95783972a 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -2855,6 +2855,49 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>  	return 0;
>  }
>  
> +static int pmbus_regulator_get_status(struct regulator_dev *rdev)
> +{
> +	struct device *dev = rdev_get_dev(rdev);
> +	struct i2c_client *client = to_i2c_client(dev->parent);
> +	struct pmbus_data *data = i2c_get_clientdata(client);
> +	u8 page = rdev_get_id(rdev);
> +	int status, ret;
> +
> +	mutex_lock(&data->update_lock);
> +	status = pmbus_get_status(client, page, PMBUS_STATUS_WORD);
> +	if (status < 0) {
> +		ret = status;
> +		goto unlock;
> +	}
> +
> +	if (status & PB_STATUS_OFF) {
> +		ret = REGULATOR_STATUS_OFF;
> +		goto unlock;
> +	}
> +
> +	/* If regulator is ON & reports power good then return ON */
> +	if (!(status & PB_STATUS_POWER_GOOD_N)) {
> +		ret = REGULATOR_STATUS_ON;
> +		goto unlock;
> +	}
> +
> +	ret = pmbus_regulator_get_error_flags(rdev, &status);
> +	if (ret)
> +		goto unlock;
> +
> +	if (status & (REGULATOR_ERROR_UNDER_VOLTAGE | REGULATOR_ERROR_OVER_CURRENT |
> +	   REGULATOR_ERROR_REGULATION_OUT | REGULATOR_ERROR_FAIL | REGULATOR_ERROR_OVER_TEMP)) {
> +		ret = REGULATOR_STATUS_ERROR;
> +		goto unlock;
> +	}
> +
> +	ret = REGULATOR_STATUS_UNDEFINED;
> +
> +unlock:
> +	mutex_unlock(&data->update_lock);
> +	return ret;
> +}
> +
>  static int pmbus_regulator_get_low_margin(struct i2c_client *client, int page)
>  {
>  	struct pmbus_data *data = i2c_get_clientdata(client);
> @@ -2995,6 +3038,7 @@ const struct regulator_ops pmbus_regulator_ops = {
>  	.disable = pmbus_regulator_disable,
>  	.is_enabled = pmbus_regulator_is_enabled,
>  	.get_error_flags = pmbus_regulator_get_error_flags,
> +	.get_status = pmbus_regulator_get_status,
>  	.get_voltage = pmbus_regulator_get_voltage,
>  	.set_voltage = pmbus_regulator_set_voltage,
>  	.list_voltage = pmbus_regulator_list_voltage,
