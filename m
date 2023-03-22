Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71F36C4AB8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjCVMfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjCVMfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:35:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFA652F65;
        Wed, 22 Mar 2023 05:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679488516; x=1711024516;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=qyQVeQpe2PlY+8uzBPRJxKWq2h6zyr3jv2h2sfKP0uY=;
  b=DpVqoJoFWiyHixmi7ZiaBQP/ebRV1YN+RrPyKgIXOyOiBkeJY8gg8lpc
   XRP0Xg3dkSrD59S2Dy+CB6BZmqQrphtLzd4BBrB/jxzWx5bRIpH9oixvI
   j0ue+/UeU/yEavDgY++vb8ULeN3tWnmIhN9nhyOd81lp7Z9VxXMJvM+n1
   aC6g0Oiy81QYGu9RuGcO6vDL+soRrNSO/beMJNre4zbO3KDQ+UzM5/5gE
   4HddNWaYg/am38MObKiwv4RcV3g2HjZoR99gBqmtw93unFgA2CFokSGK2
   ShH0GbMOReJ3xb53+vRZZPiATOyFPi6yWXzjSbrYbmaZH0Y/pH5osUhzi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="366936146"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="366936146"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 05:35:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10656"; a="856088813"
X-IronPort-AV: E=Sophos;i="5.98,281,1673942400"; 
   d="scan'208";a="856088813"
Received: from dpapgher-mobl1.ger.corp.intel.com ([10.249.45.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 05:35:13 -0700
Date:   Wed, 22 Mar 2023 14:35:07 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Arnd Bergmann <arnd@kernel.org>
cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-bluetooth@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: NXP: select CONFIG_CRC8
In-Reply-To: <20230322111636.1028838-1-arnd@kernel.org>
Message-ID: <d651b66d-a33b-ead0-e41-aeb76f4523b6@linux.intel.com>
References: <20230322111636.1028838-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1867420506-1679488515=:1906"
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1867420506-1679488515=:1906
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Wed, 22 Mar 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The driver needs both CRC32 and CRC8 to link correctly:
> 
> ld.lld: error: undefined symbol: crc8_populate_msb
> >>> referenced by btnxpuart.c
> >>>               drivers/bluetooth/btnxpuart.o:(nxp_serdev_probe) in archive vmlinux.a
> ld.lld: error: undefined symbol: crc8
> >>> referenced by btnxpuart.c
> >>>               drivers/bluetooth/btnxpuart.o:(nxp_send_ack) in archive vmlinux.a
> 
> Fixes: 3e662aa4453a ("Bluetooth: NXP: Add protocol support for NXP Bluetooth chipsets")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/bluetooth/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
> index 0703bdd44140..f84322d375de 100644
> --- a/drivers/bluetooth/Kconfig
> +++ b/drivers/bluetooth/Kconfig
> @@ -469,6 +469,7 @@ config BT_NXPUART
>  	tristate "NXP protocol support"
>  	depends on SERIAL_DEV_BUS
>  	select CRC32
> +	select CRC8
>  	help
>  	  NXP is serial driver required for NXP Bluetooth
>  	  devices with UART interface.
> 

Right. ...I should have realized this was missing too when I noticed 
select CRC32 wasn't there.

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-1867420506-1679488515=:1906--
