Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6F76C3E6B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 00:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjCUXXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 19:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUXXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 19:23:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB44574ED
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:23:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24693B81907
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 23:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C43C433EF;
        Tue, 21 Mar 2023 23:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679441008;
        bh=ea87VpNLJUaOmFKXtk3vlpERWguAOEohFqyBipOJXA0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=sT91AmakvkXJe17vPqbF0yzi89Cnnz8KII14Xw132PeiFNV36TmsGUw6o4w5aclLH
         kD+fdAz3joy+dQw4RqUuLuR1+QN6xOolCDEdmV3iQPGc+vlPpvC3QxPHQmH4zLOp+O
         LivwJfRfcCt9oRyEweIX7oVZscuYygU/bz0K/rUgWL+7/dRa4Abz/WBA3QsB7IGuyc
         50MEEFiSnxK/dtIPJ4IIAlBlWewBzbvotO8XNMcVvFLrHo4Ll4WqZH4V7xT/EiDT8W
         lO66e75li1ooJ7Irw691Hyqp5OBwwCPTiMKxbsRXlbFRGkyv777s9/cfw+X51Hz8hp
         BjYk3WCRjq7pA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 6429B154033A; Tue, 21 Mar 2023 16:23:28 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:23:28 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     feng.tang@intel.com
Cc:     linux-kernel@vger.kernel.org
Subject: A couple of TSC questions
Message-ID: <b2f07f18-b60b-403b-90ff-937ea32963ee@paulmck-laptop>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Feng!

I hope that things are going well for you and yours!

First, given that the kernel can now kick out HPET instea of TSC in
response to clock skew, does it make sense to permit recalibration of
the still used TSC against the marked-unstable HPET?

Second, we are very occasionally running into console messages like this:

Measured 2 cycles TSC warp between CPUs, turning off TSC clock.

This comes from check_tsc_sync_source() and indicates that one CPU's
TSC read produced a later time than a later read from some other CPU.
I am beginning to suspect that these can be caused by unscheduled delays
in the TSC synchronization code, but figured I should ask you if you have
ever seen these.  And of course, if so, what the usual causes might be.

Thoughts?

							Thanx, Paul
