Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA39616CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbiKBSkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbiKBSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:40:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4326571
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:40:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F37F61B30
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 18:40:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6D37C433C1;
        Wed,  2 Nov 2022 18:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667414401;
        bh=rSlJsz8L+iVdYDBWiie/50uZNNbk/g3s4X5YLB9bmuQ=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=UsPjmCBnMwc6PutBA249bVrQdC4loWIkz6QEHZ5HhCV7By16/dVWl1aoJrnTCY77D
         BW+Oidu6h9oSfJbW49genLjeIbHu0XK2l2v/5vTlNX3tXAMzbgccNKk9y+wi0Wz52W
         GYjXyLqUIFoVrIr6DsBkBBCjIiQp4GXuZbhaoZA2iq934dIHFsGygUbqFCKMoUq7zX
         pyC7C058WZpOISiestzR8JQ4oH3vooI94X2Zbel/309lYHMuReHR58SQ4qf80ShaiY
         EqVOUy7j4WCvQ3PfwVLAwQX2ymkFMJOZKgxctltPeTv2TYlZFRSkHskhSFaKhO3Hu3
         V/O0J95Ymi4dA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5E4AE5C1813; Wed,  2 Nov 2022 11:40:01 -0700 (PDT)
Date:   Wed, 2 Nov 2022 11:40:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        sboyd@kernel.org, corbet@lwn.net, Mark.Rutland@arm.com,
        maz@kernel.org, kernel-team@meta.com, neeraju@codeaurora.org,
        ak@linux.intel.com, feng.tang@intel.com, zhengjun.xing@intel.com
Subject: [PATCH clocksource 0/2] Clocksource-watchdog classification and
 backoff
Message-ID: <20221102184001.GA1306489@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series adds comments classifying bogus measurements and adds capped
exponential backoff for messages that are likely caused by overly busy
systems.

1.	Add comments to classify bogus measurements.

2.	Exponential backoff for load-induced bogus watchdog reads.

						Thanx, Paul

------------------------------------------------------------------------

 b/include/linux/clocksource.h |    4 ++++
 b/kernel/time/clocksource.c   |    2 ++
 kernel/time/clocksource.c     |   31 +++++++++++++++++++++++++------
 3 files changed, 31 insertions(+), 6 deletions(-)
