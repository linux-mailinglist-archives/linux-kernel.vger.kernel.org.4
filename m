Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B7C6B2862
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 16:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231760AbjCIPH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 10:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjCIPHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 10:07:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0632728218
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678374281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ViHH+dQMmI/KiT9ScZND3L6rVhY7uFbPCwSs6bh4wg4=;
        b=XjX89LdZVJ28PQeKjgOvniuYHpcGmqLk8T2Ej7IXU8fCivGF2y7gofcpI/CUmT1IvOzKdq
        ZJi4tPsw3pvUv65GPqp5QpvDDipdq+y/Hpm63Hka3goekWehPhkoXl6nRYmw1sDlMCr8e3
        i3NkAn0kPIVHqKGAMZ+n/Zpc+i9Fx3I=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-HJ0LxvLaOmmYX0CPM2EqXg-1; Thu, 09 Mar 2023 10:04:40 -0500
X-MC-Unique: HJ0LxvLaOmmYX0CPM2EqXg-1
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-538116920c3so22156957b3.15
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 07:04:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678374277;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ViHH+dQMmI/KiT9ScZND3L6rVhY7uFbPCwSs6bh4wg4=;
        b=CW8csJM4ngncenKm3b2t1B6Xsa/H2WrN9kcRbXy3y1EPsDoiVQ59M2z7yOMdpD4UE/
         Y8D0p8UyyGphgFGviO24BxB4hdKTG2Eh5G1/QcGu52Pj0MXZAgUTAfeDz1vjxrSv7cdy
         TqILzOdYlbEtRf/l/xOwgxnhjusBpOmRuznMyAHx/DG2/NyWbQ9vGn/pBM0hQzD52MIs
         slavsXtT9hpyco5FFPBlLMdfEoXFYNOaH6PJkj8WN3r3brYSlteG7a/8P3BZZqMUH/3+
         sWEs+T48ii2oktqyJbkKmAC5W6GG5miB5+ryxiv5r9tPi/jJkH6RdmBolNDHoZm50Co8
         WeGw==
X-Gm-Message-State: AO0yUKVeSvNc1YZR6Lsrom9FaOupaanmhk2EKvTqPzMqbURHqQkcvLFc
        e7ilYUR9r0x9W7J9I9H3W1KtJ4UCag0WE64aGHVoZhXGV67i1/WfBoly4Vs2FWf9fJ8YioL3yFA
        AeHDdt78SPcvocBSdt2is0Z1aKPh4PYjz
X-Received: by 2002:a05:7500:98b:b0:fb:265f:2db3 with SMTP id ee11-20020a057500098b00b000fb265f2db3mr594944gab.17.1678374277019;
        Thu, 09 Mar 2023 07:04:37 -0800 (PST)
X-Google-Smtp-Source: AK7set+pQojk8UkLH4FHuXMwqDYGdqTrN3D/xgZ/ik4mWw9maGzt3nu7qGUn/6mViSPnPrezV31wrA==
X-Received: by 2002:a05:7500:98b:b0:fb:265f:2db3 with SMTP id ee11-20020a057500098b00b000fb265f2db3mr594919gab.17.1678374276542;
        Thu, 09 Mar 2023 07:04:36 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id e10-20020a05620a014a00b0071a02d712b0sm13722404qkn.99.2023.03.09.07.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 07:04:36 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, bristot@kernel.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tracing/osnoise: set several trace_osnoise.c variables storage-class-specifier to static
Date:   Thu,  9 Mar 2023 10:04:14 -0500
Message-Id: <20230309150414.4036764-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

smatch reports several similar warnings
kernel/trace/trace_osnoise.c:220:1: warning:
  symbol '__pcpu_scope_per_cpu_osnoise_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:243:1: warning:
  symbol '__pcpu_scope_per_cpu_timerlat_var' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:335:14: warning:
  symbol 'interface_lock' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2242:5: warning:
  symbol 'timerlat_min_period' was not declared. Should it be static?
kernel/trace/trace_osnoise.c:2243:5: warning:
  symbol 'timerlat_max_period' was not declared. Should it be static?

These variables are only used in trace_osnoise.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/trace_osnoise.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index f68ca1e6460f..cf395d2e8775 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -217,7 +217,7 @@ struct osnoise_variables {
 /*
  * Per-cpu runtime information.
  */
-DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
+static DEFINE_PER_CPU(struct osnoise_variables, per_cpu_osnoise_var);
 
 /*
  * this_cpu_osn_var - Return the per-cpu osnoise_variables on its relative CPU
@@ -240,7 +240,7 @@ struct timerlat_variables {
 	u64			count;
 };
 
-DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
+static DEFINE_PER_CPU(struct timerlat_variables, per_cpu_timerlat_var);
 
 /*
  * this_cpu_tmr_var - Return the per-cpu timerlat_variables on its relative CPU
@@ -332,7 +332,7 @@ struct timerlat_sample {
 /*
  * Protect the interface.
  */
-struct mutex interface_lock;
+static struct mutex interface_lock;
 
 /*
  * Tracer data.
@@ -2239,8 +2239,8 @@ static struct trace_min_max_param osnoise_print_stack = {
 /*
  * osnoise/timerlat_period: min 100 us, max 1 s
  */
-u64 timerlat_min_period = 100;
-u64 timerlat_max_period = 1000000;
+static u64 timerlat_min_period = 100;
+static u64 timerlat_max_period = 1000000;
 static struct trace_min_max_param timerlat_period = {
 	.lock	= &interface_lock,
 	.val	= &osnoise_data.timerlat_period,
-- 
2.27.0

