Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A4E6C2B93
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 08:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjCUHns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 03:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCUHnr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 03:43:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A101AD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679384584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ESJ/1knv++fPH2odQdRy7nTNYhZrFIAGHXT1ZfrTzlo=;
        b=gkfwV7KV0c8hW95vzSGtj1sQ/DVJHlv7DX+3yNT7zSsaZrJEG4gaDSVBvKjWjsBQcm9KO/
        tfCJ1A5Y3IFhrrWrgtkrxjGqCDHITaEhbe80wk1wBxwBkrvrduJ0NZBCPBW3g+NhveMpUr
        U/WDAFzOVFrlKzq3OilVycfbFOrWkaE=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-HbYgTY3aPMSZbSmRDEYyCw-1; Tue, 21 Mar 2023 03:43:02 -0400
X-MC-Unique: HbYgTY3aPMSZbSmRDEYyCw-1
Received: by mail-ot1-f72.google.com with SMTP id c17-20020a056830315100b00698878489e5so6694562ots.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679384582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ESJ/1knv++fPH2odQdRy7nTNYhZrFIAGHXT1ZfrTzlo=;
        b=vJVWsW9bYI4LroRzSXziLWmae+DXwOEicl/7OYSQrosAzb1Y1509ckZe+qIf6amZo+
         5l4xuYgW1NgujNH6T7nQuob5eVlN/azJ35LEhT56f6HadN/mbLbbNWLtkvuXb6jZKcSh
         Zevx7I7tj2UMXVz91lwlKGAD4C+h9FXDZFWVSDWTaY7q1BVXA9PphXiy7lMjTGBIZTNT
         HydvANJ/TDPXIkHYg60QPHsI4ZrQD7rcEtnFD0Vlvo/M1NbuyaAOHmkfwhp+8GC8LU8E
         rpZ37gwGbfV904rFyhooMiIMmIR+epGNBdzTHL27AjfbQmS0gtMA3f/cE7IvISu45cA6
         acww==
X-Gm-Message-State: AO0yUKVkgccGGqey2+FLDEDOUgDo+ueeh2RYrOJuznh6ZzApBkL6hbHJ
        H+sKRbVoNDkCXdMu9mKYLyxtA70np91Zr2ovaLgTOSJHjXCvjxxsfyiRHtzuZquwPRQMBD3oMYU
        S7Fgy7h+oz5V+FAtAx72evTVr
X-Received: by 2002:a05:6870:4248:b0:17a:a3f9:9f5d with SMTP id v8-20020a056870424800b0017aa3f99f5dmr604194oac.29.1679384582157;
        Tue, 21 Mar 2023 00:43:02 -0700 (PDT)
X-Google-Smtp-Source: AK7set/A9uIR5EF4MO4MSwN8Ag5xIfJZhmykE+JqvDnTRRi0U8aZM3QFYPvL2/kXOaiQrFkYTcNKOQ==
X-Received: by 2002:a05:6870:4248:b0:17a:a3f9:9f5d with SMTP id v8-20020a056870424800b0017aa3f99f5dmr604184oac.29.1679384581888;
        Tue, 21 Mar 2023 00:43:01 -0700 (PDT)
Received: from localhost.localdomain ([179.111.176.145])
        by smtp.gmail.com with ESMTPSA id az15-20020a05687c230f00b0016a37572d17sm4047729oac.2.2023.03.21.00.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:43:01 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RESEND RFC PATCH v2 0/6] Deduplicating RISCV cmpxchg.h macros
Date:   Tue, 21 Mar 2023 04:42:43 -0300
Message-Id: <20230321074249.2221674-1-leobras@redhat.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Re-sending, since previous send did not work on patchwork.

While studying riscv's cmpxchg.h file, I got really interested in 
understanding how RISCV asm implemented the different versions of 
{cmp,}xchg.

When I understood the pattern, it made sense for me to remove the 
duplications and create macros to make it easier to understand what exactly 
changes between the versions: Instruction sufixes & barriers.

I split those changes in 3 levels for each cmpxchg and xchg, resulting a 
total of 6 patches. I did this so it becomes easier to review and remove 
the last levels if desired, but I have no issue squashing them if it's 
better.

Please provide comments.

Thanks!
Leo

Changes since v1:
- Fixed patch 4/6 suffix from 'w.aqrl' to '.w.aqrl', to avoid build error

Leonardo Bras (6):
  riscv/cmpxchg: Deduplicate cmpxchg() asm functions
  riscv/cmpxchg: Deduplicate cmpxchg() macros
  riscv/cmpxchg: Deduplicate arch_cmpxchg() macros
  riscv/cmpxchg: Deduplicate xchg() asm functions
  riscv/cmpxchg: Deduplicate xchg() macros
  riscv/cmpxchg: Deduplicate arch_xchg() macros

 arch/riscv/include/asm/cmpxchg.h | 316 +++++++------------------------
 1 file changed, 64 insertions(+), 252 deletions(-)

-- 
2.40.0

