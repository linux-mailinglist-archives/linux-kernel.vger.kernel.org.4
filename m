Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50E4674543
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 22:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjASVxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 16:53:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjASVxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 16:53:07 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A7AB1EDB
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:34:30 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id u2-20020a17090341c200b00192bc565119so2018181ple.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 13:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Voz2cPbyTGcLhdRPa/ltDW1JwajbV9yh0vKVRBbRKuk=;
        b=EpJxslMiPB369mzUjjkYlm6uPL2QZKBT7oLzN1SQCEJGb4OXXMQ43ol3BP9+XPdEML
         mKddYwLg2y/WgeVcvjE7lSb4L8IwQq48ztab2GpzAUIxLhCraMPm4flX/rvLREjQ1BJ/
         woPfmP8Q23JtzXFIS7OaFL9JT1D2WaGEXJL3USd5zlyxb0dpYJ+W1U25rhavicsawLcR
         XJA2m/JvJ0TkuWoccvxVy46kO3QcVjeALowtEpv+iJzDWc0cBGponBViOUHM0/hSyi7x
         qRuaQX1FtSizviOM28/qGR/R2MLtvi6ppiyasaYh/ZRh1uoBjiHnPkvrwWHMOKVs/hj/
         tSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Voz2cPbyTGcLhdRPa/ltDW1JwajbV9yh0vKVRBbRKuk=;
        b=if9xMFwdx7EJvyAObqhqtlB8usjW/IB42WTbWEAaW1cyA+kcEkRaapK9E5HfhFFvG4
         EjPxrnJiy8ltUMGAGNNF2RjmshoABesQZnKG+qhOvayA0+g0596ZSvJK+9P0qSmq/vbi
         jxJsguC8naH1q0Wa6OtWitGPVVWSgavFbeNz1jyiqsnJ7TP2IGYjewcOHRKaWknRmsxs
         gRNE3xDKHYSjST+ZnWDRw84PjygYlMskgI9C2nb2yZ1aPuKyGW0x7xtWUg63R0Q0PMzI
         6F86fwvONqR5FfzymI23AqrtZnPAL3PViTTZjLiDGUOmzD6kCXxnhy9SdxQKeYVZvJnU
         8lNg==
X-Gm-Message-State: AFqh2kqgcTsFaGadBQnSbFJ8gOmr2qiew1ZV7qdpDbYhg81B4xDi6GFm
        U3xf5U5lF3SF6AsS/7zwtjxqRAzollneA7XVpQ==
X-Google-Smtp-Source: AMrXdXsudqdC6kbrhygpqA4CaWcuUKcCGFCHdFeIRQ6SZ2R4tjo+8mTEWD2IyZTjmldQoTwpG41fDqfzm9ziS6v37w==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:b111:b0:189:a50d:2a23 with
 SMTP id q17-20020a170902b11100b00189a50d2a23mr1212871plr.32.1674164069271;
 Thu, 19 Jan 2023 13:34:29 -0800 (PST)
Date:   Thu, 19 Jan 2023 21:34:23 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119213426.379312-1-dionnaglaze@google.com>
Subject: [PATCH v3 0/2] kvm: sev: Add SNP guest request throttling
From:   Dionna Glaze <dionnaglaze@google.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on

[RFC,v7,00/64] Add AMD Secure Nested Paging (SEV-SNP) Hypervisor Support

The GHCB specification recommends that SNP guest requests should be
rate limited. This 2 patch series adds such rate limiting with a 2
burst, 2 second interval per VM as the default values for two new
kvm-amd module parameters:
guest_request_throttle_s
guest_request_throttle_burst

This patch series cooperates with the guest series,

Add throttling detection to sev-guest

in order for guests to retry when throttled, rather than disable the
VMPCK and fail to complete their request.

Changes since v2:
  * Rebased on v7, changed "we" wording to passive voice.
Changes since v1:
  * Added missing Ccs to patches.

Dionna Glaze (2):
  kvm: sev: Add SEV-SNP guest request throttling
  kvm: sev: If ccp is busy, report throttled to guest

 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kvm/svm/sev.c            | 47 +++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h            |  3 ++
 include/uapi/linux/in.h           |  1 +
 4 files changed, 50 insertions(+), 2 deletions(-)

-- 
2.39.0.246.g2a6d74b583-goog

