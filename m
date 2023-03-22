Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DF16C515D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 17:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjCVQ6K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 12:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjCVQ6J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 12:58:09 -0400
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78AF114EB2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 09:58:07 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 3FD3D20008;
        Wed, 22 Mar 2023 16:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679504286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=2mFPQR5z9/maQ8tjhD2kQ4haZ/Jx+nECWQFGftrfkyM=;
        b=FxmdX5Gzu7doM/iqCbCAYGxWUC3t/zjFQv8o35Yi38qfGijA6PkURhwmoX8qe1a838Tie2
        7AdMSAYqTdVfwklycvWmCJB5wbovPN6cgHzELQt13y70Rb8GfUL2Sl1ocsN8C0D0cSDWDv
        GMe3p01XSH8Kbu/xXMrf+gBd4fcxP2L+O4Dm24MC1m2FzULx6wCV/Qy0VajwhUyV9N956a
        a601xecc2il9oFNYFn9CspEOL1IgsHpTLGC3IA/dS8itrXos/a5uBs9bnNIFaD7XzFZC1K
        YMfBEgq0kzD8c5k9M+q6DSYssBsXzQ0INujzwGXj2boFUJyUAwMu5LoMkeswCQ==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH v2 0/4] nvmem: layouts: Create a macro to register drivers 
Date:   Wed, 22 Mar 2023 17:58:00 +0100
Message-Id: <20230322165804.2240285-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Srinivas,

Following your former review, here are a few changes creating and using
a macro to simplify nvmem layout driver registration.

While doing that I figured out the MODULE_ALIAS() macro in the Onie TLV
driver was useless and wrong, so there is a patch to drop it, but if you
wish you can also squash it with:
"nvmem: layouts: onie-tlv: Add new layout driver".

Thanks!
Miquèl

Changes in v2:
* First patch now includes driver.h as reported by Rafal.

Miquel Raynal (4):
  nvmem: Add macro to register nvmem layout drivers
  nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Drop wrong module alias

 drivers/nvmem/layouts/onie-tlv.c | 15 +--------------
 drivers/nvmem/layouts/sl28vpd.c  | 14 +-------------
 include/linux/nvmem-provider.h   |  6 ++++++
 3 files changed, 8 insertions(+), 27 deletions(-)

-- 
2.34.1

