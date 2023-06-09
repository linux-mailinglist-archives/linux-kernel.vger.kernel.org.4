Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBF04729DBE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241316AbjFIPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241723AbjFIPEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:04:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD4E210C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686323049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+w+pZDopk4F8CHu/k4rB5TG5TqlSH5TY9yzQonWJ8Y4=;
        b=imDbp2B1reYMVuvr8ZcwWX6efrMAH6afsTB/kQhReXnCBae7Th5MB/fnT/jH1pKl0Vnsq1
        7UJuhDQJ0hUAlw6qWfYINVDYtsOY9c/ckj3HmaDsajoHidaCYhhqbOJC310gu/85lHCaT3
        MAoFxzx/v3VPR2uIRoLaTyU3AIKu43I=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-zq0WDYJOMYmSGdON1cGHBA-1; Fri, 09 Jun 2023 11:04:06 -0400
X-MC-Unique: zq0WDYJOMYmSGdON1cGHBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2EF23825BAB;
        Fri,  9 Jun 2023 15:04:05 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2B034087C62;
        Fri,  9 Jun 2023 15:03:56 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [RFC PATCH 0/5] tracing/filters: filtering event fields with a cpumask
Date:   Fri,  9 Jun 2023 16:03:19 +0100
Message-Id: <20230609150324.143538-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

In the context of CPU isolation / NOHZ_FULL interference investigation, we now
have the ipi_send_cpu and ipi_send_cpumask events. However, enabling these
events without any filtering can yield pretty massive traces with a lot of
uninteresting or irrelevant data (e.g. everything targeting housekeeping CPUs).

This series is about adding event filtering via a user-provided cpumask. This
enables filtering using cpumask fields (e.g. ipi_send_cpumask) and extends this
to scalar and the local CPU common fields.

With this, it becomes fairly easy to trace events both happening on and
targeting CPUs of interest, e.g.:

  trace-cmd record -e 'sched_switch' -f "CPU & MASK{$ISOLATED_CPUS}"         \
		   -e 'sched_wakeup' -f "target_cpu & MASK{$ISOLATED_CPUS}"  \
		   -e 'ipi_send_cpu' -f "cpu & MASK{$ISOLATED_CPUS}"         \
		   -e 'ipi_send_cpumask' -f "cpumask & MASK{$ISOLATED_CPUS}" \
		   hackbench

The MASK{} thing is a bit crude but seems to work well enough without break^C
overhauling the predicate parsing logic.

Cheers,
Valentin

Valentin Schneider (5):
  tracing/filters: Dynamically allocate filter_pred.regex
  tracing/filters: Enable filtering a cpumask field by another cpumask
  tracing/filters: Enable filtering a scalar field by a cpumask
  tracing/filters: Enable filtering the CPU common field by a cpumask
  tracing/filters: Document cpumask filtering

 Documentation/trace/events.rst     |  14 ++
 include/linux/trace_events.h       |   1 +
 kernel/trace/trace_events_filter.c | 228 +++++++++++++++++++++++++----
 3 files changed, 216 insertions(+), 27 deletions(-)

--
2.31.1

