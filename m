Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E559F661678
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 17:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjAHQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 11:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 11:18:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB0C746;
        Sun,  8 Jan 2023 08:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673194714; bh=FU9rbHk25+mFU8BoKNbkZeDeFsJK6e8cHJ/ZUq4XqWA=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date;
        b=Hl2k1wlo9QEQbOdkFtv/5SXmtBUgwVpsO+iKvTuGDEZmYkRgbPthhxK9rg/zXfYKQ
         igOg/fH0QUlVHCaFaEQm/ZQKwGkrgGC1qULPO37FtHRCw+0ZYaOsDW+OuXNu+u/pQO
         ps1AN04ItlX9ZyhqZnG6zwp/AVQrUOGjkuY/OznLvYEqoBO4hNGNc+e0RKP5i9QqOE
         KVgUPwsVnF4bOFh7oGF1CIp11DRu0MoEYAB31uFi+8VRr9vaG7SUWxMgjqxnUT8TDj
         id0FJQZrie0r8u+n51D67VkoJxZ8WHq/LBT6Z2veeugmTUrqXLGdbRyss6SwZC510c
         DSohSYXt6oiFA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.191.216.48]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M89Gt-1p9to93Te7-005KsW; Sun, 08
 Jan 2023 17:18:34 +0100
Message-ID: <509b8748971fd988c5dd623adc6db97617a50fb5.camel@gmx.de>
Subject: brcmfmac regression - cfg80211_set_channel: set chanspec 0x????
 fail, reason -52 spew
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Wright Feng <wright.feng@cypress.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Sun, 08 Jan 2023 17:18:34 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:UppHptmFmtfaieEaaerob428Bj/3qZaoacinygYOj1QlqfSfAAa
 mU1da5wuAgj4Zf38XCnK6RgL/sT6o0VydcKJomErCxaICtnDRUARV5Mwp4RrC/zQJfHNs35
 ET2g96wDqIhYye3qRfOXHyA1w5tAOAv9PoHSndAvXVaNezmmmBJU08nrYRXmNe9yNh2dTN9
 y36jHxazo31G16wtxQm6w==
UI-OutboundReport: notjunk:1;M01:P0:VxFEUpf4KRU=;CmfQteOB+rFn51UrrH1z7rgkvkp
 8cIoxcaXAiMgy6CG7P3AOV9jMfiy6Hx6gh0RH7E9WTd7jIf/4Mbw9gOlSMRTSbkOYL3BU0mLw
 9Gdqbr5n24i1Z+BWpM45TX2FXBcSIqCevFu2x93gTS0t8OiMMcHW1tbj4xphvTKVF/B39a6E/
 xAcfHDIQF25rQOJFwkhLtQZ61bwACOj/hhPv4hvc3HXoqL/kuAAmu1oeblBvuW6BEN11752qy
 yY3+baG5fuVOruFgMLAGonKs0SpYAhzl39CNsx0YtbDYXm1BGBUgsNpII62kWRMcGtygrbPy6
 luGEZ0oLCGNMXVEPLKugb9zikHFxeCpY7TRkKpcE1IXeGRvb7mOMZScc2af0Ttxe+s/X2JH/1
 WRa9G+WyWXnOOdPL67lXzrW5qWiuEthbgsvXQlOGQ0ESQPX+tMRGratM3BknxWzFTugN3KEI5
 Dw+X2ArWhtR2cKbKQ8iNbHHaHMuTGWv6BhW91qBcacXlagSfV5wAdfiJ/vvqMA8H25yWg21BC
 TZco0HWhjAC2aSziSSK/qashHxuFSTJsdnHKXqwX9OSnax2SfrSzLpDSrTdoWkfy6CscjRY5Z
 3zDv5z9GbPETwULaQIdYwdWJW1RKhBPtTOsYj7JIiWQdB9Y7T92rNIlD60KijgGOwQz/NhnFY
 cc9gLFEfy7xZDJb31eqP8FLMJ/0juh8A5JfUufG5XFLvHo2fHCufpgJDDoUtm68RVqkjxipDs
 xxjKBxZn/Y3NEWHJlznzgnYdem+19Qt93PdPYqqkSUXKozJMyYhWkeMXBl96dGvTMxdiwPWBo
 g9cuUc5B1NNQh/n8DY5oBaI65vLl5qHvH9AR7B+ghabnJZhz89/8mM1T4oTTb0vhAmhNWBkxC
 ron50vPGuY/JJa5YTA8Cl/1UURJ1B+wJ9VTfuQwUznmaJ/ixH6mXMTZ5WifUXzRGcPXwXaMRj
 zo104g==
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

6c04deae1438 "brcmfmac: Add dump_survey cfg80211 ops for HostApd AutoChannelSelection"

This commit seems to inspire my little raspberrypi 4b to moan
endlessly, though it seems to work.  Brute force revert silenced it.

[    7.917448] brcmfmac: F1 signature read @0x18000000=0x15264345
[    7.974270] brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac43455-sdio for chip BCM4345/6
[    8.326846] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0: Jan  4 2021 19:56:29 version 7.45.229 (617f1f5 CY) FWID 01-2dbd9d2e
[   10.799571] brcmfmac: brcmf_cfg80211_set_power_mgmt: power save enabled
[   15.078022] brcmfmac: cfg80211_set_channel: set chanspec 0x100e fail, reason -52
[   15.078347] brcmfmac: cfg80211_set_channel: set chanspec 0xd022 fail, reason -52
[   15.185674] brcmfmac: cfg80211_set_channel: set chanspec 0xd026 fail, reason -52
[   15.289609] brcmfmac: cfg80211_set_channel: set chanspec 0xd02a fail, reason -52
[   15.393796] brcmfmac: cfg80211_set_channel: set chanspec 0xd02e fail, reason -52
[   17.066478] brcmfmac: cfg80211_set_channel: set chanspec 0xd090 fail, reason -52
[   17.066923] brcmfmac: cfg80211_set_channel: set chanspec 0xd095 fail, reason -52
[   17.070632] brcmfmac: cfg80211_set_channel: set chanspec 0xd099 fail, reason -52
[   17.071080] brcmfmac: cfg80211_set_channel: set chanspec 0xd09d fail, reason -52
[   17.071653] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a1 fail, reason -52
[   17.072197] brcmfmac: cfg80211_set_channel: set chanspec 0xd0a5 fail, reason -52

