Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA776D1DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCaKVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjCaKUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:20:31 -0400
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849251EA12;
        Fri, 31 Mar 2023 03:15:31 -0700 (PDT)
Received: by mail-ed1-f43.google.com with SMTP id t10so87441490edd.12;
        Fri, 31 Mar 2023 03:15:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680257730;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aDxPBAvVWn7ICni5AGP3RvwiATkaJyJBS+u6Ke0pY9M=;
        b=36MDxMFNrRfUJSFpMx/7k+akiYxu3V2Ppki4SnJsaELWPFQ1W7QpdWCJozlIzKZkO7
         2qeB9YK8Wl+vCWr94FOWwb1eZUXmlHnLHAbN/hUwsJW9/USyjFXbRhHSppOjJeS9Srji
         4jndx3IjtxijzZwiFUd4EE7Zt4qQLygsrMb+rbsWOW8v7GYqTScXf6TVhjZtDFsQDoNx
         BnaBQXJ3uAwdMBNi9qmen+epEFSEjGgNGiSxBrXhjkQDzsMq7/kbTiWo5kquZ4PXomdo
         yrnhY1vIKzorlOCPJs2b65jJFeCoa9ZHEAG4MSJliPa/zNQrVJC3tmhIWDiz4hbjYGb0
         OxsA==
X-Gm-Message-State: AAQBX9f++KSAVO5TNpNVmwgOOyMwQDTROdvZ9+9OOV3fATvPx5AeY+4G
        kAjqHrxyFMWTASHMwwMXdTdiIcnAVTd5OHylBkw=
X-Google-Smtp-Source: AKy350bmkHOCGsR6HrnLJJBTyThOeMAjmUtBtD2XqjCIwFWj3aidR9d7XHIp5VOOrc5cGTPh9SahXQ9NgHaT4Az+EBo=
X-Received: by 2002:a17:907:d48d:b0:93e:c1ab:ae67 with SMTP id
 vj13-20020a170907d48d00b0093ec1abae67mr12371838ejc.2.1680257729928; Fri, 31
 Mar 2023 03:15:29 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 31 Mar 2023 12:15:19 +0200
Message-ID: <CAJZ5v0izUZ4eY9vhHQSw=to-ozRgVqX9uXw1G_qvA4PQEEGCJA@mail.gmail.com>
Subject: [GIT PULL] ACPI fix for v6.3-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.3-rc5

with top-most commit c56610a869bce03490faf4f157076370c71b8ae3

 ACPI: bus: Rework system-level device notification handling

on top of commit 197b6b60ae7bc51dd0814953c562833143b292aa

 Linux 6.3-rc4

to receive an ACPI fix for 6.3-rc5.

This fixes a recent regression related to the handling of ACPI
notifications that made it more likely for ACPI driver callbacks to be
invoked in an unexpected order and NULL pointers can be dereferenced as
a result or similar.

The fix is to modify the global ACPI notification handler so it does not
invoke driver callbacks at all and allow the device-level notification
handlers to receive "system" notifications (for the drivers that want to
receive them).

Thanks!


---------------

Rafael J. Wysocki (1):
      ACPI: bus: Rework system-level device notification handling

---------------

 drivers/acpi/bus.c | 83 ++++++++++++++++++++++++------------------------------
 1 file changed, 37 insertions(+), 46 deletions(-)
