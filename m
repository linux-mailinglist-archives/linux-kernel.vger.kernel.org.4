Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86EBB607D23
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiJURAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiJURAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:00:13 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B31D631DC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:00:01 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id i7-20020a0cab47000000b004b4376895bfso2675383qvb.20
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nFhv/vtA62WAg7cu+g2W7nnuN+CB9hRxAwVFjCLPz/E=;
        b=N3PqebcHnGpwfb1EnrsvDdTvnRYDuxYhO7jFoLMpeBfvGrzFNly5uNbjeVK5y2xGO/
         6is2b55BOjkY6q1yB8VZCB1u/xQFL0J49wVNIgjwQofBWyMzefs74wMwT29HxhdVPLDx
         1uJFleYdC9+M5SFk4Yy4AJZDSsLv2CzSEBuC4vnNk+Q4sx48CtPhqS9k4gls0mbDN0xe
         3fbV6p0GpUzduBPrg3/ND8aoLaMa7lIWWkj6FjmQnzYlQGVbCgUFuzgASs5w802IJ3Nq
         XGfXTMMdhfb4YTuAPEvL7N8WfkSnXvF+m963gH42Epe6KwLZwnMGDQJP8PIYiPJhhCz4
         sKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nFhv/vtA62WAg7cu+g2W7nnuN+CB9hRxAwVFjCLPz/E=;
        b=oAc2B292xzeOjCIGgTLF1qjqLq9gn8zlHlI8ATlDrvKEj4gY5msd6KR95QGtmwtJXf
         2jl7RAse4XwQaLW/FWBLW7wwTcGrNR74cuXnpG7e0Elr7ElSTHGcgjIZMAZ39a5iA5zz
         MoDkW+w/YZlg10tcMsfSJZ1doGNbYw5O+7lcFFKZPy4H5oXjKZcmpgq8F6H7GtAPkQLS
         EjOJ6obp4AcASGf4RUaR52HPpAzKOYjbWbZBfH+f9giXpeJOs8JidWzuGDamNpOlJyUD
         rZPJhhJLjSQe8Wo7MsxOV/5TByaddUnrUnPM2eIF9QBM2/mjUnrg2nTq/4y4RaD33cXR
         OJ6A==
X-Gm-Message-State: ACrzQf2d4HafIOJUIitxszzTEV1BvKJ8dy+jjd4Xt9wlSgJrxvCi9GS8
        uARct9YcuFvxNY7DqYBl5pxvhSnbzwf/MV6K2z9hXz5ZEIyfIx4F/scJGe3Kd8B51THI4tXe96Z
        hu9EIplRK9BlUobhUlkWBSXHaaCgcj2OwyRFhEMrxbpwcCBe6BS17itje2MrFoMUKl4+Oe6o/he
        efMHovS60=
X-Google-Smtp-Source: AMsMyM7Wi00SxhbDGTUYIzg/4rocJUC06QDfyyWfEnn2zSQ8aKkHQNCpHL+gClLu2odOPwt5pub0FhA0xR+oQmo8/Q==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:903:248:b0:172:7520:db07 with SMTP
 id j8-20020a170903024800b001727520db07mr19594238plh.76.1666371588758; Fri, 21
 Oct 2022 09:59:48 -0700 (PDT)
Date:   Fri, 21 Oct 2022 16:59:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.135.g90850a2211-goog
Message-ID: <20221021165943.1968044-1-dionnaglaze@google.com>
Subject: [PATCH v3 0/4] Add throttling detection to sev-guest
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

 arch/x86/include/asm/sev.h              |  4 +--
 arch/x86/kernel/sev.c                   | 11 +++++--
 drivers/crypto/ccp/sev-dev.c            |  2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 39 ++++++++++++++++++-------
 include/uapi/linux/psp-sev.h            |  7 +++++
 include/uapi/linux/sev-guest.h          | 18 ++++++++++--
 6 files changed, 62 insertions(+), 19 deletions(-)

-- 
2.38.0.135.g90850a2211-goog

