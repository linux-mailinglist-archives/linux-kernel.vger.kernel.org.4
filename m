Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398E8692951
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 22:33:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233560AbjBJVdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 16:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbjBJVdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 16:33:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303D081CE2;
        Fri, 10 Feb 2023 13:33:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BF8A661EB0;
        Fri, 10 Feb 2023 21:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 892C3C433EF;
        Fri, 10 Feb 2023 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676064793;
        bh=ZmTI6CJ1QpyHL95uGX/6YQ6vtkLg0UV2JSOubbRz/Qg=;
        h=From:To:Cc:Subject:Date:From;
        b=Dgitt2PqkbvssqVkEq2JgV4ZqgYBTuosSIS7Uq6bzvKtuKmLKaimHVucW5eJnhnip
         AIh3MEZuiL/5Ow4gBDB7S15gGy+OpFW8wjhpo2Qtf82XGnqoY8oXtOPDAqENeMHn4x
         hETK2ZVV04hbXm4J8eFHJ3kGLIQ4pvJ0PG/J/4YSnel8Z0aiTr34JM0aCyCucHG/RR
         /VkE16FVTWswznFfrPNfE7SZQ3E+ghnwHyOYR9rCkgm90Fhjwsd1DVd8L8DZ1NWdQU
         lFSneDlqxtpWJ7+nnW5oMsU4QslO+do1n1iZFqjkno6qkF6nJ7m1kCiv2BmpL0taBG
         XenMoG0yQIOXQ==
From:   Tom Zanussi <zanussi@kernel.org>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, akpm@linux-foundation.org,
        zwisler@google.com, chinglinyu@google.com
Subject: [PATCH 0/4] tracing/histogram: Some fixes for new stacktrace variables
Date:   Fri, 10 Feb 2023 15:33:02 -0600
Message-Id: <cover.1676063532.git.zanussi@kernel.org>
X-Mailer: git-send-email 2.34.1
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

Hi Steve,

Here are a few fixes for some problems I saw when playing around
with the new stacktrace variable/synthetic event patches.

Thanks,

Tom

Tom Zanussi (4):
  tracing/histogram: Don't use strlen to find length of stacktrace
    variables
  tracing/histogram: Fix a few problems with stacktrace variable
    printing
  tracing/histogram: Fix stacktrace key
  tracing/histogram: Fix stacktrace histogram Documententation

 Documentation/trace/histogram.rst | 156 +++++++++++++++++-------------
 kernel/trace/trace_events_hist.c  |  72 +++++++++++---
 kernel/trace/trace_events_synth.c |   7 +-
 3 files changed, 153 insertions(+), 82 deletions(-)

-- 
2.34.1

