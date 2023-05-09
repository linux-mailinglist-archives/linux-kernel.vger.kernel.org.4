Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5486FBF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjEIGaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234633AbjEIG35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:29:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA6DAD09;
        Mon,  8 May 2023 23:29:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315712406so194369875e9.0;
        Mon, 08 May 2023 23:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683613794; x=1686205794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2bhxEJKjUvBujC/ThatqEJctZ1NjSn/LfyG3wTurPWU=;
        b=SCH37qt3RtAf/9u5T5O3yEGPmZRB6XxdkozAX7KIcMPybWDM2ZKCtEz54VFlaHbH5E
         P6ZStEs/bDXdQnK7NKub+xM+jSDZj0rerUKwKyxWsqbUTVpKuyGpmuXhx0qlufhf6uYG
         pmq5kAvjbXIDTANP1sozzJTzU0IGLhzyG2Et/XksR7eAm68VpmXx1Q789K85yE3LJ13b
         a8VY4Ky6Nm5qkjTcJcQJYbVlFEIQSiK5eNWWo1zvRM0EqUPg9hwV3nZ+oFJnkBA8kAyk
         ZRxMqN/9CEyiJ2TKfaLKNEgnw/c8BKCTjeq0CZE6twEHCMORIrfNPgd6XepfQXbbL4TH
         TEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613794; x=1686205794;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2bhxEJKjUvBujC/ThatqEJctZ1NjSn/LfyG3wTurPWU=;
        b=PSDXPDbFwkQCW7bzPgWE0RqQpeeByDwfGPY7LmlEP2UnrEAph8XSE5LoXnXAKBZJqm
         PBeuXj9T8LkwwPmt4+IDSm+PlJZE+DUVEaAxZeYnuO+MSLjfk+rA268F5bTaPYJNk9b5
         SJerfWRuoTyx/v+C1hhWRPjf6A1nYnGV6kiCGko/FgR+8hnsq7B2xu8PA0iE9yO0Yd8A
         xyseKNwqDT20ar3FCqKPvqZe3EUNCK4LEGI4cLaso4AqxGeIfolps5MPm3hSkdQK48vN
         3XE67tk0XemsM78eNBe/1TSiCnPJxVlvi71k8QswlhEPI2ZuJyIUOsYLnhHVCP+3+P4t
         4qwg==
X-Gm-Message-State: AC+VfDwrCbPAD2OFT6yS5/xtZMx6J3e5lOEo2sJdjuP8lNHk0bSzTMJ+
        XqJCUIXzzAnSKshvJzScXLjLeN/Ovyw=
X-Google-Smtp-Source: ACHHUZ4HrbUetNqnOcwGqklyN5gI2ongm11Ou+MzBoDK3aUvtcn0bn+WBQqDPNN/AjFZpRMO5Goepg==
X-Received: by 2002:a05:6000:c7:b0:307:9081:d355 with SMTP id q7-20020a05600000c700b003079081d355mr4284791wrx.26.1683613793985;
        Mon, 08 May 2023 23:29:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:4a02:2aff:fe07:1efc])
        by smtp.googlemail.com with ESMTPSA id a14-20020a5d53ce000000b0030732d6e104sm13228671wrw.105.2023.05.08.23.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 23:29:53 -0700 (PDT)
Date:   Tue, 9 May 2023 08:29:50 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        pjones@redhat.com, deller@gmx.de
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Cannot boot an i386-UEFI thinkpad lenovo tablet-2
Message-ID: <ZFnoXiZGGhuWDl2S@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have an old i386 lenovo thinpad tablet-2 currently windows 8.
After disabling secure boot, I tried to install a Linux on it but all my tries fail.
Grub is loading correclty.
Memtest86 run on it without problem.
( I also tried some BSD but since it is an i386 UEFI only, no BSD seems to support this)

But the Linux kernel fail to boot on it, black screen (in case of debian installer, the screen is stuck with the install choice), no more info.
Since this is a tablet, there are no ethernet port. (I wanted to boot it blindly)
The bios speak about a debug port, but I found nothing which seems a physical debug port output.
I tried to wire the microusb power port on a USB host, but the host fail to enumerate any device (I tried also a spetial USB cable with data/power separated to be sure the problem was not the host failling to give enough power)

The tablet has only one port, so I use a hub for keyboard and USB key.
Immediatly after booting Linux, all hub port light goes to off.

I tried different own made kernel with different choice about CONFIG_FB, selecting all INTEL options, etc... no change
I tried to change video resolution via vga=ask or video=640x480 but no change.

Any clue on how debug further ?

Thanks
