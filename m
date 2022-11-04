Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CB6061A204
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 21:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiKDUQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 16:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKDUQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 16:16:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1748745ED0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 13:16:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 125-20020a630283000000b0046e9babe7b3so3030999pgc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 13:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SPGoNE++quTPKk7M9kXwumlWX1jUkQJNG2L9fOTVZ7Q=;
        b=QOtWDCZHcwZq1VA2Yz+7ejGKdbICrOi681AFKe/8ED1zOMlNYPz9dHv2fBpC6yW5/9
         CzK/2y/XkzSNPsCREkOLEW7IM6GRTM2+2FhUrwbDGt1LoI4CCKchcdtJjMLSzM1+cL7W
         +ksYz8XYZFcE0vIIOIJdY5IZTewnbUIFS4xBKY2S9GqF2Ou22hEEqt+LRqnfV9bNibct
         igc4s7FFlGtrKNpzjhZ/r5y+pc4LNZdq8aBRRU0vWZUQjYskHQC9h6UDnX5xwbCxyLnI
         +CKIuQC+3+ecA/vrLXPbiPI5tW++QR8ijO0eLt1k1owXvasJtIZ8iNNrNgrHkijNz3Cs
         z6FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SPGoNE++quTPKk7M9kXwumlWX1jUkQJNG2L9fOTVZ7Q=;
        b=K+++hLK6fXJRAZH1G37vMyZOy0SeAfW7crHJbUneBgaRaK9nKrslS23lAopFhL+03g
         WmXI4iuSU3t7OSmgBvViS/NdoruG0IFWZGC7rETNribmxFs9e5nQyV2SwvLcYKzzbPTk
         L3PiReDJ0knBcnfwXElqBBF1OqJEjTWd/8g44RaOBkqMZDlrQUw5W74Oz2jNjo/zN0K6
         8FqFUDgBF6/J1tD7nJzpgCrQKbY+4LJ6rxsT51GHaY0WgIL19aTbxoTV8hVVzfy6L+UW
         KGtSYy9kB0lmuqXDG2QtPgxIRDnne0iL3PdauHsUT5tdpm3uePkILMPEibWC50r8W5bB
         GzcA==
X-Gm-Message-State: ACrzQf3/J4TO2DUqJwSRujrvvaD81M4Fm/WaJd6lDgKVQnmApMyefdS2
        5GmXbB72qQeJau6inBerZqPCYeJtxRMucGphGGDFWg9GoVKOQ+hFUVeYgCjqQCrn4okKzsJpaAd
        eiQSWjJOcCAugeBf67/gJrviPs76MLutK/xM2FcbRmznvgpHrn8LbPtf+XistxQjJUQoP1oZJ5q
        DVYPNiZG4=
X-Google-Smtp-Source: AMsMyM7GQEiFtwYcIrg5bO5Gozt3bTJ9vqVcJs+LvAj1L2b2NRimkYw9l3gPkfFr90pelW+44p6rMdHd63yirF1ifg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:b89:b0:56d:2a21:a6b3 with
 SMTP id g9-20020a056a000b8900b0056d2a21a6b3mr33441906pfj.56.1667592987372;
 Fri, 04 Nov 2022 13:16:27 -0700 (PDT)
Date:   Fri,  4 Nov 2022 20:16:12 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104201616.2268815-1-dionnaglaze@google.com>
Subject: [PATCH v7 0/4] Add throttling detection to sev-guest
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

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Dionna Glaze (3):
  x86/sev: Change snp_guest_issue_request's fw_err
  virt: sev-guest: Remove err in handle_guest_request
  virt: sev-guest: interpret VMM errors from guest request

Peter Gonda (1):
  crypto: ccp - Name -1 return value as SEV_RET_NO_FW_CALL

 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 ++--
 drivers/crypto/ccp/sev-dev.c            |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 63 ++++++++++++++++++-------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 ++++++-
 6 files changed, 78 insertions(+), 26 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

