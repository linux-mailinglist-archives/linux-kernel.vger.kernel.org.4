Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C0A96A6F44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjCAPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 10:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbjCAPWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 10:22:46 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B5C457E2;
        Wed,  1 Mar 2023 07:22:43 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 6D87C60006;
        Wed,  1 Mar 2023 15:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1677684161;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=cRigVwnQt8es5I3iXZpxk6EHiZctGQfV0rOwtbc8tUM=;
        b=inpFsoVedzeQb+Dlck6N8tnx9YU9/PguRcjm4w96w3cwgaMKoGXue83BFyZUiTZ0dUJQ5v
        lszcGYEJPJcnUfO6yG/fS2wdcHotAnHD7vKKiO5qpZcx1NTC4lgA7cBsEnUPCFBhKlcyr5
        A09WDEOpS1d4FmfnYaTrXfJdP7Rd2xSXkRiWNGwgy2Lm4D/cBEDiEIsqgMm3r/jmmJXIBT
        fDV5SRXYzrgI+5XRwCCaVuT9qX+0o1pJB8m18nOIYymuI13oe35ubLLE/xIN1QnCzKBnqP
        kcM3jQaJWwCv5lQ+VVykzIxVUbTBit8UrdhEx9sBOVR1DPrrbrX2OMjCJ1yU3Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        rafal@milecki.pl, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/8] nvmem: Let layout drivers be modules
Date:   Wed,  1 Mar 2023 16:22:31 +0100
Message-Id: <20230301152239.531194-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Following Greg's opposition to merge the current nvmem layout support
proposal [1], arguing that it would eventually grow the size of the
Linux kernel and asking for some "modularization" support, here is a
proposal to turn layout drivers into regular tristate drivers.

The first three patches are preparation changes in order to extend (and
fix) a little bit the of/device.c support. The fix does not seem to
impact most of the current users so I guess it can live with the rest of
the series in order to avoid future merge conflicts.

The nvmem core is then extended to support the absence of layouts and
possibly lead to probe deferrals when relevant.

Finally, the two existing layout drivers are converted into modules and
their Kconfig symbols changed to tristate.

The base series on which these changes apply is still contained in [1],
I would prefer to keep it as it was and apply this series on top of it.

Tests have been conducted on a Marvell Prestera switch with the mvpp2
Ethernet driver calling for a MAC address stored in the ONIE TLV table
available through a layout driver in an EEPROM/MTD device.

[1] https://github.com/miquelraynal/linux/tree/nvmem-next/layouts

Thanks,
Miquèl

Miquel Raynal (8):
  of: Fix modalias string generation
  of: Change of_device_get_modalias() main argument
  of: Create an of_device_request_module() receiving an OF node
  nvmem: core: Fix error path ordering
  nvmem: core: Handle the absence of expected layouts
  nvmem: core: Request layout modules loading
  nvmem: layouts: sl28vpd: Convert layout driver into a module
  nvmem: layouts: onie-tlv: Convert layout driver into a module

 drivers/nvmem/core.c             | 20 ++++++++++++--
 drivers/nvmem/layouts/Kconfig    |  4 +--
 drivers/nvmem/layouts/onie-tlv.c | 15 ++++++++++-
 drivers/nvmem/layouts/sl28vpd.c  | 14 +++++++++-
 drivers/of/device.c              | 45 ++++++++++++++++++++++----------
 include/linux/of_device.h        |  6 +++++
 6 files changed, 84 insertions(+), 20 deletions(-)

-- 
2.34.1

