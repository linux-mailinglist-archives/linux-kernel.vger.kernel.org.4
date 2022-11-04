Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED5A61A547
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 00:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKDXA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 19:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKDXAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 19:00:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCE642F72
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 16:00:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id n1-20020a170902f60100b00179c0a5c51fso4446999plg.7
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 16:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LUDNOFrCabE9fqr4CIKxpjV0lKU31zwrwQxKjbNeIvE=;
        b=VhaCKaZBHbMc2kop6ZZi96uSrzdSP01GxTxv1w46LALkG4vLaDRK+fM6mtqq5wq5FW
         EGfO8Qz2QNywChLOhqfqOwlK0FBWb5X+rAgsBOn6bWneCwT3AP4nEJD/weHKxgY+1Z9v
         Uj6seLeo5MPyY/+WY8os7G7zQf5Y63SZ730dDKTUvEqDbOI3LzwFI96I3t074ZOK4zio
         1+KAJ5ljdwSiRtqWVTRC8QGu/0Jvm0048bHot24Haniy4XOVlN75Hs2k+uS9cjZtHwrT
         6+3qO87fpuAVgilzktZYufzJy/auGsZ8IqNwsZ7PdEm3X6lZhi/v14W/D72OTNyTZDJC
         rUOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LUDNOFrCabE9fqr4CIKxpjV0lKU31zwrwQxKjbNeIvE=;
        b=B03wfUOrfj/gz8Lq8rDvbcYadJ0j8UIDKVtpYQ+MXK8RoL24Lq/vdKYHdcphrBC1lr
         j1Y7wWIhKeusUc4ACvPHV++QusXtKh6Iubw5Z9xTI6gfUIA2rngoWBHwNeM4s2Hkbe+j
         sagP7EiodY+UfdtSldCukfGd4Wd34hKNFWbzF8l0rgsw5jncJ677nm7yZZ/zqjF/u9JQ
         4D5ssJ8abuEiqBChZOxqXwVz0wkpojD3x2fUqX7mLprQymj1hKG2rBMX2XL1dSAKmZ9B
         HFFiBTpvXb+0SQYidcR1drIncfpCo2oYc4wN/sGvtNRuBULHRWDF/Ekng4DUODVECEXt
         IwoQ==
X-Gm-Message-State: ACrzQf02/LyG18jJgEj4IOK6dbFjMQdxtQ4z2Dsn+3tn56yKo1bRvndU
        ZjdtHKebTf0dWpGm5v/EfT7bucms1mOsbtoB1s60lIDs3VoUVqe4fyE1W0GR6OF07rf5A2ksRzl
        i5Tr6O4VYcIFvbT1oYz6AKdrOwAYBFLcIgwZsX4p3Pb45rn0gJYEDesu86YQS8LkkVoMnDH4Vo9
        rM8bHrZGo=
X-Google-Smtp-Source: AMsMyM7t9LXDDjtCjsEWzZ2p2R780xMaw5eY+uCtPIyPy6RNucjxrsfn18nMDBbUpSqZuf7jMjRYXRyIaaCe8jOtgA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:1110:b0:178:9f67:b524 with
 SMTP id n16-20020a170903111000b001789f67b524mr38239984plh.50.1667602848377;
 Fri, 04 Nov 2022 16:00:48 -0700 (PDT)
Date:   Fri,  4 Nov 2022 23:00:36 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104230040.2346862-1-dionnaglaze@google.com>
Subject: [PATCH v8 0/4] Add throttling detection to sev-guest
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
 drivers/virt/coco/sev-guest/sev-guest.c | 76 +++++++++++++++++--------
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++-
 6 files changed, 85 insertions(+), 32 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

