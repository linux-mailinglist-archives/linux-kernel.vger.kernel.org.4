Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46FE6284D3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:16:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbiKNQQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:16:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236716AbiKNQQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:16:41 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF437252AA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668442600; x=1699978600;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=9XjXu+LDtwmHBFWOixMQ50f7bL6O8H/9Tyl8CQ9aSXw=;
  b=BhZ/2r/oUQ0ltuMKW2H8SFbYU3rlMSDWFbDcDOyP0Ry6tj3y0HAf8MJY
   oGoAwsxlC0Cy9wubd096hSuZ+BIRRbOYi7RLjqRTnCSSOBeH70Eo7dA+u
   7gxLZffEErPoLKLyUKZTaaiRHGQYJyoN2vDIAlfzA+up0TtDutKPv38/Q
   2LTuefBUTar2XhKW+rLHqJTvdyqVDVrD2Hiz+fpz9qxB2SkPwUpk1ChGy
   Ay5zXlZAJXiHdtZ2vXP+nyLCI/2VauOa/wvk8mMiB9cZZJmo9woODeBG/
   MgtvRJUonNoxqvk/CQtfsQ0BRize20koDZbZGtx8i8QfnGojgMF/TcJn2
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="295373432"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="295373432"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10531"; a="638542574"
X-IronPort-AV: E=Sophos;i="5.96,164,1665471600"; 
   d="scan'208";a="638542574"
Received: from scewbso01.amr.corp.intel.com (HELO [10.212.76.77]) ([10.212.76.77])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2022 08:16:39 -0800
Message-ID: <90b01c76-fc65-a57f-9247-fae78241342c@linux.intel.com>
Date:   Mon, 14 Nov 2022 10:13:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 2/4] soundwire: Provide build stubs for common functions
To:     Charles Keepax <ckeepax@opensource.cirrus.com>, vkoul@kernel.org
Cc:     yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
References: <20221114102956.914468-1-ckeepax@opensource.cirrus.com>
 <20221114102956.914468-3-ckeepax@opensource.cirrus.com>
Content-Language: en-US
In-Reply-To: <20221114102956.914468-3-ckeepax@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/22 04:29, Charles Keepax wrote:
> Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> that are quite likely to be used from common code on devices supporting
> multiple control buses.

So far this case has been covered by splitting SoundWire related code
away from, say I2C, and with a clear 'depends on SOUNDWIRE'. This is the
case for rt5682, max98373, etc.

Is this not good enough?

I am not against this patch, just wondering if allowing code for
different interfaces to be part of the same file will lead to confusions
with e.g. register offsets or functionality exposed with different
registers.

> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
>  include/linux/soundwire/sdw.h | 92 +++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 902ed46f76c80..4f80cba898f11 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -1021,15 +1021,8 @@ int sdw_stream_add_master(struct sdw_bus *bus,
>  		struct sdw_port_config *port_config,
>  		unsigned int num_ports,
>  		struct sdw_stream_runtime *stream);
> -int sdw_stream_add_slave(struct sdw_slave *slave,
> -		struct sdw_stream_config *stream_config,
> -		struct sdw_port_config *port_config,
> -		unsigned int num_ports,
> -		struct sdw_stream_runtime *stream);
>  int sdw_stream_remove_master(struct sdw_bus *bus,
>  		struct sdw_stream_runtime *stream);
> -int sdw_stream_remove_slave(struct sdw_slave *slave,
> -		struct sdw_stream_runtime *stream);
>  int sdw_startup_stream(void *sdw_substream);
>  int sdw_prepare_stream(struct sdw_stream_runtime *stream);
>  int sdw_enable_stream(struct sdw_stream_runtime *stream);
> @@ -1040,8 +1033,20 @@ int sdw_bus_prep_clk_stop(struct sdw_bus *bus);
>  int sdw_bus_clk_stop(struct sdw_bus *bus);
>  int sdw_bus_exit_clk_stop(struct sdw_bus *bus);
>  
> -/* messaging and data APIs */
> +int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
> +void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
> +
> +#if IS_ENABLED(CONFIG_SOUNDWIRE)
>  
> +int sdw_stream_add_slave(struct sdw_slave *slave,
> +			 struct sdw_stream_config *stream_config,
> +			 struct sdw_port_config *port_config,
> +			 unsigned int num_ports,
> +			 struct sdw_stream_runtime *stream);
> +int sdw_stream_remove_slave(struct sdw_slave *slave,
> +			    struct sdw_stream_runtime *stream);
> +
> +/* messaging and data APIs */
>  int sdw_read(struct sdw_slave *slave, u32 addr);
>  int sdw_write(struct sdw_slave *slave, u32 addr, u8 value);
>  int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value);
> @@ -1053,7 +1058,74 @@ int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *
>  int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
>  int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
>  
> -int sdw_compare_devid(struct sdw_slave *slave, struct sdw_slave_id id);
> -void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id);
> +#else
> +
> +static inline int sdw_stream_add_slave(struct sdw_slave *slave,
> +				       struct sdw_stream_config *stream_config,
> +				       struct sdw_port_config *port_config,
> +				       unsigned int num_ports,
> +				       struct sdw_stream_runtime *stream)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_stream_remove_slave(struct sdw_slave *slave,
> +					  struct sdw_stream_runtime *stream)
> +{
> +	return 0;
> +}
> +
> +/* messaging and data APIs */
> +static inline int sdw_read(struct sdw_slave *slave, u32 addr)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_write(struct sdw_slave *slave, u32 addr, u8 value)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_write_no_pm(struct sdw_slave *slave, u32 addr, u8 value)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_read_no_pm(struct sdw_slave *slave, u32 addr)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_nread(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_nread_no_pm(struct sdw_slave *slave, u32 addr, size_t count, u8 *val)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_nwrite(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_nwrite_no_pm(struct sdw_slave *slave, u32 addr, size_t count, const u8 *val)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_update(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
> +{
> +	return 0;
> +}
> +
> +static inline int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val)
> +{
> +	return 0;
> +}
> +
> +#endif /* CONFIG_SOUNDWIRE */
>  
>  #endif /* __SOUNDWIRE_H */
