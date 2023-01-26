Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106C567D585
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:41:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjAZTk5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjAZTky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:40:54 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE6B10C3;
        Thu, 26 Jan 2023 11:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1674762031; bh=35rCENsPcijyAOhim7K4l+Ky2PzYKCOaBYl4vL3So08=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c8THx++88u0z3Li2dPWLmiUJh3tQYk+5k5AWe9kgtAZawNap337YUDeEm69M8y6F7
         Cq2ZeKfRlSRNw7EwlYSx9eEEZBFih2v+pZe5xxE8hY9VQ/oqV24uv1/7BgbxY+Wmyx
         Zvoz5NUo8v4yRrwiE5MCSXYFLqDHeKTKusoYbsm9IHu/sSAz5Jh5wYWrKuWbTTOTsQ
         K1Pmpru0qCnMeyNw8googOpxFOL4SODHDHm8gcM5CTZlihaX2KsiNbyiCUnZ/Fz1GT
         HalvDJ1lGRlmPLwCN9jXw87hPtQNt4pLlAhZTFwKkHgsrbQMwsEIVSeEdsKl/JC3cN
         GzCs1G11apZcQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MOzSu-1p2Ljv2IwO-00PNjg; Thu, 26 Jan 2023 20:40:31 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     jdelvare@suse.com, linux@roeck-us.net,
        platform-driver-x86@vger.kernel.org, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] platform/x86: dell-ddv: Return error if buffer is empty
Date:   Thu, 26 Jan 2023 20:40:18 +0100
Message-Id: <20230126194021.381092-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230126194021.381092-1-W_Armin@gmx.de>
References: <20230126194021.381092-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FMTSH4+GCt1tIQzTjFcLnT66ULXWluDg6AME49SW9RJN1ESjvgZ
 VlzlLuMrNKVyBIgofZwYDWFS4KsSB1uSrr8AblshAKjrk1wf4GwjlT+raPTNc0TrdUVCPPF
 6JjwVwtk+RHuggQOGvLXVRbpCq1VlrSa43K01HL6YW2RstdBBA1h4DIJQ7G8uEWrcAjezAm
 BCtgrnuYnpSEUzkwVABXQ==
UI-OutboundReport: notjunk:1;M01:P0:4icOODEvEbI=;ZMKE8wju+QfVcIYhCsHMOJcrICL
 hQOd58nd4xh9P9bhNSOJT5DpwQ3JAGkOaka8lIpE/bFZm44YDhkfJCnOOwL8OQMV0xeyjcULW
 gt16zlY+xc8URMUhQ+rYrTYYsgqvhgWx831voblF0jNZCgjY5Lov+xhzQX8DaIG78LXKTeEMt
 vdMy0YoL4FP5OFtNeAdRjRvcUZ90I9U3bWMgqFA1qCLVDilECHLJdBBXI2uHphSCUn3WsD8UK
 Aw7hxZJmVwJjIjUquzE1W6wTutsQy7vnnf773dONHmW5kpD+7goI6rao39Jp7QNktJhk6P1EZ
 LrTjX6NTv/G+AlK0SOfuPdYlYo8MAx5u7Ej3MibCFQGH4kD28J4b13KZCGmNaujDpNJ8s+eQ1
 V8+UOm/kSsNgGZnH/u4XQ1ZNgnBAzn11Uy6hAiSPH8924r9S/Ur0alrh9ovHpSXWYpykN+tAb
 kN+rpzUaLWyBQArw80Fyh7MdOEEH5L+nXXT15OkKv9WNEJ8zXfmr1ZB0d2wOnGiqKaKsvN2qV
 ICQEhRVqIMlo4MjTzMlD8hL2TC67MzuKXtGFiET+VviRXTzJjmDMDHV9lB8q2aYn8LIHdkFJi
 FJp+srLE/qCUZZJxBzZVk5JCSBIXIZ5Ohzh5oIAtGPZ+R8mW1d7i/4x6zkLDNb/VOiHDXaeXY
 znDwpYIMqq7hE/grPPFWq36phLTxFx3Vx2bQqacP+x8NJDRzFmJRGXvlDtRjgIHcZMgbrTYZq
 VZJerh3goSQ5PsHY9JTWYGXTUOaKLbUvyGPVyWOxK1RBjxpWoCP2PQaoESHmGt1kZM0/+txmv
 pcqhJDVFSxfiiOnuezA/kqSnhyRNqokHE4id0n0eX56hhZr4oeCLrkjeESO2PzS2zb3gDGW1z
 Q1vk9seCktKdR3uFJFhxXeFI/pcjM+uRjr7LS5vsWkUIVONCF5uTOdYPGZhZJT2/BPjDkmEZS
 /qAEFy7TyJ6VtIZ+hddwYYLgTAk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In several cases, the DDV WMI interface can return buffers
with a length of zero. Return -ENODATA in such a case for
proper error handling. Also replace some -EIO errors with
more specialized ones.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/dell/dell-wmi-ddv.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-wmi-ddv.c b/drivers/platform/x=
86/dell/dell-wmi-ddv.c
index 9cb6ae42dbdc..f99c4cb686fd 100644
=2D-- a/drivers/platform/x86/dell/dell-wmi-ddv.c
+++ b/drivers/platform/x86/dell/dell-wmi-ddv.c
@@ -11,6 +11,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/dev_printk.h>
+#include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/kstrtox.h>
 #include <linux/math.h>
@@ -125,21 +126,27 @@ static int dell_wmi_ddv_query_buffer(struct wmi_devi=
ce *wdev, enum dell_ddv_meth
 	if (ret < 0)
 		return ret;

-	if (obj->package.count !=3D 2)
-		goto err_free;
+	if (obj->package.count !=3D 2 ||
+	    obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER ||
+	    obj->package.elements[1].type !=3D ACPI_TYPE_BUFFER) {
+		ret =3D -ENOMSG;

-	if (obj->package.elements[0].type !=3D ACPI_TYPE_INTEGER)
 		goto err_free;
+	}

 	buffer_size =3D obj->package.elements[0].integer.value;

-	if (obj->package.elements[1].type !=3D ACPI_TYPE_BUFFER)
+	if (!buffer_size) {
+		ret =3D -ENODATA;
+
 		goto err_free;
+	}

 	if (buffer_size > obj->package.elements[1].buffer.length) {
 		dev_warn(&wdev->dev,
 			 FW_WARN "WMI buffer size (%llu) exceeds ACPI buffer size (%d)\n",
 			 buffer_size, obj->package.elements[1].buffer.length);
+		ret =3D -EMSGSIZE;

 		goto err_free;
 	}
@@ -151,7 +158,7 @@ static int dell_wmi_ddv_query_buffer(struct wmi_device=
 *wdev, enum dell_ddv_meth
 err_free:
 	kfree(obj);

-	return -EIO;
+	return ret;
 }

 static int dell_wmi_ddv_query_string(struct wmi_device *wdev, enum dell_d=
dv_method method,
=2D-
2.30.2

