Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 443C86B68E7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjCLRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCLRnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:43:35 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F8E7DB7;
        Sun, 12 Mar 2023 10:43:34 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id bd3-20020a4aee03000000b00517affa07c0so1525522oob.7;
        Sun, 12 Mar 2023 10:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678643013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GqdbbfsYH3A0BwuMoZ160BBHfFhhZcuHQkbZCTYU1CM=;
        b=CJF1DL9whe79abZrXnMG/HdulhdMMsXNPQmtSvXfm7l8jVjJ6CCIOUHWbdjIAQmVXS
         UispGyWavtU9mql1vboLZpsWSjZczEdbtJoYJHFvkzmta0EkGeaIy5YXmmK7vdu1GsvH
         BqOXU+pUPjRmEozBBCNysms97UeesOpnlAZKZfWHLklkosmBiHdG6r3MnIauWDgGStrQ
         3LZlU1Fc3+FpDlbD75F9PrQ0zMp7y7S0GPXpCeM3xVpStp4kJJYu/pPbgwqqtEd+XkGs
         yfM6LPmXa2SnORc1Mk+b+7aQioLxednRYtub7yNaSGS2YY8bamQdwHG3/BtdLAIBImF2
         iVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678643013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GqdbbfsYH3A0BwuMoZ160BBHfFhhZcuHQkbZCTYU1CM=;
        b=FYi81t8JTbD32ipe0upV9mvTznVb+JH7ox70gOAAIHpXsRbw0aRc9tDAi9tSQk0hdq
         3xUywL6OmqJ1uL19HiPYCPZzo0tqQzAsE0WcsJpECTSYayj0wgHSGdr1+BObUe0lsuWI
         Ei/IzBQucz6G/hg7snaRnBw0bEoL273QnBXtj/wl0BxHK+BPjIowTT7gCbHsm9x3db5T
         R8FzLUPtD1/jwZ2e+PvGU6DnkK1PCJHDeZiZ/WTjDpMhvGGO4g9mzZo7K1P11g7k2qMH
         G2pdcmaHk5GwdaYdnWfevIH7ENK40zUDZaMmiHT0rE2ZfYfKj5QaA1d/TFZOVC1rThf3
         1u5g==
X-Gm-Message-State: AO0yUKUW0DWW5BnkETihN0JgXp5jH4L2z02B8eX1l0Mey29R6mFzg9W+
        BArAM7MGyw8UwrDQcP3HGmw=
X-Google-Smtp-Source: AK7set9sNtnfZCx+NPgAMKMwxo7sXzK5H6QNpB8kVlp3tNOCqVtteceMPBdEZzLOzi5eIFWKhoVpRQ==
X-Received: by 2002:a4a:6f03:0:b0:525:58f7:cbef with SMTP id h3-20020a4a6f03000000b0052558f7cbefmr15652779ooc.2.1678643013475;
        Sun, 12 Mar 2023 10:43:33 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x67-20020a4a4146000000b00525240c6149sm2251265ooa.31.2023.03.12.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:43:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 12 Mar 2023 10:43:32 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Leonard Anderweit <leonard.anderweit@gmail.com>
Cc:     linux-hwmon@vger.kernel.org,
        Aleksa Savic <savicaleksa83@gmail.com>,
        Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] hwmon: (aquacomputer_d5next) Device dependent
 control report settings
Message-ID: <450cf27e-358b-4f26-ae7d-7216e1681ad3@roeck-us.net>
References: <20230214220221.15003-1-leonard.anderweit@gmail.com>
 <20230214220221.15003-4-leonard.anderweit@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214220221.15003-4-leonard.anderweit@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:02:18PM +0100, Leonard Anderweit wrote:
> Add device dependent control report id, secondary control report id, secondary
> control report size and secondary control report for devices which need
> different control report settings. All currently supported devices use the same
> values.
> 
> Signed-off-by: Leonard Anderweit <leonard.anderweit@gmail.com>

Applied. Same comment as before - please check line length in description.

Thanks,
Guenter

> ---
>  drivers/hwmon/aquacomputer_d5next.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwmon/aquacomputer_d5next.c b/drivers/hwmon/aquacomputer_d5next.c
> index f0c036d38e91..535d2fc0e55c 100644
> --- a/drivers/hwmon/aquacomputer_d5next.c
> +++ b/drivers/hwmon/aquacomputer_d5next.c
> @@ -441,6 +441,10 @@ struct aqc_data {
>  	const char *name;
>  
>  	int status_report_id;	/* Used for legacy devices, report is stored in buffer */
> +	int ctrl_report_id;
> +	int secondary_ctrl_report_id;
> +	int secondary_ctrl_report_size;
> +	u8 *secondary_ctrl_report;
>  
>  	int buffer_size;
>  	u8 *buffer;
> @@ -513,7 +517,7 @@ static int aqc_get_ctrl_data(struct aqc_data *priv)
>  	int ret;
>  
>  	memset(priv->buffer, 0x00, priv->buffer_size);
> -	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
> +	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
>  				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
>  	if (ret < 0)
>  		ret = -ENODATA;
> @@ -535,15 +539,15 @@ static int aqc_send_ctrl_data(struct aqc_data *priv)
>  	put_unaligned_be16(checksum, priv->buffer + priv->checksum_offset);
>  
>  	/* Send the patched up report back to the device */
> -	ret = hid_hw_raw_request(priv->hdev, CTRL_REPORT_ID, priv->buffer, priv->buffer_size,
> +	ret = hid_hw_raw_request(priv->hdev, priv->ctrl_report_id, priv->buffer, priv->buffer_size,
>  				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  	if (ret < 0)
>  		return ret;
>  
>  	/* The official software sends this report after every change, so do it here as well */
> -	ret = hid_hw_raw_request(priv->hdev, SECONDARY_CTRL_REPORT_ID, secondary_ctrl_report,
> -				 SECONDARY_CTRL_REPORT_SIZE, HID_FEATURE_REPORT,
> -				 HID_REQ_SET_REPORT);
> +	ret = hid_hw_raw_request(priv->hdev, priv->secondary_ctrl_report_id,
> +				 priv->secondary_ctrl_report, priv->secondary_ctrl_report_size,
> +				 HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
>  	return ret;
>  }
>  
> @@ -1447,6 +1451,11 @@ static int aqc_probe(struct hid_device *hdev, const struct hid_device_id *id)
>  		priv->serial_number_start_offset = AQC_SERIAL_START;
>  		priv->firmware_version_offset = AQC_FIRMWARE_VERSION;
>  
> +		priv->ctrl_report_id = CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_id = SECONDARY_CTRL_REPORT_ID;
> +		priv->secondary_ctrl_report_size = SECONDARY_CTRL_REPORT_SIZE;
> +		priv->secondary_ctrl_report = secondary_ctrl_report;
> +
>  		if (priv->kind == aquastreamult)
>  			priv->fan_structure = &aqc_aquastreamult_fan_structure;
>  		else
