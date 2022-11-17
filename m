Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC78E62E3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:12:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239691AbiKQSMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231240AbiKQSLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:11:48 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C60E7FF35
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:47 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t3-20020a170902e84300b00186ab03043dso1913563plg.20
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:11:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xrJm0fOsDWKeiievg8DGk4jDzdpNIiW0mf+bg8MNtpw=;
        b=GHc7ejatVxVx65ekRPS/abMf0y5HbKvvzUSX3bz4I9b8xHh0Vu1ly+slCq8n+Oor+t
         RBEl6SRMinzVMisSu5Ky3sFMqbJ6JEcw/RBz/dRhop83ZdhzzYAkPPS4w4YBJuIVLPQR
         26ck7GNfTARYlLiOotMvCxBgm1N9fcRQaPFq3Z89XNsaVzPcK3JMxrrZHdoxbcWHN+jm
         ReYvmgvGGVqZPvhlpQYb26mHLIGApy8CefsU6SKGCaiXrHXd1DN5jlAGY2HDbjYdCFpM
         XiMr3EGgRnjITzQ5qbtlFCyZFbV58ILp46BUzUIzR482iNO5uQjOwqtTaogCNXY4jkub
         w5cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xrJm0fOsDWKeiievg8DGk4jDzdpNIiW0mf+bg8MNtpw=;
        b=Bs8Dzo86pV+DP35ub5TWw204/SLNT+aH/JrjMMRp83OeY/JMEIgTvAGwzOYXrpERsG
         AddRMS7Ed7TmpCF5O64FvH+NtexOyeJ4rAII2zXPftij/K1Vk6FNpt5EWsrTAtYjmBVM
         A0KiCb2GTk/8SeEar0wAa3Uj9kmpi569ZmrcPrGuwlYWlUVjEtQuXgOk3DNi/Wvjnkfv
         1ggUJjjBzftRQ1YAY3yjcxj7QltGgBpDBsX9JPB09WKh0v1vIMvaRuOlBXBhPIazwqyq
         rrBAorlQKtuIz8x9ho0VBmwQzpe16bDEE2YaB5yBUsBViEG5tnN4N929CkozCul4N+2k
         WXvw==
X-Gm-Message-State: ANoB5pnjZlAeNLeOTd/DQ3CTkdwpZnVevq3jK9f49g1Ic4B0aQaer8OT
        68FaLIJFsIyEwWSIMQA5wRSFhovnPF1eKCZf8ZJFEzqRrvuFldxGm3s6eUkVFq93oXL/MOacmK/
        f+Rf+brtZ4qXjSiexD+yH0S2APzh9FOw8HP7+8c1tHUO6lb3uKh0QuyaIX1F2BgJTednVtTluxI
        CCui7J8lE=
X-Google-Smtp-Source: AA0mqf5VpPjTWmpCzT91ZmsiYv9LMjJILdabQwr8cQYxSzdii+0PT9VyCg84rcExr25bpO5oCpb8KbBH3DzZ07aOSQ==
X-Received: from dionnaglaze.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2ee6])
 (user=dionnaglaze job=sendgmr) by 2002:aa7:8115:0:b0:571:f667:4d85 with SMTP
 id b21-20020aa78115000000b00571f6674d85mr4129115pfi.70.1668708706586; Thu, 17
 Nov 2022 10:11:46 -0800 (PST)
Date:   Thu, 17 Nov 2022 18:11:25 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221117181127.1859634-1-dionnaglaze@google.com>
Subject: [PATCH v2 0/2] kvm: sev: Add SNP guest request throttling
From:   Dionna Glaze <dionnaglaze@google.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Dionna Glaze <dionnaglaze@google.com>
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

Changes since v1:
  * Added missing Ccs to patches.

Dionna Glaze (2):
  kvm: sev: Add SEV-SNP guest request throttling
  kvm: sev: If ccp is busy, report throttled to guest

 arch/x86/include/asm/sev-common.h |  1 +
 arch/x86/kvm/svm/sev.c            | 46 +++++++++++++++++++++++++++++--
 arch/x86/kvm/svm/svm.h            |  3 ++
 3 files changed, 48 insertions(+), 2 deletions(-)

-- 
2.38.1.584.g0f3c55d4c2-goog

