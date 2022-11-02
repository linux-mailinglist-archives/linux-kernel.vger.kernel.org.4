Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 307A26165E9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKBPTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbiKBPSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:18:52 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B69E65A4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 08:18:48 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o2-20020a170903210200b001872421f5b9so5928360ple.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 08:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DwWKTz8f3eiUA1wYKum79S+2sGYP6kV3Rd1XEcpXlMA=;
        b=DMkjWOSGioOXjTcX0zZmVu9KCY51fznlgNW99h0U6+ealHDqQUYPqDWfyYkGvm36ss
         mwvReqeJX9BKoy4RbcJIFtHO1SsTBltw07pPw3nwlYvNhYWUOPazOB+UBlDMrbc5C8P7
         cRNcUy69qUrx7Qag0spvxu0IKMjMb/C7M+dKlZKU2UYXl7qrUrPNfGtoRIiYLmoX6TwT
         ysYYtDAB+/tDuAbBXLcW0aVO5KzuLclzwAqpoKqw3cFhWhNL4cBm1YxcYERu/9PyXtX8
         5jisfIlEwX3gqbvaixChUbzoP/oGHyvmEme6iEpwWhIl5g12brQbd9d+y77w+OHbfS78
         8m0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DwWKTz8f3eiUA1wYKum79S+2sGYP6kV3Rd1XEcpXlMA=;
        b=lPrz+8llMU3iuSaG8oKGSgy/D8XFBySNl7OZ9YgpMGW34AhYRebCySaoQia19w+9Tw
         0AA0uhZpww7nQlTciaXskz6BaCi56kBOojNVYYyz830rvz8eQ+/G2KCKGO074kC3MKqp
         7g5bXxj9xnAZqfxjbykqwggw74T5+32UeGMAxkz5t0aLaQWmPYClhesofkvBS4urEHcf
         XzHLC95fcv0ON4KQ4/Qw3RmbC/7YYGB5G1inbehAx58c1WzcHZvUhPRyBRklPvOEohXS
         lJ80HLcm2OG21dkf5muzY8imd/EWwl6bT6YXvgnmTEiy7JKvNeneiYNBLKjNv7QbKo2i
         1S/g==
X-Gm-Message-State: ACrzQf3k1BY7ZKF0Z2xcXSwckB78wECUs8GrfDf6KliHHtbkaup3vDvC
        P6sJwd0+ky12p8M5Ag0BkymfXep1PjROKSFWcG7G8XWWlqr4Ey0bmvq0pBM1qt88IL/HanuU+Ev
        jOs2aS84w4O1++qn54NMwjdtumh8B55RTVjRoqnUTIlSJFfAqzYX0cxKRJi3p/wzg3EdGvo39qH
        JYigejDuQ=
X-Google-Smtp-Source: AMsMyM6m5Wl9FMW1zwDMdaD9NOYfthW1IMFe7cMyhB6oiVmv99ptqiVfv4PVhkqXaHNLTe8YiIptoie81NK+Toiwjg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a05:6a00:d72:b0:56c:3c45:6953 with
 SMTP id n50-20020a056a000d7200b0056c3c456953mr25647750pfv.54.1667402327848;
 Wed, 02 Nov 2022 08:18:47 -0700 (PDT)
Date:   Wed,  2 Nov 2022 15:18:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102151836.1310509-1-dionnaglaze@google.com>
Subject: [PATCH v5 0/4] Add throttling detection to sev-guest
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

Dionna Glaze (4):
  ccp: Name -1 return value as SEV_RET_NO_FW_CALL
  x86/sev: Change snp_guest_issue_request's fw_err
  virt/coco/sev-guest: Remove err in handle_guest_request
  virt/coco/sev-guest: interpret VMM errors from guest request

 arch/x86/include/asm/sev.h              |  4 +-
 arch/x86/kernel/sev.c                   | 10 +++--
 drivers/crypto/ccp/sev-dev.c            |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 57 ++++++++++++++++++++-----
 include/uapi/linux/psp-sev.h            |  7 +++
 include/uapi/linux/sev-guest.h          | 18 +++++++-
 6 files changed, 78 insertions(+), 20 deletions(-)

-- 
2.38.1.273.g43a17bfeac-goog

