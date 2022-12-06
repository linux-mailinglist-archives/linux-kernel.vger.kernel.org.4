Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCE66447F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 16:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbiLFPYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 10:24:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234621AbiLFPYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 10:24:09 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E2910AF
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 07:24:07 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id jl24so14231535plb.8
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 07:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=++VLLdD5R20NP2dhD9BoY4L3MuuVmiuDtlzNl1iSWtk=;
        b=cAilTNJHTAFkJQytHoH0SGB+6dKp6ndnZajpjXOAv2UO5kipCER/TNgAJmTUJcESYl
         VUtyRMqplbj+tD36ohI0lETkbFfIKMTDdyDeb35cYkms3sWCP6VCM94uPzi4In9LmbJv
         +2POC21Bj9oHiGiVhRrHZxnizizh3iJoxjf10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=++VLLdD5R20NP2dhD9BoY4L3MuuVmiuDtlzNl1iSWtk=;
        b=mh9IwNe7Sm6XQvxLfW1nwvhyPfzf4bA5bzzNkenqDJ9Sopgf+XaPpit7fG3RN8cwFT
         J0gOkSDvjylNVWb0a4Iyw58DqM5ddDR9k4wIQ1B6r7mF1r7WyVWixUvGTBp27xApuvwX
         xMmnyMqlOK2xBMosEIz3tQhDVT9C9m3P2QCNbFHbclFkYARDJzP27hb55lIy9Frkb/Ks
         ynB1qnv8xeNBj6nMMw8c5wandweDOyvkmaqWJpL8ZAssAVmkgMFhcsJ5UiMcxHV9GfrM
         F1yzCfj11a38fsnqoYnBuH3DP46CAYCMFkpROlgqScqdRcoB4HqZMZYpoDdT+Ib52oTy
         y5/g==
X-Gm-Message-State: ANoB5pkHyMnDfzKuEhGEKd7HnJzylM/1XMY99Y1eUV0bo4NwA5G7tYUu
        6Z5xiPthJbDy4cipi8PBveld0A==
X-Google-Smtp-Source: AA0mqf7aeZ4dvXiSU9Z+VNjS+yr8ocnkAalGIxhJS9tP4tTJN8fDvVoJBtGSW7msaJjFp5VgNQFYmQ==
X-Received: by 2002:a17:902:ccc3:b0:189:808b:c659 with SMTP id z3-20020a170902ccc300b00189808bc659mr46888465ple.13.1670340246644;
        Tue, 06 Dec 2022 07:24:06 -0800 (PST)
Received: from jeffxud.c.googlers.com.com (30.202.168.34.bc.googleusercontent.com. [34.168.202.30])
        by smtp.gmail.com with ESMTPSA id r25-20020a635d19000000b0046b1dabf9a8sm10004686pgb.70.2022.12.06.07.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 07:24:05 -0800 (PST)
From:   jeffxu@chromium.org
To:     skhan@linuxfoundation.org, keescook@chromium.org
Cc:     akpm@linux-foundation.org, dmitry.torokhov@gmail.com,
        dverkamp@chromium.org, hughd@google.com, jeffxu@google.com,
        jorgelo@chromium.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        jannh@google.com, linux-hardening@vger.kernel.org,
        Jeff Xu <jeffxu@chromium.org>
Subject: [PATCH v5 4/6] mm/memfd: Add write seals when apply SEAL_EXEC to executable memfd
Date:   Tue,  6 Dec 2022 15:23:56 +0000
Message-Id: <20221206152358.1966099-5-jeffxu@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
In-Reply-To: <20221206152358.1966099-1-jeffxu@google.com>
References: <20221206152358.1966099-1-jeffxu@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeff Xu <jeffxu@chromium.org>

In order to avoid WX mappings, add F_SEAL_WRITE when apply
F_SEAL_EXEC to an executable memfd, so W^X from start.

This implys application need to fill the content of the memfd first,
after F_SEAL_EXEC is applied, application can no longer modify the
content of the memfd.

Typically, application seals the memfd right after writing to it.
For example:
1. memfd_create(MFD_EXEC).
2. write() code to the memfd.
3. fcntl(F_ADD_SEALS, F_SEAL_EXEC) to convert the memfd to W^X.
4. call exec() on the memfd.

Signed-off-by: Jeff Xu <jeffxu@chromium.org>
---
 mm/memfd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index ec70675a7069..92f0a5765f7c 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -222,6 +222,12 @@ static int memfd_add_seals(struct file *file, unsigned int seals)
 		}
 	}
 
+	/*
+	 * SEAL_EXEC implys SEAL_WRITE, making W^X from the start.
+	 */
+	if (seals & F_SEAL_EXEC && inode->i_mode & 0111)
+		seals |= F_SEAL_SHRINK|F_SEAL_GROW|F_SEAL_WRITE|F_SEAL_FUTURE_WRITE;
+
 	*file_seals |= seals;
 	error = 0;
 
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

