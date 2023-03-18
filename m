Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 268056BF8CC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 09:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjCRICa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Mar 2023 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCRICY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Mar 2023 04:02:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7276F2056B
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679126494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Qx6sO30KWXOeH8l6ZlBEQgHux3VGZ/RgcLtlMop/hXs=;
        b=VbyCx0UFyBxfMJIOejvWlqC9/I/8o9qpfvGaZ9eGEG7Cd3zN4K6vnk48ncNOu72slR9RJB
        +AL+0Nb2z5YN+5r2OV23Sd7nAz2kSlRvtoyDZzBX/97vtTp5jGhg9sDUU9RalHigFyljF1
        YvIhA30cPgG1vRGT0Ivw69+17dDD0Ww=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-K5wrb_pWMQ-NjxyKFPq6LA-1; Sat, 18 Mar 2023 04:01:30 -0400
X-MC-Unique: K5wrb_pWMQ-NjxyKFPq6LA-1
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-17a03f26ff8so4201223fac.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Mar 2023 01:01:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679126490;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qx6sO30KWXOeH8l6ZlBEQgHux3VGZ/RgcLtlMop/hXs=;
        b=4Cb5umPTT06D+BkHltC2Rhg9AM2A/2VUQTaaLapB/kbQWeaT4D+HU7qomA9Pj8/HUl
         fevjlV7T7tkhap3mxxHjG+0k8GQu+3uN66NeTPjTuLBRMfP9dCdVIz5Aq9kMj72xNIIG
         65bUnbxKEM0MHVfxF6elSF+DoO32ELDYTKjN4MNcrGlZqMVWhUdo9JdN9n1kynoxQYJ7
         OLnkxCQ+5XkyYTikRA11Tx6RjcuIGcGbNV5XzqNqvfkhMIqjzbMrb0CIF9cB6UxNWt7+
         G/cktzMhZSJk82RoiThN7oyFj/WsP3pRXbTG4hI8BVRBTZECwFe/KbPzmYYJWfuCCysS
         GemA==
X-Gm-Message-State: AO0yUKUgC+XcvS+0qTGD3EHm2uDdUqDRxg5z34Zjwm7lYBMarXXLjlBb
        7puqQfCelZmbpDJ3byZtNXPdp3EwBGigmIGVhd5QIyPM5/FcttHETuZwMPY+lBT7Igp1bVLcJPG
        0gipnJQ3YiDNvGCh96pXFCllP
X-Received: by 2002:a05:6808:1396:b0:386:c879:d3ae with SMTP id c22-20020a056808139600b00386c879d3aemr3370157oiw.10.1679126489962;
        Sat, 18 Mar 2023 01:01:29 -0700 (PDT)
X-Google-Smtp-Source: AK7set/mh3aE04hb4EIJpiXnxz24ex1/4nqqBvuGMupJ7eKKQmcSN0VSwWqLwBDIghHvTT66dP/YOA==
X-Received: by 2002:a05:6808:1396:b0:386:c879:d3ae with SMTP id c22-20020a056808139600b00386c879d3aemr3370150oiw.10.1679126489729;
        Sat, 18 Mar 2023 01:01:29 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d4803000000b0069dc250cb24sm1824462otf.3.2023.03.18.01.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Mar 2023 01:01:29 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/6] Deduplicating RISCV cmpxchg.h macros
Date:   Sat, 18 Mar 2023 05:00:54 -0300
Message-Id: <20230318080059.1109286-1-leobras@redhat.com>
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

