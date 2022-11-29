Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB0E63BEAE
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 12:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232995AbiK2LLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 06:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiK2LLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 06:11:10 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CBB265F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:03 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id c10-20020a7bc84a000000b003cf81c2d3efso4589040wml.7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 03:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=C35WM+rFOww9oANmi2XKIgD3lZZHmk9pCOYrcDGbk7A=;
        b=sMaUlF+mKL0TN8tM/IH7nnj6EOZVAMDMNcq0DT6JcGOSAZaxnp5zeOKmanWdPq+0OO
         uA4KllZNoS8cHkAd01MItYNXSfwQGrPUp62pGTiwX/UvECX50Ol7dtOk07Em3thbzAq9
         z7aKGINXnQyT90Jpl1HyejJ5oZuOVnFHE3wPAeXQfXf4U1TUmtJQHKblwDr3UxwzhV/G
         IZwSe585LTE0TscrmaMS0LBhYk6OkOh7DmYuOWYy86Lznsc/W2cAHOy6ydQWb+vcz+QL
         t4IIctSup2WnNTryME2HywbK+ezh5dvN5PIGlSzAMWZc80OzSQHm1QdTROKqCcRTnFFG
         0ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C35WM+rFOww9oANmi2XKIgD3lZZHmk9pCOYrcDGbk7A=;
        b=A86ua2WMC55O+Qe1oGVqfk+JIQ4hHhg1A8F7NiFn2iVmoJFzezoWo8+eMSn9GWLZm6
         Pm52gRE0sCK3ddwiNnXZh865cuwbKM3xqvVT2RxD81VdFcI5LKlWuVr+Fc/Z1+leH93H
         i5x07pM7Di7Z8zKfclhm8aPMKuIj0NcsOb5NrraJR1Hv2T2oGa/9wE6WbGZNmQ/qyNkX
         AtrGG1zdVESS2HfXL+uSt2K/8YFL/CaCYQvR+heceTgkq1doZN1Zjjuyjq38OQJ5BbC9
         D1Q8j/qAERdsXKYlYMtsO+cvc6mRX2VjHQWVm+1tGy+4M86aTVL2C5YmQf3kouUtmV/+
         slew==
X-Gm-Message-State: ANoB5pmrWTK2KQYCZECHm3lzh9WrWBeTyMirlHZkAhIdu79F3RVtXPc7
        CyXYnyd9S17baO6BU09rhOd6PEHzKVCj5R/unw==
X-Google-Smtp-Source: AA0mqf7EIncJyBJOxt2LLSBe3uzNCWJM3+Uc6c4siivX4wgOYxrFeJVGCxzityPd80jWhV3JQBsiQ44rEKlAN3xL/g==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a05:6000:1d92:b0:241:6e0a:bfe6 with
 SMTP id bk18-20020a0560001d9200b002416e0abfe6mr26088628wrb.34.1669720262242;
 Tue, 29 Nov 2022 03:11:02 -0800 (PST)
Date:   Tue, 29 Nov 2022 12:10:53 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129111055.953833-1-peternewman@google.com>
Subject: [PATCH v4 0/2] x86/resctrl: Fix task CLOSID update race
From:   Peter Newman <peternewman@google.com>
To:     reinette.chatre@intel.com, fenghua.yu@intel.com
Cc:     bp@alien8.de, derkling@google.com, eranian@google.com,
        hpa@zytor.com, james.morse@arm.com, jannh@google.com,
        kpsingh@google.com, linux-kernel@vger.kernel.org, mingo@redhat.com,
        tglx@linutronix.de, x86@kernel.org,
        Peter Newman <peternewman@google.com>
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

Hi Reinette, Fenghua,

I've fixed the wording in changelogs and code comments throughout and
clarified the explanations as Reinette had requested.

The patch series addresses the IPI race we discussed in the container
move RFD thread[1]. The changelog in the patches should also provide a
good description.

Updates in v4:
 - Reorder the patches so that justification for sending more IPIs can
   reference the patch fixing __rdtgroup_move_task().
 - Correct tense of wording used in changelog and comments
Updates in v3:
 - Split the handling of multi-task and single-task operations into
   separate patches, now that they're handled differently.
 - Clarify justification in the commit message, including moving some of
   it out of inline code comment.
Updates in v2:
 - Following Reinette's suggestion: use task_call_func() for single
   task, IPI broadcast for group movements.
 - Rebased to v6.1-rc4

v1: https://lore.kernel.org/lkml/20221103141641.3055981-1-peternewman@google.com/
v2: https://lore.kernel.org/lkml/20221110135346.2209839-1-peternewman@google.com/
v3: https://lore.kernel.org/lkml/20221115141953.816851-1-peternewman@google.com/

Thanks!
-Peter

[1] https://lore.kernel.org/all/CALPaoCg2-9ARbK+MEgdvdcjJtSy_2H6YeRkLrT97zgy8Aro3Vg@mail.gmail.com/

Peter Newman (2):
  x86/resctrl: Update task closid/rmid with task_call_func()
  x86/resctrl: IPI all online CPUs for group updates

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 130 ++++++++++++-------------
 1 file changed, 60 insertions(+), 70 deletions(-)


base-commit: eb7081409f94a9a8608593d0fb63a1aa3d6f95d8
--
2.38.1.584.g0f3c55d4c2-goog

