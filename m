Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70CC6758DC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 16:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjATPig (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 10:38:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjATPie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 10:38:34 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73AFEC926F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:38:11 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6852C1515
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:38:11 -0800 (PST)
Received: from e110455-lin.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7DC523F67D
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 07:37:29 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:36:50 +0000
From:   Liviu Dudau <liviu.dudau@arm.com>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org,
        Xinliang Liu <xinliang.liu@linaro.org>,
        linux-mips@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        John Stultz <jstultz@google.com>,
        Mihail Atanassov <mihail.atanassov@arm.com>,
        Samuel Holland <samuel@sholland.org>,
        Russell King <linux@armlinux.org.uk>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Mali DP Maintainers <malidp@foss.arm.com>,
        linux-arm-msm@vger.kernel.org,
        Alain Volmat <alain.volmat@foss.st.com>,
        Xinwei Kong <kong.kongxinwei@hisilicon.com>,
        linux-sunxi@lists.linux.dev,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chen Feng <puck.chen@hisilicon.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        etnaviv@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Paul <sean@poorly.run>,
        linux-arm-kernel@lists.infradead.org,
        Tomi Valkeinen <tomba@kernel.org>,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Tian Tao <tiantao6@hisilicon.com>,
        Jyri Sarha <jyri.sarha@iki.fi>
Subject: Re: [PATCH v3 3/3] drm: Convert users of drm_of_component_match_add
 to component_match_add_of
Message-ID: <Y8q0tN88QGKcIfw/@e110455-lin.cambridge.arm.com>
References: <20230119191040.1637739-1-sean.anderson@seco.com>
 <20230119191040.1637739-4-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119191040.1637739-4-sean.anderson@seco.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:10:39PM -0500, Sean Anderson wrote:
> Every user of this function either uses component_compare_of or
> something equivalent. Most of them immediately put the device node as
> well. Convert these users to component_match_add_of and remove
> drm_of_component_match_add.
> 
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Jyri Sarha <jyri.sarhaı@iki.fi>
> Tested-by: Jyri Sarha <jyri.sarha@iki.fi>
> ---
> 
> (no changes since v1)
> 
>  .../gpu/drm/arm/display/komeda/komeda_drv.c   |  6 ++--
>  drivers/gpu/drm/arm/hdlcd_drv.c               |  9 +-----
>  drivers/gpu/drm/arm/malidp_drv.c              | 11 +------
>  drivers/gpu/drm/armada/armada_drv.c           | 10 ++++---
>  drivers/gpu/drm/drm_of.c                      | 29 +++----------------
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c         |  4 +--
>  .../gpu/drm/hisilicon/kirin/kirin_drm_drv.c   |  3 +-
>  drivers/gpu/drm/ingenic/ingenic-drm-drv.c     |  3 +-
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c        |  4 +--
>  drivers/gpu/drm/msm/msm_drv.c                 | 14 ++++-----
>  drivers/gpu/drm/sti/sti_drv.c                 |  3 +-
>  drivers/gpu/drm/sun4i/sun4i_drv.c             |  3 +-
>  drivers/gpu/drm/tilcdc/tilcdc_external.c      | 10 ++-----
>  include/drm/drm_of.h                          | 12 --------
>  14 files changed, 33 insertions(+), 88 deletions(-)
> 
> diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> index 3f4e719eebd8..e3bfc72c378f 100644
> --- a/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> +++ b/drivers/gpu/drm/arm/display/komeda/komeda_drv.c
> @@ -103,10 +103,8 @@ static void komeda_add_slave(struct device *master,
>  	struct device_node *remote;
>  
>  	remote = of_graph_get_remote_node(np, port, endpoint);
> -	if (remote) {
> -		drm_of_component_match_add(master, match, component_compare_of, remote);
> -		of_node_put(remote);
> -	}
> +	if (remote)
> +		component_match_add_of(master, match, remote);
>  }
>  
>  static int komeda_platform_probe(struct platform_device *pdev)
> diff --git a/drivers/gpu/drm/arm/hdlcd_drv.c b/drivers/gpu/drm/arm/hdlcd_drv.c
> index e3507dd6f82a..5f760bb66af4 100644
> --- a/drivers/gpu/drm/arm/hdlcd_drv.c
> +++ b/drivers/gpu/drm/arm/hdlcd_drv.c
> @@ -347,11 +347,6 @@ static const struct component_master_ops hdlcd_master_ops = {
>  	.unbind		= hdlcd_drm_unbind,
>  };
>  
> -static int compare_dev(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
>  static int hdlcd_probe(struct platform_device *pdev)
>  {
>  	struct device_node *port;
> @@ -362,9 +357,7 @@ static int hdlcd_probe(struct platform_device *pdev)
>  	if (!port)
>  		return -ENODEV;
>  
> -	drm_of_component_match_add(&pdev->dev, &match, compare_dev, port);
> -	of_node_put(port);
> -
> +	component_match_add_of(&pdev->dev, &match, port);
>  	return component_master_add_with_match(&pdev->dev, &hdlcd_master_ops,
>  					       match);
>  }
> diff --git a/drivers/gpu/drm/arm/malidp_drv.c b/drivers/gpu/drm/arm/malidp_drv.c
> index 589c1c66a6dc..3a49c29ba5b8 100644
> --- a/drivers/gpu/drm/arm/malidp_drv.c
> +++ b/drivers/gpu/drm/arm/malidp_drv.c
> @@ -909,13 +909,6 @@ static const struct component_master_ops malidp_master_ops = {
>  	.unbind = malidp_unbind,
>  };
>  
> -static int malidp_compare_dev(struct device *dev, void *data)
> -{
> -	struct device_node *np = data;
> -
> -	return dev->of_node == np;
> -}
> -
>  static int malidp_platform_probe(struct platform_device *pdev)
>  {
>  	struct device_node *port;
> @@ -929,9 +922,7 @@ static int malidp_platform_probe(struct platform_device *pdev)
>  	if (!port)
>  		return -ENODEV;
>  
> -	drm_of_component_match_add(&pdev->dev, &match, malidp_compare_dev,
> -				   port);
> -	of_node_put(port);
> +	component_match_add_of(&pdev->dev, &match, port);
>  	return component_master_add_with_match(&pdev->dev, &malidp_master_ops,
>  					       match);
>  }

For komeda, mali_dp and hdlcd: Acked-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu


> diff --git a/drivers/gpu/drm/armada/armada_drv.c b/drivers/gpu/drm/armada/armada_drv.c
> index 0643887800b4..c0211ad7a45d 100644
> --- a/drivers/gpu/drm/armada/armada_drv.c
> +++ b/drivers/gpu/drm/armada/armada_drv.c
> @@ -184,10 +184,12 @@ static void armada_add_endpoints(struct device *dev,
>  
>  	for_each_endpoint_of_node(dev_node, ep) {
>  		remote = of_graph_get_remote_port_parent(ep);
> -		if (remote && of_device_is_available(remote))
> -			drm_of_component_match_add(dev, match, component_compare_of,
> -						   remote);
> -		of_node_put(remote);
> +		if (remote) {
> +			if (of_device_is_available(remote))
> +				component_match_add_of(dev, match, remote);
> +			else
> +				of_node_put(remote);
> +		}
>  	}
>  }
>  
> diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> index 7bbcb999bb75..0a474729ddf6 100644
> --- a/drivers/gpu/drm/drm_of.c
> +++ b/drivers/gpu/drm/drm_of.c
> @@ -78,24 +78,6 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  }
>  EXPORT_SYMBOL(drm_of_find_possible_crtcs);
>  
> -/**
> - * drm_of_component_match_add - Add a component helper OF node match rule
> - * @master: master device
> - * @matchptr: component match pointer
> - * @compare: compare function used for matching component
> - * @node: of_node
> - */
> -void drm_of_component_match_add(struct device *master,
> -				struct component_match **matchptr,
> -				int (*compare)(struct device *, void *),
> -				struct device_node *node)
> -{
> -	of_node_get(node);
> -	component_match_add_release(master, matchptr, component_release_of,
> -				    compare, node);
> -}
> -EXPORT_SYMBOL_GPL(drm_of_component_match_add);
> -
>  /**
>   * drm_of_component_probe - Generic probe function for a component based master
>   * @dev: master device containing the OF node
> @@ -130,10 +112,9 @@ int drm_of_component_probe(struct device *dev,
>  			break;
>  
>  		if (of_device_is_available(port->parent))
> -			drm_of_component_match_add(dev, &match, compare_of,
> -						   port);
> -
> -		of_node_put(port);
> +			component_match_add_of(dev, &match, port);
> +		else
> +			of_node_put(port);
>  	}
>  
>  	if (i == 0) {
> @@ -171,9 +152,7 @@ int drm_of_component_probe(struct device *dev,
>  				continue;
>  			}
>  
> -			drm_of_component_match_add(dev, &match, compare_of,
> -						   remote);
> -			of_node_put(remote);
> +			component_match_add_of(dev, &match, remote);
>  		}
>  		of_node_put(port);
>  	}
> diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> index 1d2b4fb4bcf8..4a0dba34a6e7 100644
> --- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> +++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
> @@ -590,8 +590,8 @@ static int etnaviv_pdev_probe(struct platform_device *pdev)
>  			if (!first_node)
>  				first_node = core_node;
>  
> -			drm_of_component_match_add(&pdev->dev, &match,
> -						   component_compare_of, core_node);
> +			of_node_get(core_node);
> +			component_match_add_of(&pdev->dev, &match, core_node);
>  		}
>  	} else {
>  		char **names = dev->platform_data;
> diff --git a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> index 9c5d49bf40c9..3ee277615c39 100644
> --- a/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> +++ b/drivers/gpu/drm/hisilicon/kirin/kirin_drm_drv.c
> @@ -273,8 +273,7 @@ static int kirin_drm_platform_probe(struct platform_device *pdev)
>  	if (!remote)
>  		return -ENODEV;
>  
> -	drm_of_component_match_add(dev, &match, component_compare_of, remote);
> -	of_node_put(remote);
> +	component_match_add_of(dev, &match, remote);
>  
>  	return component_master_add_with_match(dev, &kirin_drm_ops, match);
>  }
> diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> index 3d5af44bf92d..d0c87175dec4 100644
> --- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> +++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
> @@ -1444,8 +1444,7 @@ static int ingenic_drm_probe(struct platform_device *pdev)
>  	if (!np)
>  		return ingenic_drm_bind(dev, false);
>  
> -	drm_of_component_match_add(dev, &match, component_compare_of, np);
> -	of_node_put(np);
> +	component_match_add_of(dev, &match, np);
>  
>  	return component_master_add_with_match(dev, &ingenic_master_ops, match);
>  }
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index cd5b18ef7951..abead814bfdc 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -787,8 +787,8 @@ static int mtk_drm_probe(struct platform_device *pdev)
>  		    comp_type == MTK_DSI) {
>  			dev_info(dev, "Adding component match for %pOF\n",
>  				 node);
> -			drm_of_component_match_add(dev, &match, component_compare_of,
> -						   node);
> +			of_node_get(node);
> +			component_match_add_of(dev, &match, node);
>  		}
>  
>  		ret = mtk_ddp_comp_init(node, &private->ddp_comp[comp_id], comp_id);
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index 8b0b0ac74a6f..8ccf57def955 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -5,6 +5,7 @@
>   * Author: Rob Clark <robdclark@gmail.com>
>   */
>  
> +#include <linux/component.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/fault-inject.h>
>  #include <linux/kthread.h>
> @@ -1156,10 +1157,9 @@ static int add_components_mdp(struct device *master_dev,
>  			continue;
>  
>  		if (of_device_is_available(intf))
> -			drm_of_component_match_add(master_dev, matchptr,
> -						   component_compare_of, intf);
> -
> -		of_node_put(intf);
> +			component_match_add_of(master_dev, matchptr, intf);
> +		else
> +			of_node_put(intf);
>  	}
>  
>  	return 0;
> @@ -1188,9 +1188,9 @@ static int add_gpu_components(struct device *dev,
>  		return 0;
>  
>  	if (of_device_is_available(np))
> -		drm_of_component_match_add(dev, matchptr, component_compare_of, np);
> -
> -	of_node_put(np);
> +		component_match_add_of(dev, matchptr, np);
> +	else
> +		of_node_put(np);
>  
>  	return 0;
>  }
> diff --git a/drivers/gpu/drm/sti/sti_drv.c b/drivers/gpu/drm/sti/sti_drv.c
> index ef6a4e63198f..e3aae4574c75 100644
> --- a/drivers/gpu/drm/sti/sti_drv.c
> +++ b/drivers/gpu/drm/sti/sti_drv.c
> @@ -238,8 +238,7 @@ static int sti_platform_probe(struct platform_device *pdev)
>  	child_np = of_get_next_available_child(node, NULL);
>  
>  	while (child_np) {
> -		drm_of_component_match_add(dev, &match, component_compare_of,
> -					   child_np);
> +		component_match_add_of(dev, &match, child_np);
>  		child_np = of_get_next_available_child(node, child_np);
>  	}
>  
> diff --git a/drivers/gpu/drm/sun4i/sun4i_drv.c b/drivers/gpu/drm/sun4i/sun4i_drv.c
> index cc94efbbf2d4..9b3ddd82f1be 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_drv.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_drv.c
> @@ -323,7 +323,8 @@ static int sun4i_drv_add_endpoints(struct device *dev,
>  	     of_device_is_available(node))) {
>  		/* Add current component */
>  		DRM_DEBUG_DRIVER("Adding component %pOF\n", node);
> -		drm_of_component_match_add(dev, match, component_compare_of, node);
> +		of_node_get(node);
> +		component_match_add_of(dev, match, node);
>  		count++;
>  	}
>  
> diff --git a/drivers/gpu/drm/tilcdc/tilcdc_external.c b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> index 3b86d002ef62..0138ce02a64f 100644
> --- a/drivers/gpu/drm/tilcdc/tilcdc_external.c
> +++ b/drivers/gpu/drm/tilcdc/tilcdc_external.c
> @@ -155,11 +155,6 @@ int tilcdc_attach_external_device(struct drm_device *ddev)
>  	return ret;
>  }
>  
> -static int dev_match_of(struct device *dev, void *data)
> -{
> -	return dev->of_node == data;
> -}
> -
>  int tilcdc_get_external_components(struct device *dev,
>  				   struct component_match **match)
>  {
> @@ -173,7 +168,8 @@ int tilcdc_get_external_components(struct device *dev,
>  	}
>  
>  	if (match)
> -		drm_of_component_match_add(dev, match, dev_match_of, node);
> -	of_node_put(node);
> +		component_match_add_of(dev, match, node);
> +	else
> +		of_node_put(node);
>  	return 1;
>  }
> diff --git a/include/drm/drm_of.h b/include/drm/drm_of.h
> index 10ab58c40746..685c44dc1dae 100644
> --- a/include/drm/drm_of.h
> +++ b/include/drm/drm_of.h
> @@ -33,10 +33,6 @@ uint32_t drm_of_crtc_port_mask(struct drm_device *dev,
>  			    struct device_node *port);
>  uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  				    struct device_node *port);
> -void drm_of_component_match_add(struct device *master,
> -				struct component_match **matchptr,
> -				int (*compare)(struct device *, void *),
> -				struct device_node *node);
>  int drm_of_component_probe(struct device *dev,
>  			   int (*compare_of)(struct device *, void *),
>  			   const struct component_master_ops *m_ops);
> @@ -69,14 +65,6 @@ static inline uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
>  	return 0;
>  }
>  
> -static inline void
> -drm_of_component_match_add(struct device *master,
> -			   struct component_match **matchptr,
> -			   int (*compare)(struct device *, void *),
> -			   struct device_node *node)
> -{
> -}
> -
>  static inline int
>  drm_of_component_probe(struct device *dev,
>  		       int (*compare_of)(struct device *, void *),
> -- 
> 2.35.1.1320.gc452695387.dirty
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
