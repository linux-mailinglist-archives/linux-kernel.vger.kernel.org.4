Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915A6652251
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 15:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbiLTOTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 09:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiLTOS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 09:18:57 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBB5F59F
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 06:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671545920; x=1703081920;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RNoKwRr5C4L86GoAxSCU/infqiCSap2MrAl/iBgBGgQ=;
  b=W0xtRITmjTpTntT6Luilo+Pxgi5MmAmhD6OnH+TMVdcIb44a2+zBtDBr
   TRKeYOb9dTRBjn4/6WJbAYtEbmas+SHb3IhxHH1qjgoQHYYVq/hJd4LQY
   cQd2pe14hCrWnoSnORiFzoLKFMTeyV4aqj8m7hfneZY/5R3OsQpmo17Ii
   25+sAMOYcG2h6DfPEeHzj7whOJDnyL3Vo3C0kAw40R51gSp9qv+9YVIcr
   y219G1nrtEyVigKxFKXJuf4PjYADQmtrjSSWLo+h0+7NesZqTIb40H9YC
   P7sHTZlH2nN/Q+ev8rCrMOnVenW7Qp2hlTDXoE/r6RAYTzbY3Mh2lgBdz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="299964369"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="299964369"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2022 06:18:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10567"; a="825277253"
X-IronPort-AV: E=Sophos;i="5.96,259,1665471600"; 
   d="scan'208";a="825277253"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2022 06:18:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 70BAC11D; Tue, 20 Dec 2022 16:19:05 +0200 (EET)
Date:   Tue, 20 Dec 2022 16:19:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
        Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Mauro Lima <mauro.lima@eclypsium.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] mtd: cfi: allow building spi-intel standalone
Message-ID: <Y6HEWZ840GiS0STk@black.fi.intel.com>
References: <20221220141352.1486360-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221220141352.1486360-1-arnd@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:13:34PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When MTD or MTD_CFI_GEOMETRY is disabled, the spi-intel driver
> fails to build, as it includes the shared CFI header:
> 
> include/linux/mtd/cfi.h:62:2: error: #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work. [-Werror=cpp]
>    62 | #warning No CONFIG_MTD_CFI_Ix selected. No NOR chip support can work.
> 
> linux/mtd/spi-nor.h does not actually need to include cfi.h, so
> remove the inclusion here to fix the warning. This uncovers a
> missing #include in spi-nor/core.c so add that there to
> prevent a different build issue.
> 
> Fixes: e23e5a05d1fd ("mtd: spi-nor: intel-spi: Convert to SPI MEM")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
