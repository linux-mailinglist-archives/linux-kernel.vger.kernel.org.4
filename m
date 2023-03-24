Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4809E6C86D3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231908AbjCXU0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjCXU0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:26:40 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9801CAF9;
        Fri, 24 Mar 2023 13:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1679689593; i=w_armin@gmx.de;
        bh=6wlZo2xanf4kDtHfqBasjPU5Ds+RDX/QpSs/lo8nd3c=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nrbT56XNYRYqCKmOZoWucUxx1In/KAgdMWbDJ04ws6uDUW0EVP2goztWojjRgdhF9
         Wcia+U4gSSeIVD9n7RZQCagRn2FAobCvg/oFfIyLyAWVpgWpyrAMOjwJWqPrT3P0gF
         /sVIBfR4htC5dDYH6/0FPGKjVKmnTvX5aiQvvn5EWBafmvmSCwK2sam/bQ7qzZl7vL
         63avB/w+rdYX5fQNlmT2YI8/gUFU2+3K2QTjru6wMdF62oIACg0BcT6frEdBaao4vh
         xfIQOGdPLH8bncWh5tXIfd+P1NQmq4M+rVvQmh/7bqFtl0lxnXk+IpPbYHg6aJVRPn
         QzpJPN0QA9X9g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mof9P-1qHftp3zK5-00p5e2; Fri, 24 Mar 2023 21:26:33 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, lenb@kernel.org
Cc:     linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] ACPI: EC: Fix oops when removing custom query handlers
Date:   Fri, 24 Mar 2023 21:26:27 +0100
Message-Id: <20230324202628.76966-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230324202628.76966-1-W_Armin@gmx.de>
References: <20230324202628.76966-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dC54eEAF45WHEdv420PbB5TkLeb16RrxtmkJEM2R8RRRjtRikov
 L9JtDBs/XpqFDpq1AMx4lh3lYz8ixhBJ0D4v3p9ajXtX0sRCoIDf7n0NhScllsZtFi79I+R
 dxpZwg8E2WSqjaJtG38/8ZWFBRbOXBbWbPkIzfKehQXCuUHOx5BOh5Hq5Eb2n7bgb1th1O/
 VZxTqlSlOOSg6DOlS5xRQ==
UI-OutboundReport: notjunk:1;M01:P0:gL62lcIRjBI=;8SrmOv4vicIkxI0p42bkhqbBhpV
 F/Qvx3QU2X7RG+srW+CVgNgVZGUeH+VpGVAizzI2orhvvDjoBW5YLgKeNXxRCbgFAmF1jiXac
 NXN5SJ9Q1OMapTELciCcQGBey/4INNwRoDZjt5SquDIpTTdTjVkILG/4dbWOi2wVVX/45Zd+M
 hG52V20cLUjPQIpMWoJaJ3w7VAxb2RhvCt+PM363033aVztVxKBP97J1A59E2tdHdwarWV7By
 EdchowyP4CJLOxF5Ye4uEjySyvF1e3plwDeN2GQBNRUnmvro0PsWDC2X4Ozky9yOkzWKy0brn
 Tvhp/R9fgLr/3pia556r2qWdWD3n9rjAPFL/dkvLt2qHnc02KmYij7I5+cwB49xd0Ezong/V2
 8RnbOEK4xPMyvwX5caauIKvKisWM6z8YQKZd0qJ/gBOqjuQXqZCRpEfchw/xT1w3eHBvNIKb8
 pkub1rwuHyAo0/IWN0b2hVd6sFWW5XG69QMxut9ecE9+alRbJ2t4ncRQWIyFhlqzb6qbcWrnD
 h/Tk1uBzdvgV887bo7+c6Lk0anddLKM1d6y7EnuTZ1Z4CgAyZ7Vqa+Wnv4lA72WuqF8x1mXg5
 u7b0zrK8f6Ab62lrTN2X2og1QBlizUbbwB52QksIHWOpV4yaI0/FTkfwvxrjpqWMd92qvAyRb
 NY9wasPRjkVtDdpLn43syNwm1cg/tmZsTI/cZFOavdq9G8Qz8jfwR+GONwUZ8XG1aTpX9gdbF
 849dsvsTcxH9SlOViAqbTwZt6VMkC3kqoOYikIBQfGKibA8To3BMJZvlkld7AZTxLq+J+o++a
 fVk7A1vf/x6X8D7xB8JvfNIVmhcZRGoeJ0YRv/1J6AhVP+9TCJNFZeVA87dw2X4985f9/bWPA
 115SOzr4VLgJ64XzUGOZsWNmO32ryfgT/vgEhqXdJFbUyXVJKBXkQumsPZONoSTsJJkFE9Zaf
 3dZdiHH/xNX/n3UASd4EKgY0eKw=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When removing custom query handlers, the handler might still
be used inside the EC query workqueue, causing a kernel oops
if the module holding the callback function was already unloaded.

Fix this by flushing the EC query workqueue when removing
custom query handlers.

Tested on a Acer Travelmate 4002WLMi

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/ec.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
index f84905dbd8ca..4ae017391533 100644
=2D-- a/drivers/acpi/ec.c
+++ b/drivers/acpi/ec.c
@@ -1132,6 +1132,7 @@ static void acpi_ec_remove_query_handlers(struct acp=
i_ec *ec,
 void acpi_ec_remove_query_handler(struct acpi_ec *ec, u8 query_bit)
 {
 	acpi_ec_remove_query_handlers(ec, false, query_bit);
+	flush_workqueue(ec_query_wq);
 }
 EXPORT_SYMBOL_GPL(acpi_ec_remove_query_handler);

=2D-
2.30.2

