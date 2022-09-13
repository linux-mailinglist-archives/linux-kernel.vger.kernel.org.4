Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F05B45B78A9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 19:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233646AbiIMRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 13:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiIMRrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 13:47:04 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A25FF61;
        Tue, 13 Sep 2022 09:44:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id b21so12406515plz.7;
        Tue, 13 Sep 2022 09:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TnW/jAU28QGtGyUU9YBcJqqN4hr32PMVBAg4l9tkgQY=;
        b=KC0uZMNkpMJQ4MFanTigBtTzuzPX6Sv8l/KMZWPps14qn4aoiuTKpofk+9OVcMB/TA
         gsD8fCUBYR6TdcHPcueI7EM9U0lFLw3VyikxAmM//qtu7S1+10vipb1nPzbF5mswkn8W
         2SB1pJvEVwPD8mxnWXGzjJd9lUtLCliwBbF0NPl+bPBqyOJEcDeE1hip+SqZdC1svBYE
         UeikqIyjpOiOkJrRDqeHChdfIpjk6LfCbwh6Ve4KK3vwP+fq13HORA3TtrKNlh69G6XA
         8xoDJesI8Jt4H2PNxHxtfcdt1fi08Yk/J+xXztfK3LfFjhl911fnMlnNrV9NW8X9Uv18
         CJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TnW/jAU28QGtGyUU9YBcJqqN4hr32PMVBAg4l9tkgQY=;
        b=enffmvXxpbTOnFOKWYPLuQX3k2GksDyqXE2JOGtbnmEAoGDGz/GfmG45IMxMC812TR
         IZ+mwDyV32lxVL5K8JpsypJ+J8uk4KT38MaNJnpw1AtVoT1YqBKHH0UhZiHp6ElMzmnu
         lJNje+E1L6ULr/cV9gihJ0o4BSCUcQ1sI1Gyo0n7YyrTAjhTU0l1ZNL8ENiERjh8gdw4
         G9IswdTo4EC6VOSHAf4+YWQ5rpBmVPY32zYNib/ywtMP+62TzARv1z4C8rfH/dWbw1pK
         tCok9qcQUEfoswle6a/JZgXOVcfwgOkzn7jUq6YpBN4TL+ruQYbm24urjgE9C8kJIrK0
         bKsQ==
X-Gm-Message-State: ACgBeo1q3//rex28oDAxrl3WhPzz3bQNZanBIKlPf2pvi6oWYH68jTfc
        4iYzK2oE7RZ+nmOWNX/S8ETUdH8xVn7Zkg==
X-Google-Smtp-Source: AA6agR5ulCtvuiSgoLzbowjKbWMJ+Jg3jAaZ5P69Y/CSNTGVAY90fXzH1HHwL0OuESHKy4hkX+Czfg==
X-Received: by 2002:a17:902:e383:b0:176:9ee2:e099 with SMTP id g3-20020a170902e38300b001769ee2e099mr33029961ple.44.1663087456431;
        Tue, 13 Sep 2022 09:44:16 -0700 (PDT)
Received: from rog ([2a0a:edc0:0:701:a220:c777:e1f2:5de1])
        by smtp.gmail.com with ESMTPSA id f7-20020aa79687000000b0052e6d5ee183sm8084687pfk.129.2022.09.13.09.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 09:44:15 -0700 (PDT)
Date:   Tue, 13 Sep 2022 18:44:03 +0200
From:   Philipp Zabel <philipp.zabel@gmail.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        catalin@antebit.com, travisghansen@yahoo.com,
        Shyam-sundar.S-k@amd.com, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 1/6] acpi/x86: s2idle: Move _HID handling for AMD
 systems into structures
Message-ID: <YyCzU12b+bX3yvvu@rog>
References: <20220912172401.22301-1-mario.limonciello@amd.com>
 <20220912172401.22301-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912172401.22301-2-mario.limonciello@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, Sep 12, 2022 at 12:23:55PM -0500 schrieb Mario Limonciello:
> Right now the information about which cases to use for what are in a
> comment, but this is error prone.  Instead move all information into
> a dedicated structure.
> 
> Tested-by: catalin@antebit.com
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/x86/s2idle.c | 63 ++++++++++++++++++++++++++++-----------
>  1 file changed, 46 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index f9ac12b778e6..a7757551f750 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -363,6 +363,39 @@ static int validate_dsm(acpi_handle handle, const char *uuid, int rev, guid_t *d
>  	return ret;
>  }
>  
> +struct amd_lps0_hid_device_data {
> +	const unsigned int rev_id;
> +	const bool check_off_by_one;
> +	const bool prefer_amd_guid;
> +};
> +
> +static const struct amd_lps0_hid_device_data amd_picasso = {
> +	.rev_id = 0,
> +	.check_off_by_one = true,
> +	.prefer_amd_guid = false,
> +};
> +
> +static const struct amd_lps0_hid_device_data amd_cezanne = {
> +	.rev_id = 0,
> +	.check_off_by_one = false,
> +	.prefer_amd_guid = false,
> +};
> +
> +static const struct amd_lps0_hid_device_data amd_rembrandt = {
> +	.rev_id = 2,
> +	.check_off_by_one = false,
> +	.prefer_amd_guid = true,
> +};
> +
> +static const struct acpi_device_id amd_hid_ids[] = {
> +	{"AMD0004",	(kernel_ulong_t)&amd_picasso,	},
> +	{"AMD0005",	(kernel_ulong_t)&amd_picasso,	},
> +	{"AMDI0005",	(kernel_ulong_t)&amd_picasso,	},
> +	{"AMDI0006",	(kernel_ulong_t)&amd_cezanne,	},
> +	{"AMDI0007",	(kernel_ulong_t)&amd_rembrandt,	},
> +	{}
> +};
> +
>  static int lps0_device_attach(struct acpi_device *adev,
>  			      const struct acpi_device_id *not_used)
>  {
> @@ -370,31 +403,27 @@ static int lps0_device_attach(struct acpi_device *adev,
>  		return 0;
>  
>  	if (acpi_s2idle_vendor_amd()) {
> -		/* AMD0004, AMD0005, AMDI0005:
> -		 * - Should use rev_id 0x0
> -		 * - function mask > 0x3: Should use AMD method, but has off by one bug
> -		 * - function mask = 0x3: Should use Microsoft method
> -		 * AMDI0006:
> -		 * - should use rev_id 0x0
> -		 * - function mask = 0x3: Should use Microsoft method
> -		 * AMDI0007:
> -		 * - Should use rev_id 0x2
> -		 * - Should only use AMD method
> -		 */
> -		const char *hid = acpi_device_hid(adev);
> -		rev_id = strcmp(hid, "AMDI0007") ? 0 : 2;
> +		static const struct acpi_device_id *dev_id;
> +		const struct amd_lps0_hid_device_data *data;
> +
> +		for (dev_id = &amd_hid_ids[0]; dev_id->id[0]; dev_id++)
> +			if (acpi_dev_hid_uid_match(adev, dev_id->id, NULL))
> +				break;
> +		if (dev_id != NULL)
> +			data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;
> +		else
> +			return 0;

The "!= NULL" seems unnecessary, I would change this to:

+		if (!dev_id)
+			return 0;
+		data = (const struct amd_lps0_hid_device_data *) dev_id->driver_data;

But either way,

Reviewed-by: Philipp Zabel <philipp.zabel@gmail.com>
Tested-by: Philipp Zabel <philipp.zabel@gmail.com> # GA402RJ

regards
Philipp
