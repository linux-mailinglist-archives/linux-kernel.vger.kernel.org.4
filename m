Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3925A5BC5D9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 11:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiISJzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 05:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiISJyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 05:54:33 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6BBE75;
        Mon, 19 Sep 2022 02:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663581271; x=1695117271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qcDYJZy3H3hnfIvMe6h2p+4MkNgp8SIkv0rt1iYoNJU=;
  b=HTEZd/njXh36N8MilPqBFaFX2H6iaYXPAgyxTgQSW/4XYh8XaRwdWgTH
   G3QOhVsulJ6Zrz1Z1FlfiQNpsdaOSYPqplBmc5C2YOJpFYnOppk7eWDgI
   ZKSSZE3QYrZyf7DqVDwVIFUVQC8q5uRQc18C+Nraz2bQvHiDoUrVLUwk6
   S2eQ0f+MnBYV3qaQBmzgVsHr0AAaD0a+lf9krwiZBR5/mdeOub3Pp85xO
   L09FMgPvw0s6gjahkeX/5TBZgjd53jVhHPTytuHIOWa0q1Gb1ph/KRmec
   vVT7Bo5KbW7M9hbQc1O/K3UYrmdu9nNxkFhu4qRCUd0+012JzfJVs04CF
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="296948965"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="296948965"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 02:54:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="680784526"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 19 Sep 2022 02:54:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oaDTt-004VMn-0W;
        Mon, 19 Sep 2022 12:54:25 +0300
Date:   Mon, 19 Sep 2022 12:54:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, rafael@kernel.org, mario.limonciello@amd.com,
        hdegoede@redhat.com, linus.walleij@linaro.org, timvp@google.com,
        dmitry.torokhov@gmail.com, Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <Yyg8UGRItbO4Abvb@smile.fi.intel.com>
References: <20220914235801.1731478-1-rrangel@chromium.org>
 <20220914155914.v3.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914155914.v3.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 05:57:54PM -0600, Raul E Rangel wrote:
> ACPI IRQ/Interrupt resources contain a bit that describes if the
> interrupt should wake the system. This change exposes that bit via
> a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> before arming an IRQ to wake the system.

From code perspective it's straightforward, so
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
(take a look into nit-picks, though)

From the functional perspective AFAIU it's appreciated, but I'm not
a guru in this domain to tell.

> Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> ---
> 
> Changes in v3:
> - Fixed bad indent
> 
> Changes in v2:
> - Added ability to extract wake bit from Interrupt/IRQ resources
> 
>  drivers/acpi/irq.c             | 11 ++++++++---
>  drivers/acpi/resource.c        | 24 +++++++++++++++++-------
>  drivers/pnp/pnpacpi/rsparser.c |  9 ++++++---
>  include/linux/acpi.h           |  3 ++-
>  include/linux/ioport.h         |  3 ++-
>  5 files changed, 35 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index dabe45eba055d1..5483cf9a28e3a0 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -147,6 +147,7 @@ struct acpi_irq_parse_one_ctx {
>   * @polarity: polarity attributes of hwirq
>   * @polarity: polarity attributes of hwirq
>   * @shareable: shareable attributes of hwirq
> + * @wake_capable: wake capable attribute of hwirq
>   * @ctx: acpi_irq_parse_one_ctx updated by this function
>   *
>   * Description:
> @@ -156,12 +157,14 @@ struct acpi_irq_parse_one_ctx {
>  static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
>  					    u32 hwirq, u8 triggering,
>  					    u8 polarity, u8 shareable,
> +					    u8 wake_capable,
>  					    struct acpi_irq_parse_one_ctx *ctx)
>  {
>  	if (!fwnode)
>  		return;
>  	ctx->rc = 0;
> -	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> +	*ctx->res_flags = acpi_dev_irq_flags(triggering, polarity, shareable,
> +					     wake_capable);

Can be on one line.

>  	ctx->fwspec->fwnode = fwnode;
>  	ctx->fwspec->param[0] = hwirq;
>  	ctx->fwspec->param[1] = acpi_dev_get_irq_type(triggering, polarity);
> @@ -204,7 +207,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
>  		fwnode = acpi_get_gsi_domain_id(irq->interrupts[ctx->index]);
>  		acpi_irq_parse_one_match(fwnode, irq->interrupts[ctx->index],
>  					 irq->triggering, irq->polarity,
> -					 irq->shareable, ctx);
> +					 irq->shareable, irq->wake_capable,
> +					 ctx);

Ditto.

>  		return AE_CTRL_TERMINATE;
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>  		eirq = &ares->data.extended_irq;
> @@ -218,7 +222,8 @@ static acpi_status acpi_irq_parse_one_cb(struct acpi_resource *ares,
>  						      eirq->interrupts[ctx->index]);
>  		acpi_irq_parse_one_match(fwnode, eirq->interrupts[ctx->index],
>  					 eirq->triggering, eirq->polarity,
> -					 eirq->shareable, ctx);
> +					 eirq->shareable, eirq->wake_capable,
> +					 ctx);

Ditto.

>  		return AE_CTRL_TERMINATE;
>  	}
>  
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 510cdec375c4d8..6a1c008a348902 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -336,8 +336,10 @@ EXPORT_SYMBOL_GPL(acpi_dev_resource_ext_address_space);
>   * @triggering: Triggering type as provided by ACPI.
>   * @polarity: Interrupt polarity as provided by ACPI.
>   * @shareable: Whether or not the interrupt is shareable.
> + * @wake_capable: Wake capability as provided by ACPI.
>   */
> -unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
> +unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
> +				 u8 wake_capable)

Ditto.

>  {
>  	unsigned long flags;
>  
> @@ -351,6 +353,9 @@ unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable)
>  	if (shareable == ACPI_SHARED)
>  		flags |= IORESOURCE_IRQ_SHAREABLE;
>  
> +	if (wake_capable == ACPI_WAKE_CAPABLE)
> +		flags |= IORESOURCE_IRQ_WAKECAPABLE;
> +
>  	return flags | IORESOURCE_IRQ;
>  }
>  EXPORT_SYMBOL_GPL(acpi_dev_irq_flags);
> @@ -442,7 +447,7 @@ static bool acpi_dev_irq_override(u32 gsi, u8 triggering, u8 polarity,
>  
>  static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>  				     u8 triggering, u8 polarity, u8 shareable,
> -				     bool check_override)
> +				     u8 wake_capable, bool check_override)
>  {
>  	int irq, p, t;
>  
> @@ -475,7 +480,8 @@ static void acpi_dev_get_irqresource(struct resource *res, u32 gsi,
>  		}
>  	}
>  
> -	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable);
> +	res->flags = acpi_dev_irq_flags(triggering, polarity, shareable,
> +					wake_capable);

Ditto.

>  	irq = acpi_register_gsi(NULL, gsi, triggering, polarity);
>  	if (irq >= 0) {
>  		res->start = irq;
> @@ -523,7 +529,8 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  		}
>  		acpi_dev_get_irqresource(res, irq->interrupts[index],
>  					 irq->triggering, irq->polarity,
> -					 irq->shareable, true);
> +					 irq->shareable, irq->wake_capable,
> +					 true);
>  		break;
>  	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
>  		ext_irq = &ares->data.extended_irq;
> @@ -532,9 +539,12 @@ bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  			return false;
>  		}
>  		if (is_gsi(ext_irq))
> -			acpi_dev_get_irqresource(res, ext_irq->interrupts[index],
> -					 ext_irq->triggering, ext_irq->polarity,
> -					 ext_irq->shareable, false);
> +			acpi_dev_get_irqresource(res,
> +						 ext_irq->interrupts[index],
> +						 ext_irq->triggering,
> +						 ext_irq->polarity,
> +						 ext_irq->shareable,
> +						 ext_irq->wake_capable, false);

Maybe false on the next line to split FW parameters from pure software ones?

>  		else
>  			irqresource_disabled(res, 0);
>  		break;
> diff --git a/drivers/pnp/pnpacpi/rsparser.c b/drivers/pnp/pnpacpi/rsparser.c
> index da78dc77aed32e..55b28fc0a94042 100644
> --- a/drivers/pnp/pnpacpi/rsparser.c
> +++ b/drivers/pnp/pnpacpi/rsparser.c
> @@ -206,7 +206,8 @@ static acpi_status pnpacpi_allocated_resource(struct acpi_resource *res,
>  		if (i >= 0) {
>  			flags = acpi_dev_irq_flags(gpio->triggering,
>  						   gpio->polarity,
> -						   gpio->shareable);
> +						   gpio->shareable,
> +						   gpio->wake_capable);
>  		} else {
>  			flags = IORESOURCE_DISABLED;
>  		}
> @@ -315,7 +316,8 @@ static __init void pnpacpi_parse_irq_option(struct pnp_dev *dev,
>  		if (p->interrupts[i])
>  			__set_bit(p->interrupts[i], map.bits);
>  
> -	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
> +	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
> +				   p->wake_capable);
>  	pnp_register_irq_resource(dev, option_flags, &map, flags);
>  }
>  
> @@ -339,7 +341,8 @@ static __init void pnpacpi_parse_ext_irq_option(struct pnp_dev *dev,
>  		}
>  	}
>  
> -	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable);
> +	flags = acpi_dev_irq_flags(p->triggering, p->polarity, p->shareable,
> +				   p->wake_capable);

One line?

>  	pnp_register_irq_resource(dev, option_flags, &map, flags);
>  }
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d3121cef6cc3bc..9f7947ee1b006f 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -495,7 +495,8 @@ bool acpi_dev_resource_address_space(struct acpi_resource *ares,
>  				     struct resource_win *win);
>  bool acpi_dev_resource_ext_address_space(struct acpi_resource *ares,
>  					 struct resource_win *win);
> -unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable);
> +unsigned long acpi_dev_irq_flags(u8 triggering, u8 polarity, u8 shareable,
> +				 u8 wake_capable);

One line?

>  unsigned int acpi_dev_get_irq_type(int triggering, int polarity);
>  bool acpi_dev_resource_interrupt(struct acpi_resource *ares, int index,
>  				 struct resource *res);
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 616b683563a970..3baeea4d903bfd 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -79,7 +79,8 @@ struct resource {
>  #define IORESOURCE_IRQ_HIGHLEVEL	(1<<2)
>  #define IORESOURCE_IRQ_LOWLEVEL		(1<<3)
>  #define IORESOURCE_IRQ_SHAREABLE	(1<<4)
> -#define IORESOURCE_IRQ_OPTIONAL 	(1<<5)
> +#define IORESOURCE_IRQ_OPTIONAL		(1<<5)
> +#define IORESOURCE_IRQ_WAKECAPABLE	(1<<6)
>  
>  /* PnP DMA specific bits (IORESOURCE_BITS) */
>  #define IORESOURCE_DMA_TYPE_MASK	(3<<0)
> -- 
> 2.37.3.968.ga6b4b080e4-goog
> 

-- 
With Best Regards,
Andy Shevchenko


