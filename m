Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E551163BFA6
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 13:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbiK2MDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 07:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbiK2MCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:02:15 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C530B21813
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:13 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-3b0af5bcbd3so122992527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 04:02:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nTGanFWcQKfiYltbXXTbjiWLVe4urWoYZmVI5pxZUqs=;
        b=I1tIXjEIM3UrahA0IC05CnuhuDnteeJbYDbH4iBbzQK8t9N1QN0o9S7IUXhNgc9DKi
         qA0wE1piGiYC06DKVLmUWI+Ri74pn0Ug1pM4TsZ9ZjKZlMgK0I3hEJkFp/emf5SbuJrt
         K68BsgZWI7wA+2hTJtercIdBBLI4QTjt0GSi77cHMj5SHVVy5OovIM/rAzEq9feO1COI
         UpGFpdQLx55/P104DVmLkdhm8Q883u3y9pgV0ocbaNwzLdztm49AdDv/bmU7RAXATlcQ
         OpECBk2VUqG4eD1mdZWxBhhzSwQ55lAWgvQXb9uozrWL35vPQTN4StNsqUbjQVizgHLs
         Hg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nTGanFWcQKfiYltbXXTbjiWLVe4urWoYZmVI5pxZUqs=;
        b=fo/8vHBRJpfF1ppCgjBL4zUacFc+x6McfNgZblh1/eSp2r5xvIjM2ljWEPDwTZpmRW
         6k36nU6YHBSzAbPuPdq6MpVjddrDCZvHxNzYA/ms9YP+hfzEh//CQibr3eIVgS2I0mpz
         ImmVlD2X7glUB21gkrBHwjb8ztquVM6oyCRFRknry8lXFr1GMuLTfrbR6auXdI/qJ7mH
         zHEa5LO8DN4yuaYBc5YFRWznTCJ8D2vllD4rqGQzo9y23uqY115Ht6hkUZkNNZ5tM3Y7
         BTfTlnGQMm7pfqT2qnf6tHVQy8IVnnhqkWM0zsQjlwG5d6Xs6JwV7iptHOx70kXvQ74I
         UUnA==
X-Gm-Message-State: ANoB5pnO7jfjG5b9LCiz5YNA55UgI8o/Jvnok0oEVw7OrfvcAuVPuFo/
        Cap5YNjN5qOz3qjwQYKWeYua+dswLm/e7gq2Sg==
X-Google-Smtp-Source: AA0mqf6Op2PVQkcWKsW+sWIJwH76vC0nxYMJ21k2JbJpOSvLC0LiT3wK2E9MHwld5JxQUlHGzFTC06P2gGX0AOzkpA==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:e398:2261:c909:b359])
 (user=peternewman job=sendgmr) by 2002:a05:6902:1028:b0:6e1:e51:4f19 with
 SMTP id x8-20020a056902102800b006e10e514f19mr15ybt.43.1669723332667; Tue, 29
 Nov 2022 04:02:12 -0800 (PST)
Date:   Tue, 29 Nov 2022 13:01:47 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221129120149.1035444-1-peternewman@google.com>
Subject: [PATCH v2 0/2] x86/resctrl: Implement rename to help move containers' tasks
From:   Peter Newman <peternewman@google.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com
Cc:     Babu.Moger@amd.com, bp@alien8.de, dave.hansen@linux.intel.com,
        eranian@google.com, gupasani@google.com, hpa@zytor.com,
        james.morse@arm.com, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, x86@kernel.org,
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

This patch series implements the solution Reinette suggested in the
earlier RFD thread[1] for the problem of moving a container's tasks to a
different control group on systems that don't provide enough CLOSIDs to
give every container its own control group.

This change originally depended on the CLOSID update race fix[2] to
provide a race-free mechanism for notifying the CPUs where moved tasks
were residing. However, now that the current guidance for group task
movement is to broadcast IPIs to all CPUs, this patch can be applied
independently.

This patch series assumes that a MON group's CLOSID can simply be
changed to that of a new parent CTRL_MON group. This is allowed on Intel
and AMD, but not MPAM implementations. While we (Google) only foresee
needing this functionality on Intel and AMD systems, this series should
hopefully be a good starting point for supporting MPAM.

Thanks!
-Peter

Updates:

v2: reworded change logs based on what I've learned from review comments
    in another patch series[3]

[v1] https://lore.kernel.org/lkml/20221115154515.952783-1-peternewman@google.com/

[1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
[2] https://lore.kernel.org/lkml/20221103141641.3055981-2-peternewman@google.com/
[3] https://lore.kernel.org/lkml/54e50a9b-268f-2020-f54c-d38312489e2f@intel.com/

Peter Newman (2):
  x86/resctrl: Factor rdtgroup lock for multi-file ops
  x86/resctrl: Implement rename op for mon groups

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 +++++++++++++++++++++----
 1 file changed, 88 insertions(+), 13 deletions(-)


base-commit: b7b275e60bcd5f89771e865a8239325f86d9927d
-- 
2.38.1.584.g0f3c55d4c2-goog

