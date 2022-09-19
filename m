Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23EC5BC4C7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 10:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiISIxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 04:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiISIwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 04:52:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C54318F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 01:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663577546; x=1695113546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Qm1u/FNMmy6waA/y8h4KJo7zAZIlEM/L7gSWwpBW5Yo=;
  b=WTQKATPIufZtSaHpBvJbBR6FZcxYojk8YpKuUjcEhAEYu63VjQWb9P4j
   jvyXpFTCOSY9nUEa9AS/y1Z5U2/ML7xQhLAL4CSNdaAmMEDsO2sQu6kU+
   k3LlquBYKIJlaedtDQ9pk4MxqzIj9rVzOViDfaz9vnOx1QZTDr9rlccBz
   Y1DJC8cDOn/BK//1eNRIeApmNbLZld0MkgqzOU5+uAjAsYVRJ/YAdTxmz
   S+6Gg1d9SKN5bgoXHnfQLGnDVIxgTcLnShclBKHWGSsDffpxHnrGrg0A8
   mA+oUzk3rx313AlQPpRGVnAQePNSSTqVYzs20ZxZBG2VRph+qXeqjD/uh
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="299336631"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="299336631"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:10 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="707485736"
Received: from ilick-mobl1.ger.corp.intel.com (HELO [10.252.59.91]) ([10.252.59.91])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 01:52:08 -0700
Message-ID: <9edb1178-7454-eb3f-60a5-d3f73d01c9d6@linux.intel.com>
Date:   Mon, 19 Sep 2022 10:44:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH] soundwire: bus: Fix wrong port number in
 sdw_handle_slave_alerts()
Content-Language: en-US
To:     Richard Fitzgerald <rf@opensource.cirrus.com>, vkoul@kernel.org,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com
Cc:     patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <20220917140256.689678-1-rf@opensource.cirrus.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220917140256.689678-1-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/17/22 16:02, Richard Fitzgerald wrote:
> for_each_set_bit() gives the bit-number counting from 0 (LSbit==0).
> When processing INTSTAT2, bit 0 is DP4 so the port number is (bit + 4).
> Likewise for INTSTAT3 bit 0 is DP11 so port number is (bit + 11).
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Another thing that never worked, but no one has used port interrupts so
far. I only used it for PRBS tests in early enabling some 3 years ago,
and it was for port 2 IIRC.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  drivers/soundwire/bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
> index 8eded1a55227..df0ae869ee51 100644
> --- a/drivers/soundwire/bus.c
> +++ b/drivers/soundwire/bus.c
> @@ -1622,7 +1622,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  			port = buf2[0] & SDW_SCP_INTSTAT2_PORT4_10;
>  			for_each_set_bit(bit, &port, 8) {
>  				/* scp2 ports start from 4 */
> -				port_num = bit + 3;
> +				port_num = bit + 4;
>  				sdw_handle_port_interrupt(slave,
>  						port_num,
>  						&port_status[port_num]);
> @@ -1634,7 +1634,7 @@ static int sdw_handle_slave_alerts(struct sdw_slave *slave)
>  			port = buf2[1] & SDW_SCP_INTSTAT3_PORT11_14;
>  			for_each_set_bit(bit, &port, 8) {
>  				/* scp3 ports start from 11 */
> -				port_num = bit + 10;
> +				port_num = bit + 11;
>  				sdw_handle_port_interrupt(slave,
>  						port_num,
>  						&port_status[port_num]);
