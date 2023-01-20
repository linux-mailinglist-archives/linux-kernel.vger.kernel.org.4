Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2E2675FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 22:52:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjATVwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 16:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjATVwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 16:52:07 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD8280BB0
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:06 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id jc17-20020a17090325d100b00194dd8a6c27so2226462plb.17
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 13:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YCPP50mHftdrkugDIMlvr2wVSqJJApexnFpETZnZzW0=;
        b=X2M3rLR8vE1RJwS+2TFg3bJfcAv1ZEiCKtOeRX3Sf4mSKLfxZ3t3KAPoklBYwfEcKI
         EmAsLcJ/hIo4heDlEs9welo47sawB/Eo0Vpv4d6Q/jZbJf90hzatyjqbrgpVXIo+ejbV
         fYDTz6zjP516fwJluTNzxdTQsnYI17CmNOg2gGS/6hcI23talU83VobSxbEItki7RTWj
         q9kz/sdP8N/8iOccbv26GYJz40n8ZJpbpisso2l1zFRPr2/4cyxLW3rUmidobVoJXFC+
         cotAj2tx/1UjVOM/fUgd/EZCJPx5XDGoeC4b00ePABOpJVGS5iIuIqrsSv//QHbEw8sP
         klBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YCPP50mHftdrkugDIMlvr2wVSqJJApexnFpETZnZzW0=;
        b=W9ROEN/ZM9xxcuqS0ZsmBq1r4/Jm971caZc/OKJoXNK4pNg12myUnvwSKwAKQweVmY
         fvYvhhlRTUnW+GwB6N7lIivulawJLnungEwYvn9BmyE6sOCOgBHQR4oYtCdKnR2sRHwj
         X1GYn6G3uxitSIyhiYR7Y9JXPVqJr3aFWIfN71TELlJQFNiIho07uBojxtPeoPbCx3DJ
         zfsaQFZ+Cm6TIrKCjkGWZXNZdRzvEhDYC2Sfwb0+S8JYQq7ieX/332Ld3T5rfrSOEml1
         FmirBIrSoobMROzckYG1niir4lakOFvuZHSSwygmUnNUa5Wi3frt5TEkR50Eaw4IzzW2
         TGaw==
X-Gm-Message-State: AFqh2kqQa+q4yt5K6iJkrjpmZ33DbtNjmQ2G5d9TxdaSdB4fMwZ0QCky
        5ecMOuTiHgni9G4c5fy9OnlWIcliNuHHsms5Hw==
X-Google-Smtp-Source: AMrXdXtv8orWqEiUIxO0YpcfUv4PPEQN1V5nRM+6ZfzbWGgCdEEYoc2uTbgZX9HHNdbeGovIKZN067GE15XoA5mWYw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:aa01:b0:194:4edf:b178 with
 SMTP id be1-20020a170902aa0100b001944edfb178mr1541674plb.4.1674251526054;
 Fri, 20 Jan 2023 13:52:06 -0800 (PST)
Date:   Fri, 20 Jan 2023 21:48:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230120214857.835931-1-dionnaglaze@google.com>
Subject: [PATCH v12 0/3] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
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

Dionna Glaze (2):
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: interpret VMM errors from guest request

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   | 21 ++++---
 arch/x86/include/asm/sev-common.h       |  3 -
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 13 +++--
 drivers/crypto/ccp/sev-dev.c            | 22 ++++---
 drivers/virt/coco/sev-guest/sev-guest.c | 77 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++-
 8 files changed, 114 insertions(+), 51 deletions(-)

-- 
2.39.0.246.g2a6d74b583-goog

