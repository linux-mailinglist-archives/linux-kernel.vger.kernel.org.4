Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EB276DBA7D
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjDHLqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjDHLqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:46:40 -0400
Received: from pio-pvt-msa1.bahnhof.se (pio-pvt-msa1.bahnhof.se [79.136.2.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A737BE1A3;
        Sat,  8 Apr 2023 04:46:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 20A6F3F5C5;
        Sat,  8 Apr 2023 13:46:37 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: pio-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from pio-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xjSKraQ4BQ5q; Sat,  8 Apr 2023 13:46:36 +0200 (CEST)
Received: by pio-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id D42DF3F586;
        Sat,  8 Apr 2023 13:46:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 96BC595F12;
        Sat,  8 Apr 2023 11:46:35 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fu62W0fH1-mH; Sat,  8 Apr 2023 11:46:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 75C3095F0E;
        Sat,  8 Apr 2023 11:46:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 75C3095F0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954394;
        bh=aj7BJRGxp0A9WS53Fydt2hDFp/YXbSvFyWVqf4RUrfw=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=gRLb/0FOvThhlpUVXTa7QLKES++feoRYjrWJuQiSTfUngVlEKn1wrqx1TyIseDDiv
         pVeR3gaspICQAfTfMLa7sEUSa57QTurjz/K6z5beiQK/iE3YsoXTyN7Nq0Ye+oHgA3
         nczqxoJ15HWo61qgelwKAshHab6zM25mlxfJIFr0E9ns3NtJgfY/RQSyPCkjkg0mYD
         AgjkUiH2XCFt7x5Vkp5r7MEYXwAHPIO9L7UZ5OqEFROyn1Vkr/6p/fFsGETU7EGOg7
         friF20P3JAnVviGfx9fuZz6PO1ulNFRl9M/GKxzdK5HiuJfRVKq6qjFbrmbiFv/FqJ
         pVbYKOnktZlSg==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id N_4mZzM6CVu9; Sat,  8 Apr 2023 11:46:34 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id 1DE5C95F0B;
        Sat,  8 Apr 2023 11:46:34 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v3 0/7] iio: adc: palmas_gpadc: add iio events
Date:   Sat,  8 Apr 2023 13:46:17 +0200
Message-Id: <20230408114624.824144-1-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on linux-next/master [1] and [2].

The palmas gpadc block has support for monitoring up to 2 ADC channels
and issue an interrupt if they reach past a set threshold. This can be
configured statically with device tree today, but it only gets enabled
when reaching sleep mode. Also, it doesn't look like anyone is using it.

Instead of this one special case, change the code so userspace can
configure the ADC channels to their own needs through the iio events
subsystem. The high and low threshold values can be set for every
channel, but only 2 thresholds can be enabled at a time. Trying to
enable more than 2 thresholds will result in an error.

The configured thresholds will wake up the system from sleep mode if
wakeup is enabled in /sys/devices/.../power/wakeup.

The old platform data was removed.

Thresholds, events, and wakeup were tested on omap5-uevm board. It wakes
up from sleep mode when wakeup is enabled and a threshold is passed. A
userspace tool for monitoring events and adjusting thresholds can be
found at [3].

V2 -> V3:
* Rebased to linux-next.
* Avoid reconfiguring events on error and when old =3D=3D new value.
V1 -> V2:
* Begin by removing adc_wakeupX_data instead of doing it last.
* Split changes in smaller patches

[1] git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
[2] https://lore.kernel.org/linux-iio/20230318163039.56115-1-jic23@kernel=
.org/
[3] https://github.com/Risca/pyra_vol_mon

Patrik Dahlstr=C3=B6m (7):
  iio: adc: palmas: remove adc_wakeupX_data
  iio: adc: palmas: replace "wakeup" with "event"
  iio: adc: palmas: use iio_event_direction for threshold polarity
  iio: adc: palmas: move eventX_enable into palmas_adc_event
  iio: adc: palmas: always reset events on unload
  iio: adc: palmas: add support for iio threshold events
  iio: adc: palmas: don't alter event config on suspend/resume

 drivers/iio/adc/palmas_gpadc.c | 559 +++++++++++++++++++++++++++------
 include/linux/mfd/palmas.h     |   8 -
 2 files changed, 464 insertions(+), 103 deletions(-)


base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
prerequisite-patch-id: b0418c707db13f514400956596e9ebe91c25bba0
--=20
2.25.1

