Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5CB660900
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 22:56:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAFV4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 16:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234603AbjAFV4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 16:56:30 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD25FAD;
        Fri,  6 Jan 2023 13:56:20 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id bt23so3867233lfb.5;
        Fri, 06 Jan 2023 13:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YJ1VHG8QdvW23DuDLj0FR+4QbFnd8LU8x0Q0vsj/g7A=;
        b=XR6QnKRhjr9YVIh2ceB7fPSiS2E0NvSY04bzdRg0ka8DpR4RWE1IOJNn+j1qcNaCJC
         Q2nzQng87I2Kml2/F2dFhK5Mgr/uTWveWjQx35w0eFoPumVKE08IdWUAJimaiqrM8vg8
         XSrHSpolYohKDKG9LYxTH0VY378OLgyd17W8ivYolOJ/qNzQWPl1TaOcGJaRJQMkA0wE
         rkuz8M2n81tFhSNKGnGEqdbOvEjYMVapT+FzEJuYcYrpRyyTBf4z3vEpkvFAwXGXqM3V
         4rxlrQ38a4yaVOIabmJbvl210YyPHO3xiIQ1O8YDszJmGXRFVBcyn+dqNPJLlMj9jy0c
         88Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJ1VHG8QdvW23DuDLj0FR+4QbFnd8LU8x0Q0vsj/g7A=;
        b=KXgExHHYJ5wsSOlYKnut42yaEMFZ0gZF0dWLIdKKADrxVtRTquCEgeOGT09hQBI5R1
         xt7h9X9u6clBpPzouo+JiiOpmUiLSrKW9MdERsPIbXkOUosxvY6QY2bbghVv1TvMTG2K
         6EeAD2c4pNXITJoyqiXAceJjVXAF1Rym2UhsdFaKGn5lpohf/eMEVr1sYL6SDd1lFGIL
         vH8SKBWUo6jYXpwccEq4bcEch0Pbkib/KYa8Fmq1B7RZH368NZ5j/qyRYUmJMbwn8SkO
         S2AJXDDiWQizBzjqF1MszfKeJ++963LYG43mYlRbYKe6nGJxJ2OhrqWObUjWYwdNMURH
         W/dQ==
X-Gm-Message-State: AFqh2kr25YACWBysDx813PdBuQ6xMuX91LbHxPatKgZpuDxEb8OcgSBF
        HW7tbkzi2Yqj72siWdeeOtg=
X-Google-Smtp-Source: AMrXdXuiFLTGHD/Jb7PNLzWczXpK9IOZHvL9ZCXGvQZb8hsNuAX0kGMNqxNRpnZnq3k4Hb5VpFKpTA==
X-Received: by 2002:a05:6512:2308:b0:4b5:6b87:a5ce with SMTP id o8-20020a056512230800b004b56b87a5cemr17870719lfu.46.1673042179015;
        Fri, 06 Jan 2023 13:56:19 -0800 (PST)
Received: from localhost.localdomain ([46.147.136.10])
        by smtp.gmail.com with ESMTPSA id p20-20020a056512235400b004cb430b5b38sm290474lfu.185.2023.01.06.13.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 13:56:18 -0800 (PST)
From:   Alexander Pantyukhin <apantykhin@gmail.com>
To:     peterz@infradead.org, akpm@linux-foundation.org
Cc:     mingo@redhat.com, namhyung@kernel.org, jolsa@kernel.org,
        acme@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Pantyukhin <apantykhin@gmail.com>
Subject: [PATCH] tools:perf:scripts:python:intel-pt-events del unusedvar
Date:   Sat,  7 Jan 2023 02:56:13 +0500
Message-Id: <20230106215613.7159-1-apantykhin@gmail.com>
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
 tools/perf/scripts/python/intel-pt-events.py | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 08862a2582f4..28d08e2fb7cd 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -340,7 +340,6 @@ def print_srccode(comm, param_dict, sample, symbol, dso, with_insn):
 	print(start_str, src_str)
 
 def do_process_event(param_dict):
-	event_attr = param_dict["attr"]
 	sample	   = param_dict["sample"]
 	raw_buf	   = param_dict["raw_buf"]
 	comm	   = param_dict["comm"]
@@ -359,13 +358,13 @@ def do_process_event(param_dict):
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

