Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B16C8714
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 21:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232142AbjCXUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 16:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjCXUwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 16:52:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1560714231;
        Fri, 24 Mar 2023 13:52:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AAE162C59;
        Fri, 24 Mar 2023 20:52:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07CD7C433D2;
        Fri, 24 Mar 2023 20:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679691158;
        bh=lE4Q3qpZ75yExb77V10y47R/5jEyrLyRwhRQfr0l1Nc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=RqT5QkcZ4hD90ljFQXp3wnyAyDPKrc/NKcG/P48koN1QjpOLTB0tFhi5rv8HaRcaA
         dnTEQXb/FgqV3OT1ooDti1AlJCDxfsBjLhcgALg5xxtLwb5nW7QnGH8sVj9IWg4lcT
         Q1koGmx79NApRCnzTP0FKUFmrZf7y3YOByfkzITWBUu+UWiw+HjmdcN6fklUGfvbnN
         x3lhc15pIEkQasTvPiSq/u+UMTtSCs0kDD1kweDH/w9TVlVK2bOP87O69oI2aUWK+W
         5fxyqDZ6DV/khmTy4kmMNGF57ck9X77ZZZdxYWizLeBOstFJEyCVf8JHR5oXXhqR/A
         JScjJAtzvp92w==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 936A11540432; Fri, 24 Mar 2023 13:52:37 -0700 (PDT)
Date:   Fri, 24 Mar 2023 13:52:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org
Subject: [PATCH rcu v3 0/27] Unconditionally enable SRCU
Message-ID: <8ae81b0e-2e03-4f83-aa3d-c7a0b96c8045@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230105003759.GA1769545@paulmck-ThinkPad-P17-Gen-1>
 <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113001103.GA3374173@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This v3 series removes the remaining Kconfig "select" clauses that are
no longer necessary given that SRCU is now unconditionally enabled,
courtesy of new-age printk() requirements.  Finally, the SRCU Kconfig
option is removed entirely.

1.	arch/x86: Remove "select SRCU".

2.	kvm: Remove "select SRCU".

3.	mm: Remove "select SRCU".

4.	Remove CONFIG_SRCU.

						Thanx, Paul

------------------------------------------------------------------------

 arch/arm64/kvm/Kconfig                                      |    1 -
 arch/mips/kvm/Kconfig                                       |    1 -
 arch/powerpc/kvm/Kconfig                                    |    1 -
 arch/riscv/kvm/Kconfig                                      |    1 -
 arch/s390/kvm/Kconfig                                       |    1 -
 arch/x86/Kconfig                                            |    2 --
 arch/x86/kvm/Kconfig                                        |    1 -
 kernel/rcu/Kconfig                                          |    3 ---
 mm/Kconfig                                                  |    1 -
 tools/testing/selftests/rcutorture/doc/TREE_RCU-kconfig.txt |    4 ----
 10 files changed, 16 deletions(-)
