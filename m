Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F672F4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbjFNGZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbjFNGZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:25:37 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EBC10E3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 23:25:35 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgwQh71BBzBQgpg
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 14:25:32 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686723932; x=1689315933; bh=7OkLxsdT95RRgQmH5i3rBRNHMZa
        aegElai9Zs46I9AA=; b=IR3Bt/Y8GDBGdgKG/uWH/TPDaT7tm0xp9z3B1wuAubZ
        ydvm2KioTXj+5yrA/KrJZsWrlVDIw5r1x6R5fvT22p/Fu/eOzYcJf1ekMNdZoVsT
        ImWKw2dUkb3bI/WJ6OIKvydU7pM1zlma4UuToS4W3eKY97NsKehQA4ZQBJCTK6Q7
        MxHP4Wbyf3B+diTCiEcFJInibiUhHZAp5+I6TfJ9+9J6OyOmaIpt1EkCiycAaC6Y
        4+h4zVbxbM8YE1TC8Rzm9gALR7iuTGhTHUL0sgp6+Dt95q2tNV7Cg3pQkTa9v1Gq
        SI83DHj2nKIgqBjxGrkhpX4+8FH8KIMlmhmNVkW60cg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9fsnAFdqoj25 for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 14:25:32 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgwQh17kvzBQgp7;
        Wed, 14 Jun 2023 14:25:32 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 14:25:32 +0800
From:   baomingtong001@208suo.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, anshuman.khandual@arm.com
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] perf tools:remove unneeded variable from
 perf_event_attr__fprintf()
In-Reply-To: <20230614062234.24149-1-luojianhong@cdjrlc.com>
References: <20230614062234.24149-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <329a5b1b6e2c9061467ed6ef82247b8d@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:

tools/perf/util/perf_event_attr_fprintf.c:97:5-8: Unneeded variable: 
"ret". Return "0".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  tools/perf/util/perf_event_attr_fprintf.c | 3 +--
  1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/util/perf_event_attr_fprintf.c 
b/tools/perf/util/perf_event_attr_fprintf.c
index 7e5e7b30510d..4a8f625b80c7 100644
--- a/tools/perf/util/perf_event_attr_fprintf.c
+++ b/tools/perf/util/perf_event_attr_fprintf.c
@@ -94,7 +94,6 @@ int perf_event_attr__fprintf(FILE *fp, struct 
perf_event_attr *attr,
                   attr__fprintf_f attr__fprintf, void *priv)
  {
      char buf[BUF_SIZE];
-    int ret = 0;

      PRINT_ATTRf(type, p_unsigned);
      PRINT_ATTRf(size, p_unsigned);
@@ -155,5 +154,5 @@ int perf_event_attr__fprintf(FILE *fp, struct 
perf_event_attr *attr,
      PRINT_ATTRf(aux_sample_size, p_unsigned);
      PRINT_ATTRf(sig_data, p_unsigned);

-    return ret;
+    return 0;
  }
