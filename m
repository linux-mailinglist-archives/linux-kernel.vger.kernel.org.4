Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3C71116F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 18:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjEYQzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 12:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240570AbjEYQyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 12:54:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D479E198;
        Thu, 25 May 2023 09:54:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AB9A60E08;
        Thu, 25 May 2023 16:54:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6FEC433D2;
        Thu, 25 May 2023 16:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685033684;
        bh=b/kcNC1mTxOUZ8PoUr6DD3ar+AE8iZC0VPz7vvk8tD0=;
        h=Date:From:To:Cc:Subject:From;
        b=qZfvRBE3zCT2iw7jN4UFkM8SmL6iiCIqK252yGnvskmxmzTjCK3+SAbmA8bOYuLxX
         aZKYWKY5nHfUAXaVMoxB5S+azrEzO+oUgWM5xTvlcu2EIwiPGee7UeNHr/cEqU9ZOq
         b66kGuxiJdLPktnzRthBnF8Rcm2YfvR4eDs/k0CKQ8FXiJr2wTGrd7/Pac0CqmfFqX
         gqtpa3Qk34BunwMJ/wVtZXsmXSMPGDz4tYOGKTcYLtu3UrxOlBL5heHCnNluPueNxx
         RaG4TzhmkeC/m/cYK3rYCnRKF07ZB7a9FREKK0OfB9+OVPc8jl7wDk5p2mGxkEdnik
         cpdpJlCuY4/ag==
Received: by mercury (Postfix, from userid 1000)
        id 631561060A3F; Thu, 25 May 2023 18:54:42 +0200 (CEST)
Date:   Thu, 25 May 2023 18:54:42 +0200
From:   Sebastian Reichel <sre@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [GIT PULL] power-supply changes for 6.4-rc
Message-ID: <20230525165442.lnltc55c6ivirtub@mercury.elektranox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="enjxfv2xgm7zhka3"
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--enjxfv2xgm7zhka3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/sre/linux-power-supply.git tags/for-v6.4-rc

for you to fetch changes up to 95339f40a8b652b5b1773def31e63fc53c26378a:

  power: supply: Fix logic checking if system is running from battery (2023-05-16 23:02:56 +0200)

----------------------------------------------------------------
Power Supply Fixes for 6.4 cycle

Fixes for the 6.4 cycle:
 * Fix power_supply_get_battery_info for devices without parent
   devices resulting in NULL pointer dereference
 * Fix desktop systems reporting to run on battery once a power-supply
   device with device scope appears (e.g. a HID keyboard with a battery)
 * Ratelimit debug print about driver not providing data
 * Fix race condition related to external_power_changed in multiple
   drivers (ab8500, axp288, bq25890, sc27xx, bq27xxx)
 * Fix LED trigger switching from blinking to solid-on when charging
   finishes
 * Fix multiple races in bq27xxx battery driver
 * mt6360: handle potential ENOMEM from devm_work_autocancel
 * sbs-charger: Fix SBS_CHARGER_STATUS_CHARGE_INHIBITED bit
 * rt9467: avoid passing 0 to dev_err_probe

----------------------------------------------------------------
ChiaEn Wu (1):
      power: supply: rt9467: Fix passing zero to 'dev_err_probe'

Daisuke Nojiri (1):
      power: supply: sbs-charger: Fix INHIBITED bit for Status reg

Hans de Goede (15):
      power: supply: ab8500: Fix external_power_changed race
      power: supply: axp288_fuel_gauge: Fix external_power_changed race
      power: supply: bq25890: Fix external_power_changed race
      power: supply: sc27xx: Fix external_power_changed race
      power: supply: leds: Fix blink to LED on transition
      power: supply: bq27xxx: Fix bq27xxx_battery_update() race condition
      power: supply: bq27xxx: Fix I2C IRQ race on remove
      power: supply: bq27xxx: Fix poll_interval handling and races on remove
      power: supply: bq27xxx: Add cache parameter to bq27xxx_battery_current_and_status()
      power: supply: bq27xxx: Move bq27xxx_battery_update() down
      power: supply: bq27xxx: Ensure power_supply_changed() is called on current sign changes
      power: supply: bq27xxx: After charger plug in/out wait 0.5s for things to stabilize
      power: supply: bq27xxx: Use mod_delayed_work() instead of cancel() + schedule()
      power: supply: bq25890: Call power_supply_changed() after updating input current or voltage
      power: supply: bq24190: Call power_supply_changed() after updating input current

Huacai Chen (1):
      power: supply: Fix power_supply_get_battery_info() if parent is NULL

Kang Chen (1):
      power: supply: mt6360: add a check of devm_work_autocancel in mt6360_charger_probe

Marek Vasut (1):
      power: supply: Ratelimit no data debug output

Mario Limonciello (1):
      power: supply: Fix logic checking if system is running from battery

 drivers/power/supply/ab8500_btemp.c        |   6 +-
 drivers/power/supply/ab8500_fg.c           |   6 +-
 drivers/power/supply/axp288_fuel_gauge.c   |   2 +-
 drivers/power/supply/bq24190_charger.c     |   1 +
 drivers/power/supply/bq25890_charger.c     |   5 +-
 drivers/power/supply/bq27xxx_battery.c     | 181 ++++++++++++++++-------------
 drivers/power/supply/bq27xxx_battery_i2c.c |   3 +-
 drivers/power/supply/mt6360_charger.c      |   4 +-
 drivers/power/supply/power_supply_core.c   |  15 ++-
 drivers/power/supply/power_supply_leds.c   |   5 +-
 drivers/power/supply/power_supply_sysfs.c  |   3 +-
 drivers/power/supply/rt9467-charger.c      |   2 +-
 drivers/power/supply/sbs-charger.c         |   2 +-
 drivers/power/supply/sc27xx_fuel_gauge.c   |   9 +-
 include/linux/power/bq27xxx_battery.h      |   4 +
 15 files changed, 136 insertions(+), 112 deletions(-)

--enjxfv2xgm7zhka3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRvktIACgkQ2O7X88g7
+pqgDA//WAUAILRGRhZ8clOyhjItdJRn6Op3+rARg1DvRby/uKW+CLUHAkJ3EgLk
ILJGSpXDbaoMFlcMRxv24QkUE9IEiZ/8043Jm77cHNfOL1dcdWWGw1YvylOIbIkX
cXUNi6OZF3KVbviPvlncETx9cxGPkMlz34aqtP92iT+wMPNouji1rhUiLpC8PVcT
xN+8cou8NOYZHFubA9sHTTgA26VYI2b2Zl6B1ssfqlREMOOH899WlgaCwW1sXRvm
MKmYmlkdck/B3xg/NLIXCT5iczNx400X/a0fukXkPktH8uK3VtRalopfB5roRYPK
V3HIjKMGSF0fNdeJ/3h5AaiYWYKvmOvKKruFHBAY6+37uNwDmKusSP+UYteqXqH4
C0iRtj1UDl51M2UPv7z/xXxa3BUD5/Fvep2Xdd3Fknpm1HcNdlrgz9OF0epAe8Ky
ZU7uyz3wToEY9ZtmUzpsP31IDo9IyJQmyauQ1RvBCsoNlYPR2ZfFek5kpgTa/uvB
YeMVyxzMBOuay3Gm4ra+hTRSm5f4txLpwlh47+jNt+fiQ7KUiG/i4bSg04IU04iQ
b4+9u1cqsfloYm7fDeSSbisVkEDC+e4tzylr+sXuMRaYDdGXJ9K0ZiefXPruvtG1
p4v28gphHOk3v0GKd71Lr6onqlou1VwU88GtWh0iMUbdDv/r0JA=
=hJcO
-----END PGP SIGNATURE-----

--enjxfv2xgm7zhka3--
