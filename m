Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C92CF6897A6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjBCLXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbjBCLXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:23:17 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0A4DEB59;
        Fri,  3 Feb 2023 03:23:11 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id CE0F0890;
        Fri,  3 Feb 2023 12:23:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1675423388;
        bh=VHqI8CRn6BXp25m65ONqLvDTC8VmbGmhxQbZzCSju6o=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ukbcadB+jAMBWHll0cNr/qiDS7e3P2kd+Rhk5eNQfDUnB4gzuT+CXrWlFbEQJ9m/s
         C1OITO71QkCtYrUxeaMQhVzGQpyCyE/6Acba1KMraX3AKDsn+eliP6sZkaPhvymihT
         kzlqdRNyZiCevCYNT8y79Ym8Kp69PRSR7T2Yw9l4=
Message-ID: <300c0351-6ee0-d703-bd53-bc4c0fe3af0f@ideasonboard.com>
Date:   Fri, 3 Feb 2023 13:23:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v7 1/6] drm/tidss: Remove Video Port to Output Port
 coupling
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230125113529.13952-1-a-bhatia1@ti.com>
 <20230125113529.13952-2-a-bhatia1@ti.com>
Content-Language: en-US
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230125113529.13952-2-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2023 13:35, Aradhya Bhatia wrote:
> Make DSS Video Ports agnostic of output bus types.
> 
> DSS controllers have had a 1-to-1 coupling between its VPs and its
> output ports. This no longer stands true for the new AM625 DSS. This
> coupling, hence, has been removed by renaming the 'vp_bus_type' to
> 'output_port_bus_type' because the VPs are essentially agnostic of the
> bus type and it is the output ports which have a bus type.
> 
> The AM625 DSS has 2 VPs but requires 3 output ports to support its
> Dual-Link OLDI video output coming from a single VP.

Not a biggie, but this sentence is a bit odd here at the end. Shouldn't 
it be after the "...stands true for the new AM625 DSS."?

> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>   drivers/gpu/drm/tidss/tidss_dispc.c | 47 +++++++++++++++++------------
>   drivers/gpu/drm/tidss/tidss_dispc.h | 21 +++++++------
>   drivers/gpu/drm/tidss/tidss_drv.h   |  5 +--
>   drivers/gpu/drm/tidss/tidss_irq.h   |  2 +-
>   drivers/gpu/drm/tidss/tidss_kms.c   | 12 ++++----
>   5 files changed, 48 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 165365b515e1..c1c4faccbddc 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -61,7 +61,7 @@ const struct dispc_features dispc_k2g_feats = {
>   	.min_pclk_khz = 4375,
>   
>   	.max_pclk_khz = {
> -		[DISPC_VP_DPI] = 150000,
> +		[DISPC_PORT_DPI] = 150000,
>   	},
>   
>   	/*
> @@ -96,7 +96,6 @@ const struct dispc_features dispc_k2g_feats = {
>   	.vp_name = { "vp1" },
>   	.ovr_name = { "ovr1" },
>   	.vpclk_name =  { "vp1" },
> -	.vp_bus_type = { DISPC_VP_DPI },
>   
>   	.vp_feat = { .color = {
>   			.has_ctm = true,
> @@ -109,6 +108,9 @@ const struct dispc_features dispc_k2g_feats = {
>   	.vid_name = { "vid1" },
>   	.vid_lite = { false },
>   	.vid_order = { 0 },
> +
> +	.num_output_ports = 1,
> +	.output_port_bus_type = { DISPC_PORT_DPI },
>   };

Just thinking out loud, as these will get more complex in the future, 
maybe we should finally group them with struct. E.g. we could define 
struct array for vps, like (just hacky example):

	struct {
		const char *name;
		const char *clkname;
		struct tidss_vp_feat feat;
	} vps[TIDSS_MAX_PORTS];

and then use them as:

	.vps = {
		{
			.name = "kala",
			.clkname = "kissa",
			.feat.color.has_ctm = true,
		}, {
			.name = "kala2",
			.clkname = "kissa2",
			.feat.color.has_ctm = false,
		},
	},

Perhaps something to try in the future.

>   static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
> @@ -140,8 +142,8 @@ static const u16 tidss_am65x_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>   
>   const struct dispc_features dispc_am65x_feats = {
>   	.max_pclk_khz = {
> -		[DISPC_VP_DPI] = 165000,
> -		[DISPC_VP_OLDI] = 165000,
> +		[DISPC_PORT_DPI] = 165000,
> +		[DISPC_PORT_OLDI] = 165000,
>   	},
>   
>   	.scaling = {
> @@ -171,7 +173,6 @@ const struct dispc_features dispc_am65x_feats = {
>   	.vp_name = { "vp1", "vp2" },
>   	.ovr_name = { "ovr1", "ovr2" },
>   	.vpclk_name =  { "vp1", "vp2" },
> -	.vp_bus_type = { DISPC_VP_OLDI, DISPC_VP_DPI },
>   
>   	.vp_feat = { .color = {
>   			.has_ctm = true,
> @@ -185,6 +186,9 @@ const struct dispc_features dispc_am65x_feats = {
>   	.vid_name = { "vid", "vidl1" },
>   	.vid_lite = { false, true, },
>   	.vid_order = { 1, 0 },
> +
> +	.num_output_ports = 2,
> +	.output_port_bus_type = { DISPC_PORT_OLDI, DISPC_PORT_DPI },
>   };
>   
>   static const u16 tidss_j721e_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
> @@ -229,8 +233,8 @@ static const u16 tidss_j721e_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>   
>   const struct dispc_features dispc_j721e_feats = {
>   	.max_pclk_khz = {
> -		[DISPC_VP_DPI] = 170000,
> -		[DISPC_VP_INTERNAL] = 600000,
> +		[DISPC_PORT_DPI] = 170000,
> +		[DISPC_PORT_INTERNAL] = 600000,
>   	},
>   
>   	.scaling = {
> @@ -260,9 +264,7 @@ const struct dispc_features dispc_j721e_feats = {
>   	.vp_name = { "vp1", "vp2", "vp3", "vp4" },
>   	.ovr_name = { "ovr1", "ovr2", "ovr3", "ovr4" },
>   	.vpclk_name = { "vp1", "vp2", "vp3", "vp4" },
> -	/* Currently hard coded VP routing (see dispc_initial_config()) */
> -	.vp_bus_type =	{ DISPC_VP_INTERNAL, DISPC_VP_DPI,
> -			  DISPC_VP_INTERNAL, DISPC_VP_DPI, },
> +

I think this line feed is extra.

>   	.vp_feat = { .color = {
>   			.has_ctm = true,
>   			.gamma_size = 1024,
> @@ -273,6 +275,11 @@ const struct dispc_features dispc_j721e_feats = {
>   	.vid_name = { "vid1", "vidl1", "vid2", "vidl2" },
>   	.vid_lite = { 0, 1, 0, 1, },
>   	.vid_order = { 1, 3, 0, 2 },
> +
> +	.num_output_ports = 4,
> +	/* Currently hard coded VP routing (see dispc_initial_config()) */
> +	.output_port_bus_type =	{ DISPC_PORT_INTERNAL, DISPC_PORT_DPI,
> +			  DISPC_PORT_INTERNAL, DISPC_PORT_DPI, },

Indent doesn't look right (but it might be just because this is a diff).

>   };
>   
>   static const u16 *dispc_common_regmap;
> @@ -287,12 +294,12 @@ struct dispc_device {
>   
>   	void __iomem *base_common;
>   	void __iomem *base_vid[TIDSS_MAX_PLANES];
> -	void __iomem *base_ovr[TIDSS_MAX_PORTS];
> -	void __iomem *base_vp[TIDSS_MAX_PORTS];
> +	void __iomem *base_ovr[TIDSS_MAX_VPS];
> +	void __iomem *base_vp[TIDSS_MAX_VPS];
>   
>   	struct regmap *oldi_io_ctrl;
>   
> -	struct clk *vp_clk[TIDSS_MAX_PORTS];
> +	struct clk *vp_clk[TIDSS_MAX_VPS];
>   
>   	const struct dispc_features *feat;
>   
> @@ -300,7 +307,7 @@ struct dispc_device {
>   
>   	bool is_enabled;
>   
> -	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
> +	struct dss_vp_data vp_data[TIDSS_MAX_VPS];
>   
>   	u32 *fourccs;
>   	u32 num_fourccs;
> @@ -851,7 +858,7 @@ int dispc_vp_bus_check(struct dispc_device *dispc, u32 hw_videoport,
>   		return -EINVAL;
>   	}
>   
> -	if (dispc->feat->vp_bus_type[hw_videoport] != DISPC_VP_OLDI &&
> +	if (dispc->feat->output_port_bus_type[hw_videoport] != DISPC_PORT_OLDI &&

Hmm, so is the hw_videoport a vp index or an output index? Sounds like 
the former, so it's not right, even if at the moment they're identical. 
We need some kind of mapping between those.

If the mapping can be changed (or just defined in the DT), I think we 
need a variable in struct dispc_device, which tells the output to which 
a videoport is connected to. Or vice versa, I'm not sure which direction 
we need more. If the mapping is always the same on all SoC (but I don't 
think so), we can have it in the feats.

Also, I wonder if output_port is a good name as it has "port" in it 
(like video port), and it's a bit long-ish. Would just "output" be 
enough? We could, of course, shorten it to OP, but that looks odd to me =).

>   	    fmt->is_oldi_fmt) {
>   		dev_dbg(dispc->dev, "%s: %s is not OLDI-port\n",
>   			__func__, dispc->feat->vp_name[hw_videoport]);
> @@ -955,7 +962,7 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   	if (WARN_ON(!fmt))
>   		return;
>   
> -	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI) {
> +	if (dispc->feat->output_port_bus_type[hw_videoport] == DISPC_PORT_OLDI) {
>   		dispc_oldi_tx_power(dispc, true);
>   
>   		dispc_enable_oldi(dispc, hw_videoport, fmt);
> @@ -1014,7 +1021,7 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport,
>   	align = true;
>   
>   	/* always use DE_HIGH for OLDI */
> -	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI)
> +	if (dispc->feat->output_port_bus_type[hw_videoport] == DISPC_PORT_OLDI)
>   		ieo = false;
>   
>   	dispc_vp_write(dispc, hw_videoport, DISPC_VP_POL_FREQ,
> @@ -1040,7 +1047,7 @@ void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>   
>   void dispc_vp_unprepare(struct dispc_device *dispc, u32 hw_videoport)
>   {
> -	if (dispc->feat->vp_bus_type[hw_videoport] == DISPC_VP_OLDI) {
> +	if (dispc->feat->output_port_bus_type[hw_videoport] == DISPC_PORT_OLDI) {
>   		dispc_vp_write(dispc, hw_videoport, DISPC_VP_DSS_OLDI_CFG, 0);
>   
>   		dispc_oldi_tx_power(dispc, false);
> @@ -1116,10 +1123,10 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
>   					 const struct drm_display_mode *mode)
>   {
>   	u32 hsw, hfp, hbp, vsw, vfp, vbp;
> -	enum dispc_vp_bus_type bus_type;
> +	enum dispc_port_bus_type bus_type;
>   	int max_pclk;
>   
> -	bus_type = dispc->feat->vp_bus_type[hw_videoport];
> +	bus_type = dispc->feat->output_port_bus_type[hw_videoport];
>   
>   	max_pclk = dispc->feat->max_pclk_khz[bus_type];
>   
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index e49432f0abf5..30fb44158347 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -50,11 +50,11 @@ struct dispc_errata {
>   	bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
>   };
>   
> -enum dispc_vp_bus_type {
> -	DISPC_VP_DPI,		/* DPI output */
> -	DISPC_VP_OLDI,		/* OLDI (LVDS) output */
> -	DISPC_VP_INTERNAL,	/* SoC internal routing */
> -	DISPC_VP_MAX_BUS_TYPE,
> +enum dispc_port_bus_type {
> +	DISPC_PORT_DPI,			/* DPI output */
> +	DISPC_PORT_OLDI,		/* OLDI (LVDS) output */
> +	DISPC_PORT_INTERNAL,		/* SoC internal routing */
> +	DISPC_PORT_MAX_BUS_TYPE,

Okay, so here you have just "port", not "output_port". In the DT, 
they're ports, so... Maybe we could use that name too, and for video 
port always use "vp". The current "hw_videoport" could be easily 
mistaken with "port".

I don't recall why I chose to use "hw" prefix there. I think I wanted to 
separate it from some other videoport, but... I don't know what that 
"other" is =).

  Tomi

