Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517ED6A000D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 01:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbjBWA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 19:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjBWA2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 19:28:50 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6788D14981
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:28:48 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id c1so11179832plg.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 16:28:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atishpatra.org; s=google;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WO6JN/lm3lqcQUnXcLoikkeEf2tkfRdlWGJSxQRLbXY=;
        b=F82qGBR6+LJm7hgQrtY1K9rv0f84ccQwl2P9aVuk3adqaJXZb4qRmdhXYeXAuWZcQw
         9eIsELi6Zifxx/0gWK4pSECx6ypFlVV0pIDbrFGxgXwxU8N2XYR3VqYDRTcvef+jjprR
         z6sH3x1QwlrRaeO/9R5wENE/GLujCk8qs3UTI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WO6JN/lm3lqcQUnXcLoikkeEf2tkfRdlWGJSxQRLbXY=;
        b=iaVL1jw7adnyf9ePF8oNr7OTVUWDtqSNo/Kyuzqui7lspvDck2X0ysf23zRqSDH+wC
         b1gZOaUq/OMni3ANMtLw0CyxHjir1v+3ko3lhjWa2RVEUM4OauveLQk5I0ojH6Pew7Bo
         U4IWr6DF9LEYfMa5jRxgO7aXUlRhmhjQc3nfsqaHigDxpy3FUY2LtWPffIx0JP1HaPvj
         VrAoMTHBsXuDH7yRe48jO8N52srtjYjXaMzNz6kYGLOjt0wqgN33gpx1ne0pHIVdzv+N
         8kHWY1bpDLsza8qjR76ucowEDlguEqDOs6cD+bg+mnS8nmztaLZy94joB0JdVuu7y0p1
         c4cQ==
X-Gm-Message-State: AO0yUKVXj2ni7EIulMJOCQIB4NHsF7yFOieb+J//z62iydXsO2ajKtsb
        G2MVHrQ7NcTDtNSzJQ0K7dphGKY0j4aawENSEBap
X-Google-Smtp-Source: AK7set/XC3/Aa7hXy/PABBf/Y0Z6F8a+4tSvCIQ4QT2fhxgwWrwkyx6sCvKWNMWyowSnBYt4xOIDVtO9q0vznwbApGU=
X-Received: by 2002:a17:90b:3e8a:b0:233:c312:47a1 with SMTP id
 rj10-20020a17090b3e8a00b00233c31247a1mr2193217pjb.81.1677112127857; Wed, 22
 Feb 2023 16:28:47 -0800 (PST)
MIME-Version: 1.0
From:   Atish Patra <atishp@atishpatra.org>
Date:   Wed, 22 Feb 2023 16:28:36 -0800
Message-ID: <CAOnJCUKHq_8msJtU-H1JvWJ8nY94J0tcarQMBsPNpBZO8sP6HQ@mail.gmail.com>
Subject: Perf event to counter mapping question
To:     linux-perf-users@vger.kernel.org
Cc:     "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Beeman Strong <beeman@rivosinc.com>,
        Anup Patel <apatel@ventanamicro.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
We are trying to figure out what is the best approach to define the
perf event to programmable counter mappings in RISC-V.
Until recently, all the programmable counter/event selector registers
were writable in M-mode (highest privilege mode) only. The firmware
residing in M-mode
would discover the mapping from device tree[1] and the perf driver
relies on SBI PMU[2] interface to discover the mapping between event &
counters.

There are new ISA extensions being proposed to make counters /event
selector register in supervisor mode as well. Thus, a pmu driver
can directly program the event selectors without relying on firmware.
However, the kernel needs to be aware of counter mapping to do that.

AFAIK, ARM64 allows all-to-all mapping in pmuv3[1]. That makes life
much easier. It just needs to pick the next available counter.
On the other hand, x86 allows selective counter mapping which is
discovered from the json file and maintained in per event
constraints[4].
There may be some legacy reasons why it was done in x86 this way[5].
Please correct me if I am wrong in my understanding/assumption.

Here are a few approaches that can be used to solve it in RISC-V.

1. Continue to use device tree bindings
Cons: We have to define similar entries for ACPI. It makes
virtualization difficult as the VMM has to discover and update the
device tree/ACPI as well.

2. Mandate all-to-all mapping similar to ARM64.
Note: This is only for programmable counters. If the platform supports
any fixed counters (i.e. can monitor
only a specific event), that needs to be provisioned via some other
method. IIRC the fixed counters(apart from cycle) in ARM64 are part of
AMU not PMU.

3. All platforms need to define which subset of events can be
monitored using a subset of counters. The platform specific perf json
file can specify that.
This approach provides more flexibility but makes the code path a bit
more complex as the counter mask constraint needs to be maintained per
event basis.

4. Any other approach ?

Any thoughts on what would be the best approach for RISC-V. It would
be great to repeat any past mistakes in RISC-V by learning from
experience from the community.

[1] https://lore.kernel.org/lkml/Y6tS959TaY2EBAdn@spud/T/
[2] https://github.com/riscv-non-isa/riscv-sbi-doc/blob/master/riscv-sbi.adoc#function-find-and-configure-a-matching-counter-fid-2
[3] https://elixir.bootlin.com/linux/v6.2/source/arch/arm64/kernel/perf_event.c#L899
[4] https://elixir.bootlin.com/linux/latest/source/arch/x86/events/core.c#L876
[5] https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1978937.html
-- 
Regards,
Atish
