Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0FE694DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 18:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBMRZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 12:25:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjBMRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 12:25:35 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B192F1D930
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:33 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id j28-20020a63551c000000b004fb3343142dso4906846pgb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 09:25:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9jAwlVyjiUMpd8RKZIdP0NMbKQ8H1bUqhvPnI4rVw70=;
        b=YNrxB1NJUdcH26opiqSnnwOwOsLsKtubpppcxjhWD6W47D5HM/p0LomzCcW+5pMNzW
         v4mnUk8coNJ/wVfrAhmRJ1yKxpWuzMHl8W/01MoFNBU/HqWiO+lAhEvK6AEvzyZijIdl
         Q6XXlrvt7HBdGxkjWmMp7lOZyaGiOZEHFMmyV9IvJW11d4bMO/TBjN7JkAKpnEz/eUZs
         HVfv1Mp84k5zJg0eof7ypq8HFLNO+ylkjzibKNXS40ebxGchXhT8PrfB2JD26tMv6jrF
         CKSI7qMuxcYad919TqJprvCCJ7chQqyBsE/dTK9r9u5KK0vn2S79wU1I1pjftRQR8pus
         vQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9jAwlVyjiUMpd8RKZIdP0NMbKQ8H1bUqhvPnI4rVw70=;
        b=OxE9o5zFV2Qvt6zsTPbhTN6okAhU9nHLReUZihD9w6gHLZbbfagtPBghS8hWCYHeWC
         IwVSF6zui0jUVom+QiK+vhZtJWZDh/kvjVqmVT6VdnliH9BagqgBCA6uHc18on2Ub90S
         GQqaa+EX2IaKoS6ax+Ct7nANfM4wpgV1iIFyidAijf5zrjCNeLxy+FO80+mz6pyl4zpv
         7Np3t8yCSUaR4iqpeesN4w4+7h3MInrKmpZW5r3neqPvpYCtInE3FX22+Btc3joLgrF+
         +nwxvBxoIFvSP9wn1hADmGyq8uD7tG/avgHAvdUtOZowIykMdxm1v7U3ZI3QikayWqkY
         CGbQ==
X-Gm-Message-State: AO0yUKWcl+99YEzPZgBp2xTbMVI+dnMN/ziOTsHwHhuKh7AhYGCQB0lP
        shEwPyb+bIOGQqCzGuqFgxF6HqMuvHXzpxpezaR11Hl+hcLJz6u3roxTcIdSAmP3TPD5NBnq4B/
        5ex7om+oZC2M7/Ud6TAbLs2EXAly9UtJtSLVi9bNptsURh5XOpw1Pn4j/QjfqZ+r+dbh/Q30lRM
        0pZCvBVfM=
X-Google-Smtp-Source: AK7set++YezQSZ4iTpPdXS/bJUg7azPrpYexH8PE789bMndvd804L8f0uI4gR0OBcaBrk34ctxSoBaCvdb6lWISXkQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a63:b302:0:b0:4cf:122f:2102 with SMTP
 id i2-20020a63b302000000b004cf122f2102mr4451521pgf.98.1676309133002; Mon, 13
 Feb 2023 09:25:33 -0800 (PST)
Date:   Mon, 13 Feb 2023 17:25:21 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213172525.575766-1-dionnaglaze@google.com>
Subject: [PATCH v14 0/3] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
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

Dionna Glaze (2):
  virt/coco/sev-guest: Add throttling awareness
  x86/sev: Change snp_guest_issue_request's fw_err

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 Documentation/virt/coco/sev-guest.rst   | 21 ++++--
 arch/x86/include/asm/sev-common.h       |  3 -
 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 13 ++--
 drivers/crypto/ccp/sev-dev.c            | 22 +++---
 drivers/virt/coco/sev-guest/sev-guest.c | 95 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 ++
 include/uapi/linux/sev-guest.h          | 18 ++++-
 8 files changed, 127 insertions(+), 56 deletions(-)

-- 
2.39.1.581.gbfd45094c4-goog

