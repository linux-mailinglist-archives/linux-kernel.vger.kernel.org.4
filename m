Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BD565E983
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 12:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjAELFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 06:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjAELFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 06:05:06 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACAC50E7E;
        Thu,  5 Jan 2023 03:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672916704; x=1704452704;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ed+5TF4v3rGppdgT7usbWpyQEGylXfunnAdot9pn3no=;
  b=nu+KZR00/nhn9BKBEe6f70UPCaCIcj+X6JEarY6LFrmQVTDDYikvmUVq
   TekLuLVof+SXONc+rky2KDPF/JSpZeRhaHO2wjaXidmd7MHggu0pbRkon
   djA+kkH49CM0wGhS9j9sSpC+nrqgKCbmkdHJr+iKvp3nGsAxa31ai4vR5
   cjL0HMRN3gO3XWsFE9RRokXeQTjRLajEHm4JR1gYyPDxZBmt/k33wKK1n
   ofF3JMeMv1nNkLhyZaGs9I+CE7XgOOuY4ZGSdAvRU2PQLBjza6RW8m9VT
   u/tFer7HkjfQj6/RQMfZuHQ9Xu8RaI4LbjfHGSyEBieAMXW24emYsW3cM
   A==;
X-IronPort-AV: E=Sophos;i="5.96,302,1665439200"; 
   d="scan'208";a="28258308"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 05 Jan 2023 12:04:59 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Thu, 05 Jan 2023 12:05:02 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Thu, 05 Jan 2023 12:05:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1672916702; x=1704452702;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ed+5TF4v3rGppdgT7usbWpyQEGylXfunnAdot9pn3no=;
  b=i6Ib2erDmJ5SXk0os67kYkyiUB2PkgoIxuOHSLWzFHcIM2P2MBQa4ceK
   VgCxI6qRBiQmp+4nvE9i1hNhU2wnZexQymsrf1iipKV3HPWiJjfMd4Ds1
   5+tNt/VXyqxHIj/ljlcBrAkK14JCxWc/1PaYuf4g2bTipVRINsM/CN6lu
   n1Hl29iPexdkLjjchFdOOUOZRIe8gx8D35SNI3L+FuCSESoFCWlCu8ge4
   SYgbpw4KEyCQQ4Et3IZKrnACOkQx9AUyPXPGtF0I/4shh/kX7DLg4jN4o
   m+2tgXFovNv7MUj9XRKin8ujii2f+0zDtCagsZJJa61SSMy72m8O1aiz8
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,302,1665439200"; 
   d="scan'208";a="28258288"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 05 Jan 2023 12:04:55 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 353E5280056;
        Thu,  5 Jan 2023 12:04:55 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Jonathan Corbet <corbet@lwn.net>, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v5 00/21] nvmem: core: introduce NVMEM layouts
Date:   Thu, 05 Jan 2023 12:04:52 +0100
Message-ID: <2143916.GUh0CODmnK@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
References: <20221206200740.3567551-1-michael@walle.cc> <20230103163902.218cb5c7@xps-13> <cf00e248-1f2c-d4ce-868d-9f77b2c9b76f@linaro.org>
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

Am Dienstag, 3. Januar 2023, 16:51:31 CET schrieb Srinivas Kandagatla:
> Hi Miquel,
> 
> On 03/01/2023 15:39, Miquel Raynal wrote:
> > Hi Srinivas,
> > 
> > michael@walle.cc wrote on Tue,  6 Dec 2022 21:07:19 +0100:
> >> This is now the third attempt to fetch the MAC addresses from the VPD
> >> for the Kontron sl28 boards. Previous discussions can be found here:
> >> https://lore.kernel.org/lkml/20211228142549.1275412-1-michael@walle.cc/
> >> 
> >> 
> >> NVMEM cells are typically added by board code or by the devicetree. But
> >> as the cells get more complex, there is (valid) push back from the
> >> devicetree maintainers to not put that handling in the devicetree.
> >> 
> >> Therefore, introduce NVMEM layouts. They operate on the NVMEM device and
> >> can add cells during runtime. That way it is possible to add more complex
> >> cells than it is possible right now with the offset/length/bits
> >> description in the device tree. For example, you can have post processing
> >> for individual cells (think of endian swapping, or ethernet offset
> >> handling).
> >> 
> >> The imx-ocotp driver is the only user of the global post processing hook,
> >> convert it to nvmem layouts and drop the global post pocessing hook.
> >> 
> >> For now, the layouts are selected by the device tree. But the idea is
> >> that also board files or other drivers could set a layout. Although no
> >> code for that exists yet.
> >> 
> >> Thanks to Miquel, the device tree bindings are already approved and
> >> merged.
> >> 
> >> NVMEM layouts as modules?
> >> While possible in principle, it doesn't make any sense because the NVMEM
> >> core can't be compiled as a module. The layouts needs to be available at
> >> probe time. (That is also the reason why they get registered with
> >> subsys_initcall().) So if the NVMEM core would be a module, the layouts
> >> could be modules, too.
> > 
> > I believe this series still applies even though -rc1 (and -rc2) are out
> > now, may we know if you consider merging it anytime soon or if there
> > are still discrepancies in the implementation you would like to
> > discuss? Otherwise I would really like to see this laying in -next a
> > few weeks before being sent out to Linus, just in case.
> 
> Thanks for the work!
> 
> Lets get some testing in -next.

This causes the following errors on existing boards (imx8mq-tqma8mq-
mba8mx.dtb):
root@tqma8-common:~# uname -r
6.2.0-rc2-next-20230105

> OF: /soc@0: could not get #nvmem-cell-cells for /soc@0/bus@30000000/
efuse@30350000/soc-uid@4
> OF: /soc@0/bus@30800000/ethernet@30be0000: could not get #nvmem-cell-cells 
for /soc@0/bus@30000000/efuse@30350000/mac-address@90

These are caused because '#nvmem-cell-cells = <0>;' is not explicitly set in 
DT.

> TI DP83867 30be0000.ethernet-1:0e: error -EINVAL: failed to get nvmem cell 
io_impedance_ctrl
> TI DP83867: probe of 30be0000.ethernet-1:0e failed with error -22

These are caused because of_nvmem_cell_get() now returns -EINVAL instead of -
ENODEV if the requested nvmem cell is not available.

Best regards,
Alexander



