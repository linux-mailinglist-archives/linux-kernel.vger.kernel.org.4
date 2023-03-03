Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556A06A9A74
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 16:17:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbjCCPRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 10:17:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231138AbjCCPRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 10:17:34 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC017CCA;
        Fri,  3 Mar 2023 07:17:32 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id u9so11744383edd.2;
        Fri, 03 Mar 2023 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677856651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jiz8YLTPcqlWnRa7+hI1APh94xQl+T2YHqqlHIHeeHI=;
        b=Jdup7WqmUvWn0dT9Buk1t92BPL3lqwj9+JODu1CveyogggIGL5dG/hpUinbpl3RaYO
         4/XwmnO1i/4J4pHh8ixThMCEmbTsqDo/INEHUiFLv+wDRzPnSEYpk9LHmsm46QbUPO47
         3oyYiCkB2pvqg2/YqG2DNVZPO1qspgiHuJvO7PXZW8iG3OMT8wiqPAXakU46qXB5Oyzw
         KXXSX2ATGrIJl0e2hHBY1j7O/oRPXpZp7HD9tZ8+V39cHBlAjuvSFzNfnMfBx+yKLrSQ
         +6S4eQPRwW1jfStlLXo9/ygZPYusm8eYjdbqkStTw0Gq9IMXv39YuKxzQob9NPvEooAb
         cKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677856651;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jiz8YLTPcqlWnRa7+hI1APh94xQl+T2YHqqlHIHeeHI=;
        b=zZGMiCGoMyzjxi4Lfpw5I2BMUNvHV7N1ZPeQmXno+UwQCWJ9CaTUHuNHaur0WjNoDS
         ORIWO2Td7Wuqvpah9XrIZV02gEFIBpwJubqZKWmE0JbaZatb3QJ8EKfH8M+e2tS770yK
         0+OYIfxTEg76DtUQCRat6NaNj1V0ml4758/w81EhT8RvwOWE7DXUM3WBAPkjEvScRT5E
         VnBTc7CKU+BKJcqDOF4Lgnj/FgskEn3aHgBocVgVXQgBgfnwvVwdbEnqEChrAuybeQS9
         26SkFKUl37/UijWYLgvT4psPt/FFwv2QoywFYHe/u+DYtp9J3Wo1hjlxYRX2JvQlhP9V
         urtg==
X-Gm-Message-State: AO0yUKV5HAdWlScDo4NvCkDBhcZR8aWq+jfbOR+Aej0VXlUrpfWbmd7z
        03swdNfnSSZPrESNodtHcg/mTAqa19VCrQ==
X-Google-Smtp-Source: AK7set91eGWveWWR4+wIG8jnM2sdO7C/Af5Gj+zhycaB1yJ0GzuQNDiBta9uyb89iDeFTDPgYMoHeA==
X-Received: by 2002:a17:906:36d3:b0:8bf:e95c:467b with SMTP id b19-20020a17090636d300b008bfe95c467bmr1791377ejc.63.1677856650820;
        Fri, 03 Mar 2023 07:17:30 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id o13-20020a1709062e8d00b008e22978b98bsm1048390eji.61.2023.03.03.07.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 07:17:30 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v3 0/3] Improve trace/ring_buffer.c
Date:   Fri,  3 Mar 2023 16:17:03 +0100
Message-Id: <20230303151706.57851-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.39.2
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

This series improves ring_buffer.c by changing the type of some
static functions to void or bool and uses try_cmpxchg instead of
cmpxchg (*ptr, old, new) == old where appropriate.

v2: Convert only loops with cmpxchg.
v3: Rearrange variable declarations.
 
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>

Uros Bizjak (3):
  ring_buffer: Change some static functions to void
  ring_buffer: Change some static functions to bool
  ring_buffer: Use try_cmpxchg instead of cmpxchg

 kernel/trace/ring_buffer.c | 77 ++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

-- 
2.39.2

