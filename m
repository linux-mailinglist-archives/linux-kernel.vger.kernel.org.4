Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71156F8800
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 19:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjEERva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 13:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232539AbjEERv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 13:51:27 -0400
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AA81AEEC;
        Fri,  5 May 2023 10:50:59 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-50c079eb705so562363a12.1;
        Fri, 05 May 2023 10:50:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683308969; x=1685900969;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A62ixraUK45wvfUVFdavHaQrinNdM5LIh6jDSU68RIs=;
        b=eBcVUcw9mFKlB08tk1wbFedOsfvefNfnyBS371D3M4Oh25Fya7Rm92vJJpiRGPpTeX
         38nW1q0++LP2Us4+q3cb8cLhK62SePbVBtFA0W7koCXsABOaN03iJCeSDBTVHq7IGB9X
         pPkwd8JLXLWFD1GDcLGWlzoAkwu3xQ/dZgyDYuNXWJA+TXDrxIVBWToai7wSM5ikC7EA
         1ijOjLzdSpWmXAlvqV5JG33R2OkKJ/oSa8emAF7uCq4aDcdKeI0RsGx0NEJ7Tv93ooq4
         l6ifQHoRWGPBaDQhoWBRxRQQM2UhJY6XVWQfT0CrxuU9SkNQnP2ncmobq0hT6SmWJltd
         Q59Q==
X-Gm-Message-State: AC+VfDz66HW77vimQMF4wjUINnSBpMGzv5dk33jel8Q4UfSNAV8Xda6A
        9fOS79pS0b7uv8Me73wf5YaXx2qvoJESZc1AN1M=
X-Google-Smtp-Source: ACHHUZ5+oLl+MxZzZz4UMrNXUvjSUh39EsYxV2vQYGzlz0fo10XXE9lQj+7EBfKYLvtvoN7FbDeJR3DXZoALGM7/TRU=
X-Received: by 2002:a05:6402:2788:b0:502:1f7b:f0a6 with SMTP id
 b8-20020a056402278800b005021f7bf0a6mr2067953ede.0.1683308969064; Fri, 05 May
 2023 10:49:29 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 5 May 2023 19:49:18 +0200
Message-ID: <CAJZ5v0hQO1q7B=Mp+hQaHeWnkN+cm+QARpFXEAJ=FQKGtOE8Mg@mail.gmail.com>
Subject: [GIT PULL] Thermal control fixes for v6.4-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.4-rc1-3

with top-most commit 2492ba4cd06dd24076f44327174816b04cddde90

 MAINTAINERS: remove section INTEL MENLOW THERMAL DRIVER

on top of commit 667de5c68440732373f571f7eac4ff44b1b93ee7

 Merge tag 'thermal-6.4-rc1-2' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive thermal control fixes for 6.4-rc1.

These fix a NULL pointer dereference in the Intel powerclamp driver
introduced during the 6.3 cycle and update MAINTAINERS to match recent
code changes.

Specifics:

 - Fix NULL pointer access in the Intel powerclamp thermal driver that
   occurs on attempts to set the cooling device state to 0 in the
   default configuration (Srinivas Pandruvada).

 - Drop the stale MAINTAINERS entry for the Intel Menlow thermal driver
   that has been removed recently (Lukas Bulwahn).

Thanks!


---------------

Lukas Bulwahn (1):
      MAINTAINERS: remove section INTEL MENLOW THERMAL DRIVER

Srinivas Pandruvada (1):
      thermal: intel: powerclamp: Fix NULL pointer access issue

---------------

 MAINTAINERS                              | 6 ------
 drivers/thermal/intel/intel_powerclamp.c | 4 ++++
 2 files changed, 4 insertions(+), 6 deletions(-)
