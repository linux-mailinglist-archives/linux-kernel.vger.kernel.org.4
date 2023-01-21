Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E16766BE
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 15:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjAUObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Jan 2023 09:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjAUObd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jan 2023 09:31:33 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF88F21A07
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id y1so2649876wru.2
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 06:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rarW0C3V0LVCbRSxn5OZzPRQcVqqpTUYjlstsxkGCnQ=;
        b=XsCu29i8Z1oc6uq5sN0yrMDgSjJpECZK4tV/ZSWpv7Uv/K2PEwE5UMbv20VjjgyxlY
         vg8bhcorENStwyLLUyjey9dNr++wfIekEVSst6gupetTukZG9rMpYTpYHfbIHuk66jam
         iKAWboGyzIl6Ep6fEHRYZXEmB+YB3H0ucf7nvQKEWidcjOusrcuCYpG6FtbisyPCE8Gc
         gWBRQ8HqXvNuHuNu5A6i/9gh7TNaC+jl+3hEqOHUdIDAypMszBN08bnuRVw0l6qhzGDP
         dfEjDWnOY0WCx9R8ODnSCGEPQ3dGmxqMEcp64N7ymD7xgAyUanO++dHng7c2mD6BN2qh
         xG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rarW0C3V0LVCbRSxn5OZzPRQcVqqpTUYjlstsxkGCnQ=;
        b=1j9FjrNXsOJESF73rnjq+5TEuiLFMSBxMFePpozYo1JTX4ppBSZnLlfIKJiXeh9USb
         a1m4ioQ46ewx8RSQ8LsmCjhfpzhVQoHovthV0kOhQ+ozp5/lr4KT670i4HHPB8FF57ZR
         6PkNNjjSd6HT6viLQQCpwAYxyHtny9DYJPu4DZJT8V05eTVSWLDtGijellHTgti/7R17
         ORdv8mZnkfSDETWMFuGjBEM7EYs4GNE6I40X1wb1mR+oRrh/62sNA/saavM4Rwa6g1hA
         rMEjm4bRCn8w/esR1Wof1MIkAZxc+MxtIOxTp3l3UXhmXkbw5ppX+tKdWDJjsKciA/GO
         zvqg==
X-Gm-Message-State: AFqh2koZ3IRg/Aw9pwSvWGshHQhW1548xGCq1Orwa63CvQQqoc6p2Rws
        rQbd5cqa0LW2nsPnQd5AXa1yMQ==
X-Google-Smtp-Source: AMrXdXvFZMIUXANWl+eYIekkOFr+wSSWg8hb1mKA3uO8qLOhdES9+Kt8xsHL6GIfJpTslkJ2YxykPw==
X-Received: by 2002:a5d:4d4b:0:b0:2be:9945:8112 with SMTP id a11-20020a5d4d4b000000b002be99458112mr4332624wru.41.1674311491377;
        Sat, 21 Jan 2023 06:31:31 -0800 (PST)
Received: from P-ASN-ECS-830T8C3.mpl.intranet (89-159-1-53.rev.numericable.fr. [89.159.1.53])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm16314604wrq.19.2023.01.21.06.31.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Jan 2023 06:31:31 -0800 (PST)
From:   Yoann Congal <yoann.congal@smile.fr>
To:     linux-trace-kernel@vger.kernel.org
Cc:     Yoann Congal <yoann.congal@smile.fr>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 3/3] Documentation: kprobetrace: Split paragraphs
Date:   Sat, 21 Jan 2023 15:31:10 +0100
Message-Id: <20230121143110.1706962-3-yoann.congal@smile.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230121142242.1706081-1-yoann.congal@smile.fr>
References: <20230121143110.1706962-1-yoann.congal@smile.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an empty line to force the output to split paragraphs like it is
splitin the REST source.

Signed-off-by: Yoann Congal <yoann.congal@smile.fr>
---
 Documentation/trace/kprobetrace.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index ad18c2fdbd153..99251bcdeb13d 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -74,12 +74,14 @@ respectively. 'x' prefix implies it is unsigned. Traced arguments are shown
 in decimal ('s' and 'u') or hexadecimal ('x'). Without type casting, 'x32'
 or 'x64' is used depends on the architecture (e.g. x86-32 uses x32, and
 x86-64 uses x64).
+
 These value types can be an array. To record array data, you can add '[N]'
 (where N is a fixed number, less than 64) to the base type.
 E.g. 'x16[4]' means an array of x16 (2-bytes hex) with 4 elements.
 Note that the array can be applied to memory type fetchargs, you can not
 apply it to registers/stack-entries etc. (for example, '$stack1:x8[8]' is
 wrong, but '+8($stack):x8[8]' is OK.)
+
 String type is a special type, which fetches a "null-terminated" string from
 kernel space. This means it will fail and store NULL if the string container
 has been paged out. "ustring" type is an alternative of string for user-space.
-- 
2.30.2

