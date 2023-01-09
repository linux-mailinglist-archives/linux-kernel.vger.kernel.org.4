Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF85661CB8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 04:34:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjAIDd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 22:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233780AbjAIDdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 22:33:52 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE765AC;
        Sun,  8 Jan 2023 19:33:51 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id c8-20020a17090a4d0800b00225c3614161so11415773pjg.5;
        Sun, 08 Jan 2023 19:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKPIVV+yleqWH2PtdMd1KwqVVqdXC+JKz6r5k8c0PzE=;
        b=V3/tp5znzXs078BgTLmcjKpnI2N2TC5CZhfJ/JilbaJaFJxJzSNaAFpX25smTKMBLq
         CZfPHn1djIs23uhm8aWLyBnsdkqnaS82azZhvcWbo92Q5iYzhMk1uzVTgQWZsORMICm/
         EZPTzrxHbzZYX4ECUrp1dhMAf9yrgNCGDpNwcRQNhYsEP0FsmDmdbqgxMxVVwGSYDrln
         DaxrzYbUuuBtg9u0+AZ3Hzop/F3NxDK1YMTjT6u0BZXQj8peGOPx5kj02vs/2Y0im6II
         yw+hOIfwL5YxvKoE0ei03s0wd8HHNjMjriDmtp4ul1Tncs9Z4Qr/aG786cbIQYqAZE5B
         LRIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKPIVV+yleqWH2PtdMd1KwqVVqdXC+JKz6r5k8c0PzE=;
        b=yBpX6f+nZqysC8Hfvc7mM62LJ8ebPFCQdEokIQbF6muLk2vDgpWrujr/fM61FNzAuC
         Yj/+6Qs5dy0ZfDjj9/0jRdrXW8CTJvETnYlCj8hQCM7TZNJ/MGYOMSDD+SoNOVmpXzKy
         QN6FcVL2UttQoIyE106C34iTY6e95aRpAL+3dk/k2G4HuxPiMOSkB4LHyAIX7OC4oIcG
         TaI1KjFxHtStYou4iKJPy22GPOUG9bXAtXqLzU3UStlI1HVFNhC72PQ4uoPAoYYrniUo
         AMWXnNcoE8Je4IAeuZrOLizKbtIN+0LC20DEHYUnfQpjs1nsyAOuas5Hu8tXT/ixNz5d
         INcQ==
X-Gm-Message-State: AFqh2kpef42s21ZK1hc2wZMccjy0473/8ZcVG2691tWEC9WDcjxTMZA5
        wHlpaeATRuuraYHVl5uy7OjmmfJyH5k=
X-Google-Smtp-Source: AMrXdXsrBEb6z5H3fodpDhtJDnG3BndRrwViBgeXkkNojR66sJV2HfQ0XyrQpyuDq8N2E9k6JjL2rA==
X-Received: by 2002:a05:6a20:c112:b0:ad:e904:f247 with SMTP id bh18-20020a056a20c11200b000ade904f247mr69929474pzb.29.1673235230885;
        Sun, 08 Jan 2023 19:33:50 -0800 (PST)
Received: from localhost.localdomain ([43.132.141.8])
        by smtp.gmail.com with ESMTPSA id z7-20020a63e547000000b00476d1385265sm4147301pgj.25.2023.01.08.19.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Jan 2023 19:33:50 -0800 (PST)
From:   Quanfa Fu <quanfafu@gmail.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Quanfa Fu <quanfafu@gmail.com>
Subject: [PATCH v2] tracing/eprobe: Replace snprintf with memcpy
Date:   Mon,  9 Jan 2023 11:32:13 +0800
Message-Id: <20230109033213.3220884-1-quanfafu@gmail.com>
X-Mailer: git-send-email 2.31.1
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

No need to check for negative return value from snprintf() as the
code does not return negative values. Replace snprintf with memcpy.

Signed-off-by: Quanfa Fu <quanfafu@gmail.com>

-----
V1 -> V2: memory allc uses kzalloc and replace snprintf with memcpy
---
 kernel/trace/trace_eprobe.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 352b65e2b910..56eb39f495f6 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -905,7 +905,7 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const char *argv[])
 {
 	struct event_filter *dummy = NULL;
-	int i, ret, len = 0;
+	int i, ret, arg_len, len = 0;
 	char *p;
 
 	if (argc == 0) {
@@ -923,17 +923,17 @@ static int trace_eprobe_parse_filter(struct trace_eprobe *ep, int argc, const ch
 
 	p = ep->filter_str;
 	for (i = 0; i < argc; i++) {
-		ret = snprintf(p, len, "%s ", argv[i]);
-		if (ret < 0)
-			goto error;
-		if (ret > len) {
-			ret = -E2BIG;
-			goto error;
-		}
-		p += ret;
-		len -= ret;
+		arg_len = strlen(argv[i]);
+		memcpy((void *)p, argv[i], arg_len);
+
+		if (i == argc - 1)
+			p[arg_len] = '\0';
+		else
+			p[arg_len] = ' ';
+
+		p += arg_len + 1;
+		len -= arg_len + 1;
 	}
-	p[-1] = '\0';
 
 	/*
 	 * Ensure the filter string can be parsed correctly. Note, this
-- 
2.31.1

