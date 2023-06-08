Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F79727829
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbjFHHHP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235092AbjFHHHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:07:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E3F9E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C95886092E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 07:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A79A1C433D2;
        Thu,  8 Jun 2023 07:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686208031;
        bh=KSoH5KNtLIHMAgBfGslns6P0M3C/9r4ndbmgNvQToyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+jvxE7DzXthjpe8qrMDgkz90+rveLuPlbTf57ftjP+AcueGsbvmIW9yutHyX3VHk
         H08GOPIGq8N1mPnL63bK+CeytLd5XBSfHOOqVSsutJMZatM5tXqMNymg0ozqLEtFR/
         tWSjI0BmAM9y2/JHQ1xQSyDgX2WwLV/Ym/pwTEfuyoP6RcOO2+ClfkGydouJcTjgrF
         WN2sEwUw9wQmMZE0beUdgQNYuGSWJDzMdSY7WBRYiiQ6ZGx+yvKLdwUrCr7yxi8I70
         vrk0XLuC7mEjaYWBOt0G4DTWJmoHJSk5hzzfK1LERak7Tn/LOOXhWmepCfDkZTJWRX
         9NvV0g/KKFbpw==
Date:   Thu, 8 Jun 2023 12:37:07 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 3/4] soundwire: extend parameters of
 new_peripheral_assigned() callback
Message-ID: <ZIF+G1mbis/lb8Po@matsya>
References: <20230531033736.792464-1-yung-chuan.liao@linux.intel.com>
 <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531033736.792464-4-yung-chuan.liao@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-05-23, 11:37, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> The parameters are only the bus and the device number, manager ops may
> need additional details on the type of peripheral connected, such as
> whether it is wake-capable or not.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Reviewed-by: Rander Wang <rander.wang@intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> ---
>  drivers/soundwire/bus.c             | 2 +-
>  drivers/soundwire/intel_auxdevice.c | 4 +++-
>  include/linux/soundwire/sdw.h       | 4 +++-
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 6f465cce8369..17b9a8bdf234 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -786,7 +786,7 @@ static int sdw_assign_device_num(struct sdw_slave *slave)
>  	slave->dev_num = slave->dev_num_sticky;
>  
>  	if (bus->ops && bus->ops->new_peripheral_assigned)
> -		bus->ops->new_peripheral_assigned(bus, dev_num);
> +		bus->ops->new_peripheral_assigned(bus, slave, dev_num);
>  
>  	return 0;
>  }
> diff --git a/drivers/soundwire/intel_auxdevice.c b/drivers/soundwire/intel_auxdevice.c
> index 30f3d2ab80fd..c1df6f014e6b 100644
> --- a/drivers/soundwire/intel_auxdevice.c
> +++ b/drivers/soundwire/intel_auxdevice.c
> @@ -60,7 +60,9 @@ static int generic_post_bank_switch(struct sdw_bus *bus)
>  	return sdw->link_res->hw_ops->post_bank_switch(sdw);
>  }
>  
> -static void generic_new_peripheral_assigned(struct sdw_bus *bus, int dev_num)
> +static void generic_new_peripheral_assigned(struct sdw_bus *bus,
> +					    struct sdw_slave *slave,
> +					    int dev_num)
>  {
>  	struct sdw_cdns *cdns = bus_to_cdns(bus);
>  	struct sdw_intel *sdw = cdns_to_intel(cdns);
> diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
> index 8a7541ac735e..41a856bedf1e 100644
> --- a/include/linux/soundwire/sdw.h
> +++ b/include/linux/soundwire/sdw.h
> @@ -861,7 +861,9 @@ struct sdw_master_ops {
>  	int (*pre_bank_switch)(struct sdw_bus *bus);
>  	int (*post_bank_switch)(struct sdw_bus *bus);
>  	u32 (*read_ping_status)(struct sdw_bus *bus);
> -	void (*new_peripheral_assigned)(struct sdw_bus *bus, int dev_num);
> +	void (*new_peripheral_assigned)(struct sdw_bus *bus,
> +					struct sdw_slave *slave,

maybe better, drop the bus and pass slave (which contains bus)

-- 
~Vinod
