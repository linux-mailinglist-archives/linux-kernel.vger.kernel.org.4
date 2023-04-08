Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FC56DBA8F
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 13:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbjDHLtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 07:49:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDHLtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 07:49:07 -0400
Received: from ste-pvt-msa1.bahnhof.se (ste-pvt-msa1.bahnhof.se [213.80.101.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37819E04A;
        Sat,  8 Apr 2023 04:48:59 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTP id 039A93FB25;
        Sat,  8 Apr 2023 13:48:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
X-Spam-Score: -2.1
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
Authentication-Results: ste-pvt-msa1.bahnhof.se (amavisd-new);
        dkim=pass (2048-bit key) header.d=dalakolonin.se
Received: from ste-pvt-msa1.bahnhof.se ([127.0.0.1])
        by localhost (ste-pvt-msa1.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZL6G4xavLotB; Sat,  8 Apr 2023 13:48:56 +0200 (CEST)
Received: by ste-pvt-msa1.bahnhof.se (Postfix) with ESMTPA id A7F7F3F303;
        Sat,  8 Apr 2023 13:48:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 80E5D95F96;
        Sat,  8 Apr 2023 11:48:56 +0000 (UTC)
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QbP9npGt_QIF; Sat,  8 Apr 2023 11:48:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTP id 8EE9C95F92;
        Sat,  8 Apr 2023 11:48:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra.dalakolonin.se 8EE9C95F92
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dalakolonin.se;
        s=D374B428-D0A7-11ED-A657-75977B426508; t=1680954534;
        bh=WvTeccIHvOWSU0nrd5eJOb8g88ka9+Tj40GkwzFrkTk=;
        h=From:To:Date:Message-Id:MIME-Version;
        b=Nef9P7qZwki5JyRB5lj3kf3Rx1g7V9lGIrBFHnQUEh4o1tXQYPleajRgu+c/KrB4m
         lVYpOmpecDOKEOxBVch4QpbP4MvyhMzqjpMgdFI02tHfZ+6v9jI/6CZ+u2rk1gU13N
         j9CFCI/Kl/mkCfkOoq+DFefPG/o6wk0M2zWovoiuhfwmOnR7a2hjRU1BHwpklRo3Cs
         cVklM8jG4ZtCXDpau+hnvzSV/wLER+c8ACHojY3AhMlnHC9R0rb0VvMMiCVmkoVrcC
         KnWyFoaqF9SxmsbWLN7swIQK6BaW+WXfoKq4tckFjKF0ukfi1kc9kQw/MAzcbhz5Ry
         4fSrixHxCIPfQ==
X-Virus-Scanned: amavisd-new at dalakolonin.se
Received: from zimbra.dalakolonin.se ([127.0.0.1])
        by localhost (zimbra.dalakolonin.se [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NHaeZjFvjMA2; Sat,  8 Apr 2023 11:48:54 +0000 (UTC)
Received: from rack-server-1.dalakolonin.se (unknown [172.17.0.1])
        by zimbra.dalakolonin.se (Postfix) with ESMTPSA id E7D2F95F8F;
        Sat,  8 Apr 2023 11:48:53 +0000 (UTC)
From:   =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, letux-kernel@openphoenux.org,
        kernel@pyra-handheld.com, pgoudagunta@nvidia.com,
        hns@goldelico.com, jic23@kernel.org, lars@metafoo.de,
        linux-omap@vger.kernel.org,
        =?UTF-8?q?Patrik=20Dahlstr=C3=B6m?= <risca@dalakolonin.se>
Subject: [PATCH v4 0/9] iio: adc: palmas_gpadc: add iio events
Date:   Sat,  8 Apr 2023 13:48:16 +0200
Message-Id: <20230408114825.824505-1-risca@dalakolonin.se>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is based on iio/togreg [1] and includes one patch ("fix NULL
dereference on rmmod") which is already in linux-next and another patch
from Jonathan Cameron ("Take probe fully device managed") to make the
rest of the patches apply cleanly to iio/togreg.

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
found at [2].

For more background and the use case for these patches, see [3].

V3 -> V4:
* Reabased to iio/togreg and included required patches.
* Avoid initializing variables unnecessarily.
* Minor cosmetic fixes to comments.
V2 -> V3:
* Rebased to linux-next.
* Avoid reconfiguring events on error and when old =3D=3D new value.
V1 -> V2:
* Begin by removing adc_wakeupX_data instead of doing it last.
* Split changes in smaller patches

[1] git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
[2] https://github.com/Risca/pyra_vol_mon
[3] https://pyra-handheld.com/boards/threads/improve-volume-wheel-daemon-=
bounty.99430/post-1711410

Jonathan Cameron (1):
  iio: adc: palmas: Take probe fully device managed.

Patrik Dahlstr=C3=B6m (8):
  iio: adc: palmas_gpadc: fix NULL dereference on rmmod
  iio: adc: palmas: remove adc_wakeupX_data
  iio: adc: palmas: replace "wakeup" with "event"
  iio: adc: palmas: use iio_event_direction for threshold polarity
  iio: adc: palmas: move eventX_enable into palmas_adc_event
  iio: adc: palmas: always reset events on unload
  iio: adc: palmas: add support for iio threshold events
  iio: adc: palmas: don't alter event config on suspend/resume

 drivers/iio/adc/palmas_gpadc.c | 616 +++++++++++++++++++++++++--------
 include/linux/mfd/palmas.h     |   8 -
 2 files changed, 478 insertions(+), 146 deletions(-)


base-commit: f73df43e957a6fc705a9bd6d143585bdf1b13365
--=20
2.25.1

