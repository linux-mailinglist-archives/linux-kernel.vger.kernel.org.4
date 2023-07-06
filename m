Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECDA74A398
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 20:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjGFSIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 14:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjGFSIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 14:08:50 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 06 Jul 2023 11:08:04 PDT
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20BB1BE8
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 11:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
        t=1688666884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=4tKQ7n4PPQ0pHVlMYrxnbhxqeHpKpn3WB38GUnwxXx4=;
        b=SyGqpZj5flhOpIjmO0t+QQwNOWJ0ZOVmPfin080Xe3PcXItN0B+A31fLz+yBe8lczGAgMJ
        hEzOWNF3KO+4yQlzMfmM4sUrplpDyuiUO9KwtT/lZNr0Cg2zwjjSNthLRuMVXlwnQDoXgy
        xJSmaO3929RZX+V8+Qk9puq+ArsFYhA=
Received: from g1t6213.austin.hp.com (g1t6213.austin.hp.com [15.73.96.121])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-458-drDjnOWVNyKBnno0OWCBag-1; Thu, 06 Jul 2023 14:06:58 -0400
X-MC-Unique: drDjnOWVNyKBnno0OWCBag-1
Received: from g1t6215.austin.hpicorp.net (g1t6215.austin.hpicorp.net [15.67.1.191])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g1t6213.austin.hp.com (Postfix) with ESMTPS id 5CE3E8C;
        Thu,  6 Jul 2023 18:06:56 +0000 (UTC)
Received: from jam-buntu.lan (unknown [15.74.50.248])
        by g1t6215.austin.hpicorp.net (Postfix) with ESMTP id 4FF55C;
        Thu,  6 Jul 2023 18:06:55 +0000 (UTC)
From:   Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-kernel@vger.kernel.org, eniac-xw.zhang@hp.com,
        Alexandru Gagniuc <alexandru.gagniuc@hp.com>,
        stable@vger.kernel.org
Subject: [PATCH] nvme-pci: Add suspend quirk for HP mt645 thin client
Date:   Thu,  6 Jul 2023 18:06:53 +0000
Message-Id: <20230706180653.761247-1-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Elite mt645 thin client exhibits resume times of over one
minute when using the normal nvme resume path. BIOS has tried to work
around this by setting the "StorageD3Enable" ACPI property, but only
if it detected the "Linux-HPI-Hybrid-Graphics" _OSI() flag. This flag
does not exist, so the BIOS workaround can't work.

Instead, just set NVME_QUIRK_SIMPLE_SUSPEND when running on an mt645.
The DMI_PRODUCT_NAME cannot be used because this string can be changed
in the field. Match against DMI_BOARD_NAME, which should be immutable.

Cc: stable@vger.kernel.org
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/nvme/host/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..25b59f5ce874 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2897,6 +2897,15 @@ static unsigned long check_vendor_combination_bug(st=
ruct pci_dev *pdev)
 =09=09if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
 =09=09     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
 =09=09=09return NVME_QUIRK_SIMPLE_SUSPEND;
+=09} else if (dmi_match(DMI_SYS_VENDOR, "HP") &&
+=09=09   (dmi_match(DMI_BOARD_NAME, "8B0F") ||
+=09=09    dmi_match(DMI_BOARD_NAME, "8B59"))) {
+=09=09/*
+=09=09 * Force simple suspend to work around long resume latencies
+=09=09 * (1 minute or longer).
+=09=09 */
+=09=09dev_info(&pdev->dev, "simple suspend quirk for HP mt645\n");
+=09=09return NVME_QUIRK_SIMPLE_SUSPEND;
 =09}
=20
 =09return 0;
--=20
2.39.1

