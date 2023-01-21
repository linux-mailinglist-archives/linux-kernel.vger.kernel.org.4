Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F26766BD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229841AbjAUObe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:31:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbjAUObc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:31:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4FA392B3
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:31 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r9so7151757wrw.4
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4TB1OEgjESNCwtQLX1L+eIOlyALE7x8aUBSmkMLwac=;
        b=2eY68x7jfYFUzdy4vGD+8Y6PmY5UJflCLKXoT6ybao1O1apQT0IcBuYar3gB02kPkT
         P+zPF9T/czfvdctu8iQy8CTtZ2XmSOJtxmEeiMLqX/PXNQGl8mXIvv0RPgabW8CB/5QH
         sDGmLd7Xsv0RvCrXlb9IQXBscSEvZ63q6ffN8erVu+MsbDKBzWyW2OIP6wxuXZ1CUQZl
         skyCvsGy+4u03Q6EN2LYdyRkQyPTvXuUWSmh1LI/0Mh4NZWC9NA9AQNoiFMiQgkOVYCg
         UpoJ1wpdyXiUlSkkzZSWsgEernRwVfumcQWDnkP5RcPeb4kXvuTK7LOnzsEUY6G8JbU1
         NofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4TB1OEgjESNCwtQLX1L+eIOlyALE7x8aUBSmkMLwac=;
        b=daqM/18bz3mWBM8ic9ak/Sx3oStJoinDRg99Wy3hFoZTVdI3DkWjI6MwjEZZpHe2FH
         A4/1xF7Ifeg3Bkx7zCJOxqiZfOv80fqv9mlr8eHcz4O0j606E2ribehuFK/5Bh+vn84r
         b1VrQQKRmzwNue58gDt1LbYO8lrJAJjY4zVbjaujrRnbmWLzfdxe+R0mZynbmMjIgR3E
         IbDIjJ77xr40AZnNHGRF4JC1i/y+AWyQonGHogo8jJm8zWkXXQPXmv8U/qcCPqiIN7ba
         X4Bhi0WtZ6l+yQmzANnaCmpN6cPiLDBftekiktRgQXGl2e9t5adlXsKRJ/EGzYm5lXdZ
         Ph3w==
X-Gm-Message-State: AFqh2koc32gObgVto4t72CO03Lo6vKPygnjVtbb2tTzZ4lRatvww7JYT
        Isyut1K81/QmTLxo8HdZzK5XvQ==
X-Google-Smtp-Source: AMrXdXtV5msUaxX9SPw2Y4HgCWpGdruUkoVCJRTY/xXEfWaYOOBSahlX/3E3iY5CfgT3+xjTee7YWA==
X-Received: by 2002:a5d:4572:0:b0:2ba:bd95:e38e with SMTP id a18-20020a5d4572000000b002babd95e38emr15454843wrc.41.1674311490009;
        Sat, 21 Jan 2023 06:31:30 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm16314604wrq.19.2023.01.21.06.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:31:29 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/3] Documentation: kprobetrace: Fix code block markup
Date:   Sat, 21 Jan 2023 15:31:09 +0100
Message-Id: <20230121143110.1706962-2-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121142242.1706081-1-yoann.congal@smile.fr>
References: <20230121143110.1706962-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This display the following code extract as a code block instead of a
normal paragraph.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/trace/kprobetrace.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index 1eb2c68aa0a71..ad18c2fdbd153 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -161,11 +161,11 @@ You can add and enable new kprobe events when booting up the kernel by
 "kprobe_event=" parameter. The parameter accepts a semicolon-delimited
 kprobe events, which format is similar to the kprobe_events.
 The difference is that the probe definition parameters are comma-delimited
-instead of space. For example, adding myprobe event on do_sys_open like below
+instead of space. For example, adding myprobe event on do_sys_open like below::
 
   p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack)
 
-should be below for kernel boot parameter (just replace spaces with comma)
+should be below for kernel boot parameter (just replace spaces with comma)::
 
   p:myprobe,do_sys_open,dfd=%ax,filename=%dx,flags=%cx,mode=+4($stack)
 
-- 
2.30.2

