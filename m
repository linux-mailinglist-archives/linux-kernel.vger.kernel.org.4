Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F5E675C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 19:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjATSFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 13:05:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbjATSFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 13:05:41 -0500
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07147521E2;
        Fri, 20 Jan 2023 10:05:38 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id x36so7654710ede.13;
        Fri, 20 Jan 2023 10:05:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NErkDfG9x21+FSuWLa23pYCGfCNK2geI8tfV1Iu02uI=;
        b=rjcuae9YXhxMnxrnOL6Clos1e8iN57XvbhWG/nY8jGvJZ5iyuEY2qsnPkYsuCYFjL9
         enbQdfgAGwQXvwbhehYwVEcHejVD28qW5VVIM79hSqOy1H5JoaAh5XdILCfgREkNXVoD
         t294+t4TZCOGJcG0ndn3g0SPOrxhLcnejaLu71KPYDdrkcXL+CFEx5yxiw8vxRfDL8uj
         Njy86u7ccAvBbl7wOzEq8At2KWjReJKkKN76EApEkHzBdyB5In9qLMDgLgS4G7jTrOAK
         aPo5sR6IyPv9EY6WcdOgcsxUFXAk/zmcYdtlmFMGhJjFy02+0sGFRN7OqxYpws65ymPO
         mlAA==
X-Gm-Message-State: AFqh2kqnJ/t0wPcsqe867f8NdWvSorq054v746XCQ87GLNT9C+2RO6Bq
        6Wg9XiamAxnaaEY1mqEWWONW14B9moM6mhHLa5RfbXn8VTo=
X-Google-Smtp-Source: AMrXdXu5tZWjbhyhg80YIaSghGZFoML7EUsr1ePnt7FHHgJuDOxJlQewGpPaDRQu5ux/kNCXfhnCe9/vVKjPSV9a2Ok=
X-Received: by 2002:aa7:cd47:0:b0:49d:f700:b1ee with SMTP id
 v7-20020aa7cd47000000b0049df700b1eemr1825007edw.49.1674237936651; Fri, 20 Jan
 2023 10:05:36 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 20 Jan 2023 19:05:25 +0100
Message-ID: <CAJZ5v0hh=K6rAhhRn+tg-mJaY-Fm_ysJLZDhVnYc+D1B1FnzuA@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.2-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.2-rc5

with top-most commit 6c54b7bc8a31ce0f7cc7f8deef05067df414f1d8

 thermal: core: call put_device() only after device_register() fails

on top of commit 5dc4c995db9eb45f6373a956eb1f69460e69e6d4

 Linux 6.2-rc4

to receive a thermal control fix for 6.2-rc5.

Modify __thermal_cooling_device_register() to make it call
put_device() after invoking device_register() and fix up a few
error paths calling thermal_cooling_device_destroy_sysfs()
unnecessarily (Viresh Kumar).

Thanks!


---------------

Viresh Kumar (1):
      thermal: core: call put_device() only after device_register() fails

---------------

 drivers/thermal/thermal_core.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)
