Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2BED66AB72
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjANNFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 08:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjANNFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 08:05:51 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B168A57;
        Sat, 14 Jan 2023 05:05:50 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bf43so36753860lfb.6;
        Sat, 14 Jan 2023 05:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vgp8s8P2WnixEBsyqVgrtqVW0mzwiU+P0sRoxo3EKgg=;
        b=DqIzIVQqNhd6n7jA2tIB+KM6TbxMggUX/MlouaizxXqzrSigNfPdtP1GiYuJWHsI68
         EoH0d+GVqWnM6IiIeHH7AloVnZ3iibSVeKZVoTNAIont4n1/b+X+9yUVQWYvzuX9QiaJ
         vCqQzxTvoImWC1b0q1xYmob9w+mlDSzMxHNTeOHau3P76deLvuhCmNApmI0a+jgxtcqy
         JJ7jiCjdqGOQaxS/ZymoSQZZrM6KafLZs2eqWDk4hDUdg1jsEaq/GX0EmZ6bYJXQD8Oq
         AnEx1bq6T1aigkFKmeRmkr+22xKvgToa/jVmz/CHha43Dt5EZdIl0wlvKwj0w41WP35n
         hlZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vgp8s8P2WnixEBsyqVgrtqVW0mzwiU+P0sRoxo3EKgg=;
        b=NpuhKJQwOGW7XymcBuUtF+U+Giqy5toc4Xo51pHkbefyy+eSRaggmn5VovX6sLPy4o
         tGVxQsmyZxm2sG3rW6aPSdrjHWK0eRivdsdyQzVHTFCxCuNc+IWrHyUCplGSk+yvZcVq
         elGIxWiZjqJVFUm8H5KxyPXVFKgsAoEBRbMBNxZun+GJwegYOpp3NuKXXSFZgtJ3Dvdb
         BZCAQlN+igR6hynAvzSfbpT1UHml5faD1eJ8EJErs1GfISFMT13CFPsKrqxzPAZlFZ6d
         j4xwnc0hY+CdH6Pkj4quwqA3LZMJ2yTOzB7k5Kvt4pxgZGrUo8sVma2fhteTCytD5why
         ukQw==
X-Gm-Message-State: AFqh2kqnkcOJXXw3hOdgIIhB42/pAXZLXNhrTCwlfDwHpWTDad1NYgFj
        QVAjp/zWUdbKZgGLwem50Mw=
X-Google-Smtp-Source: AMrXdXseQtXtrBTBAIuP23lB4heGwwraewT2WBFbPz/oRUxG5dwQHtlgc4vN+sjWfXMJyMGsxnoD9Q==
X-Received: by 2002:a05:6512:3415:b0:4b5:947e:68f3 with SMTP id i21-20020a056512341500b004b5947e68f3mr18870984lfr.1.1673701548196;
        Sat, 14 Jan 2023 05:05:48 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id b17-20020a056512071100b0049c29389b98sm4288987lfs.151.2023.01.14.05.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jan 2023 05:05:47 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     adrian.hunter@intel.com
Cc:     mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        acme@kernel.org, akpm@linux-foundation.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH v2] tools:perf:scripts:python:intel-pt-events del unusedvar
Date:   Sat, 14 Jan 2023 18:05:33 +0500
Message-Id: <20230114130533.2877-1-apantykhin@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event_attr is never used later, the var is ok be deleted.
Additional code simplification is to substitute string slice comparison
with "substring" function. This case no need to know the length specific
words.

Signed-off-by: Alexander Pantyukhin <apantykhin@gmail.com>
---
 tools/perf/scripts/python/intel-pt-events.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 08862a2582f4..dfd566369ca4 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
 	print(start_str, src_str)
 
 def do_process_event(param_dict):
-	event_attr = param_dict["attr"]
 	sample	   = param_dict["sample"]
 	raw_buf	   = param_dict["raw_buf"]
 	comm	   = param_dict["comm"]
@@ -349,6 +348,7 @@ def do_process_event(param_dict):
 	# callchain  = param_dict["callchain"]
 	# brstack    = param_dict["brstack"]
 	# brstacksym = param_dict["brstacksym"]
+	# event_attr = param_dict["attr"]
 
 	# Symbol and dso info are not always resolved
 	dso    = get_optional(param_dict, "dso")
@@ -359,13 +359,13 @@ def do_process_event(param_dict):
 		print(glb_switch_str[cpu])
 		del glb_switch_str[cpu]
 
-	if name[0:12] == "instructions":
+	if name.startswith("instructions"):
 		if glb_src:
 			print_srccode(comm, param_dict, sample, symbol, dso, True)
 		else:
 			print_instructions_start(comm, sample)
 			print_common_ip(param_dict, sample, symbol, dso)
-	elif name[0:8] == "branches":
+	elif name.startswith("branches"):
 		if glb_src:
 			print_srccode(comm, param_dict, sample, symbol, dso, False)
 		else:
-- 
2.25.1

