Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 122946D2791
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjCaSJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbjCaSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:09:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247D510FA;
        Fri, 31 Mar 2023 11:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680286155; i=w_armin@gmx.de;
        bh=Am7Nhw3dTswBeMtyeu1EM5iLerWvPqMeO4mcyN/Sagw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=j7oorQ+K9UXIQ+cwJucUFBmWN7x+UAPcUH05jLK5CJGAy25xKL/x/Ko2hfhvl7y3A
         tObP2+vvE2UAyS1uq3TY8mgkec8oTR/P/m0OMlTQPhALTBl5VGkvAY5WFw/09cL1YV
         g2dR8V6h8ty6+EaIinCRkqgIPasckj2BvUK/2RBLIFEPL7vWoRieweT/qkgXJ0yczc
         S6aaw886PMNTAdq23ebOOS3K4ijBGh1iLmyh2KnBWhs/GFzmUf///6ur3w9UUMY9dd
         1KCsQxWhuWB0oJTLyrdhl8/o10GpdWnWPDx7C4Xu/LwVj/OE4UBi+sMqoPqSjNHI8D
         628OZ6o8cTrUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MHG8m-1pdtLn0oMK-00DE59; Fri, 31 Mar 2023 20:09:15 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, mirsad.todorovac@alu.unizg.hr
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] platform/x86: think-lmi: Fix memory leak when showing current settings
Date:   Fri, 31 Mar 2023 20:09:12 +0200
Message-Id: <20230331180912.38392-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dOb2W6pt4BTY8NZxprhaSQSTlNEUARb01MBam187alshfjHp2GI
 R/Ax8hMw+yFfQ77jh3YDlEAiAhsH9tAlC7meTfHmuMeV0pQA2gZQMCaNztbgatf+URWOsPk
 KMvEZOzNpU2VYpbabOuTBErll/x6Y4JuGrGcc2KBrtNlzfxPwVuGO9k3R6kySUs+NcGj2Rf
 NeuZ7gPHe9/8+fW54o7OQ==
UI-OutboundReport: notjunk:1;M01:P0:o+H64xJYP30=;WDH1W3NNdk3p5InRRtW7K+q0T+4
 EzZS/mbniABKHkWXgOiJUAez678uato/IBsCwDJm2gPWlvcRczBDaLqqrJPYZjwf9QhSDjs3u
 WeCAOJUXUpVQplPA7XXCCX7Yi70TDrBIcFI+18WOWumJiQzgOVPOdhjTfOrNFE2aX5iFBTXku
 bs9fqiGkvfekmd745jTrXXJpzREjDqsTKdAIL5RRv1y+FP54dol9lRzsbWdSNWqX7oKZ4LveX
 zL/2CfINU9EIvbiB5Ec9Ruj8BJ8Gv1Lak5CGzeaS2+J4k34AjECch6Z57ectoxFTIQgleKswa
 IqP3MNep8MenhKG0Zaj8F9P0OpCYifK21PjruN/GcgYjFyjJc5oxbXDlwrU6U942TiXZyYUA+
 zbh24laozwIiUH0rYMgtbq0Sprlm7X8o+8o1hjcqx+yNDGe4PfX7OIcBvGM6UjvgGN28idXos
 88ytvsnU330yHvBE3CkDkLX9rSE8T8mTNAn4zHp98oRd/scAQL4Hhl9uEfNESJ7odVxcxsGMJ
 YVeCnMBHtU03GNlxXNq6sHQFi5Z2p1I62wHpAq712ZPSzH/J8ZkYjfkWvIa74H1t2yKjs/VJ2
 X9lNxJ4CxjYmhTAHhXlP8lPpS8PaPU6ZcphFv0cVzY2X8M4kdmSgp/Dpo2RYv+EMTe+SK9Sc2
 p9XWkjedfW/jBRLxDizILWIJq/elQURrRmXocfBKuNVvGX89urcV+y4HelkNyW6ga7ONWP+IE
 wCgXCNZq6McMw1omZltSnCStmj8AnuJ6dlH/vJmR9Moy9miLBTLHSbaNZfHSrvlW19jccxamS
 vBaJYwPBSvV2vX8BIQYdkRb0mee8RGWIN0DneB5+QAiUE7ima+skP+tJrADj+RVBDJ9v2Rxur
 TAxqqDZy01c+Cn1CW222/Jv6GchYcy4dD80JDkvUgESfg0GLZrbBib7fgJdXRO5g1yxpkkT7S
 XRrtPLWAsafxzSH9QiEmoDg+SHU=
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When retriving a item string with tlmi_setting(), the result has to be
freed using kfree(). In current_value_show() however, malformed
item strings are not freed, causing a memory leak.
Fix this by eliminating the early return responsible for this.

Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Link: https://lore.kernel.org/platform-driver-x86/01e920bc-5882-ba0c-dd15-=
868bf0eca0b8@alu.unizg.hr/T/#t
Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support o=
n Lenovo platforms")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes in v2:
- Add Reported-by: and Link: tags
=2D--
 drivers/platform/x86/think-lmi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think=
-lmi.c
index cc66f7cbccf2..8cafb9d4016c 100644
=2D-- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -930,10 +930,12 @@ static ssize_t current_value_show(struct kobject *ko=
bj, struct kobj_attribute *a
 	/* validate and split from `item,value` -> `value` */
 	value =3D strpbrk(item, ",");
 	if (!value || value =3D=3D item || !strlen(value + 1))
-		return -EINVAL;
+		ret =3D -EINVAL;
+	else
+		ret =3D sysfs_emit(buf, "%s\n", value + 1);

-	ret =3D sysfs_emit(buf, "%s\n", value + 1);
 	kfree(item);
+
 	return ret;
 }

=2D-
2.30.2

