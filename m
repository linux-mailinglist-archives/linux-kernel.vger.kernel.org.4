Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E278062E233
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239739AbiKQQon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 11:44:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiKQQol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 11:44:41 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7210B2F65E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:44:40 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so5953483pji.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 08:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pehiEX3O7+10JOfvl6Go8PAptHMCNDVr2AxlBu5gCc=;
        b=BX/ZOpVhcPqTE9SIHVYMCZo10XXujFWt57YZSrVtvWFoDVxkR2RlZorxjW8fwC/f1k
         5O7b6MpOPivawml6ImkZD2+yi88L6/1jhng6IU/4iCpVybqysfK8vmA2L2MQ3gwMhiBQ
         w9p12yTkZmvrgwV7gthcY22Q4eXf8SsPkt6tDWAIEOI8eS0V3YanzwELgAPuKNgYL2G7
         k+d/SLRnvw3q5mSmetXgZnMwhKxGdockTxKGXv44XEAepizbJ2blGcPVx6Iuj/i03z2+
         wUovn2fRmzzotOjs5sJqj5bOXPRmS7qQJ0m3eBITcIYc/a5xnFTJkgMakgKiuvRH9xRl
         M38Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:cc:date:message-id:subject:mime-version
         :content-transfer-encoding:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4pehiEX3O7+10JOfvl6Go8PAptHMCNDVr2AxlBu5gCc=;
        b=vISFUK91RsaNWJsRHmsD+fU/sH8YXPJOKDn9ffUwMfbRroGuLfeAHPhDydSOzYvse4
         5PCEDSBtLlnTDg3GmrxDTDlNvzRf6lPC+3LmGt08DZuKqgKwDIQ+JtYm8Bjw1IoZ0XdA
         VteYwx7WBDhxQJXYr+a7Dl+7cz/XQEBGvgqUSDNImxxuHs/dILksKGRC+Tb8P6eIUAxu
         7z5Wdw3ya+uL7Fr4qhKzRV/4QdEbzA8In0pLaeaom16+eq8H+ed2fN1XZ6zMwFhJiXok
         0Tzda71kETDdtEVsijbNKtekD48Jh5IuEl9DfstIHAzMEKYBQr+vOUyHmWHYPDX3+jwK
         0xtw==
X-Gm-Message-State: ANoB5pnLODIygIDOQt/x1zG4hXpNkAzrvVwVS5IGlATvnR9tXxAZzKAK
        TGKOPhP2tUNIbpytZAUyM6I=
X-Google-Smtp-Source: AA0mqf5o7C2VNkO+/ic5Mv2JfUfSMTDAyy1zQSt/xJBP0A49vtJFh1TQKlpA54uIFPlxNbRDlmV+FA==
X-Received: by 2002:a17:90a:8417:b0:210:9e08:d577 with SMTP id j23-20020a17090a841700b002109e08d577mr9846266pjn.134.1668703479649;
        Thu, 17 Nov 2022 08:44:39 -0800 (PST)
Received: from smtpclient.apple ([103.135.102.120])
        by smtp.gmail.com with ESMTPSA id r15-20020a17090a4dcf00b00214247ac1acsm3731457pjl.12.2022.11.17.08.44.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Nov 2022 08:44:39 -0800 (PST)
From:   Qiujun Huang <hqjagain@gmail.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: [PATCH] tracing: remove __bad_type_size() method
Message-Id: <D062EC2E-7DB7-4402-A67E-33C3577F551E@gmail.com>
Date:   Fri, 18 Nov 2022 00:44:35 +0800
Cc:     linux-kernel@vger.kernel.org
To:     rostedt@goodmis.org, mhiramat@kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


__bad_type_size() is unused after
commit 04ae87a52074("ftrace: Rework event_create_dir()").
So, remove it.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
---
 kernel/trace/trace_syscalls.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/trace_syscalls.c =
b/kernel/trace/trace_syscalls.c
index b69e207012c9..942ddbdace4a 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -201,8 +201,6 @@ print_syscall_exit(struct trace_iterator *iter, int =
flags,
 	return trace_handle_return(s);
 }
=20
-extern char *__bad_type_size(void);
-
 #define SYSCALL_FIELD(_type, _name) {					=
\
 	.type =3D #_type, .name =3D #_name,					=
\
 	.size =3D sizeof(_type), .align =3D __alignof__(_type),		=
\
--=20
2.30.2=
