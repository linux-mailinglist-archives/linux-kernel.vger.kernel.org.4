Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48AD15F76FD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiJGKju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiJGKjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 06:39:48 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF1DEA8
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 03:39:45 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-354c7abf786so41465837b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 03:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ISJQz79DPSkm66hvmvBdJ6e82SZwboKuGqw3xkwjuPw=;
        b=B+ULrpmvR9yACLV9AGYO9l9qA4tUtNbBrI1JPJTlEH36kugEdg4LLcpsNnVWpG9Xlg
         L7w7Wn0ylufwWWf71d2Z/6G7JFmAxnQo98PO3vKHKbkiPE/DyxZo2W4+5YjyhwGBvgfK
         n3doFefS2Tc5lQ+fmNIk+HS4peX/otJ17cHhh6D+y98mgsynG+nC4I4fE5MCdp5R6Z48
         w93GDPDlNIc9+WsHATYdASLtv/84gYRECPQpN72clbiOclLoxI036icbureEucIctuu4
         NneXrnWlKtCk4rUaRlHFbQdSuQaTNHN9AnByq+CxFYTR0a4YT2/TldCJHO4vTUX1vGFM
         4UOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ISJQz79DPSkm66hvmvBdJ6e82SZwboKuGqw3xkwjuPw=;
        b=aO9pgezuZF7jyKsN5qINIU2ilkATRIQQ1OK+3h8Hq1lC4+oj/fbIlDl5mhad4ITcUz
         oCzBrGQTZCPJc3RzT866FG4ZvPfRiWNsaF3aRF6txFChsNMpm8LVl+XHVVx0FiMwZYBh
         /NzTbWAsNR2MorWrlOFH7oe/0Q0DJ1mqBbNMqDIJLbpQK7I7eQchRUMDUovFZHkXINUF
         MB0o84Ejf1B8UUagVQ1bzdU99FMXaEjyioSNm70C/mzQ0bOfC/rJQIT48soU3o4ohjiq
         COv8ebxs5Vf7c9weh/lxKazlfNEgL0iOnCqotx0BUQY6c7QGS3WnpD/Kd/9a1a0vIYNN
         7cVw==
X-Gm-Message-State: ACrzQf0ZxdpACadQmK7ub7+CzpU2lISjAyXh5uiEYEELjpiOppigfn4G
        1KjWypUAHeuZmEHb/v1bruSL4yZXnoVAdSJ/wkZZdA==
X-Google-Smtp-Source: AMsMyM7c+4sxjg6qedSXZP0N3d9DYHnIN4wXQ9BRwyJM+XWXb2QtbiAugvkPMEMCiDzQFs/8e0uKkW04fFh7iZfzvjY=
X-Received: by 2002:a81:1204:0:b0:356:d2ae:a29 with SMTP id
 4-20020a811204000000b00356d2ae0a29mr3835103yws.398.1665139184656; Fri, 07 Oct
 2022 03:39:44 -0700 (PDT)
MIME-Version: 1.0
From:   Peter Newman <peternewman@google.com>
Date:   Fri, 7 Oct 2022 12:39:33 +0200
Message-ID: <CALPaoCj-zav4x6H3ffXo_O+RFan8Qb-uLy-DdtkaQTfuxY4a0w@mail.gmail.com>
Subject: [RFD] resctrl: reassigning a running container's CTRL_MON group
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        James Morse <james.morse@arm.com>,
        Babu Moger <Babu.Moger@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette, Fenghua,

I'd like to talk about the tasks file interface in CTRL_MON and MON
groups.

For some background, we are using the memory-bandwidth monitoring and
allocation features of resctrl to maintain QoS on external memory
bandwidth for latency-sensitive containers to help enable batch
containers to use up leftover CPU/memory resources on a machine.  We
also monitor the external memory bandwidth usage of all hosted
containers to identify ones which are misusing their latency-sensitive
CoS assignment and downgrade them to the batch CoS.

The trouble is, container manager developers working with the tasks
interface have complained that it's not usable for them because it takes
many (or an unbounded number of) passes to move all tasks from a
container over, as the list is always changing.

Our solution for them is to remove the need for moving tasks between
CTRL_MON groups. Because we are mainly using MB throttling to implement
QoS, we only need two classes of service. Therefore we've modified
resctrl to reuse existing CLOSIDs for CTRL_MON groups with identical
configurations, allowing us to create a CTRL_MON group for every
container. Instead of moving the tasks over, we only need to update
their CTRL_MON group's schemata. Another benefit for us is that we do
not need to also move all of the tasks over to a new monitoring group in
the batch CTRL_MON group, and the usage counts remain intact.

The CLOSID management rules would roughly be:

 1. If an update would cause a CTRL_MON group's config to match that of
    an existing group, the CTRL_MON group's CLOSID should change to that
    of the existing group, where the definition of "match" is: all
    control values match in all domains for all resources, as well as
    the cpu masks matching.

 2. If an update to a CTRL_MON group sharing a CLOSID with another group
    causes that group to no longer match any others, a new CLOSID must
    be allocated.

 3. An update to a CTRL_MON group using a non-shared CLOSID which
    continues to not match any others follows the current resctrl
    behavior.

Before I prepare any patches for review, I'm interested in any comments
or suggestions on the use case and solution.

Are there simpler strategies for reassigning a running container's tasks
to a different CTRL_MON group that we should be considering first?

Any concerns about the CLOSID-reusing behavior? The hope is existing
users who aren't creating identically-configured CTRL_MON groups would
be minimally impacted. Would it help if the proposed behavior were
opt-in at mount-time?

Thanks!
-Peter
