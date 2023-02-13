Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25861694266
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 11:12:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjBMKLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 05:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbjBMKLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 05:11:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBB4E39F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so18160084lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 02:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ej+P/HoLnJs9+vTrBuMVaQw7HOLkNvqo2ZBWHCQRWw=;
        b=kxHp6ZYqu2JxWOVwiStb6OfEpyHnn17hS1V1UAsQ+S8eME58V+yJeCgrKxm50aRbeM
         KHGYbdW0CokYH933J0Fxs9SfcAbGEyX3EpaBSREHE5JMBcZFQ0dj0ftWveXO2m6/O3wZ
         HbXIl4h8Ld4aysmd9PqxfaRvxutYyF5a8eAUOFW4oX1GrXW+tqEt5MWLoB6kkP5vZ3nP
         /EGhDSob+4x4IYt18uuhtXbR+FGSlZJIWDvbw3lKKatzfkTrNUhakR/oPJOrjipTzWdx
         Gj594JZ7qdenLr+8RpIoNSVGsVYZNedB1sHGgYUdTw8U09VooV0WVotNDLA/cBob8Y70
         NLNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ej+P/HoLnJs9+vTrBuMVaQw7HOLkNvqo2ZBWHCQRWw=;
        b=w6an0n/l8amulIDvFWm4ocXZHqNjjEBgo1ZHlODW54uVHOuvnChRPY36qr2NzOK6pV
         h2pQ0DvVlvTLV6JCU/lPX6/fbPaZLzYZWCOf1KFUHNpKufYwrUVAgu80Lkc05OWy2/qY
         rheFEo85jxWwgl/2wmOR9RRvyMNUhb7kvEkBaaIjtMeEWi37DL6xPbfWIYqVrV/sDQug
         +TlXdUK0NFqYSxQE+02gAnFRwFaIUjWYNjryChgJ+M+Bq6SvMpW30NULr0zwsGyuAo3y
         XJgA5UdY3aELCXaj1uvPMZ/nf5tWS8zAR7M4K2cCKDJYgqASJb0QVuxEmg49/2Mqo9sJ
         dxHA==
X-Gm-Message-State: AO0yUKVb8SvtkKFiVBkyxM1MILzKrKlSwRShf93kFDpeg2UddYV2+8SZ
        QSYwB3u4iYIL2uHlb7CT1PRrypdWoH7Xvv3H
X-Google-Smtp-Source: AK7set+dB+QZXK5K8KWyZVBivFrc1Ty1r1X052ZMPzLr+pc4cPLcc5+fwWGIJBHmB0iWsIhcjbeciQ==
X-Received: by 2002:ac2:41cb:0:b0:4d8:6492:5689 with SMTP id d11-20020ac241cb000000b004d864925689mr5944186lfi.31.1676283091886;
        Mon, 13 Feb 2023 02:11:31 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id t6-20020a19ad06000000b004b55da14ba8sm834416lfc.291.2023.02.13.02.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 02:11:31 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RFCv3 0/1] x86: allow to notify host about guest entering s2idle
Date:   Mon, 13 Feb 2023 10:09:20 +0000
Message-Id: <20230213100921.268770-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the mailing list discussion [1] about the preferred approach
for notifying hypervisor/VMM about guest entering s2idle state this RFC was
implemented.

Instead of original hypercall based approach, which involves KVM change [2]
and makes it hypervisor specific, implement different mechanism, which
takes advantage of MMIO/PIO trapping and makes it hypervisor independent.

For the RFCv1 [3]:
  Patch #1 extends S2Idle ops by new notify handler which will be invoked as a
  very last command before system actually enters S2Idle states. It also allows
  to register and use driver specific notification hook which is used in
  patch #2.

  Patch #2 introduces new driver for virtual PMC, which registers
  acpi_s2idle_dev_ops's notify handler. Its implementation is based on an
  ACPI _DSM evaluation, which in turn can perform MMIO access and allow to
  trap and therefore notify the VMM about guest entering S2Idle state.

For the RFCv2 [4]: the patch #1 was dropped as in the meantime Mario Limonciello
introduced a very similar patch [5] which uses s/notify/check and invokes the
callback a bit earlier just before s2idle_entry. Mentioned patch has already
been merged.

This patchset is marked as RFC since patch #2 implements driver for non
existing device "HYPE0001", which ACPI ID was not registered yet.
Furthermore the required registration process [6] will not be started
before getting positive feedback about this patchset.

[1] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-2-jaz@semihalf.com/
[2] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-3-jaz@semihalf.com/
[3] https://patchwork.kernel.org/project/linux-pm/cover/20220707125329.378277-1-jaz@semihalf.com/
[4] https://patchwork.kernel.org/project/linux-pm/cover/20230209152123.3186930-1-jaz@semihalf.com/
[5] https://patchwork.kernel.org/project/linux-pm/patch/20220829162953.5947-2-mario.limonciello@amd.com
[6] https://uefi.org/PNP_ACPI_Registry

Grzegorz Jaszczyk (1):
  platform/x86: Add virtual PMC driver used for S2Idle

 drivers/platform/x86/Kconfig    |  7 +++
 drivers/platform/x86/Makefile   |  3 ++
 drivers/platform/x86/virt_pmc.c | 83 +++++++++++++++++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

-- 
2.39.1.581.gbfd45094c4-goog

