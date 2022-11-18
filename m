Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEC362FA22
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 17:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241686AbiKRQVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 11:21:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbiKRQVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 11:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE503922E5
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668788443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4/lZAnOXPkFaHnGFixuznrXc+fqvh+fQumPEYd2UgBU=;
        b=dkVV+d6ryflCp+S2R2jUNE8Sd51hoOiAxQIIl5t4feFmDoDLNXQjHSHAu0OInr31oQBgNp
        ahxg+qSa8dCBXvXB/iR4ic/cn/IWirhkjgDxwgPGQb505SwfpqB4NVS8xfb9CkBmaBWPJa
        Seb4tDV1uNnTS4UD0CT6hHUVPM40n14=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-158-TjDb6TtZOKa9hyZboHluxQ-1; Fri, 18 Nov 2022 11:20:39 -0500
X-MC-Unique: TjDb6TtZOKa9hyZboHluxQ-1
Received: by mail-ej1-f72.google.com with SMTP id xc12-20020a170907074c00b007416699ea14so3301892ejb.19
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 08:20:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4/lZAnOXPkFaHnGFixuznrXc+fqvh+fQumPEYd2UgBU=;
        b=vNihDanxqnRb+kYPpelo9NFOvZ7z7+xUfajAabAOPKWDuAfv/MYzwhkKdyNGW+bjLu
         iSSfEl84L0qccNR0H5cZZRM3eDJbQSFPa0g4RbPYMhc+xuHV3cKUcjnihbsJY/H7CXSI
         4vyIuUCAPJf51aRErxFiDD12JQBzpYq4sspzY3g/XH/hNSS0stIV22sDmccKaubkX3Mg
         pxtwT95Zm0Kd51+/wSa90lDQ72/4sj/QpuXdURauHLRQCqDbRpwHCE712/HfpyznjB+c
         oZBVyyDXBBlUgbvKHmbKuVhy8trufF1CSdWDWnH5LNDtndPnCT01KRQTw9StPFsaktyT
         qNIg==
X-Gm-Message-State: ANoB5pnxLaCKDflESDVRZTP1vg0bQDjnNwi0L8mOMTkNQmsQiWBG2kob
        oRmvs7MUP08Qk2JEXKQM1x7OwVvFOlm0AE5K6W6CiqHt+xFffqKRK3vpKxO4XWx/S0oqEjkCsnv
        PLMQ0xlLHVaXW3LPkNjemdLsq
X-Received: by 2002:a17:906:32c7:b0:7ad:934f:abc2 with SMTP id k7-20020a17090632c700b007ad934fabc2mr6130437ejk.690.1668788437934;
        Fri, 18 Nov 2022 08:20:37 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5dOX+eRhJ/tb1LGJakd/27nqemCeDsScZdWGz9DaDQ6/kxFzvAd9jSwpR23iR8HrH0NlpRhw==
X-Received: by 2002:a17:906:32c7:b0:7ad:934f:abc2 with SMTP id k7-20020a17090632c700b007ad934fabc2mr6130419ejk.690.1668788437651;
        Fri, 18 Nov 2022 08:20:37 -0800 (PST)
Received: from x1.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id l19-20020aa7cad3000000b0045bd257b307sm1970007edt.22.2022.11.18.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 08:20:36 -0800 (PST)
From:   Alessandro Carminati <acarmina@redhat.com>
To:     linux-trace-devel@vger.kernel.org
Cc:     alessandro.carminati@gmail.com, acarmina@redhat.com,
        bristot@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] rv/monitors: Move monitor structure in rodata
Date:   Fri, 18 Nov 2022 17:20:33 +0100
Message-Id: <20221118162033.66389-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.31.1
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

It makes sense to move the important monitor structure into rodata to
prevent accidental structure modification.

Signed-off-by: Alessandro Carminati <acarmina@redhat.com>
---
 kernel/trace/rv/monitors/wip/wip.h   | 2 +-
 kernel/trace/rv/monitors/wwnr/wwnr.h | 2 +-
 tools/verification/dot2/dot2c.py     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
index dacc37b62a2c..9c0cd0ad5cd7 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -27,7 +27,7 @@ struct automaton_wip {
 	bool final_states[state_max_wip];
 };
 
-static struct automaton_wip automaton_wip = {
+const static struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
 		"non_preemptive"
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 118e576b91b4..57dfb1c46cb8 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -27,7 +27,7 @@ struct automaton_wwnr {
 	bool final_states[state_max_wwnr];
 };
 
-static struct automaton_wwnr automaton_wwnr = {
+const static struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
 		"running"
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index be8a364a469b..512c7a11830f 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -111,7 +111,7 @@ class Dot2c(Automata):
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append("const static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
-- 
2.31.1

