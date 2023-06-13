Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD3572E9F2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 19:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbjFMRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239515AbjFMRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 13:33:15 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5955B1FC3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:33:11 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1b3daa7ad62so12118315ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 10:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686677591; x=1689269591;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VH3BFFQPXMCmHgq4sTEkJiB5nlc/oTUMOeHBDQraoRg=;
        b=4GIIZmokLWx0sKcscVZ/WqRILAZmvgM67vXFEKRHBzyu5m0n9vru+WeePzg6h1VSfW
         NeNKYuIYEbM3Ooi8rYAYUgjOxEIK3oC35W0k9WKGXNk7U0Q6/QYqwRf6cnWcxPH2dmG7
         Ywhi/pUEMeyoJCwjNDLyAqAcK2Fu6QcGIpHL0EsPLAwr5u72PfE359HmDZAQie/fEqXR
         FSe272BX1Uep7Qo83vQHXfSfcm9mhe/B3JN/Kwkmo4R05pPLfREFUYqWzX9N2i5zGUP2
         1528wtFuWIT6J4pIYi4TDePJ9+PBNysMe9/R24DITpnKj9Z/ydxW8OnS2yimzFjdzzxh
         m+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686677591; x=1689269591;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VH3BFFQPXMCmHgq4sTEkJiB5nlc/oTUMOeHBDQraoRg=;
        b=ddAecwl049pAqIbFgTrBkAfyxNsy7Gk9Ps24VrcrXB4hjZhsuMbLabsV3j/7jiGgWi
         SOBzNhmY/2aAh7LTRwDjuAytcrkuxtcS6LYQ7Slyrm0WsogKV1FnS0bMInZlFxXZZ+Xf
         5dF8FWui0+wdqaG/bmH2t+e0g+1GzvSccc1pRvmjH/tCxgZkApSsUnDUZKvGlcpDlhbu
         ev1aO4ENnE/dHVHE/Vk1wpdyWmISFs/boSykdTuq/gjwMylI/WYelSNt6VFMOWiAEBf8
         f0hFM0WLQ2HZZRB02K0pc47tgdFTmNbFbB/aI4daQNOQfTplykCwjqbslb6mqCPnOhJq
         vt/w==
X-Gm-Message-State: AC+VfDzKxYVhOmzT05YAseAzT1wp8kYxsKqdHYAaG07bfDqcS7dMutPa
        JGydD5ZFQ3Eex2Vv9pSKgQaoeEfM2Gw=
X-Google-Smtp-Source: ACHHUZ40LZhuQyxtqTrzU0E5CVOKoCrXel1ms4oJrdweGCGHs4yjvb5eL9IveRDb17zbaD5p5K1fURK3kTk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:8a90:b0:1ae:4d1c:1282 with SMTP id
 p16-20020a1709028a9000b001ae4d1c1282mr1741443plo.7.1686677590757; Tue, 13 Jun
 2023 10:33:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Tue, 13 Jun 2023 10:33:05 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230613173305.1935490-1-seanjc@google.com>
Subject: [ANNOUNCE] PUCK Notes - 2023.06.07 - pKVM on x86
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org
Cc:     Sean Christopherson <seanjc@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies for the slow update, I was waiting for the recording to become
available and was OOO Th/F last week.

Key Takeaways:
 - Primary use case is to secure workloads that process/handle sensitive
   biometric data (e.g. fingerprints, face authentication).
 - SEAM is a poor fit as it doesn't provide mechanisms to restrict access to
   non-DRAM "memory", e.g. access to the hardware devices that provide biometric
   data.  And there's no line of sight to an AMD equivalent.
 - pKVM support requires few changes outside of KVM (though the changes to KVM
   are extensive).

Next Steps:
 - Re-assess in 3-4 weeks after people have had a chance to read through and
   review the RFC patches.

Recording:
https://drive.google.com/file/d/1JZ6e8ZgR2gUfB4uBYxsJUxp1KVL5YEA_/view?usp=drive_link&resourcekey=0-MGjMLec-8JEIFC3-vmZeLg
