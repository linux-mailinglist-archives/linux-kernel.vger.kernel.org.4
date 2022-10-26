Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4DC660E1FC
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:21:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbiJZNVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbiJZNVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:21:34 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A05D7B7A6
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:20:44 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id m2so9990466pjr.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vTJtDcKCzm+jxcTMpjvVR3+lgYBiwIQNYP+cqOJzgwI=;
        b=nwONDDCrf87pEAToQfsQ2TDMlnRvjovexwXk8PXMC34Iix1wraRwmcBkYM1hjXi3+E
         /SIqgCroxG7m3K7s55njxuAn2SvT1QpmUekAZ00C9yVRYfmJHdJIhweQCzcvAsFnsMNQ
         UUv1FBQ+CRLI5ZKudnqYRGD/q+9acy2Phqw5HXo5V4G9WXuqJ3TBI9vB+VmAqd2jLtVP
         h8tsZsz7UgxmP8GXyPy2BFzL6sGd6kw0uM3TK1CjrVkCJIylc88Vqt0niRBR4lvdVQwc
         cessoCfudM4DSddxMtcT5IuQCmMhjIeccgGOirfEKnP/pLCDnKWgCGLL2oKv7gQetFdY
         Wrcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTJtDcKCzm+jxcTMpjvVR3+lgYBiwIQNYP+cqOJzgwI=;
        b=QcDZ2nlyO/pW9ssBEY+aSiqT0sYuVY/dUeYpDJ6X83pmCtZi0dSq4Dl2juGrEzQwCf
         +ZIh/79YCt15B19Wg4UZLKrWGVQOWaj7/VbM6azGuaYl8AKELf0RGUl1Ta+rkT124LKm
         hQNRRj9sr/WogKO3Xz0MNDwKHTT/jUC89GNvw3sZuHdvZMZaw29I88qyE95HfGnkYYnz
         TDsZtwTTHtjJvKnEkaCa7pwHttxAWJS2ZpYXEF3cdOugbIGK+6kg2GnNaW3/wd/23MIF
         hGAeV6oR1RYPHu3k3KEFnHefTCTg07puvOJ2hwkOaBr5a50KYW0C7J/xx17w5KMmESOu
         llfg==
X-Gm-Message-State: ACrzQf2E9Kv4sAJ+lFH0mhxfI3aVV0klOQW8+kko2S3VReQl/Os3u0jF
        DKBhtzEkW4rY6fbT5vXaxLk=
X-Google-Smtp-Source: AMsMyM69xhZxgKyfjn+sFTG7xtAteBalwuiy+sxSOBBtcjCpmMwTIhnf/V7w21lJBOCC+O/JkJOqZA==
X-Received: by 2002:a17:902:f68c:b0:186:dfca:a444 with SMTP id l12-20020a170902f68c00b00186dfcaa444mr2184514plg.151.1666790444124;
        Wed, 26 Oct 2022 06:20:44 -0700 (PDT)
Received: from localhost.localdomain ([221.226.144.218])
        by smtp.gmail.com with ESMTPSA id v12-20020a170902b7cc00b00186b04776b0sm2880131plz.118.2022.10.26.06.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 06:20:43 -0700 (PDT)
From:   Song Shuai <suagrfillet@gmail.com>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, Song Shuai <suagrfillet@gmail.com>
Subject: [PATCH] ftrace: avoid replacing the list func with itself
Date:   Wed, 26 Oct 2022 21:20:39 +0800
Message-Id: <20221026132039.2236233-1-suagrfillet@gmail.com>
X-Mailer: git-send-email 2.20.1
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

The list func (ftrace_ops_list_func) will be patched first
before the transition between old and new calls are set,
which fixed the race described in this commit `59338f75`.

While ftrace_trace_function changes from the list func to a
ftrace_ops func, like unregistering the klp_ops to leave the only
global_ops in ftrace_ops_list, the ftrace_[regs]_call will be
replaced with the list func although it already exists. So there
should be a condition to avoid this.

This patch backups saved_ftrace_func by saved_ftrace_func_old
which will be compared with the list func before trying to patch it.

Signed-off-by: Song Shuai <suagrfillet@gmail.com>
---
 kernel/trace/ftrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index bc921a3f7ea8..56b1a42e1937 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2755,6 +2755,8 @@ void __weak ftrace_arch_code_modify_post_process(void)
 {
 }
 
+static ftrace_func_t saved_ftrace_func_old;
+
 void ftrace_modify_all_code(int command)
 {
 	int update = command & FTRACE_UPDATE_TRACE_FUNC;
@@ -2774,7 +2776,7 @@ void ftrace_modify_all_code(int command)
 	 * to make sure the ops are having the right functions
 	 * traced.
 	 */
-	if (update) {
+	if (update && saved_ftrace_func_old != ftrace_ops_list_func) {
 		err = ftrace_update_ftrace_func(ftrace_ops_list_func);
 		if (FTRACE_WARN_ON(err))
 			return;
@@ -2918,6 +2920,7 @@ static void ftrace_trampoline_free(struct ftrace_ops *ops)
 static void ftrace_startup_enable(int command)
 {
 	if (saved_ftrace_func != ftrace_trace_function) {
+		saved_ftrace_func_old = saved_ftrace_func;
 		saved_ftrace_func = ftrace_trace_function;
 		command |= FTRACE_UPDATE_TRACE_FUNC;
 	}
@@ -3007,6 +3010,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 	ops->flags &= ~FTRACE_OPS_FL_ENABLED;
 
 	if (saved_ftrace_func != ftrace_trace_function) {
+		saved_ftrace_func_old = saved_ftrace_func;
 		saved_ftrace_func = ftrace_trace_function;
 		command |= FTRACE_UPDATE_TRACE_FUNC;
 	}
@@ -8321,6 +8325,7 @@ static void ftrace_startup_sysctl(void)
 
 	/* Force update next time */
 	saved_ftrace_func = NULL;
+	saved_ftrace_func_old = NULL;
 	/* ftrace_start_up is true if we want ftrace running */
 	if (ftrace_start_up) {
 		command = FTRACE_UPDATE_CALLS;
-- 
2.20.1

