Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C216C629DE5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbiKOPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbiKOPpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:45:43 -0500
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258D92CCBD
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:42 -0800 (PST)
Received: by mail-wm1-x34a.google.com with SMTP id c187-20020a1c35c4000000b003cfee3c91cdso175011wma.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:45:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ObjehQvDuvlq01aMll7M6N89WBfUDGdC0LNnzmMXX1M=;
        b=I1Wg1uvq1oyJaj+alEl2o5E0nzemaZAoPIQF09uCoOGX/4FNMhoBwjDuBR4F/PJo5X
         eZAh3A8JgSozBKpPrr6TQPI9fimBht0G15cPIBHES1yX/YoyaIJWnKAGNe30agmYaIpD
         l3ELg4+LpVuFlVxuwpFLpAZEui/xxxf96mqE7QxwPYBHt3M4414nMZVyP7llZogIs31I
         sf9KwDd+3UAXlNQ+o6IkuqjnOga/u9ABiahZM9jnOhJqHK9lSeZbORSqBhNjRHKK9xVT
         xdYHsF2vaKG90TOxwDqlsuRrVSuLzEkCPjxvnp+0GWrN3E/5j9RNww3pNLtD+LAnlsID
         Mf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ObjehQvDuvlq01aMll7M6N89WBfUDGdC0LNnzmMXX1M=;
        b=QWWlWPj0gCmv8wcUYB6Nbx/azqAL8jCCyc0XAOIomC0qofkcMBkvap8S/6i8MOzPd2
         rRmBQx8KO+8RP9Mn7jCaE11lqc7tk5SoIz3brdTBwek0Y7Z4EkVAPKD5GZSuxpso2HWi
         DcIkXykiw04Pv4DAjNH8gVu6MfgwJcZsJg1EFHS9bWatsRHwKUItFdaReKAEDHcpN577
         Px3NSD+eDh7Yncpfy9SFI82rVsmSber2gUdhqtYofbh+WQ/Yf02b7s1w67gqkUQ5hISQ
         oY74/YsNaCD2bxWyszzxKYOjkKoE9zhSHpJtaWVrskc3nuXzlzNMiS5ygFS2s4nJGmSg
         k1WQ==
X-Gm-Message-State: ANoB5pkxPCQktCTUDvGsE18884XAVbHegwdHnyKLD+om7gXA6tQsrK19
        u6EsEWUcE3sGJ4uos22SF4xTTstgBF9M6ND9Rg==
X-Google-Smtp-Source: AA0mqf6lclCnZea8N6NOMkE/gZbhKhJZXgoQIjhYrTac3gIllgQDeI236kp8QTwoz1w+TtmKRsnrxpXLwN5w7xAE0g==
X-Received: from peternewman10.zrh.corp.google.com ([2a00:79e0:9d:6:fe62:9ede:ae13:6fda])
 (user=peternewman job=sendgmr) by 2002:a05:600c:1c9a:b0:3cf:6f23:a3e3 with
 SMTP id k26-20020a05600c1c9a00b003cf6f23a3e3mr371731wms.1.1668527140244; Tue,
 15 Nov 2022 07:45:40 -0800 (PST)
Date:   Tue, 15 Nov 2022 16:45:13 +0100
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.493.g58b659f92b-goog
Message-ID: <20221115154515.952783-1-peternewman@google.com>
Subject: [PATCH v1 0/2] x86/resctrl: implement rename to help move containers' tasks
From:   Peter Newman <peternewman@google.com>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        James Morse <james.morse@arm.com>,
        Stephane Eranian <eranian@google.com>,
        Gaurang Upasani <gupasani@google.com>,
        Babu Moger <Babu.Moger@amd.com>, linux-kernel@vger.kernel.org,
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

Without this, we were forced to write all of the task IDs from the
container into the tasks file of the new control group. Because a group
is free to dynamically create new tasks, we found this approach
unusable.

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

These patches are based on v6.1-rc5

[1] https://lore.kernel.org/lkml/7b09fb62-e61a-65b9-a71e-ab725f527ded@intel.com/
[2] https://lore.kernel.org/lkml/20221103141641.3055981-2-peternewman@google.com/

Thanks!
-Peter

Peter Newman (2):
  x86/resctrl: factor rdtgroup lock for multi-file ops
  x86/resctrl: Implement rename op for mon groups

 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 101 +++++++++++++++++++++----
 1 file changed, 88 insertions(+), 13 deletions(-)

-- 
2.38.1.493.g58b659f92b-goog

