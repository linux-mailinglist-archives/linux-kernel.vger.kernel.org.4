Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCA764A426
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232167AbiLLPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbiLLPbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:31:01 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5CBDF6D
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:31:00 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id fy4so173568pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 07:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dswdc8a03OJ4PZCgPN86bzdDFhJyMWhC2nUfUROyko4=;
        b=kp+Ud8kOL2ExTdDIV+vpnRU2GZmmaCyk8O8bZFjjCdE7XizYCdqVUmGe7P9qUrnyDT
         LH86TfsdXK/rIPvw621tAv2HRyzc7TTIUGXG3lahls2Kj4nwh28KG0EOOIRLpad5+17/
         8e5KctNEjiB8yYWe70pjyZoaD7lBMGFPR5N7FPThkB/cKRc14SwySSE1Bb6ctTAqZn+h
         skOlKGWeqhkGOprcicltuqF5qCDip2NlK4ny64rwzY+75VIkSSY3kXEnc8f4Rqqr/A55
         RJIPuk7whAVJ13JJCLuJJ1tPEi+K8Rb3Blq+TMo5IYoHW7gWJQKLcffcOlSFZWYr8JRm
         FCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dswdc8a03OJ4PZCgPN86bzdDFhJyMWhC2nUfUROyko4=;
        b=Ip0UFjM2HpyHX7yJIU8aBwFMUy5Mjf4tVLph0uKEY16SoDIXtmWzIB152hjOnT234N
         PdSn/BwO9fhns5RTc0bMbl0FOmWYjPXmvSTORONBdOhfCBOii773yqJ+KZv+HPaozA62
         ep5fa5MRAI9pcFlRSUkIxcGmO2QGw7sH/9xLFXlAhbNiMOHQPYHniF7+WZscte9tNhOm
         bJDp7eRb9wYmogrTSYGFoVVzH881A5Y9w3usShVOOnx9xKdAfIXQDbIuTEGUofW3AANT
         0fCzyJqD7kKuQIvgyuR6cHjDaqmp5SUkwZ98zlxwNId9VVhQoyGhSQTMERycOdlXpzAG
         zqNQ==
X-Gm-Message-State: ANoB5pklr3PSCgaijGF4Xtr51Ue91wPAavJU82eCeajdpBnHkRp8UR5O
        lJ1QjvNmWOs8NNhmmFRP1Bi5V0ZKCKM=
X-Google-Smtp-Source: AA0mqf4yNzNb+4DeaQhEYS2FVfrbpYQtwabRMD9CrjKWUvg5GkRjG5fC3vMaKLy+vnnFGLqqUb3RVA==
X-Received: by 2002:a17:903:24b:b0:189:62fd:140e with SMTP id j11-20020a170903024b00b0018962fd140emr17961798plh.29.1670859059606;
        Mon, 12 Dec 2022 07:30:59 -0800 (PST)
Received: from localhost ([47.88.5.130])
        by smtp.gmail.com with ESMTPSA id p8-20020a1709027ec800b001893a002107sm6538031plb.0.2022.12.12.07.30.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Dec 2022 07:30:59 -0800 (PST)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: [PATCH 0/2] kvm: x86/mmu: Skip adding write-access for spte in FNAME(sync_page) and remove shadow_host_writable_mask
Date:   Mon, 12 Dec 2022 23:32:03 +0800
Message-Id: <20221212153205.3360-1-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <jiangshan.ljs@antgroup.com>

shadow_host_writable_mask is used only in FNAME(sync_page) for adding
write-access for spte which can be added in later page fault.

Skip adding it and save a bit from spte.

Lai Jiangshan (2):
  kvm: x86/mmu: Reduce the update to the spte in FNAME(sync_page)
  kvm: x86/mmu: Remove useless shadow_host_writable_mask

 arch/x86/kvm/mmu/paging_tmpl.h | 26 +++++++++++++++++++++--
 arch/x86/kvm/mmu/spte.c        |  8 +------
 arch/x86/kvm/mmu/spte.h        | 38 +++++++++++-----------------------
 3 files changed, 37 insertions(+), 35 deletions(-)

-- 
2.19.1.6.gb485710b

