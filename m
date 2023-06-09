Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21635729DCC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 17:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjFIPFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 11:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbjFIPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:05:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BFC35B7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686323069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=snCuxFAiT0B/bnlHGtaiRqsJwVD+zCZujmUlSZJWpwM=;
        b=FYvttFH64LWYJcp7fnajMu/mF/2g4z/EazwGxwTHpP3IytegGxCHK4a9F6d60TIhtdXqCu
        zGOC/B9qp/EbwCFL4qB4+URujsBlEnzpNCiq0YnkSCzXLqjBV2t069hHsaJSlvtxo1Whzj
        YooSlBuvlQk8pL08x/+bEGTpz2JLJKE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-80-nCse8t6ROPCfh-6T_4NSdQ-1; Fri, 09 Jun 2023 11:04:25 -0400
X-MC-Unique: nCse8t6ROPCfh-6T_4NSdQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73E2E101A52C;
        Fri,  9 Jun 2023 15:04:24 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AACC54087C62;
        Fri,  9 Jun 2023 15:04:18 +0000 (UTC)
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
Subject: [RFC PATCH 5/5] tracing/filters: Document cpumask filtering
Date:   Fri,  9 Jun 2023 16:03:24 +0100
Message-Id: <20230609150324.143538-6-vschneid@redhat.com>
In-Reply-To: <20230609150324.143538-1-vschneid@redhat.com>
References: <20230609150324.143538-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cpumask, scalar and CPU fields can now be filtered by a user-provided
cpumask, document the syntax.

Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 Documentation/trace/events.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index f5fcb8e1218f6..e9bc9f23891a0 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -219,6 +219,20 @@ the function "security_prepare_creds" and less than the end of that function.
 The ".function" postfix can only be attached to values of size long, and can only
 be compared with "==" or "!=".
 
+Cpumask fields or scalar fields that encode a CPU number can be filtered using
+a user-provided cpumask in cpulist format. The format is as follows::
+
+  MASK{$cpulist}
+
+Operators available to cpumask filtering are:
+
+& (intersection), ==, !=
+
+For example, this will filter events that have their .target_cpu field present
+in the given cpumask::
+
+  target_cpu & MASK{17-42}
+
 5.2 Setting filters
 -------------------
 
-- 
2.31.1

