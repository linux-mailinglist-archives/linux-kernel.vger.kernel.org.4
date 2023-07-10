Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C874D3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGJKrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGJKrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:47:12 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92405B5;
        Mon, 10 Jul 2023 03:47:10 -0700 (PDT)
Date:   Mon, 10 Jul 2023 10:47:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1688986028; x=1689245228;
        bh=JUSxIhlyp5Rsy2QluQCpjPVJMXty3tKlls6ZhMmED8c=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=oGK35t+2jrXUNI7a8SJ7Is0Dge8JAq+HiFi8NW5VHDdxm6M5ZHBMmjd1QYqt27v6x
         l5TI5rV29lpRsdVb+aDSpjmTyP8ZP7QWFBmlgEmm4IA4OGmNdceNQnME2CH5Qhd6YV
         tTzMV7HPbfxlhMmcUymsZKC8K5mdWVLpbr5Yy0efHWYhYaw+tybokV5M3ZckKrcnTt
         o5gD1OKC2QDZrjz71KUtYFIOgWjSvxcMxzcRQzWpQ5GWWUqp/rpQjVmCwMf5VYVBaS
         GakmffrhJ+lWtDRMLy6VnFV3TZ3iqpF1SLth5ydmVAV6PMAh2gEnqGhFrSfeeEnkg1
         45kko/82wvJCg==
To:     linux-wireless@vger.kernel.org
From:   Harry Austen <hpausten@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Avraham Stern <avraham.stern@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Harry Austen <hpausten@protonmail.com>
Subject: [PATCH] wifi: iwlwifi: mvm: enable thermal zone only when firmware is loaded
Message-ID: <20230710104626.8399-1-hpausten@protonmail.com>
Feedback-ID: 53116287:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In iwl_mvm_thermal_zone_register(), when registering a thermal zone, the
thermal subsystem will evaluate its temperature.
But iwl_mvm_tzone_get_temp() fails at this time because
iwl_mvm_firmware_running() returns false.
And that's why many users report that they see
"thermal thermal_zoneX: failed to read out thermal zone (-61)"
message during wifi driver probing.

This patch attempts to fix this by delaying enabling of the thermal zone
until after the firmware has been loaded/initialized. It also gets
disabled when going into suspend.

Signed-off-by: Harry Austen <hpausten@protonmail.com>
---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c  | 18 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c    |  9 +--------
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/ne=
t/wireless/intel/iwlwifi/mvm/mac80211.c
index ce7905faa08f..a47d29a64dd4 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -1187,6 +1187,17 @@ int iwl_mvm_mac_start(struct ieee80211_hw *hw)

 =09mutex_unlock(&mvm->mutex);

+#ifdef CONFIG_THERMAL
+=09/* Needs to be done outside of mutex guarded section to prevent deadloc=
k, since enabling
+=09 * the thermal zone calls the .get_temp() callback, which attempts to a=
cquire the mutex.
+=09 */
+=09if (!ret) {
+=09=09ret =3D thermal_zone_device_enable(mvm->tz_device.tzone);
+=09=09if (ret)
+=09=09=09IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone (err =3D %d)\n=
", ret);
+=09}
+#endif
+
 =09iwl_mvm_mei_set_sw_rfkill_state(mvm);

 =09return ret;
@@ -1282,6 +1293,7 @@ void __iwl_mvm_mac_stop(struct iwl_mvm *mvm)
 void iwl_mvm_mac_stop(struct ieee80211_hw *hw)
 {
 =09struct iwl_mvm *mvm =3D IWL_MAC80211_GET_MVM(hw);
+=09int ret;

 =09flush_work(&mvm->async_handlers_wk);
 =09flush_work(&mvm->add_stream_wk);
@@ -1307,6 +1319,12 @@ void iwl_mvm_mac_stop(struct ieee80211_hw *hw)

 =09iwl_mvm_mei_set_sw_rfkill_state(mvm);

+#ifdef CONFIG_THERMAL
+=09ret =3D thermal_zone_device_disable(mvm->tz_device.tzone);
+=09if (ret)
+=09=09IWL_DEBUG_TEMP(mvm, "Failed to disable thermal zone (err =3D %d)\n",=
 ret);
+#endif
+
 =09mutex_lock(&mvm->mutex);
 =09__iwl_mvm_mac_stop(mvm);
 =09mutex_unlock(&mvm->mutex);
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c b/drivers/net/wire=
less/intel/iwlwifi/mvm/tt.c
index 157e96fa23c1..964d2d011c6b 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tt.c
@@ -680,7 +680,7 @@ static  struct thermal_zone_device_ops tzone_ops =3D {

 static void iwl_mvm_thermal_zone_register(struct iwl_mvm *mvm)
 {
-=09int i, ret;
+=09int i;
 =09char name[16];
 =09static atomic_t counter =3D ATOMIC_INIT(0);

@@ -707,13 +707,6 @@ static void iwl_mvm_thermal_zone_register(struct iwl_m=
vm *mvm)
 =09=09return;
 =09}

-=09ret =3D thermal_zone_device_enable(mvm->tz_device.tzone);
-=09if (ret) {
-=09=09IWL_DEBUG_TEMP(mvm, "Failed to enable thermal zone\n");
-=09=09thermal_zone_device_unregister(mvm->tz_device.tzone);
-=09=09return;
-=09}
-
 =09/* 0 is a valid temperature,
 =09 * so initialize the array with S16_MIN which invalid temperature
 =09 */
--
2.41.0


