Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FE6617392
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 02:10:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKCBKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 21:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKCBKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 21:10:45 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1736B5FBD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:10:45 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id m1-20020a17090a5a4100b002138550729dso95959pji.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mx+leU/OWscSldITB3zFpjjWetd6P6K/f9rRzitMlcU=;
        b=FB7DqmA0EsKuQjHGYVy6dlGV3LQmMHrxbEDBmyNUCU0nLo9tWvbXVXq2p8EX9pt5RT
         L0AZX85Pyhm88hzJOo+TL3Tj2ZSVpPOluVWzkIn7h2G02+a8vLAPujhjqpOOkEb2eI8T
         082tPzndK3fvZ5dOL53kZpS/0v/UB6PROEdVvpRhxQxSIBMViXPwm/B9+bBI9Wb6kk/n
         0VZ/kr8PlIErWquySXarbqhYBrWDHG1PF7JYhgSGQ2pvUpOkGXGUVTf/lm8WIDMP35gz
         Rkn+3dbPmgzAMuxH7fqTBjfdMZteVDG0d17wQgqn9UW3BxHQSnUUL/f6Q6QFt0q0kMyY
         Hbfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mx+leU/OWscSldITB3zFpjjWetd6P6K/f9rRzitMlcU=;
        b=VCj6qlRCL41NsxJxFf+oqoSOx8A3YkelKI3m2V8njQo6svYiZ3uZHghQ2Day1BfIWn
         1QMwLqxT7XPiTl/iVG/ZgxnU+Dy6wMLAgR+VxzjOx+f8fS8/rqq2/g4hIgCnRg9+QmLz
         zkPV1bn1iWw7gyKMCkcOdQqEeonPnqWqjFbBxOi0DsgtEA49GBCdeDw0M8xYPIQKfwaQ
         Y4V3qxND2Nryg/5Ff5gVZWbJnMomCGmT+A4GTo6kFuHaQbwXHNpV7ZDA0cLualExs3k1
         Wk2VyzNicExiSZVkKPp9afov4xrSK1f8+5gsWpsBHfSzk1RopEsnCRww7nSQ2bgi2G9g
         MMQQ==
X-Gm-Message-State: ACrzQf30Xgei5AwLztGonazBScnsBdPfFicJVNVXaQuvTPyRPyEYexxK
        uH26Rn1FqrcVvwARY3F35eRh7Wjhr+LDrR+7xVSK9+DXFyiTX/UokVumHgDW7QEEYXEqkppeI88
        0cJFKqJX4NFwesY/TxIfuFpshE915TW4KWYUxAK8tRjmJK9KDdfxoWAdaEFvZX8gJu1576pjZdz
        gCEdoMRdg=
X-Google-Smtp-Source: AMsMyM6LQPFEEDWa1HxlDiQdxXwRLqDZ8gpD+dwgBslOOmaFS6lpe2gPi0IogW1VyhReiElJZgVwxhwegBxMdsfoFA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:3901:b0:213:dfd5:a75f with
 SMTP id ob1-20020a17090b390100b00213dfd5a75fmr19732129pjb.233.1667437844445;
 Wed, 02 Nov 2022 18:10:44 -0700 (PDT)
Date:   Thu,  3 Nov 2022 01:10:34 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221103011038.1542614-1-dionnaglaze@google.com>
Subject: [PATCH v6 0/4] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joerg Roedel <jroedel@suse.de>,
        Peter Gonda <pgonda@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
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

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Dionna Glaze (3):
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: Remove err in handle_guest_request
  virt: sev-guest: interpret VMM errors from guest request

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 +++--
 drivers/crypto/ccp/sev-dev.c            |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 57 ++++++++++++++++++++-----
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++++-
 6 files changed, 78 insertions(+), 20 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

