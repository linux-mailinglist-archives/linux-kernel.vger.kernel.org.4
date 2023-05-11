Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E33B6FF953
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239262AbjEKSGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239181AbjEKSFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:05:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B3D3;
        Thu, 11 May 2023 11:05:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C685265096;
        Thu, 11 May 2023 18:04:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49BF9C4339C;
        Thu, 11 May 2023 18:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683828299;
        bh=hHesJQX+DZzTicW9tEXO+uTBEJ94ukGnFXjNeOZqXTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mSQcwNZY2Z6l0XCl8hrct4LobJ8CWG4op0o9q1ttE4AXekiMolyLhCZcQsrgduetf
         uPOhtn7/OXfsUcVfOSL4AJ8tsm97tmWLlMTPYx6pcdMsnM9nj6HWK8/AKcoUQApUpt
         tPV6txQw/JnMKQYnez4Ydzk4uFJnz55grne6YH+k4fdLIVgbxAP/IlUGPbLZwObKzD
         dD0efyiUweTtKvGipOWCdn+2LM2VKgbQfcwWRhlFd6O3W+mphFV3EGIYDSpQtm7cAo
         SftFWB5VkEKwsyI0/2UufcWadb2GrDE/VysbtXgGdkO1jARu9DrIz5ywqXMTOIEcD7
         3n/A9kfIZ/0Bw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        0000-cover-letter.patch@vger.kernel.org
Subject: 0001-rtla-Add-C-cgroup-support.patch
Date:   Thu, 11 May 2023 20:04:27 +0200
Message-Id: <20230511180457.7623-1-bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/8] rtla: Add -C cgroup support
Date: Thu, 11 May 2023 20:02:53 +0200
Message-Id: <df9ab6da3d389ebc4e5049fd84079e801974a397.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Juri Lelli <juri.lelli@redhat.com> from line 'Suggested-by: Juri Lelli <juri.lelli@redhat.com>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 2/8] rtla: Add --house-keeping option
Date: Thu, 11 May 2023 20:02:54 +0200
Message-Id: <9d24752f2af0cb5b6fe9893f236b576cedf31b62.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 3/8] rtla: Change monitored_cpus from char * to cpu_set_t
Date: Thu, 11 May 2023 20:02:55 +0200
Message-Id: <0b2e708c5951e5e3016b0a3838960066cfcea19d.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 4/8] rtla: Automatically move rtla to a house-keeping cpu
Date: Thu, 11 May 2023 20:02:56 +0200
Message-Id: <ebe5dbd39620bfae91eb95fe6c69f766334c6381.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 5/8] rtla/timerlat: Give timerlat auto-analysis its own instance
Date: Thu, 11 May 2023 20:02:57 +0200
Message-Id: <dc2fa88f7c8c6103db986122baa496c944571d02.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 6/8] rtla/timerlat_hist: Add auto-analysis support
Date: Thu, 11 May 2023 20:02:58 +0200
Message-Id: <09d6bbc8642fa930cdfc9fa003a0546f9106261d.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 7/8] rtla: Start the tracers after creating all instances
Date: Thu, 11 May 2023 20:02:59 +0200
Message-Id: <26d837baec9e9e261a1352fba6ffe9be8967ba25.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
(mbox) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'From: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Steven Rostedt <rostedt@goodmis.org> from line 'Cc: Steven Rostedt <rostedt@goodmis.org>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Cc: Daniel Bristot de Oliveira <bristot@kernel.org>'
(body) Adding cc: Masami Hiramatsu <mhiramat@kernel.org> from line 'Cc: Masami Hiramatsu <mhiramat@kernel.org>'
(body) Adding cc: Jonathan Corbet <corbet@lwn.net> from line 'Cc: Jonathan Corbet <corbet@lwn.net>'
(body) Adding cc: Daniel Bristot de Oliveira <bristot@kernel.org> from line 'Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>'
Dry-OK. Log says:
Server: mail.kernel.org
MAIL FROM:<bristot@kernel.org>
RCPT TO:<linux-trace-devel@vger.kernel.org>
RCPT TO:<rostedt@goodmis.org>
RCPT TO:<linux-doc@vger.kernel.org>
RCPT TO:<linux-kernel@vger.kernel.org>
RCPT TO:<juri.lelli@redhat.com>
RCPT TO:<chwhite@redhat.com>
RCPT TO:<bristot@kernel.org>
RCPT TO:<mhiramat@kernel.org>
RCPT TO:<corbet@lwn.net>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
To: linux-trace-devel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juri Lelli <juri.lelli@redhat.com>,
	William White <chwhite@redhat.com>,
	Daniel Bristot de Oliveira <bristot@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 8/8] rtla/hwnoise: Reduce runtime to 75%
Date: Thu, 11 May 2023 20:03:00 +0200
Message-Id: <09fd28d1be7a5f3e01da1c2c007cf56790635f39.1683827510.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <cover.1683827510.git.bristot@kernel.org>
References: <cover.1683827510.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: OK
