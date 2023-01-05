Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE96765EE9D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 15:19:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232696AbjAEOTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 09:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAEOTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 09:19:39 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB55159309;
        Thu,  5 Jan 2023 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672928363; bh=jGqmtBpJFhDWl3+/3Q4iGUyNOyvE0pOn9VoLM3cxvNw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=aWJVKi4kKq3+bkujuqlXXDtH7qS4s3vkkFJEWa9769Jkh5Cf2ypqHSTrq/Pl6pJBl
         atVy7ORdW45o2dl+uSRizAjHeoj7JlPKYcslC3XdyE8VY+Rwrm6BB0csraFjJLegbG
         4RbwWSq/kEl2BnAMv1h27+2SuCVkpG34zHwscQYJjvbvV7CqbZVhF+agn7Ob+jmMr/
         od29xWBwuxH2rgBdsTJIiTxr9xJ8UqvoRk/vb5puVxY+RA2t+Z7paGoJ55sajSxtAD
         q465h8yKJstcaG0CvOV51DJWnWXm/Y9UXLxr+Sd92Til7sXtmqA05zAo0TzTcdtifJ
         LoPDh1olt4s8Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MiacH-1oYJBN3kzn-00fjNy; Thu, 05 Jan 2023 15:19:22 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] hwmon: (ftsteutates) Add support for fanX_fault attributes
Date:   Thu,  5 Jan 2023 15:19:11 +0100
Message-Id: <20230105141911.8040-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105141911.8040-1-W_Armin@gmx.de>
References: <20230105141911.8040-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Wr0zOroG7LIq3kzpUYWfHXGxFxEa/RaUBdqfrpGwrccgs0UGXXt
 HDhhPIXJEACq3foul9FLFSqXgc9ValFo4665jsijaQrhIQbAxzhrVmEV4HetlcKIQJ6IMG7
 G+6YJBULJ16KHXVvBZGdSNLRU2oZY3oYHVd7d/S4i6Wg2Rfj+JgMsC3m3GMWute19CVHBPC
 XIJUTFWf/1z9qOoRxAWVA==
UI-OutboundReport: notjunk:1;M01:P0:A1D8S5zeCd8=;lItq4H59LTBZ4+5unBI3q1Orly9
 uYDYG1TVcmrTxWR7ISzl467UK+QTFN6F/98d4GOLq1//X9zfjdv9zX1QcCVVWKU9+aGwzmmxk
 URbsY1oiMyAz+NVrGVFuhimRH0Ic43bgFmSERrtyVdvHPO+QNWBufquGtkRNkyppBd+dkmJFm
 cUC1NFCXiVjuXyp9IItX5XWpRextp4qnjJiTJZUXPltMxMO72mYZKvbI8MzQ04YNdOwdOHLG8
 OsGK0NiD1EZLof9MbqrZ6fE5uyD0LdA0UZwIK3w6YEnfVTvqsAghe3Bq4jplfX0CSR+/KXu+N
 CehZiqP90vPK+qb6H3u/2dp3jfz66tZTqV9/rQ/QuMm3qLR0WrasqvvaVfA4FSU8Qj2arKcXI
 xBO4DG3Lu26fJWfXDaJj2vWBIHtZYyq1M4lL3jXc4bJk82gmmpvGZF9DzGxON3HpXdAFdmGV+
 Q2ZVJ6AC45AaVrO/k7uT3m0eAwTwPdKePZzV55043wU26bZYxE7lWl3Z94D/zVQHyP+aIO9kQ
 n4nk4IEc3NGVIx2bAOYnxUQPQ2FJm6ia0A2WPu4j80El7UICwgDSJkMHORsaMoRDpGyi4PGV0
 eBMg4rx1tZ3bmv3M29hJuE6mDqVKPlAB4FhzwSk9AaDwAPwLjfKL4Q70U6/8x5I1aHV7RY0hj
 6E8OBtAP7CWvnfCHhJ1tKbzO5EEkCyQsglo+V/3RBanv56351LTph2JV13rI7iRA7F1mW5rSO
 nm9s3Rr8ieVI31dFfWaL3d6Y1pIsqAD17rKE0jvXv8NfaEWAzUYeABOH3szyfyhH/zGv1dyf4
 xJ2fYIMrKfBAVBR5xaGj5FwwOIkdFm0s3s6GeVAwxRiTDQ44QRrsW/x0v7l17ZiR/gTXCXhjl
 jpR++DFl+OQs0Vze12j7j4Rv0wTlPsxQYPg9xOldizTrZ4GtLl04PCyCH/K0UEHKiZCA1jaN8
 Ue/reQKfj3mfH/MPt6e9XgQXcxA=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver knows internally when a fan is not connected,
but does not export this knowledge to userspace. Use the
standard fanX_fault attributes to notify userspace if a
fan is not connected.

Tested on a Fujitsu DS3401-B1.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/hwmon/ftsteutates.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/ftsteutates.c b/drivers/hwmon/ftsteutates.c
index 0d8ab94250a9..25afd9167a34 100644
=2D-- a/drivers/hwmon/ftsteutates.c
+++ b/drivers/hwmon/ftsteutates.c
@@ -356,6 +356,7 @@ static umode_t fts_is_visible(const void *devdata, enu=
m hwmon_sensor_types type,
 	case hwmon_fan:
 		switch (attr) {
 		case hwmon_fan_input:
+		case hwmon_fan_fault:
 			return 0444;
 		case hwmon_fan_alarm:
 			return 0644;
@@ -411,6 +412,10 @@ static int fts_read(struct device *dev, enum hwmon_se=
nsor_types type, u32 attr,
 		case hwmon_fan_alarm:
 			*val =3D !!(data->fan_alarm & BIT(channel));

+			return 0;
+		case hwmon_fan_fault:
+			*val =3D !(data->fan_present & BIT(channel));
+
 			return 0;
 		default:
 			break;
@@ -536,14 +541,14 @@ static const struct hwmon_channel_info *fts_info[] =
=3D {
 			   HWMON_T_INPUT | HWMON_T_ALARM | HWMON_T_FAULT
 			   ),
 	HWMON_CHANNEL_INFO(fan,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM,
-			   HWMON_F_INPUT | HWMON_F_ALARM
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT,
+			   HWMON_F_INPUT | HWMON_F_ALARM | HWMON_F_FAULT
 			   ),
 	HWMON_CHANNEL_INFO(pwm,
 			   HWMON_PWM_AUTO_CHANNELS_TEMP,
=2D-
2.30.2

