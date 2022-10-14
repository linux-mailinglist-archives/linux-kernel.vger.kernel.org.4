Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8355FED11
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 13:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbiJNLQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 07:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiJNLQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 07:16:18 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02942EA6B7;
        Fri, 14 Oct 2022 04:16:18 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id u71so4056130pgd.2;
        Fri, 14 Oct 2022 04:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YuGz1UR2tMDPkoC9Gg1xaN13XsAUY7sbqcFKXBvRIGk=;
        b=iQfcQvPhrp14avWNSn0mB8rCa/YN2BadcgBvi6kFdxzog8A/yIEl9CAApdG4W4RFYo
         A6yUMJa6pZNM2BlQ9Tzt52CT1iJRztZFq9afWK1EV9zSYO2LCfdBVK3ouFt/1gU9LlfX
         8c9WBPRWiAoSX9o7q9hAcXKTz+T5RdLkILa8LW3R8lLkSakPokrXPv4grbMjVNXlW7aM
         PLdiz/+18gc+ZL7pJmiQtlAOdadGTRYnr7QbphLko+U+dmSNFJRvSXKIzEPFOllunLTb
         uLJB9GxXh086efkLkPwUVF/0QZE0kEShEX77rQJwVSdOjBBHVMNRc7ZvkH4kz5vz5oD2
         rmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YuGz1UR2tMDPkoC9Gg1xaN13XsAUY7sbqcFKXBvRIGk=;
        b=qfgSqNcthdebB9DS4Kyia68qCEQzvw+TgxBosJbQZdhmuYeJr7HbFMpO2ZbCiCnY5D
         9jKORnD7vP72Phrdeapn0SOTM6v21+o+5bL/cTe76gY9OVJ8pjyRbAxBA7s53cKuq1S5
         3gDT/zfbPvFP3wYxHf22Zg1k8CnSbbCW90m3/WnAOoLsAkCLxi+wueZrEeeum5kzjpmw
         kB8gEFmLTdRSpFUzb4ooLqmZtRMJksBcjp3uY408EV11EuGwrwf477lzm186aPzxDbho
         YgYEZhmHivGMAS//YPxkaOGod2z9bU5rIc7CMPZvASL+Jy44eBTsrvY3yZO5vrbktDdH
         eSQw==
X-Gm-Message-State: ACrzQf0jR6EQGSG+wDTt6y3j9c2gzb1St8SA3rFOpr+8+A+VaTgto3px
        ILzCxuUsLigfo1ooiI7T3gzqp/eCclaQgA==
X-Google-Smtp-Source: AMsMyM7ABZW5aEBu1yfVTtACBP/mCFoBH6sYRjMcZ++pxFDVU1EiBIaN9xgjgvAxUm05LweDaNCaUA==
X-Received: by 2002:a05:6a00:10cf:b0:563:34ce:412f with SMTP id d15-20020a056a0010cf00b0056334ce412fmr4613147pfu.67.1665746177184;
        Fri, 14 Oct 2022 04:16:17 -0700 (PDT)
Received: from dell-void.nyanpasu256.gmail.com.beta.tailscale.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id n9-20020a17090aab8900b001fd6066284dsm1304628pjq.6.2022.10.14.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 04:16:16 -0700 (PDT)
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Eirin Nya <nyanpasu256@gmail.com>
Subject: [PATCH V2 0/3] Input: Fix incorrectly halved touchpad range on ELAN v3 touchpads
Date:   Fri, 14 Oct 2022 04:15:30 -0700
Message-Id: <20221014111533.908-1-nyanpasu256@gmail.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Linux 5.19.10, on my laptop (Dell Inspiron 15R SE 7520) with an Elan
v3 touchpad, the reported size of my touchpad (1470 by 700) is half that
of the actual touch range (2940 by 1400), and the upper half of my
touchpad reports negative values. As a result, with the Synaptics or
libinput X11 driver set to edge scrolling mode, the entire right half of
my touchpad has x-values past evdev's reported maximum size, and acts as
a giant scrollbar!

The problem is that elantech_setup_ps2() -> elantech_set_absolute_mode()
sets up absolute mode and doubles the hardware resolution (doubling the
hardware's maximum reported x/y coordinates and its response to
ETP_FW_ID_QUERY), *after* elantech_query_info() fetches the touchpad
coordinate system size using ETP_FW_ID_QUERY, which gets cached and
reported to userspace through ioctl(fd, EVIOCGABS(ABS_X/Y), ...). So the
touchpad size reported to userspace (and used to subtract vertical
coordinates from) is half the maximum position of actual touches.

This patch series splits out a function elantech_query_range_v3() which
fetches *only* ETP_FW_ID_QUERY (touchpad size), and calls it a second
time if elantech_set_absolute_mode() enables double-size mode. This
means the first call is redundant and wasted if a second call occurs,
but this minimizes the need to restructure the driver.

A possible alternative approach is to restructure the driver and set
resolution before querying touchpad size. I did not attempt this myself,
and don't know how the Windows Dell Touchpad ELAN driver handles
double-resolution. See
https://lore.kernel.org/linux-input/20221008093437.72d0f6b0@dell-void.nyanpasu256.gmail.com.beta.tailscale.net/
for discussion.

Changes in v2:
- Fix commit summaries
- Add "Fixes:" tag holding commit that introduced bug

Link: https://lore.kernel.org/linux-input/CAL57YxZNutUVxBtvbVWKMw-V2kqeVB5kTQ5BFdJmN=mdPq8Q8Q@mail.gmail.com/
Link v1: https://lore.kernel.org/linux-input/20220929082119.22112-1-nyanpasu256@gmail.com/

Eirin Nya (3):
  Input: elantech - Remove redundant field elantech_data::y_max
  Input: elantech - Remove redundant field elantech_data::width
  Input: elantech - Fix incorrectly halved touchpad range on ELAN v3
    touchpads

 drivers/input/mouse/elantech.c | 51 +++++++++++++++++++++++-----------
 drivers/input/mouse/elantech.h |  2 --
 2 files changed, 35 insertions(+), 18 deletions(-)


base-commit: d4a596eddb90114f5f5f32a440057a175517b090
-- 
2.38.0

