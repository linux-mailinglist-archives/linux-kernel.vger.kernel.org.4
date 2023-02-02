Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187568832F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbjBBPzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:55:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233065AbjBBPyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:54:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C3C717149;
        Thu,  2 Feb 2023 07:54:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A567461BF3;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF4FC4339C;
        Thu,  2 Feb 2023 15:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675353284;
        bh=QetgjlA8zQgsGiz0MLws4l3SIlHob8bLKbL8vJ5tNew=;
        h=From:To:Cc:Subject:Date:From;
        b=BHgy+90mKYUKLrJgdCiF6NF8ePTATmbJjaNoD/zl5Xg2lUMzU0ic916Zm3NFrHMdd
         el7J5Vl3ser/FWC6d6c6xZiVYrX28fZjK3QZSgdJ0X3swcP12DLUHhn8TJJ1AeakAZ
         YW5xbUvQi5ZgYWL4cAa7TRgq9RWGwYEXWsHqICVdWiGG8vYMWgHH0Uyb4zcgMe/Kgd
         tshX4MwU9kudk4PXJkLN6zqFCEXemumxZZwspkJzk8bEaf7b3qceAnscU2DGx5Ss+8
         b69ysCKdjXw0zK0Pcd1r1/Q0JN+REX9PF96NzxZYebbSHpJJAB7VdzZ70r5C33MYAH
         ED2I+1NWKzUzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pNbvY-0001lh-EU; Thu, 02 Feb 2023 16:55:08 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 00/22] rtc: pm8xxx: add support for setting time using nvmem
Date:   Thu,  2 Feb 2023 16:54:26 +0100
Message-Id: <20230202155448.6715-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for setting the RTC time on Qualcomm platforms
where the PMIC RTC time registers are read-only by instead storing an
offset in some other non-volatile memory. This is used to enable the RTC
in the SC8280XP Compute Reference Design (CRD) and Lenovo Thinkpad X13s
laptop.

The RTCs in many Qualcomm devices are effectively broken due to the time
registers being read-only. Instead some other non-volatile memory can be
used to store and offset which a driver can take into account. On
machines like the X13s, the UEFI firmware (and Windows) use a UEFI
variable for storing such an offset, but not all Qualcomm systems use
UEFI.

The Qualcomm firmware also does not support any UEFI runtime services,
but Maximilian Luz recently posted a driver for talking to the secure
world directly through the SCM interface and this can be used to access
the UEFI variables:

	https://lore.kernel.org/all/20220723224949.1089973-1-luzmaximilian@gmail.com/

I was initially told that the PMICs in the X13s did not have any spare
battery-backed registers which could have been used to store an RTC
offset so there seemed to be no alternative to try using the UEFI
offset. In the processes however, I learnt that there are in fact some
registers in PMIC that could be used, at least on the SC8280XP CRD and
the X13s. 

This was especially fortunate as it turned out that the firmware on the
CRD I have does not allow updating the UEFI RTC offset even if this
works on the X13s (and on a second CRD with more recent firmware I
learned last week).

As the benefit of sharing the RTC offset with the UEFI firmware (and
Windows) is rather small (e.g. to make sure they never get out sync), I
instead opted for using the PMIC registers on both machines. This also
avoids relying on a fairly complex reverse-engineered firmware driver,
as well as potential issues like flash wear due to RTC drift. Let's keep
it simple.

But as there could be older Qualcomm UEFI machines out there where we
don't have any other non-volatile storage I included the UEFI patches
as an RFC in v1 of this series for reference. In case it turns out there
are systems out there were this could be used (e.g. the Lenovo Yoga C630
laptop) those two patches could be merged as well. An alternative could
be to see if Maximilian's work could be extended to access the time
services directly.

This series first fixes a few issues with the current Qualcomm PMIC RTC
driver before cleaning it up a bit so that support for setting the time
using an offset stored in an nvmem cell can be added.

The final patches enables the RTC on the SC8280XP CRD and X13s and can
be merged by Bjorn once the (non-UEFI) RTC patches are in.

Note that for the SDAM nvmem driver to be autoloaded when built as a
module, you also need this fix:

	https://lore.kernel.org/lkml/20230126133034.27491-1-johan+linaro@kernel.org/

Johan


Changes in v2
 - replace nvme operation dev_err() with dev_dbg() (Alexandre)
 - squash patch adding copyright entry with patch adding nvme support
   (Krzysztof)
 - drop last two dev_err() (new patch)
 - amend dts commit message as setting variables appears to work on some
   CRD
 - drop the two UEFI RFC patches for now due to one EFI dependency not
   yet in mainline and on-going binding discussion

Johan Hovold (22):
  rtc: pm8xxx: fix set-alarm race
  rtc: pm8xxx: drop spmi error messages
  rtc: pm8xxx: use regmap_update_bits()
  rtc: pm8xxx: drop bogus locking
  rtc: pm8xxx: return IRQ_NONE on errors
  rtc: pm8xxx: drop unused register defines
  rtc: pm8xxx: use unaligned le32 helpers
  rtc: pm8xxx: clean up time and alarm debugging
  rtc: pm8xxx: rename struct device pointer
  rtc: pm8xxx: rename alarm irq variable
  rtc: pm8xxx: clean up comments
  rtc: pm8xxx: use u32 for timestamps
  rtc: pm8xxx: refactor read_time()
  rtc: pm8xxx: clean up local declarations
  rtc: pm8xxx: drop error messages
  dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell offset
  rtc: pm8xxx: add support for nvmem offset
  arm64: defconfig: enable Qualcomm SDAM nvmem driver
  arm64: dts: qcom: sc8280xp-pmics: add pmk8280 rtc
  arm64: dts: qcom: sc8280xp-pmics: add pmk8280 sdam nvram
  arm64: dts: qcom: sc8280xp-crd: enable rtc
  arm64: dts: qcom: sc8280xp-x13s: enable rtc

 .../bindings/rtc/qcom-pm8xxx-rtc.yaml         |  12 +
 arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  15 +
 .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  15 +
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  18 +
 arch/arm64/configs/defconfig                  |   1 +
 drivers/rtc/rtc-pm8xxx.c                      | 533 +++++++++---------
 6 files changed, 324 insertions(+), 270 deletions(-)

-- 
2.39.1

