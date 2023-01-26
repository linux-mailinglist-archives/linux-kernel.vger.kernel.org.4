Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C056D67D588
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjAZTlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:41:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjAZTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:40:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA44DBDF;
        Thu, 26 Jan 2023 11:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762033; bh=2z2q3D58SxI2OajPK6DnDMenUSp1L1IQAUjbGhv12o4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LgPh1JBTURosMdr/JcNu4u2YBVQx8SlXuAhnlEgm9HPgmh7uqQJ76dlr4N2NS6bBV
         KyPQLvrmXbdag6F6isDoGtAjcS/j2/F+83nv1dTBy0BdcNuhdWu7yUK1pdaV0pyQMl
         7X1Ma/y2kPtlLCg40lQKLB9JKfgtv8oa87G2J9ta4IThYrmy0GRx3CuZQmDQCpR87s
         BYWycuh4Omcm9nhdsSEADutBsBLfgtB4n8t+upfMwcFn/NfOihsJ1cPcQUvmQoBFJe
         XDst35WpPwqEIUGi/GbAPXDke/EiilyXDaxASYwLVfENLAdDocmIAE04obrRPvyElX
         2vTdMXfEnF6WQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MBDnC-1pWiQI3u9u-00CiQy; Thu, 26 Jan 2023 20:40:33 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] platform/x86: dell-ddv: Replace EIO with ENOMSG
Date:   Thu, 26 Jan 2023 20:40:19 +0100
Message-Id: <20230126194021.381092-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126194021.381092-1-W_Armin@gmx.de>
References: <20230126194021.381092-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:NLVVbpI0BmlKNg26OrmolKtnlDOYVheuTHtAOKwORDofmSKfbcM
 bjnky+2Lh3flELgms70KofKOudqX/n6r+g+p6ddyRdtCXqzs/DjHN0KROyOy/AoP4902TXN
 I9GWkowT/hIG9SAKRl+7dgGlS55SZyWMwLJmEdE8Rkl6xSEz7++RLdS7gcv/TyAuuf5KJhu
 Cv7hUVLjOExBaUnNcbKpA==
UI-OutboundReport: notjunk:1;M01:P0:y6MTc6yr1t4=;XLSNSA9rwoNDlSx+yXsyXK1OrpS
 iy8pSN6DIVpjGkMlMcnVCqg4e8ZudOoWyVszsq2zBGalc4Q9q3H1EV1LrGpvp2ADjHVc11cir
 HGQUE10h3IqfoKjBygkb7j77ljewKikXU4wg48fqAw1C4ZnL+kkuVR5zqord7gG4ENkNMgMex
 4b0zmGf4U6dOIhAXkArNa13Wk8+MDYQQ7dgzKWVo3TSBRKxXgj7UjiEuwKJ0SlaqJqy82rWuH
 Mwq+2w2vLk7ycVcBAwIKa5eia5sDFw7y2gJzLUIfCoqfo0VeISwWfbkxN6DIkT8OsG+MAKiuT
 4csbpXDkr1XpkK9MCdbm5BKjSxBffMc5dsVwjBXj3ecEaMFspX8t/GP7NpvnXKTousDb4ZrZV
 huFyt5prhDifJSs6wBVnBkfWVLpraKFstoxljMXt8ifyGxQBWA0QXyerrlJwJoBKrCqM6CrdP
 kf9QoZhdckWR1suwx1w0agwIPzghmlden9LwVNcEmrcGwdiImUewa8n3ZvWxTbjj0COJRgjbC
 kY/ThdeJ1x4NM8huWP4/qwy77zEH3SWKnC4+8gRLO0Cz+dyrw4eZQ7sfclqjrGr9fmr0DuOHv
 hNFDsLh/lWzAnHlyX1SETMlmIAtPDV75EX6zP03BoPARW7LJLWQxBRC8EaVvsc6w8Ci823eHl
 CaBirN1Bqthm/QRpz5Jmiv6YO9oVG06WXds80TEi+xhrtUU/Eh2DV4no4EXF/8BHwC9DnbiJu
 CjZY2BiaqYZcOPZGq092IHsGM/VO5Qt2DrGJcfa4g8us4NOhy93d8Na9Lg8uPTW+HdlG/k0WG
 /bv/rqK/Bs1hf8k+xYhHr8LYQ6Qp2X5JeuINMA8bUHtPNUDkTwGOYVdfO7E3Tm+nVm9vCoOQc
 4yBUH9t7CA77OYVAAAc7PS0hxLcP0oZBRCikpUK6rwKRhJFSviey4SS2XKsETXlqG2bIYE/bR
 SwbqOQfsUJdSR5jOBr0dNPTqyaY=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the ACPI WMI interface returns a valid ACPI object
which has the wrong type, then ENOMSG instead of EIO
should be returned, since the WMI method was still
successfully evaluated.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index f99c4cb686fd..58fadb74e86a 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -87,7 +87,7 @@ static int dell_wmi_ddv_query_type(struct wmi_device *wd=
ev, enum dell_ddv_method

 	if (obj->type !=3D type) {
 		kfree(obj);
-		return -EIO;
+		return -ENOMSG;
 	}

 	*result =3D obj;
=2D-
2.30.2

