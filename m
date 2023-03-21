Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303456C2A7E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCUGfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 02:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCUGfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 02:35:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BEA3118
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679380496;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=QE3XU3Zue9M7HDU7dSkC4z4rXd/9VbR7G9gpQxcbxKY=;
        b=jCiPA/hm5vzKJ69rmIsOy0pDW0cADhSKKzgrJX3dWFmUq7ClV/zgZjHNRR4PtuLdoRv+ah
        ibNliyPzEBCmkhY+LGkJs3GBlRZMcbHhPwLiQRYYrN8NXme9xSZgLB1RDDvqj4UfFSgHm7
        6SaFnRzajJM77+ZMcJMH3P7F2/RJipc=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-cCHRiT0kMW-KOMbOqbxbCQ-1; Tue, 21 Mar 2023 02:34:54 -0400
X-MC-Unique: cCHRiT0kMW-KOMbOqbxbCQ-1
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-172cafd4245so8286194fac.21
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 23:34:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679380494;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QE3XU3Zue9M7HDU7dSkC4z4rXd/9VbR7G9gpQxcbxKY=;
        b=oSKfMLqnU0EEFCTz0f9bsC3dg0uOq/QGvAYkVb+rIMBMo5CnXE8x2ErFM8ki+JZwKD
         NAAQd+3pjITOgi2ghu8yjyxLdC8Bemk76SusXgY1Tin1G/zBXzmymTVVGJvp5MH1Uv/R
         YrxaGeQfljp2zbgBN06R+ISjpuOpkWjkWka2MgcNdCLAc8HKJV6s9xswPTcGdzw4x47o
         BlWjRx7iqU8bQiu8aWummB6rB8TvPxwrn0V1bsdOKdBxjf8xBKJ/vprpF8ezh9DgmVjd
         SUGF85OCKwgud45RGCAkYPb2hM/ss7MiSok2L/rqI8N0l6ja914mNFpOjYVCnicqON1h
         hsEQ==
X-Gm-Message-State: AO0yUKUrj3EdkybfVWmPtt6p/6Tet1RzjJKWNdmOXzWtwB0xl6eaOuLH
        PIc5VEPFx+eRGgDvQNztYlACMsflCoHYa1Vvs3m6cPkChOYSV1RIWuSDpcSx1BvejwjHIFXimXG
        +dLSOtzHiQZffGi+77vhuOGic
X-Received: by 2002:a9d:3e10:0:b0:69f:1577:d8e9 with SMTP id a16-20020a9d3e10000000b0069f1577d8e9mr450789otd.8.1679380493869;
        Mon, 20 Mar 2023 23:34:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set+fYUkJDXtxyGwR/4oInygBuG0trygiznXejWTs81vY/TFo47Up6YucY+xrz9N15XIYjbb2sA==
X-Received: by 2002:a9d:3e10:0:b0:69f:1577:d8e9 with SMTP id a16-20020a9d3e10000000b0069f1577d8e9mr450782otd.8.1679380493648;
        Mon, 20 Mar 2023 23:34:53 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:b074:274d:d04e:badc:c89f])
        by smtp.gmail.com with ESMTPSA id y75-20020a4a454e000000b005293e9a12f5sm4545147ooa.45.2023.03.20.23.34.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 23:34:53 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>, Guo Ren <guoren@kernel.org>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/6] Deduplicating RISCV cmpxchg.h macros
Date:   Tue, 21 Mar 2023 03:34:25 -0300
Message-Id: <20230321063430.2218795-1-leobras@redhat.com>
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

