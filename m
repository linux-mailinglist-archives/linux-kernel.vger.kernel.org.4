Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C84C064E74F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 07:36:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbiLPGgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 01:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbiLPGgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 01:36:07 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0823213CDC
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 22:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671172562; x=1702708562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vTyDp3WRHQkfKwZUmHm2YaSTJQCuH5GyeO9PrVqb4Ng=;
  b=InZU57EGYOXfW8U8Zwy1eWYhGK4XLdYmZL2/gdWfv9ZInmRyVE9qoOzT
   sp5jHzxHiZPRLA6e/yD1I4J8QUnXdRK5s4aRFZbdrnDybifCoI8ARAlmj
   D3KGlpodGiIFVYiaK0SBpYMGCaE8bwDPKVNWnK1Glb5ocl6wQWjpddLRn
   b8mOfyTgiIHKMCLRQ4N2XXYPWPu5KNrS/eHmS2E8xAcm/2Fp+ZKzVFhSQ
   B2u5K17OE/DyrBcFaPxil9wwI1FDGPxVYRI7cAnbMeRLKGjV2rP3QUpHd
   HSm6+LIlK+VRiR8fTaljYARQvTw/676KJih2YBwOo4jTyNYXsICuVnvoO
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="345981625"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="345981625"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 22:36:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="627467591"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="627467591"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 15 Dec 2022 22:35:56 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1FD40F7; Fri, 16 Dec 2022 08:36:26 +0200 (EET)
Date:   Fri, 16 Dec 2022 08:36:26 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tokunori Ikegami <ikegami.t@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: cfi: allow building spi-intel standalone
Message-ID: <Y5wR6qiYGIYDRE6j@black.fi.intel.com>
References: <20221215163950.649791-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215163950.649791-1-arnd@kernel.org>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 05:39:38PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> fails to build, as it includes the shared CFI header:
> 
> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>    62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
> 
> Use an #ifdef here to guard the settings so the header can be included
> in all configurations.
> 
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
