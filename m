Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E972CEF9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237723AbjFLTGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237691AbjFLTGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:06:00 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272CAB7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686596760; x=1718132760;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=N/dzqJlblDp6TTKWc155X+LGbZjpw//MJhRXHQQsR5k=;
  b=Ed7iF1mLmKNj6fKMJxmiBCP+YAkCCcwzU91B1BbtiyqZhNHQ3lv0Ra2s
   1gUCFNujExtwCVtzPIanV8ehZrEg3Y/bTydngz4r60A0lbYKpDqajQOj1
   8dxGKSyJqOg0hg7EuSJWFMCQ9PtRyY2YV+dGnh3Y8HaW/Pr4Epb4kglMk
   KwGcJSdQJkmp/Lkesi8NAf2z3w6vWUb3dywff46c1v+rToGpQ4o+Ucofj
   5RvHXxOiCpBO5mH7VFr3s6BkzdhL3QLE3zIUAXjyYILn/0jiOzEahpNMQ
   2vgTtUf1z8pqMv81zwkuX7oQlEDi6HUUJ2dymumJDGlCnKUsKMUPXQUJ8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338499170"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="338499170"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 12:05:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776503224"
X-IronPort-AV: E=Sophos;i="6.00,236,1681196400"; 
   d="scan'208";a="776503224"
Received: from atulpuri-mobl1.amr.corp.intel.com (HELO [10.212.234.150]) ([10.212.234.150])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 12:05:58 -0700
Message-ID: <5899c2b8-e984-fda9-5e12-190b0c9fd3b2@linux.intel.com>
Date:   Mon, 12 Jun 2023 13:09:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.11.0
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH V4 1/9] ASoC: amd: ps: create platform devices based on
 acp config
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org
Cc:     alsa-devel@alsa-project.org, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Mastan.Katragadda@amd.com,
        Arungopal.kondaveeti@amd.com, mario.limonciello@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20230612095903.2113464-1-Vijendar.Mukunda@amd.com>
 <20230612095903.2113464-2-Vijendar.Mukunda@amd.com>
Content-Language: en-US
In-Reply-To: <20230612095903.2113464-2-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=
> +static int sdw_amd_scan_controller(struct device *dev)
> +{
> +	struct acp63_dev_data *acp_data;
> +	struct fwnode_handle *link;
> +	char name[32];
> +	u32 sdw_manager_bitmap;
> +	u8 count = 0;
> +	u32 acp_sdw_power_mode = 0;
> +	int index;
> +	int ret;
> +
> +	acp_data = dev_get_drvdata(dev);
> +	/*
> +	 * Current implementation is based on MIPI DisCo 2.0 spec.
> +	 * Found controller, find links supported.
> +	 */
> +	ret = fwnode_property_read_u32_array((acp_data->sdw_fw_node), "mipi-sdw-manager-list",
> +					     &sdw_manager_bitmap, 1);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to read mipi-sdw-manager-list: %d\n", ret);
> +		return -EINVAL;
> +	}
> +	count = hweight32(sdw_manager_bitmap);
> +	/* Check count is within bounds */
> +	if (count > AMD_SDW_MAX_MANAGERS) {
> +		dev_err(dev, "Manager count %d exceeds max %d\n", count, AMD_SDW_MAX_MANAGERS);
> +		return -EINVAL;
> +	}

nit-pick: the count is not enough, you should also check that only bits
0 and 1 are set in mipi-sdw-manager-list...

> +
> +	if (!count) {
> +		dev_dbg(dev, "No SoundWire Managers detected\n");
> +		return -EINVAL;
> +	}
> +	dev_dbg(dev, "ACPI reports %d SoundWire Manager devices\n", count);
> +	acp_data->sdw_manager_count = count;
> +	for (index = 0; index < count; index++) {
> +		snprintf(name, sizeof(name), "mipi-sdw-link-%d-subproperties", index);

... otherwise this will be wrong.

> +		link = fwnode_get_named_child_node(acp_data->sdw_fw_node, name);
> +		if (!link) {
> +			dev_err(dev, "Manager node %s not found\n", name);
> +			return -EIO;
> +		}
> +
> +		ret = fwnode_property_read_u32(link, "amd-sdw-power-mode", &acp_sdw_power_mode);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * when SoundWire configuration is selected from acp pin config,
> +		 * based on manager instances count, acp init/de-init sequence should be
> +		 * executed as part of PM ops only when Bus reset is applied for the active
> +		 * SoundWire manager instances.
> +		 */
> +		if (acp_sdw_power_mode != AMD_SDW_POWER_OFF_MODE) {
> +			acp_data->acp_reset = false;
> +			return 0;
> +		}
> +	}
> +	return 0;
> +}

