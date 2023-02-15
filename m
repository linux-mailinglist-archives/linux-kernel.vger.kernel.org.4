Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B16981AB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 18:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjBORMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 12:12:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbjBORMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 12:12:32 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31ECA25B85
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 09:12:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5F96B8231D
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 17:12:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1323DC433D2;
        Wed, 15 Feb 2023 17:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676481148;
        bh=MnTXXCrHB8q0dm2TiMdq46pcPd1e+WyWRchO1UVIneM=;
        h=From:Date:Subject:To:Cc:From;
        b=gErMUGavKVhpeh61yCAbqALnRBmTxJvZ72Au68l86Fezdkm8wLEDM6pFITxISAz6o
         +zsH1JFWOB+tg3EYzrqltMaLmlXNXO3osAJ/3rMjEyJMVM/3rEpupBGxdN74ew63V2
         QQrljTw9WqaAzI+zfgxuIoIkF9gHWxApqBXJiOGp1xwwrWbCvN4m2R82zomqZ3W5Ur
         px0muhmpjRk7VUxr/IV84YfwU7kVU+1+QlcfVQrIe4C7Yv8wrZCVQ7cqLlEY6KzAK2
         SUDamUI0eJdFWKeNofWuJmd15TnCsX6x48PA/ElFHGmqmFDQJ+79FNU/+XPnrQO9F/
         VX30YfAM384iQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Wed, 15 Feb 2023 10:12:12 -0700
Subject: [PATCH] macintosh: windfarm: Use unsigned type for 1-bit bitfields
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230215-windfarm-wsingle-bit-bitfield-constant-conversion-v1-1-26415072e855@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGsS7WMC/x2OwQqDMBBEf0X23AVNbA/9ldJDNBtd0LXsBi2I/
 96kh4EZhnnMCUbKZPBsTlDa2XiTErpbA+McZCLkWDK41vnWdXc8WGIKuuJhLNNCOHCuSkxLxHE
 Ty0FyNTtppaF3faL4IOd7B4U7BCsrDTLOlbwGy6S1+Cgl/v7PvN7X9QO+MPwNnAAAAA==
To:     mpe@ellerman.id.au, benh@kernel.crashing.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2498; i=nathan@kernel.org;
 h=from:subject:message-id; bh=MnTXXCrHB8q0dm2TiMdq46pcPd1e+WyWRchO1UVIneM=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDMlvhar1c1ZPa7g0ZXWNysufTnWLfOMOLJF790ivuTjgh
 7/SzUmHO0pZGMQ4GGTFFFmqH6seNzScc5bxxqlJMHNYmUCGMHBxCsBETLgY/ik7v7EsmLOS0Xs7
 14LFp7nnaDEoz2QUFSlrkt2ny3K2rI2R4ejNOSxll69yq7Srct7dmHH4S5hrlpzXz55D924E6d0
 9zgsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang warns:

  drivers/macintosh/windfarm_lm75_sensor.c:63:14: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
                  lm->inited = 1;
                             ^ ~

  drivers/macintosh/windfarm_smu_sensors.c:356:19: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
                  pow->fake_volts = 1;
                                  ^ ~
  drivers/macintosh/windfarm_smu_sensors.c:368:18: error: implicit truncation from 'int' to a one-bit wide bit-field changes value from 1 to -1 [-Werror,-Wsingle-bit-bitfield-constant-conversion]
                  pow->quadratic = 1;
                                 ^ ~

There is no bug here since no code checks the actual value of these
fields, just whether or not they are zero (boolean context), but this
can be easily fixed by switching to an unsigned type.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/macintosh/windfarm_lm75_sensor.c | 4 ++--
 drivers/macintosh/windfarm_smu_sensors.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/macintosh/windfarm_lm75_sensor.c b/drivers/macintosh/windfarm_lm75_sensor.c
index 24f0a444d312..9c6febce2376 100644
--- a/drivers/macintosh/windfarm_lm75_sensor.c
+++ b/drivers/macintosh/windfarm_lm75_sensor.c
@@ -33,8 +33,8 @@
 #endif
 
 struct wf_lm75_sensor {
-	int			ds1775 : 1;
-	int			inited : 1;
+	unsigned int		ds1775 : 1;
+	unsigned int		inited : 1;
 	struct i2c_client	*i2c;
 	struct wf_sensor	sens;
 };
diff --git a/drivers/macintosh/windfarm_smu_sensors.c b/drivers/macintosh/windfarm_smu_sensors.c
index 00c6fe25fcba..2bdb73b34d29 100644
--- a/drivers/macintosh/windfarm_smu_sensors.c
+++ b/drivers/macintosh/windfarm_smu_sensors.c
@@ -274,8 +274,8 @@ struct smu_cpu_power_sensor {
 	struct list_head	link;
 	struct wf_sensor	*volts;
 	struct wf_sensor	*amps;
-	int			fake_volts : 1;
-	int			quadratic : 1;
+	unsigned int		fake_volts : 1;
+	unsigned int		quadratic : 1;
 	struct wf_sensor	sens;
 };
 #define to_smu_cpu_power(c) container_of(c, struct smu_cpu_power_sensor, sens)

---
base-commit: ceaa837f96adb69c0df0397937cd74991d5d821a
change-id: 20230215-windfarm-wsingle-bit-bitfield-constant-conversion-324fed6e2342

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>

