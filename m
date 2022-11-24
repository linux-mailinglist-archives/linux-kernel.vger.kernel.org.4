Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE159637199
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 05:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiKXEvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 23:51:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKXEvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 23:51:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8FC8C72FE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 20:51:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ED0CB8255B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Nov 2022 04:51:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D82BC433D6;
        Thu, 24 Nov 2022 04:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669265497;
        bh=yJ2mQRZPfqeST/3rdNB7vR82fMPOErOCCRL2chwCXTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CJu1qtyjkD5bcpDzTgnxUpmLDMTlQL2EjMsFjsX+UQ5huLkpETXcAVY0AiLXlibJt
         9pqxnqdKW02EQPWanY6JusAfBJN9i4kltd3sx/FmRTz7Jhp4U7ygdesBofK1RtB2NB
         hiuT0wyaVLg/EB/qbK5EdDg7q4aoewxjura0ylO+Uc0sdu0EbGOHA8ealwlPY71Rpr
         VKg6HY5HO6l+BB2clHpmDJPXTqQsOJP9/nf9DkGb4g5z+4A5X6TkqALXSq0U4H6v/G
         O7I9MnV3qJkLwDtcsITNc9Wxro7w0klLXdGBR642BBwrLXCuYKWyrStRowBHS/rLIl
         qD5+d8R4eDp8w==
Date:   Thu, 24 Nov 2022 10:21:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     yung-chuan.liao@linux.intel.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com
Subject: Re: [PATCH v3 2/4] soundwire: Provide build stubs for common
 functions
Message-ID: <Y374VPAQcX6MkG22@matsya>
References: <20221121141406.3840561-1-ckeepax@opensource.cirrus.com>
 <20221121141406.3840561-3-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121141406.3840561-3-ckeepax@opensource.cirrus.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-11-22, 14:14, Charles Keepax wrote:
> Provide stub functions when CONFIG_SOUNDWIRE is not set for functions
> that are quite likely to be used from common code on devices supporting
> multiple control buses.
> 
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> ---
> 
> No changes since v2.
> 
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

Should this and other here not return error...? Indicating sdw is not
available..? Silently ignoring may not be very helpful in debugging


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
> -- 
> 2.30.2

-- 
~Vinod
