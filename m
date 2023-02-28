Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84B636A5E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 18:59:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjB1R7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 12:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjB1R7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 12:59:51 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 796C92A6F0;
        Tue, 28 Feb 2023 09:59:50 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id s26so43393954edw.11;
        Tue, 28 Feb 2023 09:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ghhb/LaJjrGYBzQapO6q5bJ+7Ok9ApRFFpAQvScLSMU=;
        b=G1FMtz/ZpW9qTmiK5Bmf7ekvyfZcI43Y29uRkdiJFtbJTl86IN+If5/DzMW/us5tJe
         nk581JVq7NeVEilVq8pGr24PXds0m3D7Z2/xQ8RdoI6EVl89hjqYvej53Wye7lOurxNq
         Q4AoCZc1nPYVfGuWfwd+NReXWPDzA05SQhEezrIRpJo+nzK3TxJFoxB7nvwDVc5gb+Kn
         NqfB2TYajubhu3h+AjY+72HPDCnuh8rr7dSDfPxDMvGzqUCoyQgc6/qZU1Cfw7nKuOkl
         cpZZOlzzt3oa3s2HufwjSN+nlS+GL/rySpumaoGS8yaX2YlkSdkpuLNlWvdGBe0wnI+x
         dokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ghhb/LaJjrGYBzQapO6q5bJ+7Ok9ApRFFpAQvScLSMU=;
        b=OcVivWz/GASoVwvUZy3r8nCJ0TeEqRKsbC6gFQur2M79+J251ipugQIMREywdMOoPM
         zN2arXE2Dqe1DNT9BUF7GcfHzLxXt0VlMukZr+AfktJUfuaaccLs8DUhWT1Cm/a5NPMM
         LBxxbfdfrNK++knSs9nTfR5mefbn0TrKkYN0sBmXb+khGcvBvWeRZDPCk00371J5ytQa
         guRLeynYlMObYPR+p9NNBkmX/rNSS+sEwO5APoAEG5dtvN10FZSqvfp9l7sCDo0GyThA
         0T5DiYVtDWjCF64nGGltBBtZz5DJGtDk5WvpPaNX/fwPyfzpYsoaS1TD1HzpO8Aoty2S
         13gw==
X-Gm-Message-State: AO0yUKVngfvIKhp4aAtLHCWEuG3wMOppPsLKgP9lx2i7RITe0DCYs3iY
        HH+UEndBq7ucFAW3rvtVl25EjqvlqTmXFqxz
X-Google-Smtp-Source: AK7set/X0sunPyjVHRbCeY5C9BITNhtZZj6psWqlXrv4qYg5XSMhQwgrlHqNvAgNlDpcnos2pmV/8w==
X-Received: by 2002:a17:907:3fa0:b0:8be:aba:e927 with SMTP id hr32-20020a1709073fa000b008be0abae927mr5144768ejc.17.1677607188619;
        Tue, 28 Feb 2023 09:59:48 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id m5-20020a170906234500b008d9c518a318sm4869725eja.142.2023.02.28.09.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 09:59:48 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/3] Improve trace/ring_buffer.c
Date:   Tue, 28 Feb 2023 18:59:26 +0100
Message-Id: <20230228175929.7534-1-ubizjak@gmail.com>
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

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>

Uros Bizjak (3):
  ring_buffer: Change some static functions to void
  ring_buffer: Change some static functions to bool
  ring_buffer: Use try_cmpxchg instead of cmpxchg

 kernel/trace/ring_buffer.c | 89 ++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 52 deletions(-)

-- 
2.39.2

