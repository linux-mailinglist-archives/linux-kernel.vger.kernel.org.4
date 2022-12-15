Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E9264DFE3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 18:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiLORmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 12:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLORml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 12:42:41 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235A911C0E;
        Thu, 15 Dec 2022 09:42:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671126161; x=1702662161;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7ORcbraRfGd7oELZedGg8ctUSrjqDFehZ6+LmmGW3YY=;
  b=ThvF2sXHXvSfBYAR7tDZL/hPh0MeYj0AKjgo37Ut79opIvyBkS9Sdm4p
   x+B1uCnX4H/Qxmnsqw+aHqrrLPgkSrBkAXreSy4PHRhYvfRkmcHPiZnt+
   Qi3plqYHUfhyAOWhGm71+sfdw8kRA431phpiux4drec8ziwi5T/LNYELi
   ht6xcxB9Lp2q2yvPrNkaAr4zuBXbDsPJ/qBZ8AfEbL8iuA58/UHZHiy3j
   KARICLYrHHwTjslsXeU7iATJAv36PRyooxT6FbPwKZ4XVLq1mxgejsj1S
   hwuvRjCuydnemmd6xZPYjJqCs1v7tOE8wDw3pc+MQTxtZatKRbFyTEJCv
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="319912012"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="319912012"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="681966231"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="681966231"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 15 Dec 2022 09:42:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1p5sFc-00ASLZ-1h;
        Thu, 15 Dec 2022 19:42:32 +0200
Date:   Thu, 15 Dec 2022 19:42:32 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk, cang1@live.co.uk,
        colin.i.king@gmail.com, phil.edworthy@renesas.com,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        lukas@wunner.de, u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        UNGLinuxDriver@microchip.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v9 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support
Message-ID: <Y5tciHzsEGU67h1Z@smile.fi.intel.com>
References: <20221216052656.2098100-1-kumaravel.thiagarajan@microchip.com>
 <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216052656.2098100-3-kumaravel.thiagarajan@microchip.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 16, 2022 at 10:56:54AM +0530, Kumaravel Thiagarajan wrote:
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

...

> +static const int logical_to_physical_port_idx[][MAX_PORTS] = {
> +	{0,  1,  2,  3},/* PCI12000, PCI11010, PCI11101, PCI11400, PCI11414 */
> +	{0,  1,  2,  3},/* PCI4p */
> +	{0,  1,  2, -1},/* PCI3p012 */
> +	{0,  1,  3, -1},/* PCI3p013 */
> +	{0,  2,  3, -1},/* PCI3p023 */
> +	{1,  2,  3, -1},/* PCI3p123 */
> +	{0,  1, -1, -1},/* PCI2p01 */
> +	{0,  2, -1, -1},/* PCI2p02 */
> +	{0,  3, -1, -1},/* PCI2p03 */
> +	{1,  2, -1, -1},/* PCI2p12 */
> +	{1,  3, -1, -1},/* PCI2p13 */
> +	{2,  3, -1, -1},/* PCI2p23 */
> +	{0, -1, -1, -1},/* PCI1p0 */
> +	{1, -1, -1, -1},/* PCI1p1 */
> +	{2, -1, -1, -1},/* PCI1p2 */
> +	{3, -1, -1, -1},/* PCI1p3 */

One space or TAB before /* will increase readability.

> +};

...

> +	ret = serial8250_pci_setup_port(pdev, port, 0, port_idx * 256, 0);

Actually isn't 0x100 better (show that there is an offset rather than
a value of an register)?

> +	if (ret < 0)
> +		return ret;

...

> +static unsigned int pci1xxxx_get_max_port(int subsys_dev)
> +{
> +	int i = 0;

What the point to assign this one?

Actually, better is

	unsigned int = MAX_PORTS;

> +	if (subsys_dev < ARRAY_SIZE(logical_to_physical_port_idx))

> +		for (i = MAX_PORTS - 1; i >= 0; i--)

while (i--) {

> +			if (logical_to_physical_port_idx[subsys_dev][i] != -1)
> +				return logical_to_physical_port_idx[subsys_dev][i] + 1;

}

(Note missinng {} in the above code. Does checkpatch complain on this?)

> +
> +	if (subsys_dev != PCI_SUBDEVICE_ID_EFAR_PCI11414)
> +		return 1;
> +
> +	return 4;
> +}

...

> +	num_vectors = pci_alloc_irq_vectors(pdev, 1, max_vec_reqd, PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0) {

> +		pci_iounmap(pdev, priv->membase);

Here is inconsistency on how you interpret pci_*() calls when
pcim_enable_device() has been used. I.e. for IRQ you don't
deallocate resources explicitly (yes, it's done automatically
anyway), but you explicitly call pci_iounmap(). Choose a single
approach for all of them.

> +		return num_vectors;
> +	}

...

> +static_assert((ARRAY_SIZE(logical_to_physical_port_idx) ==
> +	       PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3 + 1));

Can be still one line.

-- 
With Best Regards,
Andy Shevchenko


