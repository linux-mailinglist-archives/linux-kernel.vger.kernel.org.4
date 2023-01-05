Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F265F5D7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 22:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbjAEVbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 16:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235992AbjAEVbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 16:31:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B7671BB;
        Thu,  5 Jan 2023 13:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672954277; x=1704490277;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=GOTDvrhzlvM4EmgW0TpXAOqu08MBVz3+6xW4/8keqdw=;
  b=GIe1M5Zy1mHo/+6Nz5yfjsbiNf4Xpx0V3j4MritQwLdBB5G3acmZNGgO
   E6+loQ/euJBQT9+WS920LvJPGFeY/xb6bR6t2Z1AFYk9ZfAQYpPXOucfL
   XhdoRfHH62TpXLY9HpMx6wehOp9YPjzWkIbf0qYybCju3yP9Kv1jCq/cz
   vZFSz2ZaUmKnimDnclkxR4Gf1q3ODu19qIiRLje/QQ41kXYwO+Kx1hMdb
   tY+2gmxokdy0enQ0A8D2A59O3xModw73B0gMPoKZjMq8jec2ux+M4rAJ/
   3H6pHeGSfXn+d0ieA6c8nCznBqa8L/0m4g7tz7Gll+EQ+U/7msvbxmyX6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="322395961"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="322395961"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:31:16 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10581"; a="763284816"
X-IronPort-AV: E=Sophos;i="5.96,303,1665471600"; 
   d="scan'208";a="763284816"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.249.42.126])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2023 13:31:13 -0800
Message-ID: <9841589c-757e-ea01-0c55-abe4a38fae03@intel.com>
Date:   Thu, 5 Jan 2023 23:31:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.1
From:   Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6 22/24] mmc: sdhci-uhs2: add post-mmc_attach_sd hook
To:     Victor Shih <victorshihgli@gmail.com>, ulf.hansson@linaro.org
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>
References: <20221213090047.3805-1-victor.shih@genesyslogic.com.tw>
 <20221213090047.3805-23-victor.shih@genesyslogic.com.tw>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20221213090047.3805-23-victor.shih@genesyslogic.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/12/22 11:00, Victor Shih wrote:
> From: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> 
> This "post" hook for mmc_attach_sd(), uhs2_post_attach_sd, will be required
> to enable UHS-II support, at least, on GL9755.
> 
> Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
> Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> ---
>  drivers/mmc/host/sdhci.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index e5f64b38e339..4aac22b58d79 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -728,6 +728,7 @@ struct sdhci_ops {
>  	void    (*dump_vendor_regs)(struct sdhci_host *host);
>  	void	(*dump_uhs2_regs)(struct sdhci_host *host);
>  	void    (*uhs2_pre_detect_init)(struct sdhci_host *host);
> +	void    (*uhs2_post_attach_sd)(struct sdhci_host *host);

This gets called already in "mmc: sdhci-uhs2: add uhs2_control()
to initialise the interface"

Either move that line to this patch or vice versa.

Please check compiling after each patch is applied.

>  };
>  
>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS

