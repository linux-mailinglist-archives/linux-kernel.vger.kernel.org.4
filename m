Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B7E74BE22
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 17:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjGHPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 11:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjGHPYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 11:24:19 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7750170C
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jul 2023 08:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688829854;
        bh=vaylDKoxgIrBhavmAwyPUc47XqT+b4piq1AuB544sWs=;
        h=From:To:Cc:Subject:Date;
        b=YgcyAlTOocqbe9QZZu4elSg8GOKI4eJ2Zqt0hcL+EIExMxr91Q1s1Dt3p7zr9MLb4
         NDXpk16JfoGHZXtJjNpgt/dSeIy/U5mW1wxqLHYSYskzEyi5UUAoW4JbaefRM9kJi7
         icJQmLBMKrNOOiVspDaZy3CBiGgBhauUKe5qTyOo=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 60CB8219; Sat, 08 Jul 2023 23:24:12 +0800
X-QQ-mid: xmsmtpt1688829852tphn623yf
Message-ID: <tencent_8B518B25E46F5E6AB7B7D6C1943C0E141009@qq.com>
X-QQ-XMAILINFO: Nb13eR/nWe3kdfAIccr+AJjdMx8nZXqdwm4yqJ4hx1+VwJDAtNjzQHUvsnCWQq
         a/mYtUBOT3Qj7t5nfP/yeVBL2CL44GltSne2V+NJija/JCpoNwIAebamHgCMOmAx9/boUtM8oOCV
         ePWehB8ROI2M4KU2Hg5vOlG5O8fjSIpfpN9bWf1Nst1C2V/1/DjfPEvnbSFCqOr98ARqFXPKEJD1
         Ku1JjGZ1NprKllBizi1E75K7WqZFJkfJE/+juiAlrac0ZtGiRiavnD0ev8DYwlJxXXyY1LoRrUUP
         J5AF+O8Hxh1MzCi7rKDZ0meGipz9D4/Scel90eYdjq3D+d2vZPunL6Hzl+3EooaJupOuuTXEyFtQ
         XpwIeWPYmsw6kJLy9SFipa+qjjsQY+RT3zBC/Qc9e4SI2Li5vTmvT7T5j31wOnEVyuA2VZ/OUmHE
         /zuQ+s0FIhE0Ek1MkSleHu7MgE9IiN3EwEnga4nFebPcfj9AVb3Y+487lgtzw/mFq9I9NsbWOpZi
         DCr+cEd2q118pfo4LiI6Ge2G1cnj7ko1Xybo0SvH8IhmVaF62yetOcwlVU+RyvAB6DJZTLlBVFFN
         NGwj0HsBSkiOkpFlJeYERhTp9lGXG7TEcyRVsiK6UMamYcmDj+8zJpsrmc/sDQY0lk8WViwL681d
         j0nCTHfDJDOwDKf5PdDM+uimQEoFOqQR/g1Pzgsvyuv71AuEXLs2d2zB4mUkt26v27pqnc4m0KVF
         WRwbqGOY4NUwExMaJe81D1c4Z31bTYGeo7B4aQnOvFdqPuKar41faaH1sy7Wg+x3YnsN/E+WAnrr
         vYvpobxbeShuX0wBXKdNJbwnDHvjUvk6LYn48e6QmD1AyLdggSMVRTGoeaMc02hUa/ExZM72FmKI
         rJeoVGCfILLaEW7f0cIRBbGUBCz7eS21IANNqcqT8ysrNEMEEzdQYpAtfjdwSRfaRfp8awqRtam2
         ei2uXs8SG+u/tjNntAhTG40VDvR2UQNKn9w/5lYL8ABjszfcTN3YOy7yOZck4duFBUpEHtgrsh+n
         nwcnZ8jQ==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] media: af9005: Fix null-ptr-deref in af9005_i2c_xfer
Date:   Sat,  8 Jul 2023 23:24:11 +0800
X-OQ-MSGID: <20230708152411.3694672-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In af9005_i2c_xfer, msg is controlled by user. When msg[i].buf
is null and msg[i].len is zero, former checks on msg[i].buf would be
passed. Malicious data finally reach af9005_i2c_xfer. If accessing
msg[i].buf[0] without sanity check, null ptr deref would happen.
We add check on msg[i].len to prevent crash.

Similar commit:
commit 0ed554fd769a
("media: dvb-usb: az6027: fix null-ptr-deref in az6027_i2c_xfer()")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/media/usb/dvb-usb/af9005.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/usb/dvb-usb/af9005.c b/drivers/media/usb/dvb-usb/af9005.c
index 0827bf3d4e8c..13604e6acdb8 100644
--- a/drivers/media/usb/dvb-usb/af9005.c
+++ b/drivers/media/usb/dvb-usb/af9005.c
@@ -422,6 +422,10 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 		if (ret == 0)
 			ret = 2;
 	} else {
+		if (msg[0].len < 2) {
+			ret = -EOPNOTSUPP;
+			goto unlock;
+		}
 		/* write one or more registers */
 		reg = msg[0].buf[0];
 		addr = msg[0].addr;
@@ -431,6 +435,7 @@ static int af9005_i2c_xfer(struct i2c_adapter *adap, struct i2c_msg msg[],
 			ret = 1;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 	return ret;
 }
-- 
2.30.2

