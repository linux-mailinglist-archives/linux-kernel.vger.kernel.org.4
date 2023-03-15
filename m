Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A1A6BA451
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 01:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCOAwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 20:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCOAw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 20:52:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5165BCA1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id h11-20020a17090a2ecb00b00237c740335cso227891pjs.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 17:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678841542;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HWvw/Z4J7DW17S7wIsg2UZsniVXYaOHOKM9++ZIrdXA=;
        b=PkXVpwd4rK52XJ3BEhsjrijYir88cnebSe9k/K16FCcDiyRqNkzVyKRBpasjT7gqjw
         JvQOC4bGjcxTu2BCag1MPEfvTgTBGHsSTaoH6vO1Xu3zcYyvuoC3+g8DTEy0O7gqP43a
         cZMmfISc2kg9MuI96VYylAnkzp6ziqbz6ko20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678841542;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HWvw/Z4J7DW17S7wIsg2UZsniVXYaOHOKM9++ZIrdXA=;
        b=pRGwcqJPOBONb7a2SofTxR0G+D7qUsbeGIoFNeGWUkivk9d5QtDk1HtTgF0l+hc+Qr
         +oa0I3/SdGRZy288BLyXLySqaxLMuv81s/8Sk1s80ar1ULLn0nqEhS8RdYA2aPUDKMki
         vm2ooXwPUwPzg4csSbupch1NRUD1+y8H4+CxyVbvTfI1MIOcsENHXjkd6ryf8UrPFHxZ
         AurPiZQBsdiMvYNVn04sUfoKqNpPk3DLjcIZczgKvb6+EFL7uw3UHmN/8wFqvvuzhflN
         EQMtBDMkI9n+JyHYdoQP95freqp9k0k4hMYNg+1m9cN2v1IGkM05/mkDjmzqyw0DlODx
         MEJw==
X-Gm-Message-State: AO0yUKUrvUZtMPUUZ7BOAhhExvAGf9bih4J7yAPCz/16+TWTWYfDuB9Y
        jRrj67YLUGsZl8bhXLCQWz2y0Lk4DFwkNEiwJc5wax85hmdGSYDORsdb4X9o2req3uQDxCKcWM5
        zbyFqBUoQ5aXngwjThOYrj9MZDVvPhT8vHr4PmLSc1DtgD+ZknlHVM+LffuxpHaYha/EjKF/2Jn
        ZtFu3v1S6uPBibki3kMZErGt4=
X-Google-Smtp-Source: AK7set+g/mi4CUmMy0khxk0NxC6nO0RtSKdzHG2/Tg3rguYEXiiGdXp+xc5+HByuphn+VpvQ7nGTLQ==
X-Received: by 2002:a17:90b:4b92:b0:23d:16d6:2f05 with SMTP id lr18-20020a17090b4b9200b0023d16d62f05mr6995543pjb.22.1678841542418;
        Tue, 14 Mar 2023 17:52:22 -0700 (PDT)
Received: from ldt-sj3-komrakov.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902b28a00b001a04027e0e0sm2303108plr.258.2023.03.14.17.52.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 17:52:21 -0700 (PDT)
From:   Alexander Komrakov <alexander.komrakov@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     giometti@enneenne.com, gregkh@linuxfoundation.org,
        Alexander Komrakov <alexander.komrakov@broadcom.com>
Subject: [PATCH v3] pps: Add elapsed realtime timestamping
Date:   Tue, 14 Mar 2023 17:52:26 -0700
Message-Id: <20230315005226.80347-1-alexander.komrakov@broadcom.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000cd799205f6e5c126"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_NO_TEXT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000cd799205f6e5c126
Content-Transfer-Encoding: 8bit

Some applications like Android needs elapsed realtime timestamping
to PPS pulse for its clock management. Add sysfs node for this.

Signed-off-by: Alexander Komrakov <alexander.komrakov@broadcom.com>
---
Changes in v3:
  - Remove "staging",wrap changelog text at 72 columns and remove sysfs_emit()
  - .gittconfg updated, clock_gettime removed, trailing whitespaces remvoved
  - COONFIG_ELAPSED_REALTIME_PPS added to enable elapsed assert/clear sysfs

 Documentation/ABI/testing/sysfs-pps | 27 ++++++++++++++++++
 drivers/pps/Makefile                |  4 +++
 drivers/pps/kapi.c                  | 24 ++++++++++++++--
 drivers/pps/sysfs.c                 | 44 +++++++++++++++++++++++++++--
 include/linux/pps_kernel.h          |  2 ++
 5 files changed, 96 insertions(+), 5 deletions(-)

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
diff --git a/drivers/pps/Makefile b/drivers/pps/Makefile
index ceaf65cc1f1d..443501310445 100644
--- a/drivers/pps/Makefile
+++ b/drivers/pps/Makefile
@@ -8,4 +8,8 @@ pps_core-$(CONFIG_NTP_PPS)	+= kc.o
 obj-$(CONFIG_PPS)		:= pps_core.o
 obj-y				+= clients/ generators/
 
+ifeq ($(CONFIG_ELAPSED_REALTIME_PPS),y)
+EXTRA_CFLAGS += -DENABLE_ELAPSED_REALTIME_PPS
+endif
+
 ccflags-$(CONFIG_PPS_DEBUG) := -DDEBUG
diff --git a/drivers/pps/kapi.c b/drivers/pps/kapi.c
index d9d566f70ed1..69b432873ce7 100644
--- a/drivers/pps/kapi.c
+++ b/drivers/pps/kapi.c
@@ -23,6 +23,7 @@
 /*
  * Local functions
  */
+ #define NANOSEC_PER_SEC 1000000000 /* 10^9 */
 
 static void pps_add_offset(struct pps_ktime *ts, struct pps_ktime *offset)
 {
@@ -162,11 +163,20 @@ void pps_event(struct pps_device *pps, struct pps_event_time *ts, int event,
 	unsigned long flags;
 	int captured = 0;
 	struct pps_ktime ts_real = { .sec = 0, .nsec = 0, .flags = 0 };
+	struct pps_ktime ts_real_elapsed = { .sec = 0, .nsec = 0, .flags = 0 };
+	struct timespec64 ts64 = { .tv_sec = 0, .tv_nsec = 0 };
 
 	/* check event type */
 	BUG_ON((event & (PPS_CAPTUREASSERT | PPS_CAPTURECLEAR)) == 0);
+	/* Calculate the monotonic clock from the timespec clock and stores the result in pps_ktime format
+	   ktime_get_boottime_ts64() : because elapsed realtime includes time spent in sleep */
+	ktime_get_boottime_ts64(&ts64);
+	timespec_to_pps_ktime(&ts_real_elapsed,ts64);
 
-	dev_dbg(pps->dev, "PPS event at %lld.%09ld\n",
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
index 134bc33f6ad0..9e100e287ba7 100644
--- a/drivers/pps/sysfs.c
+++ b/drivers/pps/sysfs.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/pps_kernel.h>
+#include <linux/sysfs.h>
 
 /*
  * Attribute functions
@@ -24,11 +25,28 @@ static ssize_t assert_show(struct device *dev, struct device_attribute *attr,
 		return 0;
 
 	return sprintf(buf, "%lld.%09d#%d\n",
-			(long long) pps->assert_tu.sec, pps->assert_tu.nsec,
-			pps->assert_sequence);
+			   (long long) pps->assert_tu.sec, pps->assert_tu.nsec,
+			   pps->assert_sequence);
 }
 static DEVICE_ATTR_RO(assert);
 
+#ifdef ENABLE_ELAPSED_REALTIME_PPS
+static ssize_t assert_elapsed_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTUREASSERT))
+		return 0;
+
+	return sprintf(buf, "%lld.%09d#%d\n",
+			   (long long) pps->assert_elapsed_tu.sec,
+			   pps->assert_elapsed_tu.nsec,
+			   pps->assert_sequence);
+}
+static DEVICE_ATTR_RO(assert_elapsed);
+#endif
+
 static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 			  char *buf)
 {
@@ -43,6 +61,24 @@ static ssize_t clear_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(clear);
 
+#ifdef ENABLE_ELAPSED_REALTIME_PPS
+static ssize_t clear_elapsed_show(struct device *dev,
+			  struct device_attribute *attr,
+			  char *buf)
+{
+	struct pps_device *pps = dev_get_drvdata(dev);
+
+	if (!(pps->info.mode & PPS_CAPTURECLEAR))
+		return 0;
+
+	return sprintf(buf, "%lld.%09d#%d\n",
+			(long long) pps->clear_elapsed_tu.sec,
+			pps->clear_elapsed_tu.nsec,
+			pps->clear_sequence);
+}
+static DEVICE_ATTR_RO(clear_elapsed);
+#endif
+
 static ssize_t mode_show(struct device *dev, struct device_attribute *attr,
 			 char *buf)
 {
@@ -82,6 +118,10 @@ static DEVICE_ATTR_RO(path);
 static struct attribute *pps_attrs[] = {
 	&dev_attr_assert.attr,
 	&dev_attr_clear.attr,
+#ifdef ENABLE_ELAPSED_REALTIME_PPS
+	&dev_attr_assert_elapsed.attr,
+	&dev_attr_clear_elapsed.attr,
+#endif
 	&dev_attr_mode.attr,
 	&dev_attr_echo.attr,
 	&dev_attr_name.attr,
diff --git a/include/linux/pps_kernel.h b/include/linux/pps_kernel.h
index 78c8ac4951b5..1fecaaf4c8b9 100644
--- a/include/linux/pps_kernel.h
+++ b/include/linux/pps_kernel.h
@@ -47,6 +47,8 @@ struct pps_device {
 
 	__u32 assert_sequence;			/* PPS assert event seq # */
 	__u32 clear_sequence;			/* PPS clear event seq # */
+	struct pps_ktime assert_elapsed_tu; /* PPS elapsed rt assert seq # */
+	struct pps_ktime clear_elapsed_tu;  /* PPS elapsed rt clear event seq */
 	struct pps_ktime assert_tu;
 	struct pps_ktime clear_tu;
 	int current_mode;			/* PPS mode at event time */
-- 
2.25.1


--000000000000cd799205f6e5c126
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
BJ2duBPw/VvvslqDMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCD2Q9ds5f9o03EG
ZK7OHF4+M3UwG93GOtPQyXsFQu3s2zAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3
DQEJBTEPFw0yMzAzMTUwMDUyMjJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCG
SAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEB
BzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAW24o1dKJCpnr2aJpp+eGynI7hiTtrsDw
z6Xc8EB8a0s/4Cf3T55LWTD/2yuVgSIaEvhdWEEeW6804Bhf+L2R/KCcjKgvps/Sr4FtnaDeIjq5
NWOUNKGuvgJrvjLIRGgxmxBK79lPbrMGo56j+7IrJy1AiH8dQeTfMx81YGEwQi6YFwnPi/x2kD1e
QSoWlnzTqr1NDxdm/+pAa0tsZCCTtc3v1HXoiN4RDsd9Momgrm7ckhRqHpm09ZlYI9/XaBaRy8gq
2EVGqAhYzIeebPRcqcQ7+RdP4l34pbXJI6hULbu3zlAjQXWfYra7EwdihISWR3R3THmMsEmDnDEu
d1tx8Q==
--000000000000cd799205f6e5c126--
