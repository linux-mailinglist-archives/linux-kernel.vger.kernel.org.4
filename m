Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F465B7939
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 20:14:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbiIMSN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 14:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbiIMSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 14:13:37 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2129A954;
        Tue, 13 Sep 2022 10:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663089684; x=1694625684;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ZNR5WfgGNzNcp/Bdx5BLP+k/cNO7NVcoI5L/8sUO5E=;
  b=c7ohSKlN5KVvpqh0u2fJ4ERx1khFt78qw2yruWKVc+djd8wFNoJtsnAg
   GMlrlY1M7TMJ6HVXHXulXNjq8MXbkYjqrwthYpcaZks2iOL5QUbErWIEu
   GQos6+mUD8/8uQtlR8eB3GprZhHAO7Bqqv4KnEr9s/LGrbZJyzbodHEWp
   q/u9LVi9UNBfqrw9aGyGd1w4Ot67fsCp0jLAXcAHxUrp4Ymne5lqLjxC1
   i8OsOdDqbRFxbGzBzwWiGp0Wc2O85LwB1hf8zyXgSsobuSlFiYigvCfq2
   fz7yDiLedvCI4Hat3nCAJpwXT0QmYhSWHRNS1x6q9WolsQCISQdetyBc5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285221297"
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="285221297"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:21:23 -0700
X-IronPort-AV: E=Sophos;i="5.93,313,1654585200"; 
   d="scan'208";a="616537399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2022 10:21:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oY9b2-001r5L-0N;
        Tue, 13 Sep 2022 20:21:16 +0300
Date:   Tue, 13 Sep 2022 20:21:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raul E Rangel <rrangel@chromium.org>
Cc:     linux-acpi@vger.kernel.org, linux-input@vger.kernel.org,
        jingle.wu@emc.com.tw, mario.limonciello@amd.com, timvp@google.com,
        linus.walleij@linaro.org, hdegoede@redhat.com, rafael@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Len Brown <lenb@kernel.org>,
        Terry Bowman <terry.bowman@amd.com>,
        Wolfram Sang <wsa@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/13] ACPI: resources: Add wake_capable parameter to
 acpi_dev_irq_flags
Message-ID: <YyC8C+ZH57xHYLQd@smile.fi.intel.com>
References: <20220912221317.2775651-1-rrangel@chromium.org>
 <20220912160931.v2.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912160931.v2.6.I8092e417a8152475d13d8d638eb4c5d8ea12ac7b@changeid>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 04:13:10PM -0600, Raul E Rangel wrote:
> ACPI IRQ/Interrupt resources contain a bit that describes if the
> interrupt should wake the system. This change exposes that bit via
> a new IORESOURCE_IRQ_WAKECAPABLE flag. Drivers should check this flag
> before arming an IRQ to wake the system.

...

>  static inline void acpi_irq_parse_one_match(struct fwnode_handle *fwnode,
>  					    u32 hwirq, u8 triggering,
>  					    u8 polarity, u8 shareable,
> +					    u8 wake_capable,
>  					    struct acpi_irq_parse_one_ctx *ctx)

This function is used only in scope of a single C-file. Why instead not
converting it to use some internal structure and acpi_irq_parse_one_cb()
becomes like:

	struct internal_struct s;

        switch (ares->type) {
	case ACPI_RESOURCE_TYPE_IRQ:
		...fill internal_struct...
		break;
	case ACPI_RESOURCE_TYPE_EXTENDED_IRQ:
		...fill internal_struct...
		break;
	default:
		return AE_OK;

	acpi_irq_parse_one_match(&s);
	return AE_CTRL_TERMINATE;

?

...

> +			acpi_dev_get_irqresource(res,
> +						 ext_irq->interrupts[index],
> +						 ext_irq->triggering,
> +						 ext_irq->polarity,
> +						 ext_irq->shareable,
> +						 ext_irq->wake_capable, false);

Ditto.

Actually it can be shared structure for these too.

-- 
With Best Regards,
Andy Shevchenko


