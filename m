Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBAC363DEDC
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiK3Slc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiK3SlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:41:20 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6117A98947;
        Wed, 30 Nov 2022 10:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1669833667; bh=vgKVPXmvYqutJBkLIGS/n+sdxLzPLkmkKPGB9sgdkpE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=eLTGK2Crx7cXcz72ruhuZmROWdSjeQL/tU6MqQ2/ltbrLWebl/By1SoGSWw5dDrT6
         d/HsUWWiDNuYfY1c1Di0y+Rzjkjr0UYdGIpe976fqNeyPOCOQagUoxfom2U7JuL0CR
         RpYvI0Amu+1GwoFh+MzX6WsDeYZyOt8P0QF7bIi01UbUo3JAv9pnUONlMX1rAVibPs
         GgFfqBXlveNQXbKhnXJAPmNc0cj5InLXCaVAFv7jmfBMsFhXCbHJZLhjoZslTG/r2u
         BcHlDEPQV4H42DfqXMdGnEUMBLT3kmENSpxGXrEAq9sgNCxsDLx4z+q97vd17sjQwd
         NTfpRXDAZfHfg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N3siG-1orY150AVs-00zl5t; Wed, 30 Nov 2022 19:41:07 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     rafael@kernel.org, hdegoede@redhat.com
Cc:     lenb@kernel.org, markgross@kernel.org, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: battery: Call power_supply_changed() when adding hooks
Date:   Wed, 30 Nov 2022 19:41:01 +0100
Message-Id: <20221130184101.357899-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:v2Ti+bj8vLJsIA+n83Ulg5oP9sdjSkk1OPNXdaafMgk/8ZrVwh2
 S+E+4dEVKzZ2jX9/oZGnbbLkLWZJ/vlR7ICG1Z/m2rNXg2Pk1OobQVC5ehL9lQEMd5yXzYi
 zjLK3LinzUrvF7Paom8nUZFQoytz8Ha9EsJ6hlkmYBUeNSrPRKex4sh0VdwyGzZlW+xAvh7
 IYKmZkCjfw3rcp+R4uEHw==
UI-OutboundReport: notjunk:1;M01:P0:ZtWMprlq8Yw=;YMr0KkNagjdwMnP8KTCm2Xs2czT
 UuA5vfEyiaETVpKK1VOkbVTWB/1UB2VYnJpIK7CtltFRdD8VYIlncGd00d8BqsQMQ88iu/Pvd
 GzBUdAbQqgqH3hxsX9Id8gLNax4GI08u841WDIyZAGFFJVnrFK6Yj8XKMZOordlFfpoXAUaaJ
 KGZCeepArsVvld8B8Bi+vMl5TyaYrciA0s3SXFS7hX+9AqQ6c/IZKM4nnMY2AF9AmD7N0hRgW
 uzp0DkEwbPIEqC/m6IBFjd6cCB8xSINnjvQ7Rw5OZkb426AwqMoe/ib5y/tUHgAkmX60jRdt4
 aQIJ8UGbdXP2VHu4VDqoRu4iHUwaJri9w42JXXRxxGwhM8ra+Ob2V5HajlvEq5+8jkULDcdYd
 Mih0DF/HF+xSToPeMuehZcU0+FWRHLGLFUUO1mrtk/sQhB8HL4xZChcTeviBJOi/RutXyi9w1
 EFQ7R/o422ghOR/qdDlTrnWjC9TfirT3WKKVArcJ+hNDNPs/OVev+oaikM25z69PfBfZp2zbD
 hgGhnGqR5364AWIFEYJB6rITMgkrcT6gqc9H1fSfrL1qIreCww6KfX3hyPZPlm5VSH/0v0Uu3
 SKWDq+j3obV/kTAWIvsrONElafTslXU8C2DKLsAhK8Fk3pclrV0WzQnu16JE1YsMAgBopsw29
 iwhzezMSvIdZE7fFJFye98l7IgmYO22LsoETpw1FAGa88n+SASVVH765wEAY3AtyjoMn0mpOv
 x1lHm1y0KjlSAi+yfyaka0j6oCNJxlprxn6INmT6XIJSWiZjRKj3pUuzUP1gMGswCNrPP7++H
 ZTCl3DzXX9TLWP2DQbw0lzr9rKPf4ScZ5K6Yx52phKkpRuTD/H5eEMf/KyUtLc0cUf00weW6U
 xAzJ8h5y3Jvj9xHHa8OXR1g4vbCqXLUG9JdvZbN8lmoWbuIp24NWuEJ2uQxZ+Qb8ajypW1m1M
 7kSVUpUQGDEa/8ATFqUzzGn5CCI=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a battery hook is added to a battery, userspace software
is not informed that the available properties of the battery
might have changed. This for example causes upower to react
slowly if a new battery hook is added during runtime.

Fix this by calling power_supply_changed() if a battery hook
was successfully added/removed.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/battery.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
index 9482b0b6eadc..bf99053e5021 100644
=2D-- a/drivers/acpi/battery.c
+++ b/drivers/acpi/battery.c
@@ -696,7 +696,8 @@ static void __battery_hook_unregister(struct acpi_batt=
ery_hook *hook, int lock)
 	if (lock)
 		mutex_lock(&hook_mutex);
 	list_for_each_entry(battery, &acpi_battery_list, list) {
-		hook->remove_battery(battery->bat, hook);
+		if (!hook->remove_battery(battery->bat, hook))
+			power_supply_changed(battery->bat);
 	}
 	list_del(&hook->list);
 	if (lock)
@@ -735,6 +736,8 @@ void battery_hook_register(struct acpi_battery_hook *h=
ook)
 			__battery_hook_unregister(hook, 0);
 			goto end;
 		}
+
+		power_supply_changed(battery->bat);
 	}
 	pr_info("new extension: %s\n", hook->name);
 end:
=2D-
2.30.2

