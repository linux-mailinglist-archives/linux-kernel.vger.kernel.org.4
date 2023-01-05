Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8888565EA9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 13:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjAEMVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 07:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbjAEMVo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 07:21:44 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1874615FCA;
        Thu,  5 Jan 2023 04:21:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672921302; x=1704457302;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhCHkc0mEVa9z8SFt3Ty3XUNkrJ0qgLzmtmqvAN8sTU=;
  b=CaLuYjmtFOZ8KFRzoNySrtRWJPccZ06bWuQAD3AGn1HfBo3X8wZ1cCMu
   O/CgL0jdC7tEem1FKNYiDSK9o1whRq+zIrS24CPg/+pMPVMk6exul4hO3
   cZnQ/nFZyCeriQVOHzD1puGfcAKRGWY9nbjIGgl++Z1M7Ay4zwnqF4reA
   nCoPeQSYUgvBHpkjIcELOIKAZejyx2kSBMWt66ybxAh38zh9gCDTDzQ6d
   1t1WIBacf6lJPLf5GEmMk/zZxrDoKrWFq0Qy1UbXK4DIugnbfEJWzVczP
   nQOJ8p3ZH69Ned3vGsfJNvruhRKUm27+h9UHbhuAIT6WNetZouWiptjD9
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,302,1665439200"; 
   d="scan'208";a="28259529"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Jan 2023 13:21:39 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 05 Jan 2023 13:21:40 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 05 Jan 2023 13:21:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672921300; x=1704457300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JhCHkc0mEVa9z8SFt3Ty3XUNkrJ0qgLzmtmqvAN8sTU=;
  b=hdYAxr+HRLnwe4xxTOqIWS8TdguZInssVHxeqiUY3FtsTMAJSo3dT7S+
   RanoKeL+pOIEGc1ViTcfajLzy9+Y4lPnNVk1mZeitekb9k4VYslhHzxm8
   ywhnCebYM6v4uxoCKj75wb8szm+8dAK9dcw1l/SdyvtNt4UYz8z7+PysL
   NqH9gPjj80JjFVS945EiGjFbJs2cA/4bzzaIFjFDUobolRn7JJ2pkUIY2
   FfrhYaxZlqbo2k1eru9WX3n3b4SMY6K4mA/lae0Bk33vS28TbCaxARBR7
   MOHB3nnqEBoZcNEFs6othQtzo7Xgc2/Bjv9k4Xt0yqdrYrfNXLCL1PRZF
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,302,1665439200"; 
   d="scan'208";a="28259528"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jan 2023 13:21:39 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id A856C280056;
        Thu,  5 Jan 2023 13:21:39 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Date:   Thu, 05 Jan 2023 13:21:37 +0100
Message-ID: <5906091.UjTJXf6HLC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <34cddc1aa4f8a55c752a9565d1726127@walle.cc>
References: <20221206200740.3567551-1-michael@walle.cc> <20230105123534.38a70640@xps-13> <34cddc1aa4f8a55c752a9565d1726127@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Donnerstag, 5. Januar 2023, 13:11:37 CET schrieb Michael Walle:
> Hi Alexander,
> 
> thanks for debugging. I'm not yet sure what is going wrong, so
> I have some more questions below.
> 
> >> This causes the following errors on existing boards (imx8mq-tqma8mq-
> >> mba8mx.dtb):
> >> root@tqma8-common:~# uname -r
> >> 6.2.0-rc2-next-20230105
> >> 
> >> > OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/
> >> 
> >> efuse@30350000/soc-uid@4
> >> 
> >> > OF: /soc@0/bus@30800000/ethernet@30be0000: could not get
> >> > #nvmem-cell-cells
> >> 
> >> for /soc@0/bus@30000000/efuse@30350000/mac-address@90
> >> 
> >> These are caused because '#nvmem-cell-cells = <0>;' is not explicitly
> >> set in
> >> DT.
> >> 
> >> > TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get nvmem
> >> > cell
> >> 
> >> io_impedance_ctrl
> >> 
> >> > TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22
> >> 
> >> These are caused because of_nvmem_cell_get() now returns -EINVAL
> >> instead of -
> >> ENODEV if the requested nvmem cell is not available.
> 
> What do you mean with not available? Not yet available because of probe
> order?

Ah, I was talking about there is no nvmem cell being used in my PHY node, e.g. 
no 'nvmem-cells' nor 'nvmem-cell-names' (set to 'io_impedance_ctrl'). That's 
why of_property_match_string returns -EINVAL.

> > Should we just assume #nvmem-cell-cells = <0> by default? I guess it's
> > a safe assumption.
> 
> Actually, that's what patch 2/21 is for.
> 
> Alexander, did you verify that the EINVAL is returned by
> of_parse_phandle_with_optional_args()?

Yep.

--8<--
diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 1b61c8bf0de4..f2a85a31d039 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1339,9 +1339,11 @@ struct nvmem_cell *of_nvmem_cell_get(struct device_node 
*np, const char *id)
        if (id)
                index = of_property_match_string(np, "nvmem-cell-names", id);
 
+       pr_info("%s: index: %d\n", __func__, index);
        ret = of_parse_phandle_with_optional_args(np, "nvmem-cells",
                                                  "#nvmem-cell-cells",
                                                  index, &cell_spec);
+       pr_info("%s: of_parse_phandle_with_optional_args: %d\n", __func__, 
ret);
        if (ret)
                return ERR_PTR(ret);
--8<--

Results in:
> [    1.861896] of_nvmem_cell_get: index: -22
> [    1.865934] of_nvmem_cell_get: of_parse_phandle_with_optional_args: -22
> [    1.872595] TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to 
get nvmem cell io_impedance_ctrl
> [    2.402575] TI DP83867: probe of 30be0000.ethernet-1:0e failed with error 
-22

So, the index is wrong in the first place, but this was no problem until now.

Best regards,
Alexander



