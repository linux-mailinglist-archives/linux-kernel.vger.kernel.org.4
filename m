Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21A569203E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 14:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbjBJNwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 08:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjBJNwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 08:52:12 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131D91C5BC;
        Fri, 10 Feb 2023 05:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676037131; x=1707573131;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=r4w/CErbxaJzMbH7832T/6D/ahn1FgUG57ZITj5IzaQ=;
  b=br2AjmrslSKiAD96sEqS3M0uZj6ZLLQx0EtxEBC55chAqIkg378H2UaM
   sM35r/W7GPs2NCsvPaxQCVxKLqPB2QvqAkySZuQI3GjRavp7eDOXpb5et
   A5kD+jytRCvM50eMK0paM4CnlqcydhBGosvbgmesGuY2i0/3gDiNxrB1e
   j8hjw31OT8mD1fio+seJvphpiSVUbtzRYFAj/tLkFErAqp0wOcK+3FiUt
   1k1heezVYtJGVSqhAE6ZbTN5DWjbdBoOpK+aAJtxem4VUfRPb1SPluAhJ
   /csUXEAQ56H6g0wT9g2raMfgdYL8m4IBdRaPGkLYIzL72IsMdkKe64wEF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="392826850"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="392826850"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:52:10 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10617"; a="736748179"
X-IronPort-AV: E=Sophos;i="5.97,287,1669104000"; 
   d="scan'208";a="736748179"
Received: from tnemeth-mobl1.ger.corp.intel.com ([10.251.213.60])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2023 05:52:06 -0800
Date:   Fri, 10 Feb 2023 15:52:03 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        joel@jms.id.au, andrew@aj.id.au, Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH 3/4] serial: 8250: Add Aspeed UART driver
In-Reply-To: <20230210072643.2772-4-chiawei_wang@aspeedtech.com>
Message-ID: <2d389fc9-0d5-42a1-b6d7-695c70dcf0fe@linux.intel.com>
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com> <20230210072643.2772-4-chiawei_wang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023, Chia-Wei Wang wrote:

> Add the driver for Aspeed UART/VUART devices, which are 16550A
> compatible. It is an wrapper to cover the generic 16550A operation
> while exetending DMA feature for the devices.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/tty/serial/8250/8250_aspeed.c | 502 ++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig       |   8 +
>  drivers/tty/serial/8250/Makefile      |   1 +

Hi,

Before I look any further into this, could you please explain why this is 
made to be entirely separate from what we have in 
  drivers/tty/serial/8250/8250_aspeed_vuart.c
?

I quickly went through some functions and they've significant parts in 
common with no variations at all in many functions and you're defines 
are 1:1 too (except for the DMA buf sizes). It would seem much better to 
add the missing functionality into 8250_aspeed_vuart.c rather than 
creating something from scratch with large overlap with existing code.

If you intend to keep it as a separate one, you should have a rather good 
justification for it.


-- 
 i.

