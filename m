Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14215FF210
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJNQMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJNQME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:12:04 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3336F2FFC8;
        Fri, 14 Oct 2022 09:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665763923; x=1697299923;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oHMAZQy+mCQkpcnxGLzs5vgm2UUBbtUUFVS1Gcs02f8=;
  b=GKTTrFaPr9+lrQ4O3LijMwkDaLlKvAruxTDbyjzQ0367XYb5qMR4l+4h
   7/wI/YlxX2Kv/iutilRNXEP163TboOShF0NH7VcTp58KvIdB935nLc1Mr
   CZkAaendwC+1Zsw5zMCviInlD1PSNu3m6j75xpgx333w8MqW9iinrwaDD
   U5XQXelSNB560058+fo6wLYUdL/Tot4A7i6Nqnst7oRoi3NCb2W1B1/3u
   PMu9qANBNDfsbOVV1bMkKpv2rMQ98XAcNcEwfoBn+2pFzDaNHBxxAuiOq
   ydcYULncpw6hgjqz/YQgx0Np/gBEFCrrtm+c9bLwK4p0idy6Jt4j2Am+a
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="305399756"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="305399756"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 09:12:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10500"; a="696354160"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="696354160"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmsmga004.fm.intel.com with ESMTP; 14 Oct 2022 09:11:59 -0700
Date:   Sat, 15 Oct 2022 00:02:54 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Nava kishore Manne <nava.kishore.manne@amd.com>
Cc:     git@xilinx.com, michal.simek@xilinx.com, mdf@kernel.org,
        hao.wu@intel.com, trix@redhat.com, gregkh@linuxfoundation.org,
        ronak.jain@xilinx.com, rajan.vaja@xilinx.com,
        abhyuday.godhasara@xilinx.com, harsha.harsha@xilinx.com,
        lakshmi.sai.krishna.potthuri@xilinx.com, tanmay.shah@xilinx.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-fpga@vger.kernel.org
Subject: Re: [PATCH v3 2/2] fpga: zynqmp-fpga: Adds status interface
Message-ID: <Y0mILkB9ym5fQ4wJ@yilunxu-OptiPlex-7050>
References: <20221013090556.741357-1-nava.kishore.manne@amd.com>
 <20221013090556.741357-3-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013090556.741357-3-nava.kishore.manne@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-13 at 14:35:56 +0530, Nava kishore Manne wrote:
> Adds status interface for zynqmp-fpga, It's a read only interface
> which allows the user to get the Programmable Logic(PL) configuration
> status.
> 
> Usage:
> To read the Programmable Logic(PL) configuration status
>         cat /sys/class/fpga_manager/<fpga>/device/status
> 
> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> ---
> Changes for v2:
>               - Updated status messages handling logic as suggested by Xu Yilun.
> 
> Changes for v3:
>               - Updated status interface handling logic (Restrict the status
>                 interface to the device-specific instead of handled by the core)
>                 as suggested by Xu Yilun.
> 
>  drivers/fpga/zynqmp-fpga.c | 87 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 87 insertions(+)
> 
> diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
> index c60f20949c47..4e0295486c36 100644
> --- a/drivers/fpga/zynqmp-fpga.c
> +++ b/drivers/fpga/zynqmp-fpga.c
> @@ -15,6 +15,37 @@
>  /* Constant Definitions */
>  #define IXR_FPGA_DONE_MASK	BIT(3)
>  
> +/* Error Register */
> +#define IXR_FPGA_ERR_CRC_ERR		BIT(0)
> +#define IXR_FPGA_ERR_SECURITY_ERR	BIT(16)
> +
> +/* Signal Status Register */
> +#define IXR_FPGA_END_OF_STARTUP		BIT(4)
> +#define IXR_FPGA_GST_CFG_B		BIT(5)
> +#define IXR_FPGA_INIT_B_INTERNAL	BIT(11)
> +#define IXR_FPGA_DONE_INTERNAL_SIGNAL	BIT(13)
> +
> +/* FPGA error status. */
> +enum {
> +	ZYNQMP_FPGA_STATUS_CRC_ERR,
> +	ZYNQMP_FPGA_STATUS_SECURITY_ERR,
> +	ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR,
> +	ZYNQMP_FPGA_STATUS_SIGNAL_ERR,
> +	ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR,
> +	ZYNQMP_FPGA_STATUS_EOS_ERR,
> +	ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR,
> +};
> +
> +static const char * const zynqmp_fpga_error_statuses[] = {
> +	[ZYNQMP_FPGA_STATUS_CRC_ERR] = "reconfig CRC error",
> +	[ZYNQMP_FPGA_STATUS_SECURITY_ERR] = "reconfig security error",
> +	[ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR] = "Device Initialization error",
> +	[ZYNQMP_FPGA_STATUS_SIGNAL_ERR] = "Device internal signal error",
> +	[ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR] = "All I/Os are placed in High-Z state",
> +	[ZYNQMP_FPGA_STATUS_EOS_ERR] = "Device sequence error",
> +	[ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR] = "firmware request error",

If you have multiple errors, the output would be a mess. You can not
even tell how many errors are there.

For string values, I suggest one word for each, and separated by a space.

Thanks,
Yilun

> +};
> +
>  /**
>   * struct zynqmp_fpga_priv - Private data structure
>   * @dev:	Device data structure
> @@ -77,6 +108,54 @@ static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
>  	return FPGA_MGR_STATE_UNKNOWN;
>  }
>  
> +static ssize_t status_show(struct device *dev,
> +			   struct device_attribute *attr, char *buf)
> +{
> +	unsigned long status = 0;
> +	ssize_t len = 0;
> +	u32 reg_val;
> +	int ret;
> +	u8 i;
> +
> +	ret = zynqmp_pm_fpga_get_config_status(&reg_val);
> +	if (!ret) {
> +		if (reg_val & IXR_FPGA_ERR_CRC_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_CRC_ERR;
> +		if (reg_val & IXR_FPGA_ERR_SECURITY_ERR)
> +			status |= ZYNQMP_FPGA_STATUS_SECURITY_ERR;
> +		if (!(reg_val & IXR_FPGA_INIT_B_INTERNAL))
> +			status |= ZYNQMP_FPGA_STATUS_DEVICE_INIT_ERR;
> +		if (!(reg_val & IXR_FPGA_DONE_INTERNAL_SIGNAL))
> +			status |= ZYNQMP_FPGA_STATUS_SIGNAL_ERR;
> +		if (!(reg_val & IXR_FPGA_GST_CFG_B))
> +			status |= ZYNQMP_FPGA_STATUS_HIGH_Z_STATE_ERR;
> +		if (!(reg_val & IXR_FPGA_END_OF_STARTUP))
> +			status |= ZYNQMP_FPGA_STATUS_EOS_ERR;
> +	} else {
> +		status = ZYNQMP_FPGA_MGR_STATUS_FIRMWARE_REQ_ERR;
> +	}
> +
> +	for_each_set_bit(i, &status, ARRAY_SIZE(zynqmp_fpga_error_statuses))
> +		len += sysfs_emit_at(buf, len, "%s ",
> +				     zynqmp_fpga_error_statuses[i]);
> +
> +	if (len)
> +		buf[len - 1] = '\n';
> +
> +	return len;
> +}
> +
> +static DEVICE_ATTR_RO(status);
> +
> +static struct attribute *zynqmp_fpga_device_attrs[] = {
> +	&dev_attr_status.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group zynqmp_fpga_attr_group = {
> +	.attrs = zynqmp_fpga_device_attrs,
> +};
> +
>  static const struct fpga_manager_ops zynqmp_fpga_ops = {
>  	.state = zynqmp_fpga_ops_state,
>  	.write_init = zynqmp_fpga_ops_write_init,
> @@ -88,6 +167,7 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct zynqmp_fpga_priv *priv;
>  	struct fpga_manager *mgr;
> +	int ret;
>  
>  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
> @@ -95,6 +175,13 @@ static int zynqmp_fpga_probe(struct platform_device *pdev)
>  
>  	priv->dev = dev;
>  
> +	/* Add the device attributes */
> +	ret = sysfs_create_group(&dev->kobj, &zynqmp_fpga_attr_group);
> +	if (ret) {
> +		dev_err(dev, "Error creating sysfs files\n");
> +		return ret;
> +	}
> +
>  	mgr = devm_fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
>  				     &zynqmp_fpga_ops, priv);
>  	return PTR_ERR_OR_ZERO(mgr);
> -- 
> 2.25.1
> 
