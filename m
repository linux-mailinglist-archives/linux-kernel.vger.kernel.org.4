Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04FFB5FDDDA
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 18:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiJMQBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 12:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbiJMQBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 12:01:10 -0400
Received: from mail-ot1-x349.google.com (mail-ot1-x349.google.com [IPv6:2607:f8b0:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0F211A964
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:01:08 -0700 (PDT)
Received: by mail-ot1-x349.google.com with SMTP id 104-20020a9d0371000000b00661c7c3f0beso186439otv.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 09:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NqiBAv6+VkTIDngM0GJAXUgqa89MgZqUX29OFMPrrEM=;
        b=kXLOth/pecVFm2kkZKFH1JceBXW7GEaN7oYMvWFruxc5a/HGs6T2gaf95D7KHrnKas
         R3w3GsEGkShWBEUfpY/SDfb5IeBMQhnik0Sx4b1PE874TrT5rbtSpqdIo9tCHhjztKj8
         7PgFuOA5ByVHVVRZkhqx5WJ812PRplpwgZA8CyFtoltx5d5uHPqxqa4+gt493nAWAnb0
         W1z6O1R4mgK3ugYrq+jgWQFviEQFbUunYlR2/zh6dvhJ1Yq486bIfbjU2DNEtu9Q8jyH
         i7fB1SpTJeHQry/ncZjRb2ViL0ppJDvViKiXBvwXyfrJ3YVKo4C8RI4Rba6xCRC3ITRy
         6kTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NqiBAv6+VkTIDngM0GJAXUgqa89MgZqUX29OFMPrrEM=;
        b=aIUL3yoEpDmvmE0Ug8W3Ywqx8e9CjKaj0w/FrpDNJ1LmU+kTwBPz6i31cXGoiK30V6
         R5S1+/44wcVPP+78LfWgPJjxSqP2vK+BYtiHzLbSONh7qSYUFfrRKhKVJpRYKLGHjubE
         Q7zOVb2TA4ReBQv7mjz1kVPQ3pQ3qSofo/7PAswdGd8SPYsv6ALLgPlVDJFU5KZiM5no
         p5auQVKGIv9l8q00dXJoaEbaWqgPFdXCrGtjN2HNqFoifWymJAM3VSaV6VfIehSc0dfF
         N+HLFptms9fyBwoInUiYN2FZgFuf1bT+14i50uQIAqhZQNUwUWKJZpNKnH7gH8q7KNJv
         QTNw==
X-Gm-Message-State: ACrzQf3QvZv7lC/pz8OqWSJx+VaD5nKY8grylEuM2co3/rj4gMlo4Twe
        jf+Sl82ovydosH28+8mNLXmAaP70hhBGJCshAyX7B+4TCZfvcg5JH8M0e4HKYS99jS8rgGbOCtm
        v8wrnV2y1MwyDFXvzEMCkSiX2DqGx816Pppfu1diCAoz+jM4xr9Sz7H1350+L1vNjpc1Y2doNJs
        dFzPO0msU=
X-Google-Smtp-Source: AMsMyM501RMTCrdXeyN5TyTeWewWYCe8+uj+5aa3KRjLp/7Fwcg3IGhqQ1cefdtu/fEhDBRpPtLmCPLQ8M4v4y3vOg==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:a17:90b:3850:b0:20d:54f2:a780 with
 SMTP id nl16-20020a17090b385000b0020d54f2a780mr12078380pjb.115.1665676856516;
 Thu, 13 Oct 2022 09:00:56 -0700 (PDT)
Date:   Thu, 13 Oct 2022 16:00:38 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.0.413.g74048e4d9e-goog
Message-ID: <20221013160040.2858732-1-dionnaglaze@google.com>
Subject: [PATCH 0/2] Add throttling detection to sev-guest
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
 include/uapi/linux/sev-guest.h          | 17 +++++++++++--
 4 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.38.0.rc1.362.ged0d419d3c-goog

