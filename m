Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247DA61A3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 23:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiKDWBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 18:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiKDWBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 18:01:01 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E80DBE34
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 15:01:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-368036d93abso56926637b3.18
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 15:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eaArFinzItu7ripZjOXJqFLsWmZG7JNztWdVb1+Ghnw=;
        b=gkit+WHBjPgdB9QuXMlchSKCOia5gDT5j+d1Hh4dMas7vVXmR18SzhdIkgv8zKD/XI
         FFVC91WqvOd0tHdhckjhSJLvndyG1RRLMe0e1Hjk2/oa068Yv6QkKKV/5tWrFtKaPum6
         GNjSkVD8kY8QLxtNXlt3Je/6aaA/Oljt7EULYezUzcUPivBjI25bN3y58FoF5W2/uZ0k
         OVW9IKH6l8ynig6SJyHc8NgqpC/3Vb2lHhso4uzTdUP1ytCI9hFH3bwH2TcDEuAtaFPV
         AEqAbrPAP1FJ771xZf9TbwXzYxvNlu3Cbcdh7Cmc/vnLACgEul2Ob881Eap279BGWZ6E
         H4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eaArFinzItu7ripZjOXJqFLsWmZG7JNztWdVb1+Ghnw=;
        b=x3OceSl8U8wGrHWjCp0v0kJwveXlAcRSrm6ND53CVEXYJwp+683KtRXPKWb13vRcjM
         NRrQd4DpNvFtzhEagQlGyDxg3oOuAhd1+G4A2qT3ym+cr17wpXUrgoiUbP7k9yMEVb2t
         sBceAapGImOvHo3ka5vRL64ONEm1Qw/srEAsJLL69IenrjY0/0sEebITAOULlt1ENvyD
         B7qISG1HqwI/tHOEHM5K1qUYxoLV1zxvQROd2Il5ivuQ7RQBer2IgbJxgg9XyYcO1Kyy
         nFz5yErTEc62W6RJSrBVeUoVShqwZX5QEBEsaXJ4n1i7Qgd1ipU2B3nQtXCXq7ihjDkO
         8MuQ==
X-Gm-Message-State: ACrzQf1jHqAjkYaEu8u2l5J2uwWHPn7HiRKdXKAjlq+CELBueIWFf3r1
        wDd8Iu0zJmHhz7nO0oKOTk8Coi/k4Bg=
X-Google-Smtp-Source: AMsMyM6+ydn9ulI2NhOBBQtxKTxNYzUcSU9KV2mUTjFRSaaA28pVpwI/N11lbAQCSH0FNZY8OaVI3Rosm60=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4d5:0:b0:370:b2b:c52a with SMTP id
 204-20020a8104d5000000b003700b2bc52amr389475ywe.342.1667599260729; Fri, 04
 Nov 2022 15:01:00 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date:   Fri,  4 Nov 2022 22:00:51 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104220053.1702977-1-seanjc@google.com>
Subject: [PATCH 0/2] x86/mm: More KASAN per-CPU CEA mapping bug fixes
From:   Sean Christopherson <seanjc@google.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
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

Two more bug fixes from the gift that keeps on giving.  Both of these were
found by inspection, and both are lightly tested.  I'm pretty confident
that patch 01 fixes a real bug, somewhat less so about patch 02, though
given the other issues I debugged I don't see anything that prevents the
DS buffers from exploding.

Sean Christopherson (2):
  x86/mm: Recompute physical address for every page of per-CPU CEA
    mapping
  x86/mm: Populate KASAN shadow for per-CPU DS buffers in CPU entry area

 arch/x86/mm/cpu_entry_area.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)


base-commit: 3301badde43dee7c2a013fbd6479c258366519da
-- 
2.38.1.431.g37b22c650d-goog

