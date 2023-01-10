Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B705D663F33
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 12:21:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjAJLVF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 06:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbjAJLVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 06:21:01 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E15FE8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:20:54 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id d13so8344148qvj.8
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 03:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9MPu3Wa9CUcuJv9SQo53gj4hFSOASJJs6prztLhccjc=;
        b=W9X6Dp6Kr3cS6Nm7ToN8FkocE4ipWCmBzgM81QXmZG5cEvskylo3EpK0FBr9B+h6OU
         8IYlnPxJsZvSHTWNrC+2RTYnb/Q3fHfdfDVs0AV18uUfTHw5wgwSsmiZMLvZ3TtAO/cW
         quZGimYO2e7qEiXtf+OYMRZ5oXuoAnHt/EZu1o2yYoBbqsxFII6BXKNvME4EC4FsTNDc
         GK9uI1QXGjrHDk8HwqIJ7jWityrJqaJHVNIphHN4Ofrsx19ENPHQgZDb2FAnr9P2SKrr
         SFi+VfQB/YZnZAL3xVXI9YaYk5f3a82tfH/LgndDIVpOcPTL3Uo4HFEcr9NChcj317Ni
         +2Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9MPu3Wa9CUcuJv9SQo53gj4hFSOASJJs6prztLhccjc=;
        b=heHfTnltgzvEEvwjvoX8s1UxnO8GL8B/8Gr9szBh1dFRSMOhZKAEl/GFVcPVTkN2SV
         E1EzbSKFoxxRaqqR/34NRD81dvJR4cJ1CTNcav16PB0op4GQWEOKXaL74/k15g1q8hY4
         MajNM93+YUIoXWbkcjzWvc53CNYfiKYk0Fh7bkspchrUv5j89PLNOshCaFzIv9cVMoce
         npiN6IImz5SpItALOhB4FIoLtil6ug+59UT9ZnLCfEcpUq08ghgv63y031Sn9fic8uZ3
         Jt4pGJDbDXUj+2GFiRjVVkm2Ny53PePhP9tXkUecSUTDmTAFBTQnyvL8ZZYxnpkD8aMk
         IcqA==
X-Gm-Message-State: AFqh2krPWmp2LcPu5MamnXticn6gjfmV2ROMSf8NoypqzFlQ0xA5WdFa
        TClyRez3Z2Yd/sl8Xu7G3r23EIda4xvpxg==
X-Google-Smtp-Source: AMrXdXskY2zfeStg9UtuObXAR/TEZunQxkW9h1SejhGVnVtZ+SjQ/fooHg8YR8qvnarqMJV0LJg/8w==
X-Received: by 2002:a05:6214:5a07:b0:532:1ebe:84c8 with SMTP id lu7-20020a0562145a0700b005321ebe84c8mr19710288qvb.2.1673349653242;
        Tue, 10 Jan 2023 03:20:53 -0800 (PST)
Received: from localhost.localdomain ([191.96.227.64])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006fa12a74c53sm6895644qkp.61.2023.01.10.03.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 03:20:52 -0800 (PST)
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     unixbhaskar@gmail.com, linux-kernel@vger.kernel.org
Cc:     paulmck@kernel.org
Subject: [PATCH V2] tools: rcu: Added check for argument and usage function
Date:   Tue, 10 Jan 2023 16:46:34 +0530
Message-Id: <20230110111634.26371-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.38.2
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

Thought it would be good to have some formatted way of letting user know
about, how to use this script properly and added some checking too for missing
argument.


cc: paulmck@kernel.org

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 Changes from V1 : Flip the code blocks of function for logical evaluation
                   and strip off the path from script when displaying help
 tools/rcu/extract-stall.sh | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/tools/rcu/extract-stall.sh b/tools/rcu/extract-stall.sh
index e565697c9f90..6ea76230f72f 100644
--- a/tools/rcu/extract-stall.sh
+++ b/tools/rcu/extract-stall.sh
@@ -1,11 +1,24 @@
 #!/bin/sh
 # SPDX-License-Identifier: GPL-2.0+
 #
-# Extract any RCU CPU stall warnings present in specified file.
-# Filter out clocksource lines.  Note that preceding-lines excludes the
-# initial line of the stall warning but trailing-lines includes it.
-#
-# Usage: extract-stall.sh dmesg-file [ preceding-lines [ trailing-lines ] ]
+# This is a usage function to spit out information about properly use this
+# script
+
+usage() {
+
+   echo  Extract any RCU CPU stall warnings present in specified file.
+   echo  Filter out clocksource lines.  Note that preceding-lines excludes the
+   echo  initial line of the stall warning but trailing-lines includes it.
+
+   echo Usage: $(basename $0) dmesg-file [ preceding-lines [ trailing-lines ] ]
+}
+
+# Terminate the script, if the argument is missing
+
+if [ $# -eq 0 ];then
+	usage
+	exit 1
+fi

 echo $1
 preceding_lines="${2-3}"
--
2.38.2

