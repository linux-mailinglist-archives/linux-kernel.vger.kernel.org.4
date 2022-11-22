Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF39634299
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbiKVRiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 12:38:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233978AbiKVRiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 12:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A8F634A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669138624;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Aj+Hy7/pmo4M08v1ZMJrMPL04jwIP+2wr02vMZIdx8Y=;
        b=YZsFMqpE0vf1LBah2md3JYEI1b6L0ZbwJ750hrDCl3sKnXrYBIpP433N1obFbYjScMsAml
        biNzmj8HIY+KNJh/N+4nJ7lfAc9WGIyZhVNid9wUlH73GXA+17LJaxGkQ51h2DKaUVSbFu
        Jmv84+y3dJTmVHLSPOxOcPNXP3zsD+M=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-306-lMOUXRGIMi2wegEsM2eFAQ-1; Tue, 22 Nov 2022 12:37:03 -0500
X-MC-Unique: lMOUXRGIMi2wegEsM2eFAQ-1
Received: by mail-ej1-f70.google.com with SMTP id qw20-20020a1709066a1400b007af13652c92so8750917ejc.20
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 09:37:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aj+Hy7/pmo4M08v1ZMJrMPL04jwIP+2wr02vMZIdx8Y=;
        b=VzGoo3/9fxKXC5vnNTTGtB4Ae3/4L6wiq+9nlLhUg9mOJ2dp8uS4AuoChml8mHC14j
         mJ3eFBOMlvAF0lCvOYQPPB4PIYTNGR9bVhfUJmUSGVnMrgpt+3/NkCp32xAcsA9f06A6
         tRFqhe/wRAtO38DL4KlqQ5c28896bRR1oEQD0LAmteo8S+m7AkknRzAh6BRqICaNO8rP
         Fnus7yT4/DzOFBlNfCWAOFARjEiqKNuqbkKiSESR4XlFNhtoT3MxRm4qdUXHbwgOrymK
         +sSfvhocnsXGz2pGTj6sjwaZIXgt0PiF4y62X5hKVgu+sQ4pCfABAZgFm39ayynQFbE1
         b4xw==
X-Gm-Message-State: ANoB5plzt/SS12BwzqI3/Y7UeE2kd/d/bclmvTt095ycP4kdwqSx3jYh
        ggKKvd1WrjaluAzJfhoAvbLxsnDmZKOJlAUdQ78ZECELd1yY8JpLNUxnvTKp/68stmtfRHBf33M
        9b9jzpLvkFc/7nWzKr+baWWaH
X-Received: by 2002:a17:906:a40c:b0:7ae:180e:9b53 with SMTP id l12-20020a170906a40c00b007ae180e9b53mr20717455ejz.206.1669138622040;
        Tue, 22 Nov 2022 09:37:02 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5+YDUMQsIqm2ye9t7VXvKKmkQPj+CpN04bUStnpfXPdyYFH/5C9Te+k8AiyJ9cY9q9CDm77Q==
X-Received: by 2002:a17:906:a40c:b0:7ae:180e:9b53 with SMTP id l12-20020a170906a40c00b007ae180e9b53mr20717440ejz.206.1669138621796;
        Tue, 22 Nov 2022 09:37:01 -0800 (PST)
Received: from x1.hqhome163.com ([194.183.10.152])
        by smtp.googlemail.com with ESMTPSA id kw1-20020a170907770100b0078246b1360fsm6290759ejc.131.2022.11.22.09.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 09:37:01 -0800 (PST)
From:   Alessandro Carminati <acarmina@redhat.com>
To:     linux-trace-devel@vger.kernel.org
Cc:     alessandro.carminati@gmail.com, acarmina@redhat.com,
        bristot@kernel.org, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] rv/monitors: Move monitor structure in rodata
Date:   Tue, 22 Nov 2022 18:36:48 +0100
Message-Id: <20221122173648.4732-1-acarmina@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <7febf4f5-88d9-7902-e231-af2b6d0d6df0@kernel.org>
References: <7febf4f5-88d9-7902-e231-af2b6d0d6df0@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
index dacc37b62a2c..2e373f2c65ed 100644
--- a/kernel/trace/rv/monitors/wip/wip.h
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -27,7 +27,7 @@ struct automaton_wip {
 	bool final_states[state_max_wip];
 };
 
-static struct automaton_wip automaton_wip = {
+static const struct automaton_wip automaton_wip = {
 	.state_names = {
 		"preemptive",
 		"non_preemptive"
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
index 118e576b91b4..d0d9c4b8121b 100644
--- a/kernel/trace/rv/monitors/wwnr/wwnr.h
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -27,7 +27,7 @@ struct automaton_wwnr {
 	bool final_states[state_max_wwnr];
 };
 
-static struct automaton_wwnr automaton_wwnr = {
+static const struct automaton_wwnr automaton_wwnr = {
 	.state_names = {
 		"not_running",
 		"running"
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index be8a364a469b..87d8a1e1470c 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -111,7 +111,7 @@ class Dot2c(Automata):
 
     def format_aut_init_header(self):
         buff = []
-        buff.append("static struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
+        buff.append("static const struct %s %s = {" % (self.struct_automaton_def, self.var_automaton_def))
         return buff
 
     def __get_string_vector_per_line_content(self, buff):
-- 
2.31.1

