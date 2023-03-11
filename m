Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5AF6B600C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 20:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjCKTG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 14:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCKTGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 14:06:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0EA64232;
        Sat, 11 Mar 2023 11:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A515B80522;
        Sat, 11 Mar 2023 19:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F91C433EF;
        Sat, 11 Mar 2023 19:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678561582;
        bh=OVpVDAx6o+qPxZLHPJLKgJrkkAtgPU+JJrR+L7/ayqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OxedlAcIv6lwoziD8w1j78pxnHMQD6CZ5pJHdoDz8EZOhPS+l/mDwjnL4ELyJwifX
         nm9p8l/u/CqrG6H3CO+DxKZfMXclPDX5ZHaQDn+9lrDBjBvx/S7cxPqKvQma0gyY7s
         6nuFXWlmsVLZt+w3gwiS2XGZYlKc39mdw7qi6dG6M1VI9ERmMzDVL3Z0xStdUi/RL8
         uTiPGiEAowtwJ0rxpLRBjWl3T66E579rxEaPd6b9wEM1BdhYKI+zZgzwUNMHh2OrxN
         7z5+4xzSbvgLZjFBpDwCVlRZgSuhD2lw5S5tE5K/aSiPUl1t+7G2783NYiq5YmG7Jj
         18/vGvTfKaWEw==
Date:   Sat, 11 Mar 2023 19:06:25 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        michal.simek@amd.com, Jonathan Corbet <corbet@lwn.net>,
        Jean Delvare <jdelvare@suse.com>,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michal Simek <michal.simek@xilinx.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-doc@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v2 2/4] hwmon: pmbus: Use devm_krealloc_array
Message-ID: <20230311190625.1618bbf4@jic23-huawei>
In-Reply-To: <20230309150334.216760-3-james.clark@arm.com>
References: <20230309150334.216760-1-james.clark@arm.com>
        <20230309150334.216760-3-james.clark@arm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  9 Mar 2023 15:03:31 +0000
James Clark <james.clark@arm.com> wrote:

> Now that it exists, use it instead of doing the multiplication manually.
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: James Clark <james.clark@arm.com>
FWIW LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwmon/pmbus/pmbus_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
> index 95e95783972a..e7bee25a3706 100644
> --- a/drivers/hwmon/pmbus/pmbus_core.c
> +++ b/drivers/hwmon/pmbus/pmbus_core.c
> @@ -1190,9 +1190,9 @@ static int pmbus_add_attribute(struct pmbus_data *data, struct attribute *attr)
>  {
>  	if (data->num_attributes >= data->max_attributes - 1) {
>  		int new_max_attrs = data->max_attributes + PMBUS_ATTR_ALLOC_SIZE;
> -		void *new_attrs = devm_krealloc(data->dev, data->group.attrs,
> -						new_max_attrs * sizeof(void *),
> -						GFP_KERNEL);
> +		void *new_attrs = devm_krealloc_array(data->dev, data->group.attrs,
> +						      new_max_attrs, sizeof(void *),
> +						      GFP_KERNEL);
>  		if (!new_attrs)
>  			return -ENOMEM;
>  		data->group.attrs = new_attrs;

