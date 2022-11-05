Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE7B61A798
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 05:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiKEE5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 00:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiKEE5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 00:57:10 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6C331DD7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 21:57:10 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id h16-20020a170902f55000b001871b770a83so4907485plf.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 21:57:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XzQ/JwtPWhSrAT5jdOi7rv7mHMX+sB3nOWPz6ecV840=;
        b=Mujmrs7ffOhJTdpBZz7thLFAW5rIFh8MtxNsLNnm4mofYyhJlK6EPvWWrPS22HQPWU
         SM204oFfX/dt8Oy3Ac/XGkQ+CPqooalXTlCdIWktoNaxCKC4hR4xA/tcDx9eywbgjTeX
         T7wKtVlmFDfLtinFb/MXKllVWRMMZZDTV6OjBynXPboYtEhoq7wRzp8sFoP1jNfm0/2j
         lfReFTq0wHLbUmwrGtUVFbD/mCqwtP0gM4jryw67RV5gJOOlRAGIkVU1lCrfh6F9Y+bi
         +QRaXBngV+YkmZB3n0QSUpLG67icQTtFQihZJaC6/4mTUwRKvuTrukGbiME4+WMRfMio
         zwoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XzQ/JwtPWhSrAT5jdOi7rv7mHMX+sB3nOWPz6ecV840=;
        b=t0H0VhoRSyJc32k1qgWR7zT3VniL1w5ym5h39rpk3x7CnPAD/dKtkyEr3LgJ391QSD
         qqEYe1Sd2uy6MJqtbd4G3i4uQ0o7AHdhOJhDPIVKF7vNZ4c+x//f0URtgABMB5mOUJgR
         r40uVfgPV0aDry7/v1yNv3HmFayTUK5rRHZ3xgDYLLCPtIUM7iDcihPRwDJdKJT+gwlF
         dO/xpoaXZB9v0TqUTaEulCHx09CHZ3DFt8XKmgZHc5cNffgJjvN/dXXFeCXaHVbixojQ
         Eo6bMFpkcZOg9mwCTB2ZnUpxvGL/gGz372OZAoANv8g4rrOiHXwyaOY3R7skHx+iPyL6
         jjIQ==
X-Gm-Message-State: ACrzQf20MM8X9c13p87qgEGSknOYI8G6WY0+i1mN0HksjCOC+K1QFd53
        l6j7kGY0PaCVSJs0iHV4OLwgjifrMKzz
X-Google-Smtp-Source: AMsMyM6JziBXYGDsP00lbMCuca3QR+oGSfuT6bcd7s6s4XJhNqTeqfuaOhWcgh+QMDTzlmYpMvEokz7tLFsF
X-Received: from vipin.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:479f])
 (user=vipinsh job=sendgmr) by 2002:a17:90a:7348:b0:213:2708:8dc3 with SMTP id
 j8-20020a17090a734800b0021327088dc3mr1066872pjs.2.1667624229329; Fri, 04 Nov
 2022 21:57:09 -0700 (PDT)
Date:   Fri,  4 Nov 2022 21:56:58 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221105045704.2315186-1-vipinsh@google.com>
Subject: [PATCH 0/6] Add Hyper-v extended hypercall support in KVM
From:   Vipin Sharma <vipinsh@google.com>
To:     seanjc@google.com, pbonzini@redhat.com, vkuznets@redhat.com
Cc:     dmatlack@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Vipin Sharma <vipinsh@google.com>
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

This patch series adds Hyper-V extended hypercall support. All
hypercalls will exit to userspace if CPUID.0x40000003.EBX BIT(20) is
set.

Patch 4 and 5 are prep patches, they move some code to hyperv.h later
used by newly introduced test hyperv_extended_hcalls in Patch 6.

RFC: https://lore.kernel.org/lkml/20221021185916.1494314-1-vipinsh@google.com/

Vipin Sharma (6):
  KVM: x86: hyper-v: Use common code for hypercall userspace exit
  KVM: x86: hyper-v: Add extended hypercall support in Hyper-v
  KVM: selftests: Test Hyper-V extended hypercall enablement
  KVM: selftests: Make Hyper-V guest OS ID common
  KVM: selftests: Move hypercall() to hyper.h
  KVM: selftests: Test Hyper-V extended hypercall exit to userspace

 arch/x86/kvm/hyperv.c                         | 43 +++++----
 tools/testing/selftests/kvm/.gitignore        |  1 +
 tools/testing/selftests/kvm/Makefile          |  1 +
 .../selftests/kvm/include/x86_64/hyperv.h     | 31 +++++++
 .../selftests/kvm/x86_64/hyperv_clock.c       |  2 +-
 .../kvm/x86_64/hyperv_extended_hcalls.c       | 90 +++++++++++++++++++
 .../selftests/kvm/x86_64/hyperv_features.c    | 32 +++----
 .../selftests/kvm/x86_64/hyperv_svm_test.c    |  2 +-
 8 files changed, 163 insertions(+), 39 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86_64/hyperv_extended_hcalls.c

-- 
2.38.1.273.g43a17bfeac-goog

