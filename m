Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485FE60DEF7
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 12:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJZKpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 06:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbiJZKo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 06:44:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525424AD71;
        Wed, 26 Oct 2022 03:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C340DB82189;
        Wed, 26 Oct 2022 10:44:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F7E2C433C1;
        Wed, 26 Oct 2022 10:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666781093;
        bh=U82//oUDhaVje5b0sUsZV8SSFolQg4Jy8YYSsA3q5Ew=;
        h=From:To:Cc:Subject:Date:From;
        b=uFq7Oc1SDyKqkgr6vxDa6I06tknv7JNntEqWuqHzhBEJlNkgPf0B9CDnhjJOmcVN5
         6+3WI2CAym9pFj+teebjNYIDcmHTw4LtaxcHh0f+wXI3++Wmt4IKWpBjOhqKqxORlN
         7b1RvOB0qWQhFnGXyq3Al/vM9r8BK/eJi483T178M9y0WVzoCGB8b49b9cLMzrQyAy
         3h6wSd9cv1BxhSaChn7HHVKE4yBYBDEuML4KEHdEFheT+i2KhrwNBFQx28ukOp3g3+
         8xZZuN6Afa7rCar+SthYyGxv3mFB26F9Q/tw4zHODc9hBEQ8gMIGbwq6yOdYxTiOVB
         Oa2xf1IR9XYVQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        linux-trace-devel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] verification/rv: Add rv tool
Date:   Wed, 26 Oct 2022 12:44:38 +0200
Message-Id: <cover.1666776642.git.bristot@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the (user-space) runtime verification tool named rv.

This tool aims to be the interface for in-kernel rv monitors, as
well as the home for user-space controlled monitors.

The tool receives a command as the first argument, the current
commands are:

  list	- list all available monitors
  mon	- run a given monitor

Each monitor is an independent piece of software inside the
tool and can have their own arguments.

Daniel Bristot de Oliveira (3):
  rv: Add rv tool
  tools/rv: Add in-kernel monitor interface
  Documentation/rv: Add verification/rv man pages

 Documentation/tools/index.rst              |   1 +
 Documentation/tools/rv/Makefile            |  52 ++
 Documentation/tools/rv/common_appendix.rst |  13 +
 Documentation/tools/rv/common_ikm.rst      |  21 +
 Documentation/tools/rv/index.rst           |  24 +
 Documentation/tools/rv/rv-list.rst         |  39 ++
 Documentation/tools/rv/rv-mon-wip.rst      |  40 ++
 Documentation/tools/rv/rv-mon-wwnr.rst     |  39 ++
 Documentation/tools/rv/rv-mon.rst          |  51 ++
 Documentation/tools/rv/rv.rst              |  57 ++
 tools/verification/rv/Makefile             | 141 +++++
 tools/verification/rv/README.txt           |  38 ++
 tools/verification/rv/include/in_kernel.h  |   3 +
 tools/verification/rv/include/rv.h         |  12 +
 tools/verification/rv/include/trace.h      |  16 +
 tools/verification/rv/include/utils.h      |   8 +
 tools/verification/rv/src/in_kernel.c      | 698 +++++++++++++++++++++
 tools/verification/rv/src/rv.c             | 177 ++++++
 tools/verification/rv/src/trace.c          | 128 ++++
 tools/verification/rv/src/utils.c          |  46 ++
 20 files changed, 1604 insertions(+)
 create mode 100644 Documentation/tools/rv/Makefile
 create mode 100644 Documentation/tools/rv/common_appendix.rst
 create mode 100644 Documentation/tools/rv/common_ikm.rst
 create mode 100644 Documentation/tools/rv/index.rst
 create mode 100644 Documentation/tools/rv/rv-list.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wip.rst
 create mode 100644 Documentation/tools/rv/rv-mon-wwnr.rst
 create mode 100644 Documentation/tools/rv/rv-mon.rst
 create mode 100644 Documentation/tools/rv/rv.rst
 create mode 100644 tools/verification/rv/Makefile
 create mode 100644 tools/verification/rv/README.txt
 create mode 100644 tools/verification/rv/include/in_kernel.h
 create mode 100644 tools/verification/rv/include/rv.h
 create mode 100644 tools/verification/rv/include/trace.h
 create mode 100644 tools/verification/rv/include/utils.h
 create mode 100644 tools/verification/rv/src/in_kernel.c
 create mode 100644 tools/verification/rv/src/rv.c
 create mode 100644 tools/verification/rv/src/trace.c
 create mode 100644 tools/verification/rv/src/utils.c

-- 
2.37.3

