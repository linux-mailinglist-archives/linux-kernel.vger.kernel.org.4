Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187E669AC9C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 14:36:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBQNf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 08:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBQNf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 08:35:57 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2142AD32;
        Fri, 17 Feb 2023 05:35:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676640956; x=1708176956;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6/L3UtpTr16oh0QX766DOPTVsm/1w6Jvudma6EjcOSs=;
  b=gQ4DrbXWBTzpPGREtg9gd1P2CPR9jxBHwpvpVwQWc5SqN+c8cKULjhCK
   8qv6EWtIt6UxOBOqdXRhGw5t2GZ9BQBXbrJxg8QafPIKAYCLvY6nDykuZ
   ErMwFCSQrPc9I0Lmk7ChZNMHO+FuBa1cOLNHlDG3Bb3XSCdW3Jk+WtD7l
   0T/8UcUpCF1XLfTSO7BA90AabwIvLXB4+RJ66AngRZV6Th3MCgJlhOg95
   ZpKafJCvJNEy+CtLn2nnWQIC/k0aWdURX3/NXWi1nPgRZfAp68DILUoNc
   /hjtWGgdD/5ZrAMId5uKSmVOVMObMIzQv9HwZgh1318b8Yx9hTGPf+8ZI
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="418207509"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="418207509"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 05:35:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10623"; a="620401812"
X-IronPort-AV: E=Sophos;i="5.97,304,1669104000"; 
   d="scan'208";a="620401812"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2023 05:35:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 2C1E01C5; Fri, 17 Feb 2023 15:36:34 +0200 (EET)
Date:   Fri, 17 Feb 2023 15:36:34 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>, Sanju.Mehta@amd.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] thunderbolt: Refactor DROM reading
Message-ID: <Y++C4gWAfbw2rQUt@black.fi.intel.com>
References: <20230216201910.12370-1-mario.limonciello@amd.com>
 <20230216201910.12370-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230216201910.12370-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

On Thu, Feb 16, 2023 at 02:19:10PM -0600, Mario Limonciello wrote:
> The NVM reading code has a series of gotos that potentially introduce
> unexpected behaviors with retries if something unexpected has failed
> to parse.
> 
> Additionally the retry logic introduced in commit f022ff7bf377
> ("thunderbolt: Retry DROM read once if parsing fails") was added from
> failures in bit banging, which aren't expected to be present when the
> DROM is fetched directly from the NVM.

Okay that's why you remove the EILSEQ returns below, right?

> Refactor the code to remove the gotos and drop the retry logic.

Thanks for doing this. Few minor stylistic comments below. I can also
fix these myself when applying if you prefer.

Note I will be on vacation next week but will be picking up patches once
v6.3-rc1 is released.

> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> v2->v3:
>     * Split out refactor
> ---
>  drivers/thunderbolt/eeprom.c | 147 +++++++++++++++++++----------------
>  1 file changed, 79 insertions(+), 68 deletions(-)
> 
> diff --git a/drivers/thunderbolt/eeprom.c b/drivers/thunderbolt/eeprom.c
> index a326cf16ca3d..2a078c69f0d2 100644
> --- a/drivers/thunderbolt/eeprom.c
> +++ b/drivers/thunderbolt/eeprom.c
> @@ -416,7 +416,7 @@ static int tb_drom_parse_entries(struct tb_switch *sw, size_t header_size)
>  		if (pos + 1 == drom_size || pos + entry->len > drom_size
>  				|| !entry->len) {
>  			tb_sw_warn(sw, "DROM buffer overrun\n");
> -			return -EILSEQ;
> +			return -EIO;
>  		}
>  
>  		switch (entry->type) {
> @@ -543,7 +543,37 @@ static int tb_drom_read_n(struct tb_switch *sw, u16 offset, u8 *val,
>  	return tb_eeprom_read_n(sw, offset, val, count);
>  }
>  
> -static int tb_drom_parse(struct tb_switch *sw)
> +static int tb_drom_bit_bang(struct tb_switch *sw, u16 *size)
> +{
> +	int res;

ret

> +
> +	res = tb_drom_read_n(sw, 14, (u8 *) size, 2);
> +	if (res)
> +		return res;

empty line here.

> +	*size &= 0x3ff;
> +	*size += TB_DROM_DATA_START;

here too.

> +	tb_sw_dbg(sw, "reading drom (length: %#x)\n", *size);
> +	if (*size < sizeof(struct tb_drom_header)) {
> +		tb_sw_warn(sw, "drom too small, aborting\n");

DROM

> +		return -EIO;
> +	}
> +
> +	sw->drom = kzalloc(*size, GFP_KERNEL);
> +	if (!sw->drom)
> +		return -ENOMEM;
> +
> +	res = tb_drom_read_n(sw, 0, sw->drom, *size);
> +	if (res)
> +		goto err;
> +
> +	return 0;

empty line

> +err:
> +	kfree(sw->drom);
> +	sw->drom = NULL;

empty line

> +	return res;
> +}
> +
> +static int tb_drom_parse_v1(struct tb_switch *sw)
>  {
>  	const struct tb_drom_header *header =
>  		(const struct tb_drom_header *)sw->drom;
> @@ -554,7 +584,7 @@ static int tb_drom_parse(struct tb_switch *sw)
>  		tb_sw_warn(sw,
>  			"DROM UID CRC8 mismatch (expected: %#x, got: %#x)\n",
>  			header->uid_crc8, crc);
> -		return -EILSEQ;
> +		return -EIO;
>  	}
>  	if (!sw->uid)
>  		sw->uid = header->uid;
> @@ -588,6 +618,43 @@ static int usb4_drom_parse(struct tb_switch *sw)
>  	return tb_drom_parse_entries(sw, USB4_DROM_HEADER_SIZE);
>  }
>  
> +static int tb_drom_parse(struct tb_switch *sw, u16 *size)
> +{
> +	struct tb_drom_header *header = (void *) sw->drom;
> +	int res;

ret

> +
> +	if (header->data_len + TB_DROM_DATA_START != *size) {
> +		tb_sw_warn(sw, "drom size mismatch\n");

DROM

> +		goto err;
> +	}
> +
> +	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
> +
> +	switch (header->device_rom_revision) {
> +	case 3:
> +		res = usb4_drom_parse(sw);
> +		break;
> +	default:
> +		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
> +			   header->device_rom_revision);
> +		fallthrough;
> +	case 1:
> +		res = tb_drom_parse_v1(sw);
> +		break;
> +	}
> +
> +	if (res) {
> +		tb_sw_warn(sw, "parsing DROM failed\n");
> +		goto err;
> +	}
> +
> +	return 0;

empty line

> +err:
> +	kfree(sw->drom);
> +	sw->drom = NULL;

empty line

> +	return -EIO;
> +}
> +
>  /**
>   * tb_drom_read() - Copy DROM to sw->drom and parse it
>   * @sw: Router whose DROM to read and parse
> @@ -601,8 +668,7 @@ static int usb4_drom_parse(struct tb_switch *sw)
>  int tb_drom_read(struct tb_switch *sw)
>  {
>  	u16 size;
> -	struct tb_drom_header *header;
> -	int res, retries = 1;
> +	int res;
>  
>  	if (sw->drom)
>  		return 0;
> @@ -613,11 +679,11 @@ int tb_drom_read(struct tb_switch *sw)
>  		 * in a device property. Use it if available.
>  		 */
>  		if (tb_drom_copy_efi(sw, &size) == 0)
> -			goto parse;
> +			return tb_drom_parse(sw, &size);
>  
>  		/* Non-Apple hardware has the DROM as part of NVM */
>  		if (tb_drom_copy_nvm(sw, &size) == 0)
> -			goto parse;
> +			return tb_drom_parse(sw, &size);
>  
>  		/*
>  		 * USB4 hosts may support reading DROM through router
> @@ -626,7 +692,7 @@ int tb_drom_read(struct tb_switch *sw)
>  		if (tb_switch_is_usb4(sw)) {
>  			usb4_switch_read_uid(sw, &sw->uid);
>  			if (!usb4_copy_host_drom(sw, &size))
> -				goto parse;
> +				return tb_drom_parse(sw, &size);
>  		} else {
>  			/*
>  			 * The root switch contains only a dummy drom
> @@ -640,67 +706,12 @@ int tb_drom_read(struct tb_switch *sw)
>  	}
>  
>  	/* We can use LC to get UUID later */
> -	if (sw->cap_lc && tb_drom_copy_nvm(sw, &size) == 0)
> -		goto parse;
> -
> -	res = tb_drom_read_n(sw, 14, (u8 *) &size, 2);
> +	if (sw->cap_lc)
> +		res = tb_drom_copy_nvm(sw, &size);
> +	else
> +		res = tb_drom_bit_bang(sw, &size);
>  	if (res)
>  		return res;
> -	size &= 0x3ff;
> -	size += TB_DROM_DATA_START;
> -	tb_sw_dbg(sw, "reading drom (length: %#x)\n", size);
> -	if (size < sizeof(*header)) {
> -		tb_sw_warn(sw, "drom too small, aborting\n");
> -		return -EIO;
> -	}
> -
> -	sw->drom = kzalloc(size, GFP_KERNEL);
> -	if (!sw->drom)
> -		return -ENOMEM;
> -read:
> -	res = tb_drom_read_n(sw, 0, sw->drom, size);
> -	if (res)
> -		goto err;
> -
> -parse:
> -	header = (void *) sw->drom;
> -
> -	if (header->data_len + TB_DROM_DATA_START != size) {
> -		tb_sw_warn(sw, "drom size mismatch\n");
> -		if (retries--) {
> -			msleep(100);
> -			goto read;
> -		}
> -		goto err;
> -	}
> -
> -	tb_sw_dbg(sw, "DROM version: %d\n", header->device_rom_revision);
> -
> -	switch (header->device_rom_revision) {
> -	case 3:
> -		res = usb4_drom_parse(sw);
> -		break;
> -	default:
> -		tb_sw_warn(sw, "DROM device_rom_revision %#x unknown\n",
> -			   header->device_rom_revision);
> -		fallthrough;
> -	case 1:
> -		res = tb_drom_parse(sw);
> -		break;
> -	}
> -
> -	/* If the DROM parsing fails, wait a moment and retry once */
> -	if (res == -EILSEQ && retries--) {
> -		tb_sw_warn(sw, "parsing DROM failed\n");
> -		msleep(100);
> -		goto read;
> -	}
>  
> -	if (!res)
> -		return 0;
> -
> -err:
> -	kfree(sw->drom);
> -	sw->drom = NULL;
> -	return -EIO;
> +	return tb_drom_parse(sw, &size);
>  }
> -- 
> 2.34.1
