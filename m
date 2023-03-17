Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070E6BE5E7
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 10:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjCQJvE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 05:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbjCQJvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 05:51:01 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 627BC1CAC9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:50:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id ay18so2754930pfb.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 02:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1679046658;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQouKbztgEXI/GX4OnWRW1CoUxg0mNouSqPmkVWb82s=;
        b=BiDksCrWC3vb9Z+LC1lrZby7qZOsXSWbeO7roIL6LTz/P7+b7nazdszxhohZmY02ZJ
         uQql4T9ellIYNdfiIaQlEW1rI2L+1gDl6+ZNs1k4a5qEbxvYhU1KaLD1Ej4/YADZKgR9
         rVqt9gFh84hy+TU8+eqd4Zd6Md2sudnsqYku8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679046658;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQouKbztgEXI/GX4OnWRW1CoUxg0mNouSqPmkVWb82s=;
        b=77DGZBDCt42oNx9qMrdA+jsTED/TvXMg1iKF51S8vK0bnBpjTqlyPXbRZ4eNwKAO6C
         pXVDaCda3XpSi0pE4aeeyV1TtBFyVsIjBDB+hd533CpltKFClrwyJ6RBiAmnVO8Ebvmj
         cSzXFa+fAYLcRm5G8ZkQp4kNOPmSQzkCnnXm+cPoPSqPhDtTovYtXFY1LwFBciYXorSU
         yfkhQQKR7Pg6u1ITK3NsNcgs3kPirLs9qojg/HeRxAmR1NjD3TN6DUYSPIF4ndmBjs1s
         jO60X6pxFFrzKcXyLI3vtmxNpDYwkDGDTaVc6qz6bPnT65lo0OhV/6XS6kaN6Pv1RJ8j
         01Kg==
X-Gm-Message-State: AO0yUKWdW6TxliQmiNDQqpaA1aFi6votwUhjKnsaqpZsAuE1ONTwab0S
        cnO0LCWPUrz1ywVew5UZdoBz7A/r6tuVdZE4HIqvnD6ZnVPBrRNhjWMh9+nTV+VegyP2h8sTp0k
        7cI806Fa6g8kaslJ8YPwVPbhLq2DSOhwipb65xRjtXeQWNcenQT5PYodnIleaJ7pN6J7rsEUblH
        EUlbN95V6Ex8u9VXX+Z0vaAcI=
X-Google-Smtp-Source: AK7set960uqewLJLJvH8lUtfrf1KkSDdoBu5Dl61a0DtGH5xk2IlssVQzeaG1g9B8y+AnLbETWNkqg==
X-Received: by 2002:aa7:9dc1:0:b0:626:72b8:743b with SMTP id g1-20020aa79dc1000000b0062672b8743bmr313167pfq.33.1679046658362;
        Fri, 17 Mar 2023 02:50:58 -0700 (PDT)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id u3-20020aa78483000000b00625e6eb438bsm1158912pfn.71.2023.03.17.02.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 02:50:57 -0700 (PDT)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, gregkh@linuxfoundation.org,
        Alexander Komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH v5] [PATCH v5] pps: Add elapsed realtime timestamping
Date:   Fri, 17 Mar 2023 02:51:01 -0700
Message-Id: <20230317095101.249784-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a9802b05f71583c0"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a9802b05f71583c0
Content-Transfer-Encoding: 8bit

Some applications like Android needs elapsed realtime timestamping
to PPS pulse for its clock management. Add sysfs node for this.

Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
---
 Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
 Documentation/driver-api/pps.rst    | 19 ++++++++++++++++
 drivers/pps/kapi.c                  | 24 +++++++++++++++++---
 drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
 include/linux/pps_kernel.h          |  2 ++
 5 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
index 25028c7bc37d..031ec89e1ed6 100644
--- a/Documentation/ABI/testing/sysfs-pps
+++ b/Documentation/ABI/testing/sysfs-pps
@@ -1,3 +1,30 @@
+What:		/sys/class/pps/pps0/assert_elapsed
+Date:		October 2021
+Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
+Description:
+		The /sys/class/pps/ppsX/assert_elapsed file reports the
+		elapsed real-time assert events and the elapsed
+		real-time assert sequence number of the X-th source
+		in the form:
+
+			<secs>.<nsec>#<sequence>
+
+		If the source has no elapsed real-time assert events
+		the content of this file is empty.
+
+What:		/sys/class/pps/ppsX/clear_elapsed
+Date:		October 2021
+Contact:	Alexander Komrakov <alexander.komrakov@broadcom.com>
+Description:
+		The /sys/class/pps/ppsX/clear_elapsed file reports the elapsed
+		real-time clear events and the elapsed real-time clear
+		sequence number of the X-th source in the form:
+
+			<secs>.<nsec>#<sequence>
+
+		If the source has no elapsed real-time clear events the
+		content of this file is empty.
+
 What:		/sys/class/pps/
 Date:		February 2008
 Contact:	Rodolfo Giometti <giometti@linux.it>
diff --git a/Documentation/driver-api/pps.rst b/Documentation/driver-api/pps.rst
index 2d6b99766ee8..bd0e63f15f95 100644
--- a/Documentation/driver-api/pps.rst
+++ b/Documentation/driver-api/pps.rst
@@ -167,6 +167,25 @@ sequence number. Other files are:
  * path: reports the PPS source's device path, that is the device the
    PPS source is connected to (if it exists).
 
+Real-time assert event::
+
+   Calculate the monotonic clock from the timespec clock to generate PPS elapsed
+   real-time event value and store the result into /sys/class/pps/pps0/assert_elapsed.
+   Because we have requirements to make sure the delta between standard time,
+   say the GPS Time, and elapsedRealtime < 1 millisecond,
+   regular linux clock timestamp is not enough for our use case.
+   The pin PPS will generate elapsedRealtime event at 1 sec boundary
+   which is an exact value of the monotonic clock from the kernel PPS driver
+   /sys/class/pps/pps0/assert_elapsed.
+   Whenever AP receives this pulse, kernel's pps driver timestamp this
+   elapsedRealtime event and let this time available via sysfs node
+   /sys/class/pps/pps0/assert_elapsed or the IOCTL call.
+
+   The device's Unix epoch time system clock is not monotonic; it can jump forwards
+   or backwards unpredictably and may be changed at any time by the user,
+   so this time should not be used to order or compare locations.
+   Prefer for that purpose, as the elapsed realtime clock is guaranteed to be monotonic.
+
 
 Testing the PPS support
 -----------------------
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..1f3ddccf9642 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -162,11 +162,21 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	unsigned long flags;
 	int captured = 0;
 	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
+	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
+	struct timespec64 ts64 = { .tv_sec = 0, .tv_nsec = 0 };
 
 	/* check event type */
 	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
 
-	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
+	/* Calculate the monotonic clock from the timespec clock and stores the result in pps_ktime format
+	   ktime_get_boottime_ts64() : because elapsed realtime includes time spent in sleep */
+	ktime_get_boottime_ts64(&ts64);
+	timespec_to_pps_ktime(&ts_real_elapsed,ts64);
+
+	dev_dbg(pps->dev, "PPS event (monotonic) at %lld.%09d\n",
+			(s64)ts_real_elapsed.sec, ts_real_elapsed.nsec);
+
+	dev_dbg(pps->dev, "PPS event (timestamp) at %lld.%09ld\n",
 			(s64)ts->ts_real.tv_sec, ts->ts_real.tv_nsec);
 
 	timespec_to_pps_ktime(&ts_real, ts->ts_real);
@@ -181,11 +191,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	pps->current_mode = pps->params.mode;
 	if (event & pps->params.mode & PPS_CAPTUREASSERT) {
 		/* We have to add an offset? */
-		if (pps->params.mode & PPS_OFFSETASSERT)
+		if (pps->params.mode & PPS_OFFSETASSERT) {
+			pps_add_offset(&ts_real_elapsed,
+					&pps->params.assert_off_tu);
 			pps_add_offset(&ts_real,
 					&pps->params.assert_off_tu);
+		}
 
 		/* Save the time stamp */
+		pps->assert_elapsed_tu = ts_real_elapsed;
 		pps->assert_tu = ts_real;
 		pps->assert_sequence++;
 		dev_dbg(pps->dev, "capture assert seq #%u\n",
@@ -195,11 +209,15 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	}
 	if (event & pps->params.mode & PPS_CAPTURECLEAR) {
 		/* We have to add an offset? */
-		if (pps->params.mode & PPS_OFFSETCLEAR)
+		if (pps->params.mode & PPS_OFFSETCLEAR)	{
+			pps_add_offset(&ts_real_elapsed,
+					&pps->params.clear_off_tu);
 			pps_add_offset(&ts_real,
 					&pps->params.clear_off_tu);
+		}
 
 		/* Save the time stamp */
+		pps->clear_elapsed_tu = ts_real_elapsed;
 		pps->clear_tu = ts_real;
 		pps->clear_sequence++;
 		dev_dbg(pps->dev, "capture clear seq #%u\n",
diff --git a/drivers/pps/sysfs.c b/drivers/pps/sysfs.c
index 134bc33f6ad0..983f16b86a62 100644
--- a/drivers/pps/sysfs.c
+++ b/drivers/pps/sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/pps_kernel.h>
+#include <linux/sysfs.h>
 
 /*
  * Attribute functions
@@ -29,6 +30,21 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(assert);
 
+static ssize_t assert_elapsed_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTUREASSERT))
+		return 0;
+
+	return sysfs_emit(buf, "%lld.%09d#%d\n",
+			   (long long) pps->assert_elapsed_tu.sec,
+			   pps->assert_elapsed_tu.nsec,
+			   pps->assert_sequence);
+}
+static DEVICE_ATTR_RO(assert_elapsed);
+
 static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -43,6 +59,22 @@ static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(clear);
 
+static ssize_t clear_elapsed_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTURECLEAR))
+		return 0;
+
+	return sysfs_emit(buf, "%lld.%09d#%d\n",
+			(long long) pps->clear_elapsed_tu.sec,
+			pps->clear_elapsed_tu.nsec,
+			pps->clear_sequence);
+}
+static DEVICE_ATTR_RO(clear_elapsed);
+
 static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -82,6 +114,8 @@ static DEVICE_ATTR_RO(path);
 static struct attribute *pps_attrs[] = {
 	&dev_attr_assert.attr,
 	&dev_attr_clear.attr,
+	&dev_attr_assert_elapsed.attr,
+	&dev_attr_clear_elapsed.attr,
 	&dev_attr_mode.attr,
 	&dev_attr_echo.attr,
 	&dev_attr_name.attr,
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..807642da12f7 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -47,6 +47,8 @@ struct pps_device {
 
 	__u32 assert_sequence;			/* PPS assert event seq # */
 	__u32 clear_sequence;			/* PPS clear event seq # */
+	struct pps_ktime assert_elapsed_tu;	/* PPS elapsed rt assert seq # */
+	struct pps_ktime clear_elapsed_tu;	/* PPS elapsed rt clear event seq */
 	struct pps_ktime assert_tu;
 	struct pps_ktime clear_tu;
 	int current_mode;			/* PPS mode at event time */
-- 
2.25.1


--000000000000a9802b05f71583c0
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
dlCTVYtojuUaRbmzA19y0yWkhdD+tvBz6ZhiadUNgctJrRB/eM/Haly51x78TAN/7VMnEWcMJOAI
VqjxmYlUuUSDPxgXnmYPrOW6BoN2Gdu8XPtl7PMaDi5hpmKwmXBjAgMBAAGjggHgMIIB3DAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCoGA1UdEQQjMCGBH2FsZXhhbmRlci5rb21yYWtvdkBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYI
KwYBBQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFPkwjpj+
FmVF/4S+Xdk0AEyqpwxWMA0GCSqGSIb3DQEBCwUAA4IBAQCb5JMXul2vbdO/cV9H0z8JwNx+fZND
3wpL+BeVFFv2+CqHQUsGXEE2RfswQsmqO2oiD5oDDaxmQf7L4Oriw+KftdjmrJdJNCcMaJmhLNVw
YQeqEpOVnI5QlzKjUEwRqBpmbP01qvCoywUk+rP3NyesFiVLnFUTeclNnsdbwsbq7E9sAaDOmqaB
RHynszy96G2ivLxlhO8mmtesGggPPO1ZtDNoRtqLhCQ3w3dJwV11auZCqJEoMHzGxc7ZWKveQZnW
VfoQxBddLcnLJHjOvhYNiZrbpyPq0sCDoJpOlFH1MaXTVRYhUOIZ/brFvlUB3I/AC9nxzt6W37L1
7ma2ySaiMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBu
di1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIM
BJ2duBPw/VvvslqDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBOgdsAJOd+oyVU
MZLRWpsSP3/L3MwBO1LZDTEoP3aEmDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzAzMTcwOTUwNThaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEA1I1z9/KYvbS/yxneg43UBjcTclK8RCug
c8ZXxbw5jvAEKlbZAi702gIFi3c/fbeVTEarML5dZGD7/axf81cPVqbnLUhlDRvvdGlnCzhBD78d
/n6EN97z07WLEJZcCa2Jz5ZSTNlafGb9TUMeM9AR8bgdUoSg2Ofs9fMq5nqBXPm20H22PpteVT9M
dcW6lvzD4A3x/9vtQRCQzwgi110hzC3zWHY8Ue5RBExrlqWMgQ2MZkGJNep4sOibm/W/Wu1YpykE
46MTgjWpnTNM8bMQPmMEYHAnSDsAQO7YtagKIoVZEug3grtFlueMVHJ+6X9E0w+paiBhZvwe5vTR
Lb+GHQ==
--000000000000a9802b05f71583c0--
