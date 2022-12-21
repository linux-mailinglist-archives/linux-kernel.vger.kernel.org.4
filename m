Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B234653310
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 16:19:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbiLUPTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 10:19:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiLUPTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 10:19:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEB1C12E
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671635902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=8darXxKNQpmbon3UbqbTxOV7GIsf40UucsuTSbXzyhQ=;
        b=dGrzU3SJb+tdTAyLAAHg3OPMTdxQAvoSWI72UQwQifGUvsuWaJmFmLXNTvhDatkmrgKD1A
        Pq5XhN5IXZAgIE2NDz67qnfE6No3Rukv/KBN3m6zyZEjKwBucMY33JXC6/DFlz4t2ZLOcL
        IjV7dcOGfQQ6mkfvryiLhohDg0sMYYc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-664-iQqSP61TMQmcllkXsNQ3pA-1; Wed, 21 Dec 2022 10:18:21 -0500
X-MC-Unique: iQqSP61TMQmcllkXsNQ3pA-1
Received: by mail-wm1-f70.google.com with SMTP id c1-20020a7bc001000000b003cfe40fca79so783113wmb.6
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 07:18:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:subject:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8darXxKNQpmbon3UbqbTxOV7GIsf40UucsuTSbXzyhQ=;
        b=5tc0yi1QBHLjma+kSqYPZ59oX5ocDQ2AJHQHFQBekAZInU4yyCE6vpuWOHf8p6qZoO
         cyf/pYnDhE/bF9yeSA4UHZqgJC+/ZQ35xtH/1LnSQrUUT2AnnwYzNa8VXWMtNCWVsa5G
         1ghC59bJ0yokeLO3+ad0QJyIjL+RTtr9Rk66fkM49j/J27K+YEpBy6tOnRGwBWgqKz44
         16ym8YcghUwDtkrvTV/OovFguI8X1mqEj2nAxUvcid9cBl/kmhinvNqH2HfqosyjGWPd
         RmIpQfY9mzW78AzyZUtTEbD+eqGX5RrnTL7Oix8eF5lkMkrZn72214t08mLh6jf/d/p0
         IEYA==
X-Gm-Message-State: AFqh2kpg++RpabD6XchKAkOxRmOUTqhCe84a6RoODjeiYZWThy50YiuU
        0WaevIyqzNsLK1u1acAYjRZ7h6Xj+9P4DGUoIsl84fMoAUcIKcPdb8RsThEUiNzMZpdVYDU2wbo
        Yt68NSKslpE1HcsA1Oo8ycZrO
X-Received: by 2002:a05:600c:34ca:b0:3d6:80b5:f948 with SMTP id d10-20020a05600c34ca00b003d680b5f948mr1876451wmq.39.1671635899128;
        Wed, 21 Dec 2022 07:18:19 -0800 (PST)
X-Google-Smtp-Source: AMrXdXv6Z8l508m6IPDzsUXPgZ7THq99li47zu9yjexpehXzRbZ7EFgep0UldPRnjr7tGmT2CFC+SQ==
X-Received: by 2002:a05:600c:34ca:b0:3d6:80b5:f948 with SMTP id d10-20020a05600c34ca00b003d680b5f948mr1876443wmq.39.1671635898942;
        Wed, 21 Dec 2022 07:18:18 -0800 (PST)
Received: from [192.168.240.2] (82-65-22-26.subs.proxad.net. [82.65.22.26])
        by smtp.gmail.com with ESMTPSA id m4-20020a05600c3b0400b003c6b7f5567csm9195475wms.0.2022.12.21.07.18.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 07:18:18 -0800 (PST)
Message-ID: <c80b4fac-a515-b15e-7233-92145bb2a39c@redhat.com>
Date:   Wed, 21 Dec 2022 16:18:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] HID fixes
Cc:     lkml <linux-kernel@vger.kernel.org>, Jiri Kosina <jikos@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

    git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2022122101

to receive fixes for HID subsystem. Highlights:

=====
- 4 potential NULL pointers dereferences (Bastien Nocera, Enrik Berkhan, Jiasheng Jiang
   and Roderick Colenbrander)
- Allow Wacom devices in bootloader mode to be flashed (Jason Gerecke)
- Some assorted devices quirks (José Expósito and Terry Junge)
=====

Thanks.

----------------------------------------------------------------
Bastien Nocera (1):
       HID: logitech-hidpp: Guard FF init code against non-USB devices

Enrik Berkhan (1):
       HID: mcp2221: don't connect hidraw

Jason Gerecke (1):
       HID: wacom: Ensure bootloader PID is usable in hidraw mode

Jiasheng Jiang (1):
       HID: amd_sfh: Add missing check for dma_alloc_coherent

José Expósito (3):
       HID: Ignore HP Envy x360 eu0009nv stylus battery
       HID: multitouch: fix Asus ExpertBook P2 P2451FA trackpoint
       HID: sony: Fix unused function warning

Roderick Colenbrander (1):
       HID: playstation: fix free of uninialized pointer for DS4 in Bluetooth.

Terry Junge (1):
       HID: plantronics: Additional PIDs for double volume key presses quirk

  drivers/hid/Kconfig                      |  2 +-
  drivers/hid/amd-sfh-hid/amd_sfh_client.c |  4 ++++
  drivers/hid/hid-ids.h                    |  4 ++++
  drivers/hid/hid-input.c                  |  2 ++
  drivers/hid/hid-logitech-hidpp.c         | 11 +++++++++--
  drivers/hid/hid-mcp2221.c                | 12 +++++++++---
  drivers/hid/hid-multitouch.c             |  4 ++++
  drivers/hid/hid-plantronics.c            |  9 +++++++++
  drivers/hid/hid-playstation.c            |  2 +-
  drivers/hid/hid-sony.c                   |  2 ++
  drivers/hid/wacom_sys.c                  |  8 ++++++++
  drivers/hid/wacom_wac.c                  |  4 ++++
  drivers/hid/wacom_wac.h                  |  1 +
  13 files changed, 58 insertions(+), 7 deletions(-)

