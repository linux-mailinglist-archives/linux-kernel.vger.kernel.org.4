Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90F06DCE87
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 02:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjDKAjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 20:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjDKAjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 20:39:43 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980F5269E
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:39:42 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so11593062pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 17:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1681173582;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DchW70QoPX3pGKCfRid9SEWcjX4QCHK98jYufnmuBXY=;
        b=W6YK9olDTSTk1vCyRaInO+oFjXBKLBLbA6TObDQCEADXnIRwUec1oXbMhzmNBR9zp1
         AjNZN+qUKWP87f5zojz0CnzCG+IvryWqIWyZH49qtrvRl+9nCRWEpXHW6AUADsv37mFQ
         SW5oJhsE0QGgEDKP3ZDF0xnhuoWpb7F52xHH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681173582;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DchW70QoPX3pGKCfRid9SEWcjX4QCHK98jYufnmuBXY=;
        b=uoAs2s+Wv4EcDigekVg/sAbKtGO5nmYlVUt4v+aGuX5xSus3SSFCS4uJO23NCTZvsc
         FnjhnwxW0nyRkoe/ZzfTLAngwYxwg9aMHPIloMeylW0+dfqBGlg5g2n9j9kMerGNnuIK
         LBo5v/UjYxULEecd902pyVuJU0fCZUhA6Psv3z7HRAxddQazhRbecWKFMTleZ2NUCQbB
         B6XFlxIe18RbmnM4fAfwCcu77hnxF/aP9WvBO3kCWZsbrjt6A/4al5EHQHAfXFQ3OQCu
         NsazRZvBHK7iXdcOk7SVsX4dW7JGodz3eT78CwGrkStlBzoRa4+ndsWvOZNCugLbsHHW
         68wg==
X-Gm-Message-State: AAQBX9dXsQU9um81r3pcov4BJlteWjYPMx7atkpDcNsb0VrIGpMh+f95
        6ApeHp7H6b8L6zelW4gk+LqpX2lqA33Ny88ugtN6lwlfoLpLJfBp43DK8vjxu18P1MDdd2d/RvH
        XWqVIubfMaB+/U+nMiB0DtUhGMn+TKSWMl5ShvpnTKhqNCG9+jhldeC1vCz3oN/2ohbksV215iN
        EjhT3eE099DfaYce1+BcTg
X-Google-Smtp-Source: AKy350ZypkVR58hytI/GgT+2yPdKrL/A8FTDWRqFhyiMYQrDjdsdp13iAApoCh6vdQA+7HzdPXsS7g==
X-Received: by 2002:a17:902:db10:b0:19a:b754:4053 with SMTP id m16-20020a170902db1000b0019ab7544053mr21313846plx.26.1681173581514;
        Mon, 10 Apr 2023 17:39:41 -0700 (PDT)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id x6-20020a63aa46000000b0050f9b7e64fasm7570525pgo.77.2023.04.10.17.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 17:39:41 -0700 (PDT)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, gregkh@linuxfoundation.org,
        Alexander Komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH v6] pps: Add elapsed realtime timestamping
Date:   Mon, 10 Apr 2023 17:39:53 -0700
Message-Id: <20230411003953.519629-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002a73ed05f904bac4"
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002a73ed05f904bac4
Content-Transfer-Encoding: 8bit

Some applications like Android needs elapsed realtime timestamping
to PPS pulse for its clock management. Add sysfs node for this.

Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
---
Changes in v6:
  - Removed "staging",wrap changelog text at 72 columns
  - clock_gettime removed, trailing whitespaces removed 
  - <tab> added, extra spaces removed
  - Rename sprintf() to sysfs_emit() 
  - "Real-time assert event" info added to driver-api/pps.rst
  - new entries were moved below the main pps entry
  - Use pps/ppsX/ instead of pps/pps0/

 Documentation/ABI/testing/sysfs-pps | 27 +++++++++++++++++++++++
 Documentation/driver-api/pps.rst    | 19 ++++++++++++++++
 drivers/pps/kapi.c                  | 24 +++++++++++++++++---
 drivers/pps/sysfs.c                 | 34 +++++++++++++++++++++++++++++
 include/linux/pps_kernel.h          |  2 ++
 5 files changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-pps b/Documentation/ABI/testing/sysfs-pps
index 25028c7bc37d..ac5051059fc3 100644
--- a/Documentation/ABI/testing/sysfs-pps
+++ b/Documentation/ABI/testing/sysfs-pps
@@ -71,3 +71,30 @@ Description:
 
 		If the source is not connected with any device the content
 		of this file is empty.
+
+What:		/sys/class/pps/ppsX/assert_elapsed
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


--0000000000002a73ed05f904bac4
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
BJ2duBPw/VvvslqDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCMtRWIqu08kwzx
C2H+E/kuHD1guippD4qFVYFu9kUKEDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzA0MTEwMDM5NDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAwNOgxBg325HF9jDpCGNuQsxXhPwVpOaj
ghid2Zzr11bp0eTS6f9yni9OtT8iw+Ck06jLNIX2IYnDMmFEHHka1rZ7UxhdZGyutEcDakCrIwEb
OrSCe20Q5jGoMR/v7jZ/rXvvyGqnznVKpeE/GZ71lD4h0Ny7cYvs9HktlJbaFaipeqR9u2vzHXUy
w4fzixHX2k/O3Y8qideMc9R4uww9bA6WcWOu1dUYMPt2y5YYtZIhomrtq9OkY9w3weCpsfkJe9SJ
fYTeZ5VKQdaX00HTQyu0qUJUwWLeCc6mNcoXUzagrC0NjI5NDwNcx+BhgBr0/prZlZdmGc6YjtgA
vzj0hA==
--0000000000002a73ed05f904bac4--
