Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4092D6DC31D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 06:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbjDJEeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 00:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjDJEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 00:34:24 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C263C28
        for <linux-kernel@vger.kernel.org>; Sun,  9 Apr 2023 21:34:21 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-632384298b3so1820208b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 09 Apr 2023 21:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681101261; x=1683693261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wo/NLYM68CpVej7TFrEwhf6OkmmykabPIEmuzOcGQhk=;
        b=14ynvSGMjNFozUEgNPf5yBPQdprMlno4GnJrckN9NKprlViZIhNxxhN+f827VAuy1q
         xTJdqsEWvAxss3rv3YkvvUiGOM/KAiDibpbl0fr9nq2K6FGQrFdYZNr79ZVV37OrqjCY
         yOINUEMPyaQksnmOmcwjlbYCyYPvYji/7ZpU41pQRlDaWVovmxudkH49/g12crFxYvXC
         OpSK2bG0bF5NUz+BCbClWhGq24I5+PSrqoXIggZa1XWhsu+DqcFrFNuiT2UNJgvqRQZB
         nTCxHZpXU/Nsj0PFIeThbrBkVXfwGDvE9LqKheqwp4tJvZZZsK+6bqAMhqoBLxJOYZE6
         6DSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681101261; x=1683693261;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wo/NLYM68CpVej7TFrEwhf6OkmmykabPIEmuzOcGQhk=;
        b=pQe/l2SvwBBs8H7p+EpUzTqwPDlurQFaVLGx5QIlSVTHKGxvOqIgzeFbe809BNn2kl
         dktACLHKO1o7z2XnZPXqb3Hvwn0FUoPaTkhUqMrCDzT5d5uHBgFu4RV2R11dmGpAFBmc
         UiUkwFq75XnF5nmvKsj6ZksPiNP/3OMkjMRdPF8fq4l/HHSOW2/EdLFceDSs0r6g1ggf
         /utcXgOwM8pTGh1YuUOzSza5rwFc9I7R69eLGM7Ju9nBSI6Em3O8+Ms5n8NppcMHUs/R
         ZtJQywWMfGpLFZ1s4C29pT3s5Y4GoFuSZdEY0ucUNuv1IBAdlx3ZOXLrMPWkN8WPzBbz
         Na9A==
X-Gm-Message-State: AAQBX9c59oZmJe0nrQPHBKZJ6qA+qngvUlEz27oedpeveH0ZmL4C2eNn
        UmMYKnctWlBh1BKMeHgNec/3Kg==
X-Google-Smtp-Source: AKy350Z2pVohIIfC8uOSvebyeFmf1J41yDqHZ+iw/kR/cSkcgoer36lMoJOfnE61nWFF+haa+PKKiA==
X-Received: by 2002:a62:180b:0:b0:628:1862:dda6 with SMTP id 11-20020a62180b000000b006281862dda6mr9491271pfy.17.1681101261451;
        Sun, 09 Apr 2023 21:34:21 -0700 (PDT)
Received: from x1.. ([2601:1c2:1801:d250:45c0:94f2:eea7:6dc3])
        by smtp.gmail.com with ESMTPSA id x24-20020aa793b8000000b00634a96493f7sm2394411pff.128.2023.04.09.21.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Apr 2023 21:34:20 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Atish Patra <atishp@rivosinc.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?q?Kornel=20Dul=C4=99ba?= <mindal@semihalf.com>,
        Adrien Ricciardi <aricciardi@baylibre.com>
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [RFC PATCH 0/2] RISC-V: Detect Ssqosid extension and handle sqoscfg CSR
Date:   Sun,  9 Apr 2023 21:36:44 -0700
Message-Id: <20230410043646.3138446-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This RFC series adds initial support for the Ssqosid extension and the
sqoscfg CSR as specified in Chapter 2 of the RISC-V Capacity and
Bandwidth Controller QoS Register Interface (CBQRI) specification [1].

QoS (Quality of Service) in this context is concerned with shared
resources on an SoC such as cache capacity and memory bandwidth. Intel
and AMD already have QoS features on x86, and there is an existing user
interface in Linux: the resctrl virtual filesystem [2].

The sqoscfg CSR provides a mechanism by which a software workload (e.g.
a process or a set of processes) can be associated with a resource
control ID (RCID) and a monitoring counter ID (MCID) that accompanies
each request made by the hart to shared resources like cache. CBQRI
defines operations to configure resource usage limits, in the form of
capacity or bandwidth, for an RCID. CBQRI also defines operations to
configure counters to track the resource utilization of an MCID.

The CBQRI spec is still in draft state and is undergoing review [3]. It
is possible there will be changes to the Ssqosid extension and the CBQRI
spec. For example, the CSR address for sqoscfg is not yet finalized.

My goal for this RFC is to determine if the 2nd patch is an acceptable
approach to handling sqoscfg when switching tasks. This RFC was tested
against a QEMU branch that implements the Ssqosid extension [4]. A test
driver [5] was used to set thread_struct.sqoscfg for the current
process. This allowed __qos_sched_in() to be tested without resctrl.

A forthcoming RFC series will enable resctrl to support systems that
implement CBQRI and will reference a QEMU branch that implements CBQRI.

NOTE: CBQRI was previously known as CMQRI and the github repo with the
spec has not yet been renamed [6].

[1] https://github.com/riscv-non-isa/riscv-cmqri/blob/main/riscv-cbqri.pdf
[2] https://docs.kernel.org/x86/resctrl.html
[3] https://lists.riscv.org/g/tech-cmqri/message/38
[4] https://github.com/pdp7/qemu/tree/ssqosid_v8.0.0-rc1
[5] https://github.com/pdp7/linux/commits/ssqosid_sqoscfg_v6.3
[6] https://lists.riscv.org/g/tech-cmqri/message/41

Drew Fustini (1):
  RISC-V: Add support for sqoscfg CSR

Kornel Dulęba (1):
  RISC-V: Detect the Ssqosid extension

 arch/riscv/Kconfig                 | 19 ++++++++++++++
 arch/riscv/include/asm/csr.h       |  8 ++++++
 arch/riscv/include/asm/hwcap.h     |  2 ++
 arch/riscv/include/asm/processor.h |  3 +++
 arch/riscv/include/asm/qos.h       | 40 ++++++++++++++++++++++++++++++
 arch/riscv/include/asm/switch_to.h |  2 ++
 arch/riscv/kernel/cpu.c            |  1 +
 arch/riscv/kernel/cpufeature.c     |  1 +
 8 files changed, 76 insertions(+)
 create mode 100644 arch/riscv/include/asm/qos.h


base-commit: d34a6b715a23ccd9c9d0bc7a475bea59dc3e28b2
-- 
2.34.1

