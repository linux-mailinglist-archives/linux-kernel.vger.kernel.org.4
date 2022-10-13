Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709DF5FDEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 19:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJMRWy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 13:22:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiJMRWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 13:22:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74F0D8EF0;
        Thu, 13 Oct 2022 10:22:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43827618CE;
        Thu, 13 Oct 2022 17:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF06C433C1;
        Thu, 13 Oct 2022 17:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665681770;
        bh=zGWUK6MZwKcTOIKSSZVkqZtl4VdTmvoh50LAWQHfI2w=;
        h=From:To:Cc:Subject:Date:From;
        b=GIpZoZP3i8MPs4ZIRD8DQdqZxL+bcxEKcGp0OwSb/v2ZVXF5eaWnxQdA0wrGsn7A6
         SZwLyFJgcoP5dkv4db9isF8NuNPpHsfjj08oqp/E3lRy2BvWGvgV7KTiSRq7ECUA4n
         6etRbVa0W2m5z8QbCdm1C8lA0gFfnlaJktnNan8IOzA9wQNb8OAzM082omaOYXT7OG
         0+akPXh1r7Yrj4pjceFTOop60DsLdASxQVgkS/zSSOwZYh0whlCUdAjjNYqQIDESIU
         o4EOrZ0GC0TeeaJAEMuxn0kyLdtukCH//QkJFOv/YlGOooBC0jgUIxoklAgM0H742a
         tDsT+Ob1oNAUQ==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        quic_neeraju@quicinc.com, joel@joelfernandes.org,
        rcu@vger.kernel.org, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH 0/3] srcu: A few NMI-safe debugging updates
Date:   Thu, 13 Oct 2022 19:22:41 +0200
Message-Id: <20221013172244.1099010-1-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This has passed SRCU-N, SRCU-P and SRCU-T so far.

git://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
	srcu/nmisafe

HEAD: 3cfdc2c6b8e89ca3c33954ea9b0d69e8cd141412

Thanks,
	Frederic
---

Frederic Weisbecker (3):
      srcu: Warn when NMI-unsafe API is used in NMI
      srcu: Explain the reason behind the read side critical section on GP start
      srcu: Debug NMI safety even on archs that don't require it


 include/linux/srcu.h     | 44 ++++++++++++++++++++++++++++++++++----------
 include/linux/srcutiny.h | 12 ------------
 include/linux/srcutree.h |  7 -------
 kernel/rcu/srcutree.c    | 31 ++++++++++++++++---------------
 4 files changed, 50 insertions(+), 44 deletions(-)
