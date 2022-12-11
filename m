Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5892F64960A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Dec 2022 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiLKTiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 14:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiLKTiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 14:38:04 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7895D95AB
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 11:38:03 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d2-20020a170902cec200b001899479b1d8so8756336plg.22
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RgALFf7PGAYeLm7qK7ef+qSJDgWYIBq1PtAWuUeE+QU=;
        b=EIC/vFnXWam/5mn41nXwqZAMPXeKHbmC3C2uEEyQyGcNwdefXhyEjulzMVKpiE4JBO
         b9K5G/e95BFG+rWcTR7SK/a4vRA4dfMQW7/TmYRzUxor5ncTOIqiNFciWY51BvuBOog+
         FhYaueQUw+lGcpVI9ehSFAi6Njr4gGR8sPxWYQmqN9VjjFikWd1kmZlzSMYR7wEi4/N4
         dimcNIXvd63jI7HJHQe+J5sGCZC7L6Bzirsf+QgUIYm+2drZA2Kr+MqFTn7oA/CiW5MX
         G2B3TGkAYEsFXlhheiOdZIuufLD7Bwn+A+rhSnVvr3ruQS2OIt2ATvuYRmUK+k2bGuA+
         5BIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RgALFf7PGAYeLm7qK7ef+qSJDgWYIBq1PtAWuUeE+QU=;
        b=tAwlhHOe/tTpYyIVvuNGUctNCLYo8Il/tSlho3yoT2MUt8GfQWCQ/jE9gNvg17+md6
         SjWcTAJ746aaufuMqTbqfM6aF6sWJJu31RxHjQPRIHruTfHLMDBe/VFD7zMWpATlK0oG
         tD/CGJlCdk2gcH0tDTUvgu9iYUdqxIJOEWYLAOfaMIBzgR5hcCeJcuL8suwwJ6QOiZYm
         ctdkRLUZ0fQxjjGxgzYUgF1dDoxARo652TS6/BL/H9BQLgS/I+Oi6zgwpEV+QdgxKeMo
         E4wi42B3+/ubTEo5b3mxzH6m/d5bgwt9xOb7EN5khenBc89EqzAI1s3YVQNxdyA4IKYB
         QKsQ==
X-Gm-Message-State: ANoB5pnvJPtietxEvLD59Fe7ba5ivDIeWJiVPmEck4bcIBqyDrBMXkrP
        6Bl0fh/+NpNP7Yd0s29/jGuneDIBu0k=
X-Google-Smtp-Source: AA0mqf4rggOLQr7KxGq0jZGUdlpIIBy9rOW/7a4GzvFBOq9RfdaKAuggD+jnCOqt/zwOSp1p2pRMtdhPwAA=
X-Received: from badhri.mtv.corp.google.com ([2620:15c:211:201:6e12:1d4:7ea0:48cd])
 (user=badhri job=sendgmr) by 2002:a17:90a:2a88:b0:220:1f03:129b with SMTP id
 j8-20020a17090a2a8800b002201f03129bmr149467pjd.0.1670787482696; Sun, 11 Dec
 2022 11:38:02 -0800 (PST)
Date:   Sun, 11 Dec 2022 11:37:55 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.rc1.256.g54fd8350bd-goog
Message-ID: <20221211193755.1392128-1-badhri@google.com>
Subject: [PATCH v1] usb: typec: altmodes/displayport: Add hpd sysfs attribute
From:   Badhri Jagan Sridharan <badhri@google.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        RD Babiera <rdbabiera@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exporsing HotPlugDetect(HPD) helps userspace to infer HPD
state as defined by VESA DisplayPort Alt Mode on USB Type-C Standard.
This allows userspace to notify users for self help, for instance,
to hint user that the display port cable is probably detached (or)
the display port sink (viz., monitors ect.,) is un-powered.
Also helps to debug issues reported from field.

This change adds an additional attribute "hpd" to the existing
"displayport" attributes.

VESA DisplayPort Alt Mode on USB Type-C Standard defines how
HotPlugDetect(HPD) shall be supported on the USB-C connector
when operating in DisplayPort Alt Mode. This is a read only
node which reflects the current state of HPD.

Valid values:
 - 1 when HPD=E2=80=99s logical state is high (HPD_High)
 - 0 when HPD=E2=80=99s logical state is low (HPD_Low)

Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
---
 .../ABI/testing/sysfs-driver-typec-displayport    | 15 +++++++++++++++
 drivers/usb/typec/altmodes/displayport.c          | 10 ++++++++++
 2 files changed, 25 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-driver-typec-displayport b/Doc=
umentation/ABI/testing/sysfs-driver-typec-displayport
index 231471ad0d4b..256c87c5219a 100644
--- a/Documentation/ABI/testing/sysfs-driver-typec-displayport
+++ b/Documentation/ABI/testing/sysfs-driver-typec-displayport
@@ -47,3 +47,18 @@ Description:
 		USB SuperSpeed protocol. From user perspective pin assignments C
 		and E are equal, where all channels on the connector are used
 		for carrying DisplayPort protocol (allowing higher resolutions).
+
+What:		/sys/bus/typec/devices/.../displayport/hpd
+Date:		Dec 2022
+Contact:	Badhri Jagan Sridharan <badhri@google.com>
+Description:
+		VESA DisplayPort Alt Mode on USB Type-C Standard defines how
+		HotPlugDetect(HPD) shall be supported on the USB-C connector when
+		operating in DisplayPort Alt Mode. This is a read only node which
+		reflects the current state of HPD.
+
+		Valid values:
+			- 1: when HPD=E2=80=99s logical state is high (HPD_High) as defined
+			     by VESA DisplayPort Alt Mode on USB Type-C Standard.
+			- 0 when HPD=E2=80=99s logical state is low (HPD_Low) as defined by
+			     VESA DisplayPort Alt Mode on USB Type-C Standard.
diff --git a/drivers/usb/typec/altmodes/displayport.c b/drivers/usb/typec/a=
ltmodes/displayport.c
index de66a2949e33..06fb4732f8cd 100644
--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -146,6 +146,7 @@ static int dp_altmode_status_update(struct dp_altmode *=
dp)
 		if (dp->hpd !=3D hpd) {
 			drm_connector_oob_hotplug_event(dp->connector_fwnode);
 			dp->hpd =3D hpd;
+			sysfs_notify(&dp->alt->dev.kobj, "displayport", "hpd");
 		}
 	}
=20
@@ -508,9 +509,18 @@ static ssize_t pin_assignment_show(struct device *dev,
 }
 static DEVICE_ATTR_RW(pin_assignment);
=20
+static ssize_t hpd_show(struct device *dev, struct device_attribute *attr,=
 char *buf)
+{
+	struct dp_altmode *dp =3D dev_get_drvdata(dev);
+
+	return sysfs_emit(buf, "%d\n", dp->hpd);
+}
+static DEVICE_ATTR_RO(hpd);
+
 static struct attribute *dp_altmode_attrs[] =3D {
 	&dev_attr_configuration.attr,
 	&dev_attr_pin_assignment.attr,
+	&dev_attr_hpd.attr,
 	NULL
 };
=20

base-commit: 81c25247a2a03a0f97e4805d7aff7541ccff6baa
--=20
2.39.0.rc1.256.g54fd8350bd-goog

