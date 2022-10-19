Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45FC3604EF6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiJSRhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiJSRhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:37:13 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E31C6BE4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:35:58 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id h186-20020a636cc3000000b0045a1966a975so9924142pgc.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x60Xt5Xqce3O74J5dTGuOeZ5YLoRzr8kJwmEklJwyWA=;
        b=pbY3EbLRUD7kzFmh0GLfcywoKwPrz90q1uu0OqSeea1hMhExrSYADtQWKH8wh80+O/
         GWgzmlx4NGXn+RqxSqaopoWlujpDhSvIvsq8z8HtUoH/o/nf5ZNH/2wkLcnWBXhLk2eN
         jtdRZixvihfRVuuH8Uw3UgNcNgFoy19Tuv41t3VTUO7BjBiPXV0v9eBD0jYW4+dO6nIx
         DvIIGjzYcNUP1GEjKYCipRlmgYwlYKPlnkVP5YJ7liaP7+wAqONwQRDV3BKbBJ4S9MVP
         DfB74ARhp/sYR38Cd6pMa1xjr+gIIDGIkIkJgIVcnW5H3aFXyE3ERWAA6Z5HARGnYIWi
         dcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x60Xt5Xqce3O74J5dTGuOeZ5YLoRzr8kJwmEklJwyWA=;
        b=0vK4DfnkODOmgIiZKhubi8yw/6LNT0PloYZPSv72+2S7DdsXLTupZtr0NSeb/maEV1
         Qumhl9N24vsvbQXkIYcjiUoVLTG7eRsGR7hR6raSoBrchgJ5pDCJ9VW/FCxfCNCu7tk0
         x3hVORMf58o6wgH8ZFI4OGyUQ7vdVd++W8M8fGbBXUwV3/PBwvZp81lZo4aDMc+zGpeu
         /cpVPPVCpUNa5dhDE9wPlO2HV3/f8J8Rt1yn8nAOjRddHQw6msAvvBPq7UgCXKnT2ecc
         vFbajTEzuZTN6ImZOlBocVSvMyzdGySf+fJy3K00rKUuR4wOmIu2v3bJRW2Se9PxT4iV
         7kxA==
X-Gm-Message-State: ACrzQf1Xj2Jg2+SRutX3EFTT/3q5r5z6Nv5ZTUVaaLUYonkUycMc6yC9
        dWDXZ4qr0NZMqJhWS7sDmHtwu+zYlzoMkdY6gg==
X-Google-Smtp-Source: AMsMyM7md+cfa720X3aPbTCrtERijE1CxwnBxLJf2ToN364fOemTbhV/5NGRCgl3M6lSfNQgA8oblL2dwOVeeuCrDA==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:902:edc3:b0:172:8ae3:9778 with
 SMTP id q3-20020a170902edc300b001728ae39778mr9683589plk.72.1666200950191;
 Wed, 19 Oct 2022 10:35:50 -0700 (PDT)
Date:   Wed, 19 Oct 2022 17:35:35 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221019173537.1238121-1-dionnaglaze@google.com>
Subject: [PATCH v2 0/2] Add throttling detection to sev-guest
From:   Dionna Glaze <dionnaglaze@google.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
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

Changes from v1:
  * Changed throttle error code to 2

Cc: Tom Lendacky <Thomas.Lendacky@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Joerg Roedel <jroedel@suse.de>
Cc: Peter Gonda <pgonda@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>

Signed-off-by: Dionna Glaze <dionnaglaze@google.com>

Dionna Glaze (2):
  x86/sev: Rename snp_guest_issue_request's fw_err
  virt/coco/sev-guest: interpret VMM errors from guest request

 arch/x86/include/asm/sev.h              |  4 +--
 arch/x86/kernel/sev.c                   |  6 ++---
 drivers/virt/coco/sev-guest/sev-guest.c | 34 +++++++++++++++++--------
 include/uapi/linux/sev-guest.h          | 16 ++++++++++--
 4 files changed, 42 insertions(+), 18 deletions(-)

-- 
2.38.0.413.g74048e4d9e-goog

