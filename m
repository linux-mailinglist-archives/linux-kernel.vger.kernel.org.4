Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67FB265F70C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236322AbjAEWvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 17:51:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236273AbjAEWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 17:51:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701CB58820;
        Thu,  5 Jan 2023 14:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1672959075; bh=jGqmtBpJFhDWl3+/3Q4iGUyNOyvE0pOn9VoLM3cxvNw=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SX+53odXcOSY/gg9DN4453hhebH3D8CpXdcsg1EoQesO8lVZFFw1MOlmxLfQnmS6S
         9SKG/gIREabUvtxNbNzB6f4TOeKLuAMBxOiVr4pS1xtKLbdsdY49FaNSuV5QJViRYZ
         EMRH2UH7mUZI5EQaOnNR2HM6ZqD5t0dysMc6Ut41f6XodFH3ft24G456S+n1rqotZ7
         +zUAOJVnhJIXGLiHbGq2oyAlY+j8E8czcbJUepQr56GDCGRSUw3ljMLfSy2t3YmW6l
         zwfXLV4Y4X1nEJwMXephrlCJXZzZRREceJWSl45IMYYUK7yQeXWWXFFyLpoL2GesEU
         okwJmHUvEVStQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from esprimo-mx.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MD9XF-1p4WeY1ACP-0099E0; Thu, 05 Jan 2023 23:51:15 +0100
From:   Armin Wolf <W_Armin@gmx.de>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] hwmon: (ftsteutates) Add support for fanX_fault attributes
Date:   Thu,  5 Jan 2023 23:51:07 +0100
Message-Id: <20230105225107.58308-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230105225107.58308-1-W_Armin@gmx.de>
References: <20230105225107.58308-1-W_Armin@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1IbpAIpZxtlA3c3W6IInAlAIKGzqpBwvLzm1zc41/PnopcAoh8x
 miGWNOsjZS0vMQLkqnnwObDuIfs/eEts/k/PWIXx5Cis4X52iDH690+O8GAuDEA8sa/Oj6/
 ZZ+x3Abj9qDVnknFtlwx/jDx8Da4Rrp/1+SUFOsSn/b5Ra8sykx9q5y0rTBUlke+02kKQDP
 byOfk2kPpJaVrdQBM4t9g==
UI-OutboundReport: notjunk:1;M01:P0:RrZhXS+p/QQ=;ff2fMn08FZn1+MKmcFLfPg+uqg4
 GBjmVOf+eRtK8a4sOry9wMNFsHKBVQVlnvsNhrUHVXUDEmQfjG/xnqXrdxUOBUxQbCd4OKvvt
 wcv685P8tJo1sCDlXNUk0SuGh/xlyjt9L/0WaS7xsUq9HIeqRqcbyTjf0B8FC4rzqvIzCjuSI
 sSpmYmP0BpVvixZ4MuLOHQU1LbSF4zZFYpXAv9tmzYK4k3vLhGImKxWRzLTUoiWIzuSp6SzJN
 zm6U0dsq1maUvnoi6v0NC5j1W4KVQOxyErTvSt/QBPLnsPFC1EqNVmRcIy69g6aLf4H5j5SpW
 C9i80frIG6pcwPn6p/FBwLzELQgS47/HPH64rf5j2/dkbzDg1Br05U/dD6pp6J+Dm9Y67Pjbw
 GhjwRfuM8e4fySNAS3Ri99hwsLSCLf3Sfi22Oabxh4NsuSpH4J3YU1rfgV+X/yF09PhG/qPYO
 q6qdAxHEJf2xnawmybTXDV6pJ3TOIulW3tKVULpnGO3xv19FsLDtOg7+pPel/vInfN/bkI8hl
 JxyrhF4QXnWvQCmgF06AbwN2mrlVfSl0t8yj1iOpbkJeN7QbNv5yC/3wv+GELW8oc0Och+hgu
 uhpuBW3TSa1Z05oCSD0nZFpaDPGbSd57p1Af0oslCukEzHvjJcoaPOnFxnPMpF8mAS8XNfs9U
 CJPBgSrNkZcFNL5HVBZt2wyMdNuKJawbkJSdRBUKsBwEILPdywyIavUWM2vuW2e67ZuaUtBvG
 VP/ImIhyO8yWO/HQ81AGvyPfwzZD3d7rqU2trHYylGADgr74mIsLy/jnpfsJbaAeNTNyw93dl
 66H5v1EMXR0nKx4DZ2Q+5I4kBOMtBfjPyiLNCtyttJjOJP7CVg8l57jApGQa2tnLKKhutQ2am
 4U2bpAxaAr2SbjP7PSMU4mt+CCuJQslt+pLLnl97PPlKfjfPdfYQaLa718RPzCc6SX+QLpm75
 vODjDTmiWF3iiwEdCUwhzmZTH9U=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

