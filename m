Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 759BD636224
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 15:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236444AbiKWOoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 09:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbiKWOoK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 09:44:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8E6D1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 06:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0B8BEB8202D
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 14:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1648CC433D6;
        Wed, 23 Nov 2022 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669214646;
        bh=G3ijxHCawFa1niWMPyUbZFEAKr9W06XfOYoLufYKlBQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qG+b9VAeuac0I16Axm1x0mtNJNFmRI+5tell1MjfCvbugc0JCDm/M+8yfWud0dxUN
         /ctyxcilYNitjQZW+v4F2mGSLkV2WsXI+85HRI1LSw+kd33I+5khhTjSqtfBdYC4m/
         2pksW0/aAQ7cJVRuk14YZj7ln6v/a9euArGBDOBhb866j2v/QM8BImxLQyeiaLYn8S
         YJy/bHHE/cMVfueUTXJusn6RekaO9OxyLhQtSLoiZyc0yHTk/7YaXyUZhkmtQJu6UC
         JdH3YZtnxhfva15wcD6ZKTv49Bb3rdRwdRkNWnLFtQpce7WQ6UnFKlao78gNYoLFZ1
         9oMhQiRet3GEA==
Date:   Wed, 23 Nov 2022 20:14:02 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/2] soundwire: remove is_sdca boolean property
Message-ID: <Y34xsiIkuzq/PMb+@matsya>
References: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
 <20221111021633.39908-2-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221111021633.39908-2-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-11-22, 10:16, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The Device_ID registers already tell us if a device supports the SDCA
> specification or not, in hindsight we never needed a property when the
> information is reported by both hardware and ACPI.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.c           | 4 ++--
>  include/linux/soundwire/sdw.h     | 2 --
>  sound/soc/codecs/rt1316-sdw.c     | 1 -
>  sound/soc/codecs/rt711-sdca-sdw.c | 1 -

The change lgtm, but needs ACK from Mark. Please split the ASoC bit to
separate patch and copy Mark (that can be first patch here)

>  4 files changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 76515c33e639..c23275b443ac 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1587,7 +1587,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  		goto io_err;
>  	}
>  
> -	if (slave->prop.is_sdca) {
> +	if (slave->id.class_id) {
>  		ret = sdw_read_no_pm(slave, SDW_DP0_INT);
>  		if (ret < 0) {
>  			dev_err(&slave->dev,
> @@ -1724,7 +1724,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  			goto io_err;
>  		}
>  
> -		if (slave->prop.is_sdca) {
> +		if (slave->id.class_id) {
>  			ret = sdw_read_no_pm(slave, SDW_DP0_INT);
>  			if (ret < 0) {
>  				dev_err(&slave->dev,
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 9e4537f409c2..8fb458931772 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -365,7 +365,6 @@ struct sdw_dpn_prop {
>   * @sink_dpn_prop: Sink Data Port N properties
>   * @scp_int1_mask: SCP_INT1_MASK desired settings
>   * @quirks: bitmask identifying deltas from the MIPI specification
> - * @is_sdca: the Slave supports the SDCA specification
>   */
>  struct sdw_slave_prop {
>  	u32 mipi_revision;
> @@ -389,7 +388,6 @@ struct sdw_slave_prop {
>  	struct sdw_dpn_prop *sink_dpn_prop;
>  	u8 scp_int1_mask;
>  	u32 quirks;
> -	bool is_sdca;
>  };
>  
>  #define SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY	BIT(0)
> diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
> index ed0a11436362..8b27401237f7 100644
> --- a/sound/soc/codecs/rt1316-sdw.c
> +++ b/sound/soc/codecs/rt1316-sdw.c
> @@ -203,7 +203,6 @@ static int rt1316_read_prop(struct sdw_slave *slave)
>  
>  	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>  	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> -	prop->is_sdca = true;
>  
>  	prop->paging_support = true;
>  
> diff --git a/sound/soc/codecs/rt711-sdca-sdw.c b/sound/soc/codecs/rt711-sdca-sdw.c
> index 4120842fe699..6ca8795eed68 100644
> --- a/sound/soc/codecs/rt711-sdca-sdw.c
> +++ b/sound/soc/codecs/rt711-sdca-sdw.c
> @@ -186,7 +186,6 @@ static int rt711_sdca_read_prop(struct sdw_slave *slave)
>  
>  	prop->scp_int1_mask = SDW_SCP_INT1_BUS_CLASH | SDW_SCP_INT1_PARITY;
>  	prop->quirks = SDW_SLAVE_QUIRKS_INVALID_INITIAL_PARITY;
> -	prop->is_sdca = true;
>  
>  	prop->paging_support = true;
>  
> -- 
> 2.25.1

-- 
~Vinod
