Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E73860BF7D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiJYAXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiJYAXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:23:25 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C5210C4FF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:01 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id l185-20020a6388c2000000b004610d11faddso5220473pgd.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 15:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AwCVjIH3fuXtFw6RC7AMHfdiXpbNVRxho1cvQpgLuOk=;
        b=MiCR/3mNpnr11BBjH3q1p/mmj/KYq1dJcrlyj302pTCZ99GrpG21yCIWInryUWsYZO
         NahMPSx10izNkzXzGNu6VuMqvS9PDVKRTmuekqbnd9+81WcCEoY2+sk5UfeOAQs6zAV7
         fFjN2hwGqdyEbUsCyHre3QVnMTMQuZ+4CHJHlAx6bTE/u9gcMci2n1FAPJj8gdDog/3R
         MU/dE9tG3+BnpLNXBJFE+AzKK9U+p3SVFvYCBlqhvODCgSU7io0wxiMliLuLoCzdT+hH
         Es2B3h9Onr5vjws3lVIX3/Q0+dM+uxCe4S+YEfQkQkgpsz4gLAlKd0HD68TJIvdismvx
         kVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AwCVjIH3fuXtFw6RC7AMHfdiXpbNVRxho1cvQpgLuOk=;
        b=PVtJxBKqDkO0pn1jlUwSy5QbKcKro4enpAIMdesQB8SgxuI+P7MY1BhX5Yd0Aj5bE1
         f5L6iuOAGRz4R5JHsiRMT/4iwbWWJk3pGOY74VNKJC1vBswafkC+Es0gPtgVNncOV7UQ
         6cOT1dn0IogcaVuG4cXzjdViibiAoSMOl+YwdbgueXW7fp01k5VDEOPxYV5VOc86h1y0
         2i2YCVsEogqGPa98e23qlW65zoEuyp8TSrs4iO2FyenCe9vaHMU4FWwg/lpz0AIQFrTX
         pAFo7o4/8KFgADm6coJbxpBF/RCgjumSsQyYMDWB1fkdYAClMaVSnktkIt9nBSeta90c
         ZLyQ==
X-Gm-Message-State: ACrzQf1ATmZK+l1eu4ge8efeLv0urBu3rlzRiGN7Ui3ufirxA/HCK5Vs
        mInN4kzNQyczSM4NHHcO8ckGwUQ3g6ILQyF+qXmSwzGD+MJjeMOx8ZuHVdCnTAeoL2iGF/+VFJk
        kAsKjqYN9ClCIdZcfgKrseBe4mlt5H9EoMufZrwNECj2nQredcQucc4xEL6yiEvR1ZCApw9cAV3
        ipD1Z87lM=
X-Google-Smtp-Source: AMsMyM6j/3+pJGg3lbzLNejHovD/qWs2671bNkOnwXDIiCXGYcMWROGtYQqcOfM8MiYUmnklFpfgj7HXsDciQU+IKQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:aa7:8011:0:b0:567:70cc:5b78 with SMTP
 id j17-20020aa78011000000b0056770cc5b78mr31698384pfi.29.1666651620446; Mon,
 24 Oct 2022 15:47:00 -0700 (PDT)
Date:   Mon, 24 Oct 2022 22:46:53 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221024224657.2917482-1-dionnaglaze@google.com>
Subject: [PATCH v4 0/4] Add throttling detection to sev-guest
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

Dionna Glaze (4):
  ccp: Name -1 return value as SEV_RET_NO_FW_CALL
  x86/sev: Change snp_guest_issue_request's fw_err
  virt/coco/sev-guest: Remove err in handle_guest_request
  virt/coco/sev-guest: interpret VMM errors from guest request

 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 ++--
 drivers/crypto/ccp/sev-dev.c            |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 61 ++++++++++++++++++++-----
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++++-
 6 files changed, 82 insertions(+), 20 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

