Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025696B5C70
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbjCKNwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjCKNwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:52:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2D25123DF8
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678542678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NJ0Bmh3QpR71VfAXbH6zJND/zwnfiw4+lhOdGrMJTe8=;
        b=ABdVtUB8rrv0ycBE5AVIe3zXSxLJYwmvRQkD+VTHfXq15IOs8eLaHait61ZP78eNQP+LSh
        OzoiF+AYgXkXz1LhpekjMhoek0WUGDyIdAwJVxdXwa8gsfQ0iIPO82sG1zYLZ/1Xjuv3Ds
        c15crj3nzFYZ7AFeJcXjCG5xYIsz2To=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-bZmkJ7dbO5KsENJPbGR48Q-1; Sat, 11 Mar 2023 08:51:17 -0500
X-MC-Unique: bZmkJ7dbO5KsENJPbGR48Q-1
Received: by mail-qv1-f71.google.com with SMTP id fb18-20020ad44f12000000b0056ed45f262dso4452215qvb.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:51:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJ0Bmh3QpR71VfAXbH6zJND/zwnfiw4+lhOdGrMJTe8=;
        b=Ube7R7RIQLZCtLxAoWNiuFYAOh/7J/oySZx6uDPFZx085ElHgvZwAra2yOYwdrP4SQ
         1je22WB5HhH6TYu5TAYFBqIazgLYHHBjEY4yIZWVfQpIusxQBud9K16f+iDuPK77MXsi
         UMwiW45UIoBJk0pKGDYea86JS5Y8rsEXoMKNqEw21u1i6JjH9DFZomRqdhW2l01jNpFc
         qxtsOMAn+Y4gC7SUfPitVH69x9RL2DEGPuxtDlbouxPpz/udJkp5i7gRfU+Lmh3dwLL9
         gzYpQgzvZkgTmeqBDEDb3YSsBYDYRNkeqvVlrb3Q/caKb9WmcvPZsDsY90R/4LxKgm5D
         cXiA==
X-Gm-Message-State: AO0yUKVqPeHb1lrO87nCd1Go5itqvAYDTylo0I0vl1SYkDUFkuy0HOAx
        v1FSiubA41hpWHfKbFb6PYjVBbOCdO7S/2q1STsza58ZDy7j4+FtB51f/MMa1ZLv7wvXBGK69dV
        DAqP3J3Lci77D/TZes4nZRjP+
X-Received: by 2002:ac8:5812:0:b0:3bf:d4dc:7058 with SMTP id g18-20020ac85812000000b003bfd4dc7058mr50196270qtg.11.1678542676980;
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
X-Google-Smtp-Source: AK7set9lLnjrFgLGllezeYDec5YUFS01Mn9vN9iAmu8uD7oGadaM7RIjfAipVilkNFU7+sRp+uEwuA==
X-Received: by 2002:ac8:5812:0:b0:3bf:d4dc:7058 with SMTP id g18-20020ac85812000000b003bfd4dc7058mr50196250qtg.11.1678542676763;
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id p12-20020ac8740c000000b003afbf704c7csm1943823qtq.24.2023.03.11.05.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:51:16 -0800 (PST)
From:   Tom Rix <trix@redhat.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ftrace: set direct_ops storage-class-specifier to static
Date:   Sat, 11 Mar 2023 08:51:13 -0500
Message-Id: <20230311135113.711824-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
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

smatch reports this warning
kernel/trace/ftrace.c:2594:19: warning:
  symbol 'direct_ops' was not declared. Should it be static?

The variable direct_ops is only used in ftrace.c, so it should be static

Signed-off-by: Tom Rix <trix@redhat.com>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 29baa97d0d53..05f76dc1f0c5 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2591,7 +2591,7 @@ static void call_direct_funcs(unsigned long ip, unsigned long pip,
 	arch_ftrace_set_direct_caller(fregs, addr);
 }
 
-struct ftrace_ops direct_ops = {
+static struct ftrace_ops direct_ops = {
 	.func		= call_direct_funcs,
 	.flags		= FTRACE_OPS_FL_DIRECT | FTRACE_OPS_FL_SAVE_REGS
 			  | FTRACE_OPS_FL_PERMANENT,
-- 
2.27.0

