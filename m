Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C3A60539B
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 01:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiJSXC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 19:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiJSXCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 19:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A91D73C3;
        Wed, 19 Oct 2022 16:02:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E1636199F;
        Wed, 19 Oct 2022 23:02:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1276C433D7;
        Wed, 19 Oct 2022 23:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666220523;
        bh=udClaS588dBqhBl3syllaqjXm2I8E0t6QsPYTT6qrDc=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=RmclcZepvEYIep7d7lOM0GRo/08K5Xhwsa2+te29UsoXOWbPnmticCmbmTcUrbzsn
         fUsHI3ENcnyLAnv393V6s5/Q19Jnr721+a7pQqodreAXqTZKDpvvETmZ26oT+ae/N+
         xSf/vR1lOAajvjdjkfFuX+VX7qvYB9XDMuIH7aSxecT9SeKMaFKxC0L0OspahR01PC
         atAXWlulc1UrmDF2zwEtiI4tQkxAUmOrv6sqHghhwK3yEyOLrBt8X0BJuifo1l/PmO
         zBOrGqBg8zOvYLMN2AE8puV4x1D+TwkeDEf21NJqtyzAmNa6hHQ3YB/LEOxPOYAeYC
         c6CKrTqyYMR6w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 72CFE5C06B4; Wed, 19 Oct 2022 16:02:03 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:02:03 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org
Subject: [PATCH rcu 0/8] Torture-test scripting updates for v6.2
Message-ID: <20221019230203.GA2501612@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This series provides torture-test scripting updates, perhaps most notably
elimination of redundant builds by torture.sh.

1.	Add --bootargs parameter to kvm-again.sh.

2.	Use mktemp instead of guessing at unique names.

3.	Make kvm-test-1-run-qemu.sh check for alternative output.

4.	Make kvm-recheck.sh export TORTURE_SUITE.

5.	Add --datestamp parameter to kvm-again.sh.

6.	Avoid redundant builds for rcuscale and refscale in torture.sh.

7.	Avoid torture.sh compressing identical files.

8.	Make torture.sh create a properly formatted log file.

						Thanx, Paul

------------------------------------------------------------------------

 b/tools/testing/selftests/rcutorture/bin/config2csv.sh           |    3 
 b/tools/testing/selftests/rcutorture/bin/config_override.sh      |    3 
 b/tools/testing/selftests/rcutorture/bin/configcheck.sh          |    3 
 b/tools/testing/selftests/rcutorture/bin/configinit.sh           |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-again.sh            |    9 
 b/tools/testing/selftests/rcutorture/bin/kvm-assign-cpus.sh      |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-build.sh            |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-end-run-stats.sh    |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-recheck.sh          |    2 
 b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh           |   13 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-batch.sh |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh  |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh       |    3 
 b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh        |   68 ++++
 b/tools/testing/selftests/rcutorture/bin/kvm.sh                  |    3 
 b/tools/testing/selftests/rcutorture/bin/parse-build.sh          |    3 
 b/tools/testing/selftests/rcutorture/bin/torture.sh              |    3 
 tools/testing/selftests/rcutorture/bin/kvm-again.sh              |   40 ++
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run-qemu.sh    |    2 
 tools/testing/selftests/rcutorture/bin/torture.sh                |  140 +++++++++-
 20 files changed, 247 insertions(+), 66 deletions(-)
