Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113C4696A3D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 17:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjBNQsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 11:48:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232482AbjBNQsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 11:48:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98AD72A6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:46 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id v63-20020a254842000000b008f257b16d71so12606505yba.15
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 08:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/Hxjp2ClOG3rMfDYkCMiTSvIpfx2BaUm4/6bMcZvkdY=;
        b=P0f2Sze4osOuatALcyTTazvf4cu6uyUC7sOCR+imJ/wKLFitOwfjaYxbvawviCLGEw
         pJt4ETflYapcqu2/r/6g1hNohrME4c4o+ter1GbMKh3v7iyrnGfVq80ryzXs2QQp0Dw1
         XDWia2HlARnDOk9ZhoM3BkkTXllxS3LedZIsSOw9YnBMAfPXGww/X1HTpOZ1T5+KRQLY
         qXI5s/Snl0Lg9dZbw1BSOdIIWqwVNA+OhFjp25v7qhrROwc/FvJQ+PGr/a80St5ERMw/
         Sh/ow7EztICoQmtn3sLOtxANjBvCbhk9ixHazPibw+mqAQuQaw/ZfGFNNIi6AJc/6LTb
         BjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/Hxjp2ClOG3rMfDYkCMiTSvIpfx2BaUm4/6bMcZvkdY=;
        b=DdIPRSHLYlRVRfYK5PiN+deaKZ4OFtXD9U0VNykJZN/oztp7ZuzCvR+6yy5CoXq7Vr
         zkQv92OuI2j3kPHwSvjYJbb7EIdZVk/fFRBAQZrcZmwhho805pKwNeMipWQjuHraYAA4
         Vn7mByPQeTKbic0qg/US0nP1PlcrMXasqjp09WiXTE5X8yCK5rTfe30MGDd5VV9oFW5c
         K1Y2W/YhKJq0HI3CpupPciNq8ildV0H0y9If8Lbb9GG/SkRBMLHKqGNyEhtHTvM+Izt4
         3HkYoq35oZ/texZjMjV398lol02HwUfa/wO7wiaTW4ZyyglJxkkk7C0b/tpjOYpdhlD1
         VFYA==
X-Gm-Message-State: AO0yUKWsJyW8Zd1gdYxKT4nkov8d0v4QndkM+ALh5aIbA/walUriajTX
        z3CXm2DowfVoN0S33E5QswJ3nAKMHjj/iCC2hv7YyfMM7rlkGdOJBEbn5+NWMbM3eHWd8ry2tVO
        5RR/MxW2rwGMeQ23EeteW725H88zy3MW56flXSRUEJkxauFR75arfgeY93S5d+ZBJA59UWShNw4
        W8mkuEvFo=
X-Google-Smtp-Source: AK7set/UBtx/LRQeeiSXr/yZPQ+236pTsNLkXQ/Wp8nbBFktXXf98F7ifsK9PPltAxx8KHcmshr2YtQ0jsuIxMXqnw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a0d:dfc1:0:b0:52e:e814:44a3 with SMTP
 id i184-20020a0ddfc1000000b0052ee81444a3mr331104ywe.505.1676393325910; Tue,
 14 Feb 2023 08:48:45 -0800 (PST)
Date:   Tue, 14 Feb 2023 16:46:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
Message-ID: <20230214164638.1189804-1-dionnaglaze@google.com>
Subject: [PATCH v15 0/4] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <Borislav.Petkov@amd.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Venu Busireddy <venu.busireddy@oracle.com>,
        Michael Roth <michael.roth@amd.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michael Sterritt <sterritt@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The guest request synchronous API from SEV-SNP VMs to the host's security
processor consumes a global resource. For this reason, AMD's docs
recommend that the host implements a throttling mechanism. In order for
the guest to know it's been throttled and should try its request again,
we need some good-faith communication from the host that the request
has been throttled.

These patches work with the existing /dev/sev-guest ABI to detect a
throttling code.

Changes from v14:
  * Split double-buffering into its own patch.
  * Changed cond_resched to schedule_timeout_killable.
Changes from v13:
  * Added double-buffering fix to the "Fixes" patch to address a secondary
    concern of zero trust with respect to host access to intermediate
    cryptographic computations in shared memory.
  * Removed module parameters and rate limiting in favor of just
    cond_resched.
  * Removed possible infinite loop of retries by giving up with an erased
    VMPCK and -ETIMEDOUT error after 60 seconds of retries.
Changes from v12:
  * Reordered fix patch to the beginning and kept it minimal.
  * Changed documentation in same patch as the respective change to the
    header.
  * Changed exitinfo2 in dev_alert to print in hex.
Changes from v11:
  * Squashed all type changing patches into 1 that modifies both sev-guest
    and x86/kernel/sev.c.
  * Removed fw_err field from sev-guest command struct (renamed exitinfo2).
Changes from v10:
  * Added sev_guestreq_err_t typedef early in chain to change a signature
    acress x86/sev and virt/coco/sev-guest in a single change. This makes
    all patches build. I have 3 cleanup patches to change the type and
    subsequently remove the typedef.
  * Changed exitinfo2 initial undefined value back to 0xff since Thomas
    indicated that a firmware error is only 16 bits.
Changes from v9:
  * Rebased on v6.2-rc3
Changes from v8:
  * Added documentation changes.
  * Changed commit messages to use passive voice.
  * Simplified control flow for __sev_platform_init_locked.
Changes from v7:
  * Replaced handle_guest_request arguments msg_ver and fw_err with a
    pointer to the snp_guest_request_ioctl argument struct.
Changes from v6:
  * Rebased on the IV reuse fix patch
  * renamed rate_hz to rate_s and fixed its MODULE_PARM_DESC to use the
    correct variable name.
  * Changed sleep_timeout_interrutible (not defined) to
    schedule_timeout_interruptible.
Changes from v5:
  * Fixed commit prefix text
  * Added all get_maintainers.pl folks to commits' Cc tags
  * Changed SET_RET_NO_FW_CALL commit's metadata to show pgonda signs
    off and is the author.
Changes from v4:
  * Clarified comment on SEV_RET_NO_FW_CALL
  * Changed ratelimit loop to use sleep_timeout_interruptible
Changes from v3:
  * sev-guest ratelimits itself to one request twice a second.
  * Fixed a type signature to use u64 instead of unsigned int
  * Set *exitinfo2 unconditionally after the ghcb_hv_call.
Changes from v2:
  * Codified the non-firmware-call firmware error code as (u32)-1.
  * Changed sev_issue_guest_request unsigned long *fw_err argument to
    u64 *exitinfo2 to more accurately and type-safely describe the
    value that it outputs.
  * Changed sev_issue_guest_request to always set its exitinfo2
    argument to either the non-firmware-call error code, the
    EXIT_INFO_2 returned from the VMM if the request failed, or 0 on
    success. This fixes a bug that returned uninitialized kernel stack
    memory to the user when there is no error.
  * Changed the throttle behavior to retry in the driver instead of
    returning -EAGAIN, due to possible message sequence number reuse
    on different message contents.

Changes from v1:
  * Changed throttle error code to 2

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <Borislav.Petkov@amd.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Venu Busireddy <venu.busireddy@oracle.com>
Cc: Michael Roth <michael.roth@amd.com>
Cc: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: Michael Sterritt <sterritt@google.com>

Dionna Glaze (3):
  virt/coco/sev-guest: Add throttling awareness
  virt/coco/sev-guest: Double-buffer messages
  x86/sev: Change snp_guest_issue_request's fw_err

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   |  21 +++--
 arch/x86/include/asm/sev-common.h       |   3 -
 arch/x86/include/asm/sev.h              |   4 +-
 arch/x86/kernel/sev.c                   |  13 +--
 drivers/crypto/ccp/sev-dev.c            |  22 ++++--
 drivers/virt/coco/sev-guest/sev-guest.c | 100 +++++++++++++++++-------
 include/uapi/linux/psp-sev.h            |   7 ++
 include/uapi/linux/sev-guest.h          |  18 ++++-
 8 files changed, 132 insertions(+), 56 deletions(-)

-- 
2.39.1.637.g21b0678d19-goog

