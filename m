Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D246D277B
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjCaSDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbjCaSDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:03:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484D41115F;
        Fri, 31 Mar 2023 11:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1680285795; i=w_armin@gmx.de;
        bh=2Lp2z+/qvRtTGAJyRpBMFhDcmIL5gFtMEMl6MY8KmRQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=Nyi60R1NTwYE6vrAUMzPEWG9a9EHDfE1Ecyg/CLaXNIpHWXLSXPgYgLRn5R5JnnVX
         7q4MYpiv52ElUDiWjgMcpZ5EGhu0UcmrJsybcxzP+7rp4DGPCk+lyYxHHxrkHe0I/g
         Zl4+NqmQIr+le2oZYBfoZ/zhGz5p5WlR3r0uVtbEvR3lu5K6Lo2DpBVGxSZsHGPage
         R2lscL05RBJMCWxdutMcV4+WIQyxWdUzX0uPiepRy/uKU3gn2P4/mtiIzv8FzmMOZa
         a4Z7kcgssusIAdhahGwZsdL9iCdyOnToH69wM3kAJeHoCnCN2xzioEMoSkcQ0TgCbJ
         3fCykEgaLDhbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M7sHo-1pmAyn2Vdq-005106; Fri, 31 Mar 2023 20:03:15 +0200
From:   Armin Wolf <W_Armin@gmx.de>
To:     markpearson@lenovo.com, mirsad.todorovac@alu.unizg.hr
Cc:     hdegoede@redhat.com, markgross@kernel.org, thomas@t-8ch.de,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platform/x86: think-lmi: Fix memory leak when showing current settings
Date:   Fri, 31 Mar 2023 20:03:12 +0200
Message-Id: <20230331180312.37997-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:H+fNulAdyhggvwC9T//bmx/rp1Y3e2v7ooogPF8J2FFB9KvzgTr
 xJ/XlNHfTNs787D9dnPIf1UQrYc/v4ce7vsv0wjPjCCJ309hpGLLLExJIfQlx4Vswqcjjz7
 Sn/83fucU8bMF4WGWA2dJ5sV10nXmjmavK4SiPSkwkifzIp5u2kaAMBuBHu6UGzd8PPv7wM
 R/ANCAKBtwlmrxe/IZj0Q==
UI-OutboundReport: notjunk:1;M01:P0:dO2iJJPkjfw=;Wtu1GOrIhxArCLMl3lyuq1RxcJf
 x6MPFVwYXjwWT0JxvgBUs31+AjtO7OLBl860jNuKLE8Q1numTvKWFFLblXqfRXdl+PovC6fys
 peAmRJ/xmE8+EaWPS7NqyYA86iC1PLTwuRGDU4Xw2Rt/jF0uwXONesBEnUqxPs090aZDH3M1q
 OCTS3l42S3JpYvKpxBnkXuARkjx/1YWLg+RLGfclGiQkYUHXhplbBij22IV5nj5K5iQKWALGH
 GH5HZuk1pWf/9dz338YrLG7wNtv3fgFn9jV98hRGUyX4lGOVXfhu4+nn89lr3wMOLzCEXjUEo
 RyXNs8V/dOGKBRPqy011GGUOhi5BZuHksTNDcEeKvaBS5MlEdTAzEM/Yeo1Ve7WKsqYwADb6H
 /xBjAssu7CfWmLl4zDAyG3zh3wojloWsDMOKwRmgkQA0kMX5LxxLKAkorXVHhK198As0iw674
 RsDPueIvy/acGTzQhkI3rBIaZ6V32lVhxPri8cizcL0oRCG6XVlgrQFEkdXTNXkUn+/IM+TAW
 avMqxx8BI2esSUlt5E/RnVouyoZeBFZhBls00fc4iDze9iE8i087IdiWu4GpseLDwa3bPqMKz
 j0O8TKOmrmlqRaYqY/YDspMMeeK5mT8Tb6b0Z+gtg4fiVBvKLb39U1f/kKBXLhMeDlfWk4NOH
 SZemdhn0OD8GKjeAaPKrCLj3fDpNKOyZN58EkFdrqUo9TLs2XN5oXowvt1W3puU/HqDe0GHF2
 AqzL4YYXFJMUb6IEDScUsXy4lMVbkIZYatpLSUWu4c88ih1LhX7B+HRo1fVooYB5Qj/VqvYHt
 wWGcYzmqQs/eixjq2XuTQNFTBX4HluSRNNv32+Ps6wBLbvuE1wxuOCnruaVHDZPfs9sRCoJfz
 V3uNuNlMX1DrLRvt1f87vtt9AbjSMFXS40MDvrRwTMS8PuwpqU8/QS1VK+o7O0yke4Z9xM0np
 FUAO5BIG8vTX9MgtcDHJjPcO8xU=
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

Fixes: a40cd7ef22fb ("platform/x86: think-lmi: Add WMI interface support o=
n Lenovo platforms")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
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

