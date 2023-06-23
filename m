Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D3373BD88
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 19:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFWRMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 13:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbjFWRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 13:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13411981
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:12:43 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x7mPbDQnnkVRw/X9cygYC/TR6vXzcXX4SBLDkMXnm/E=;
        b=so0dYC6ZPkrddiaQFe/ZvLI9mhhRRMEG7vBD1rAvbekbtvx5yuMcBOpxS6E+JZLFmVAUhq
        gBqThCmPJjiu8n0biHp+SNkyULF2cICRdg0GIZPPcUAZO1nuGQjYdB+vF3K0VleMfiVc/t
        6RCZhRgagZf8dQC7Dw/aOXrqBnPhG9h16MYwLrXq2OL+tc5A805LmHnb+zADkFD4tpyXVl
        49lMKBuUpfLyce3126ZklbYFyfAOTs0OTcBMC/bXJ3R3ZKUpA/Z8jF3goVWGjMSnWx+jr3
        VU5d6Tc51FKiUOwk62t4wHxwXp82ixQF+jxM2NYCu9H38E7ApMZJ47YvXoc5DA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687540361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=x7mPbDQnnkVRw/X9cygYC/TR6vXzcXX4SBLDkMXnm/E=;
        b=0IrnBgyyvuh8AQrCOb9IMtBRgkE4iusIj1B0LImfMddij1r9MqAIJZ5f7KjdAfQYyg/3Vj
        vUnfwaZhxmLFF/CA==
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.co>, Will Deacon <will@kernel.org>
Subject: [PATCH v2 0/2] seqlock,mm: lockdep annotation + write_seqlock_irqsave()
Date:   Fri, 23 Jun 2023 19:12:30 +0200
Message-Id: <20230623171232.892937-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this has been a single patch (2/2) but then it was pointed out that the
lockdep annotation in seqlock needs to be adjusted to fully close the
printk window so that there is no printing after the seq-lock has been
acquired and before printk_deferred_enter() takes effect.

I'm sending both patches in this series so both sides (locking and mm)
are aware of the situation.=20
I hope that both patches can be applied independently via their subsystem
tree (the lockdep splat + deadlock is low risk).

The original thread starts at
	https://lore.kernel.org/20230621104034.HT6QnNkQ@linutronix.de

Sebastian


