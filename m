Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4F6596E1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:37:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbiL3Jgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234958AbiL3JgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:36:17 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D041AA0D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:36:06 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id z8-20020a05600c220800b003d33b0bda11so12477384wml.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RPyHCCui8j/AUmTAGy1dU2iENSbeUSVwwvZJro1sbhw=;
        b=BDW92xS/VquTBKZxefcZolzqpdLTtJ2bYxhcvP8Imj+dmoRok4+A4nFjmxHaAKH2hI
         wohypNluNpxrzAkZvgswSuMBldjdns72a2YE/gwazxmIGnuQiE28D5U7aw5ekT9COhv+
         gdV+xEaDyCCGHKlGzbxadLHa7PYIrICQMMCXesO9dfVW8u3EL9Rd6Q2b3ER+apBQWO6f
         4VmmpA5sCt322D5XHG1skyeobKAky6iC5hAR+Dl+4FWc7Iyr4ONgaOaL1NeUL7Tgec3L
         i+nPgEibchEJv+RnMPKcjUgK5ep8f2SnMXxxFIIMRHeoo33u2EehuD6V71woSV/vs0cp
         1zMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPyHCCui8j/AUmTAGy1dU2iENSbeUSVwwvZJro1sbhw=;
        b=mCYIvH2xiWFsh6mBjQVduC6OSccFS/URH7H6G+i5jhY1wWdKiDbYTe1WqAlCKJWzhK
         VPDOjkIG9F1oa1Ups66tduyB5eCJxLzpwAM5uteCMNy30RPWHJcWJ7MJHb+DTz/0YNz5
         djPuLawvd0sCMz6FHO7WBsTHqHH2jAm5gHp+yfxyLOZMayBXl2bO/r1+uxpPSEX5BYJc
         OBi7UuIdxMycXTdtKsJ92gFVcLdTK61Ow5lMCwURK6uQ2QImme5X9x3JJbKqpVSuV/7o
         8F6rdp4k7meyP+Ev++jykqUFgxJ89mgBj3w+2ICEQfnXE8L4d4CyInJsDkEeF0x/fOPa
         eCZw==
X-Gm-Message-State: AFqh2kqkFxXNsfq2UFdf0zmqu2TNX/zB0V7l73znCverDE7BnuLaAnHs
        0kX4iPyaX5zECgogKuuTlV1FUf5ucg==
X-Google-Smtp-Source: AMrXdXuw8GkmO/dqm4Sn+mEouY1PYUHty2iRrGPbJTqiN/AKvhQ+DcdgNfWkKuGLUxcbR4E4aId/NQ==
X-Received: by 2002:a7b:c4da:0:b0:3d3:864a:1173 with SMTP id g26-20020a7bc4da000000b003d3864a1173mr21636394wmk.18.1672392965011;
        Fri, 30 Dec 2022 01:36:05 -0800 (PST)
Received: from p183 ([46.53.249.223])
        by smtp.gmail.com with ESMTPSA id e16-20020a05600c4e5000b003c21ba7d7d6sm27830310wmq.44.2022.12.30.01.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Dec 2022 01:36:04 -0800 (PST)
Date:   Fri, 30 Dec 2022 12:36:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] proc: mark /proc/cmdline as permanent
Message-ID: <Y66xAveh2yUsP7m9@p183>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cmdline is never removed, mark is as permanent for slightly faster
open and close.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/cmdline.c |    1 +
 1 file changed, 1 insertion(+)

--- a/fs/proc/cmdline.c
+++ b/fs/proc/cmdline.c
@@ -17,6 +17,7 @@ static int __init proc_cmdline_init(void)
 	struct proc_dir_entry *pde;
 
 	pde = proc_create_single("cmdline", 0, NULL, cmdline_proc_show);
+	pde_make_permanent(pde);
 	pde->size = saved_command_line_len + 1;
 	return 0;
 }
