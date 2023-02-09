Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60469690B24
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 14:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbjBIN6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 08:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjBIN6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 08:58:32 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0111D913
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 05:58:31 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so3288338lfv.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 05:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5vIk3jzXuSyaHW1FYxyA9cfIJXbVLZ1cRv9vB0DvrCA=;
        b=Aa2XvtCj7k1EQ5AB4TnvMCLfRsS0RKTQZW/lMsHxUzlMxHgBVyGkCRxYU7RF5RcL9u
         tY+e/Kqcui8pT9ABaiDJ2k9bJh4xkTUo0awV6587gnbiJcv+pWPGUb4dMlpy0e+UnTfs
         YlqmgmX5YNE9Sobf3zTNU/9zmW0WB121wYmfr6zagvOy0LSa4Wk16P+4T456WBz41Adc
         DjjZuQqK4yZu0htvspUodmMMLjKt874cxm/HXTehfcORrwTcl79+uHAtWJCTJ/eZgMHQ
         3zxnCm5mFkYTi7SYwdXA6gtiXvxsntjgP7Ps+dX/O+oeuQoNwz6u9dS6Wl+MTIz2BA7X
         v/Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5vIk3jzXuSyaHW1FYxyA9cfIJXbVLZ1cRv9vB0DvrCA=;
        b=F1sUipJRAuLaA7mWWKP7uoVZIbIJAIxv3e6h05VAB9Q+NsiwfaYHKnYVxoheAKkL0j
         Elyg+/5KrNH8wYXl7fWl471wiPuNs13rM/42M1w/KwPTzhfoGrXOSvdYdnKbrLTStcBv
         RdbYyOO5BccFc55aSvi9GqqhoEtRL8xIHQnJIkC/s5vt1w5cVuJbJOpaT3q1MGvCQgiC
         Hgku6yIV+Wex/tpvjTBLc/6/mX3Uij8wfv+by4TnwTSZiq8+A7t+yFnfeKCpacGGNTFU
         fDgvwmqEfhZoJhaNGaOY53C19MLZeapZE1kM/s0aphDmzD0jTLRw+QHc/sNV1GJpZk6X
         MLBg==
X-Gm-Message-State: AO0yUKUmk066IngHYghor1BXrzcIf6Tq1vOj9DQprTaO+PU5oFjncnx5
        zbAPesqndY6IkcJ/1tiuOk7ciD5r8X9HBqIL
X-Google-Smtp-Source: AK7set9FPvh10WNQrIs+53FfwJ6h4mOwrNl1RN+TN6g0Bj9QedNmNInZVqJ0KHWO+IQLdIhnr37jcQ==
X-Received: by 2002:a05:6512:94d:b0:4d8:56db:1cd8 with SMTP id u13-20020a056512094d00b004d856db1cd8mr2896775lft.40.1675951109351;
        Thu, 09 Feb 2023 05:58:29 -0800 (PST)
Received: from jazctssd.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id m9-20020a056512014900b004d5786b7299sm137785lfo.5.2023.02.09.05.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 05:58:28 -0800 (PST)
From:   Grzegorz Jaszczyk <jaz@semihalf.com>
To:     linux-kernel@vger.kernel.org, rafael@kernel.org
Cc:     dmy@semihalf.com, tn@semihalf.com, dbehr@google.com,
        zide.chen@intel.corp-partner.google.com, seanjc@google.com,
        upstream@semihalf.com, hdegoede@redhat.com, markgross@kernel.org,
        dtor@google.com, Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: [RFCv2 0/1] x86: allow to notify host about guest entering s2idle
Date:   Thu,  9 Feb 2023 13:56:45 +0000
Message-Id: <20230209135646.3179418-1-jaz@semihalf.com>
X-Mailer: git-send-email 2.39.1.519.gcb327c4b5f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

