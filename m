Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8B76BACEA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbjCOKDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjCOKCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:02:41 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D79C148
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 03:01:12 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id E359C240014;
        Wed, 15 Mar 2023 10:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1678874467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vLhjQspryoroEWEi1tNWoO82ZACMmM/H06JvBb8eGGU=;
        b=B7RKxGEknNtvoDuiZFxSOKe4P4MhxKdZ564LeNO4B2XntlrscHnrMHJjuDHPWCHbbq1UTh
        RWlo8kOmJ+wqMDvo2FAJO6ufFyNza1JGeWcXjBAPHok7BpSJezZ2ueHRtiTMdIF1TE1JO6
        Y7AINHvI2Zz/X7O0ULTSMOnqabDpv8Zhr8675fqPAU3JksAGGH3/qvDC9QxQ3O3vD7rTjG
        9TGA2lm4aCrlHv0sYSK7j+jSW9Q7rgAtDSaph7nOs80Ao6Pdeej/nJPoqszDCMY+fzJRGn
        Lm7D5n+AjdZ3IMp3Gy3H1p5QtJv8aPyLEZXdtAodP3HMI22Ims0CdTkV/ZFy9g==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>
Cc:     Michael Walle <michael@walle.cc>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 0/4] nvmem: layouts: Create a macro to register drivers 
Date:   Wed, 15 Mar 2023 11:00:14 +0100
Message-Id: <20230315100018.1660071-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Miquel Raynal (4):
  nvmem: Add macro to register nvmem layout drivers
  nvmem: layouts: sl28vpd: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Use module_nvmem_layout_driver()
  nvmem: layouts: onie-tlv: Drop wrong module alias

 drivers/nvmem/layouts/onie-tlv.c | 15 +--------------
 drivers/nvmem/layouts/sl28vpd.c  | 14 +-------------
 include/linux/nvmem-provider.h   |  5 +++++
 3 files changed, 7 insertions(+), 27 deletions(-)

-- 
2.34.1

