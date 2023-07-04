Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51901746EDF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 12:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjGDKjK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 06:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGDKjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 06:39:09 -0400
X-Greylist: delayed 79 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 03:39:07 PDT
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5981187
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 03:39:07 -0700 (PDT)
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <LW@KARO-electronics.de>)
        id 1qGdPk-00012Z-CS; Tue, 04 Jul 2023 12:37:44 +0200
Date:   Tue, 4 Jul 2023 12:37:43 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Felix Matouschek <felix@matouschek.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC] Bad ecc layout in drivers/mtd/nand/spi/xtx.c
Message-ID: <20230704123743.7f4c87af@ipc1.ka-ro>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kb21haW5mYWN0b3J5LWt1bmRlLmRl
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while trying to add support for the 'XT26G01C' variant of the XTX
SPI-nand chip I noticed a flaw in the ECC layout of the existing
driver.
According to the  XT26G01A datasheet the first eight bytes of the OOB
area are not protected by ECC:
Offset      ECC  Bytes  Area               Description
800H 807H    No      8  Spare 4, Group E   This Area is not covered by internal ECC,
                                           800H is reserved for bad block mark        
808H 82FH   Yes 40 Spare 5 , Group F       User Meta Data Area covered by internal ECC.
830H 83FH    No 16 Spare 6 , Group G       ECC_EN=1: this area contains Internal ECC Data, Read-Only,
                                           Programming to this area will be ignored
                                           ECC_EN=0: this area is writable for user

But the driver defines bytes 1..47 as user OOB area:
|static int xt26g0xa_ooblayout_free(struct mtd_info *mtd, int section,
|				   struct mtd_oob_region *region)
|{
|	if (section)
|		return -ERANGE;
|
|	region->offset = 1;
|	region->length = 47;
|
|	return 0;
|}

IMO this should be:
|	region->offset = 8;
|	region->length = 40;
to have the whole user oob area protected by ECC.

Obviously this cannot simply be changed in the driver because it would
break access to flash that was programmed with the current parameters.
Since the data structures that provide the oob layout are completely
static and cannot be modified at runtime (e.g. depending on some DTB
property) the only way I see to provide a layout with ECC protection
for the whole user metadata would be a Kconfig option to select one or
the other layout at compile time.

Any comments or better ideas?



Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
