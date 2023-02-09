Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA74690CCA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 16:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBIPVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 10:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjBIPVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 10:21:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5611FD535
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 07:21:37 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id cf42so3637810lfb.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 07:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cthpLXx0f+oWoF1dzgJ83xt8I8sgWAj9IDXrTHyK+HI=;
        b=pvSCPpmO6boIlc/8GfJMMZzVFLc8xPOCk6GRM1D1yvs8C3YfOL03iFuuWDm3B7sYWu
         lUCiSMqMtePy6ReBPEfPhpFvl64fluB1sC4RWlcuFYEe6FG1SNQ58Iy07mPDzJ2J82N9
         fJcIn/YLn1uIZGQ1Rw0Z40Sy2klnUAbZ0BsxIq/qKQczg8ZAiGlycakmVRQi4POjteqX
         148tu/+ka4f43RCGmErg6mO/nnfo8hOrLMtVoPDkXLzwsKTbc+5Iqi8yc1uddSNDqkwt
         MLEV2PpyLe/V103g4xavt6ki34d2x/vx41L3frrGhph9NtbGVQTZQb4ihHjTqH6ilXKQ
         /ufw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cthpLXx0f+oWoF1dzgJ83xt8I8sgWAj9IDXrTHyK+HI=;
        b=BwAJ5o3fmmUK0+UrjAkvofZMTvlFPePuoSErG+zTUPUVyHRxHv5fQUiz6lKUu477bT
         L5HO5zGRGRnIrqeT/nOXf/yd9bKdmprB097KIzQLAhy1UBYHA1yc0br1zUibOZijEhVF
         qT9IJEwYEfJgwjoNW+fd587pyR3zVHODvXDJUekDZH+8zoszWabF6sVY8xxFqEP8Icxn
         Tl4klppskuEsaOWUYE3Y3l1BE/qEX5kfgPeUNLGmC4BCS3+rhx2aHIx45qjSvAhERPrd
         lM5dpac2W8zAICrrmYtmrqHrn5tKFjQnXEtXmUKPDrwjOIouRM4dBxkKso37NXGX7sAo
         f3Ug==
X-Gm-Message-State: AO0yUKUdMJJIozz/8of1JFIh6NWHqYiQATHzqZY+eYvOFwOY2CX+Z1Vs
        nXFLP5zsSoskgPFoj/sVNl5CpiRiiMwXszZvmqE=
X-Google-Smtp-Source: AK7set+TU+Y0EfByBRNfYHVNJGDzXTPUI812KqOgxmhS1mCgtjOMwkkgxe3xIvsXQ/qenGNxWLuRAg==
X-Received: by 2002:a05:6512:40d:b0:4d8:530b:25b7 with SMTP id u13-20020a056512040d00b004d8530b25b7mr2736443lfk.58.1675956094955;
        Thu, 09 Feb 2023 07:21:34 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id l7-20020ac25547000000b004d40e22c1eesm145037lfk.252.2023.02.09.07.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:21:34 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, mario.limonciello@amd.com,
        linux-pm@vger.kernel.org, x86@kernel.org,
        platform-driver-x86@vger.kernel.org,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RESEND RFCv2 0/1] x86: allow to notify host about guest entering s2idle
Date:   Thu,  9 Feb 2023 15:21:22 +0000
Message-Id: <20230209152123.3186930-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
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

<Resend with some extra lists added to the Cc>

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

For the RFCv2: the patch #1 was dropped as in the meantime Mario Limonciello
introduced a very similar patch [4] which uses s/notify/check and invokes the
callback a bit earlier just before s2idle_entry. Mentioned patch has already
been merged.

This patchset is marked as RFC since patch #2 implements driver for non
existing device "HYPE0001", which ACPI ID was not registered yet.
Furthermore the required registration process [5] will not be started
before getting positive feedback about this patchset.

[1] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-2-jaz@semihalf.com/
[2] https://patchwork.kernel.org/project/linux-pm/patch/20220609110337.1238762-3-jaz@semihalf.com/
[3] https://patchwork.kernel.org/project/linux-pm/cover/20220707125329.378277-1-jaz@semihalf.com/
[4] https://patchwork.kernel.org/project/linux-pm/patch/20220829162953.5947-2-mario.limonciello@amd.com
[5] https://uefi.org/PNP_ACPI_Registry

Grzegorz Jaszczyk (1):
  platform/x86: Add virtual PMC driver used for S2Idle

 drivers/platform/x86/Kconfig    |  7 ++++
 drivers/platform/x86/Makefile   |  3 ++
 drivers/platform/x86/virt_pmc.c | 73 +++++++++++++++++++++++++++++++++
 3 files changed, 83 insertions(+)
 create mode 100644 drivers/platform/x86/virt_pmc.c

-- 
2.39.1.519.gcb327c4b5f-goog

