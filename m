Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD2621E8D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 22:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiKHVcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 16:32:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKHVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 16:32:31 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ACF6176D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 13:32:29 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3697bd55974so146800617b3.15
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 13:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVnwybF1Djy6AD6SuMEt9dMImSI/+BPUs0lJ15TFezw=;
        b=hs1F57t1c2qCzMvcb6uLQ4xKi+vPfN0kk2Z8pIzt/GuaSj1lv/qhhMsDABPwj3zxUj
         uKWOm6A5q9U4ZfaICJCmsKW3BDLvLf9PoMtYs2A3tuJ7KNP655p2t09aSyvnZLV+yH5U
         hPlYsyaScoHlX98KkZ+Op2RJYyxpiaLbkNraZFQ5btVgChzLTMQV/SoBCtiARDnrAEh+
         bLvBKIIez5VrEb7qxXKXdU6O4cc18eqN4OtCEFlgN6oGG9UEzpp7EQxyHMro76Z6VOau
         stm52dN4NrGoJdkWOMFMSnQkg1gyH7S0mGe+FvsOXmccLAPmoDYAzKB7k3rBTfkl8HrZ
         Tejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVnwybF1Djy6AD6SuMEt9dMImSI/+BPUs0lJ15TFezw=;
        b=FPXyi3luhetzunSvYkn8Dk3ESwdSRxOsupn1elccfSVSJ1caubLsi8bZh20u4q0ZXb
         Fp19SO+0sASOxXsI61unk5Gr5ah3ShfkNAet5hynz7P9eXK6qAA3inpoDx1NDfkYMxT5
         iTTl4F9jOVZnp4nPqz/rRLVOrZpjGsoXXT541QPy+Al2lXpqT1hOr5xiqYKxtfufqti6
         +w+UCrP5qVlxTgdVgTomHJUyT5hRFYZP4QvytTFA4HaGcu5fB0HmW0ZtpyIgaNLNUjXe
         FcYyk3OThSN9NVPcognC0uD0tN53NtVVpcnj49SZqeO/s8piVRBcGRBCB2oSJ7QkIv8W
         C8uA==
X-Gm-Message-State: ACrzQf0hmRS8iqgTo7JsxiTLK3AuIjYK3aN5sLBIvrhIrN/S3lirA8cl
        lV44hDVh4NQ+wLwBCXzqcTYIoaNPdCirgc0R4ABthZELmRLRznJWhceZWIq/BO4Gc1z5ELvaleK
        +K7+EduHVROMssSORdaK9DY1IkRELuoufAhc2rN2cdb0+4quAEidrmSCrFEW/i/32OOgZgruAU3
        VA43SnFYk=
X-Google-Smtp-Source: AMsMyM4Kq92n+pG5C7OlxI7DdRcO9DdTNLNDKfuMilRLJ27e/hsIlDfcTkMEL551HCHlynCDSXw7hUbyv6U0j8Jqaw==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a25:a286:0:b0:6ca:e3de:110d with SMTP
 id c6-20020a25a286000000b006cae3de110dmr53860621ybi.100.1667943149120; Tue,
 08 Nov 2022 13:32:29 -0800 (PST)
Date:   Tue,  8 Nov 2022 21:32:24 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221108213226.3340496-1-dionnaglaze@google.com>
Subject: [PATCH 0/2] kvm: sev: Add SNP guest request throttling
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>,
        Tom Lendacky <Thomas.Lendacky@amd.com>,
        Ashish Kalra <Ashish.Kalra@amd.com>,
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

This patch series is based on

[PATCH Part2 v6 00/49] Add AMD Secure Nested Paging (SEV-SNP)

and is requested to be rolled into the upcoming v7 of that patch series.

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

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Dionna Glaze (2):
  kvm: sev: Add SEV-SNP guest request throttling
  kvm: sev: If ccp is busy, report throttled to guest

 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kvm/svm/sev.c            | 46 +++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h            |  3 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.38.1.431.g37b22c650d-goog

