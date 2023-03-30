Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B996D1234
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjC3Wf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjC3Wf4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:35:56 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 30 Mar 2023 15:35:55 PDT
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93E2CC36;
        Thu, 30 Mar 2023 15:35:54 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 2F0F39C067A;
        Thu, 30 Mar 2023 18:16:48 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id G_mheA3hoNBf; Thu, 30 Mar 2023 18:16:47 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.savoirfairelinux.com (Postfix) with ESMTP id 733949C119B;
        Thu, 30 Mar 2023 18:16:47 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 733949C119B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
        t=1680214607; bh=7qo2rLKAL25Z9760f+RGPuYG7UZYqwlNSMksNKRTGTA=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=SQAHrKHfuT4FlJlNfTjKbYeCIewoNNosgmWi3Lawo3N2rsgfpOo6CsY0O/L2ba22r
         6Hr37b15xggCKWIV8QPUIs/fQUrJIpirvOhznDLr4L8Z5ofhGjUCo0NZQURmAbZmyb
         LgkNxR28p/bhKolzH8Tzw3PJj5bZrV5d0y3OfQTvG7eb7iht7e2VGOT0+RbL6sKKCf
         pbnL3FCKmjA9sCpRWgJaSYfAcUemEXqYUeycbBTjumlstx5hwrAm9WFRl229JQ5FGS
         CMMxEDj/0P28Jt3E8BHlig6TNrQXkdxw52z10TBql7tYKAAMk0Be7VbYYApA73U4B+
         EMZDdmIy+QdeA==
X-Virus-Scanned: amavisd-new at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
        by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id amYl8MsB-nNT; Thu, 30 Mar 2023 18:16:47 -0400 (EDT)
Received: from j1-slave-ryzen-3900-indu.sfl.team (unknown [192.168.51.254])
        by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 5B9099C067A;
        Thu, 30 Mar 2023 18:16:47 -0400 (EDT)
From:   Thomas Ballasi <thomas.ballasi@savoirfairelinux.com>
To:     linux-usb@vger.kernel.org
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Ballasi <thomas.ballasi@savoirfairelinux.com>
Subject: [PATCH] usb: chipidea: imx: avoid unnecessary probe defer
Date:   Thu, 30 Mar 2023 18:16:37 -0400
Message-Id: <20230330221637.1605161-1-thomas.ballasi@savoirfairelinux.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The changes brought by commit 73de93440186 have been inadvertidly
removed, causing ci_hdrc_imx's probe to be loaded before usbmisc_imx's,
despite ci_hdrc_imx needing usbmisc_imx.

This condition may cause unexpected behaviors, especially when the
ChipIdea node is being referred to under /sys/class/udc/:

$ ls -l /sys/class/udc/
$

when it should show as the following:

$ ls -l /sys/class/udc/
ci_hdrc.0 -> ../../devices/[...]/ci_hdrc.0/udc/ci_hdrc.0

Some userspace tools may depend on this feature[1].

[1]: https://github.com/nxp-imx/imx-uuc/blob/69029e71b0642ded83a6c9bfa031=
02bb310c88ed/linuxrc#L148

Fixes: 95caa2ae70fd ("usb: chipidea: allow disabling glue drivers if EMBE=
DDED")
Signed-off-by: Thomas Ballasi <thomas.ballasi@savoirfairelinux.com>
---
 drivers/usb/chipidea/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/Makefile b/drivers/usb/chipidea/Makefil=
e
index 6f4a3deced359..71afeab97e837 100644
--- a/drivers/usb/chipidea/Makefile
+++ b/drivers/usb/chipidea/Makefile
@@ -14,5 +14,5 @@ ci_hdrc-$(CONFIG_USB_OTG_FSM)		+=3D otg_fsm.o
 obj-$(CONFIG_USB_CHIPIDEA_GENERIC)	+=3D ci_hdrc_usb2.o
 obj-$(CONFIG_USB_CHIPIDEA_MSM)		+=3D ci_hdrc_msm.o
 obj-$(CONFIG_USB_CHIPIDEA_PCI)		+=3D ci_hdrc_pci.o
-obj-$(CONFIG_USB_CHIPIDEA_IMX)		+=3D ci_hdrc_imx.o usbmisc_imx.o
+obj-$(CONFIG_USB_CHIPIDEA_IMX)		+=3D usbmisc_imx.o ci_hdrc_imx.o
 obj-$(CONFIG_USB_CHIPIDEA_TEGRA)	+=3D ci_hdrc_tegra.o
--=20
2.25.1

