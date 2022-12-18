Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD97B650478
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Dec 2022 20:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiLRTNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Dec 2022 14:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbiLRTNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Dec 2022 14:13:18 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BC1B866
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:13:18 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id c7so6780110qtw.8
        for <linux-kernel@vger.kernel.org>; Sun, 18 Dec 2022 11:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6wBQIku0dQkyfB58N1D5s2KPLrixlbfwvdwL9dUxK98=;
        b=lroTRSYT+lpaoGdLTvSe0vNJT4ct3IB3eeOKCL3YQRvVP5j2VrdsOPUcLi8fN4+xcQ
         tqx9I1ei9F8C2t0E6UYlk4BJAjVqoiJuWOBCAE31g+550nlQkhBhVROKlRx+VoNaGB/1
         bWNL2XgieQGjgcDJbwvxzTqS2q3XrhB/3WDXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6wBQIku0dQkyfB58N1D5s2KPLrixlbfwvdwL9dUxK98=;
        b=Lt2xvKripCmEaLdiVK03FmFO1/D5LYLeiNibTlzLjUyTtYU+tWX3T/uCIX7MpsPr23
         Xg3IqZ2CljPjhTep89zLizpVuplKsfhMgyNKRirUl8xob1Yo8NIXm8C7NwDb38ez87uv
         pGWhX0//KE4Va/yu7ETS1+bt6rzAX9eqXSO49anBb0TE7t9tc8rd0UoYrmNRBybzjD+t
         /f98hmJqgQBs6lUGbnajid112lea8RBg3O2YI7xP1idAjv3FtgnnC6fOJj9zD+9FJc3D
         ZbY5VVPQgimmnc6sRVfRpV2B3qalN5GT5BNilVWPmxmSH35A6GlIPxEp89AFtP0hEcQ6
         VklA==
X-Gm-Message-State: ANoB5pkjuHVTtbuw258Mv2DFoP274sg9szlbOCr/Nn0wOWXmSoih/zZI
        fi51NuBLs+b1mAwswJaQBuc3HcsgIc/DuzCtBrY=
X-Google-Smtp-Source: AA0mqf7J6UsYdtU3I+7qCCh94ebdBJCmtFyROhsopD/KPQRuOlbhn8h1ckK0lufGxdBXEQVLb6pAww==
X-Received: by 2002:ac8:1019:0:b0:39c:da20:683 with SMTP id z25-20020ac81019000000b0039cda200683mr46753016qti.38.1671390796655;
        Sun, 18 Dec 2022 11:13:16 -0800 (PST)
Received: from joelboxx.c.googlers.com.com (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id cq8-20020a05622a424800b003a591194221sm4952864qtb.7.2022.12.18.11.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Dec 2022 11:13:15 -0800 (PST)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC 0/2] srcu: Remove pre-flip memory barrier
Date:   Sun, 18 Dec 2022 19:13:07 +0000
Message-Id: <20221218191310.130904-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, I believe the pre-flip memory barrier is not required. The only reason I
can say to remove it, other than the possibility that it is unnecessary, is to
not have extra code that does not help. However, since we are issuing a fully
memory-barrier after the flip, I cannot say that it hurts to do it anyway.

For this reason, please consider these patches as "informational", than a
"please merge". :-) Though, feel free to consider merging if you agree!

All SRCU scenarios pass with these, with 6 hours of testing.

thanks,

 - Joel

Joel Fernandes (Google) (2):
srcu: Remove comment about prior read lock counts
srcu: Remove memory barrier "E" as it is not required

kernel/rcu/srcutree.c | 10 ----------
1 file changed, 10 deletions(-)

--
2.39.0.314.g84b9a713c41-goog

