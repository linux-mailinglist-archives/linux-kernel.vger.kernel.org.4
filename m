Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062D56DDD68
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjDKOOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 10:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjDKOOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:14:43 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF231B1;
        Tue, 11 Apr 2023 07:14:42 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id c10-20020a17090abf0a00b0023d1bbd9f9eso11108895pjs.0;
        Tue, 11 Apr 2023 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681222482; x=1683814482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nUqBPGgh8CrNxczOidhg/CSqsuSy4JlqYBSAJ+z/y9s=;
        b=Gu7+eyUOLclC1bTu8BcvYj14sC6QoGrw3NMzAIq+OpKET0Clg1rXkZkOAYAVNWpKgS
         4sPHsUqgwrQi95ufUaMLK38qQrwVMIKkK0tfRxmt2QOkPnTA6NT7kNrMHEL2eBUuRrK+
         GwIcQBD5HNK4f1EwsJ+NQnqIMhPCddh38R2fymNcDL7/GlirPWTIiRrZN70V2WNOEjBY
         99bcfItjprKWxL3gH4SGTZwChBgUOGhqakf6niF3igEqtL5k0RB8uzLpl0QQYsgq3xja
         Gb3wSqNGEfEYWkNfTuxBPQ1QceWaIzdHq8rt0OLhTeucqPd28FOd0pIFkhehHju4+CSs
         7gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681222482; x=1683814482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nUqBPGgh8CrNxczOidhg/CSqsuSy4JlqYBSAJ+z/y9s=;
        b=kTxW6iOJuusZAl0t4e99paoHBmvJJnOOJ6uyMfNBnudwLLbDSMZLuWHo42np1s++KW
         VWze7YOVhkw8CSJVLfv4W5DuDCLIQNI8+JnJUNKLRIC3PSWn8J2gbN9E6ziIkc2JioO2
         oV3kgoYBK1yCey4um03oIfJs8u03B1xJtt9DHqHYtmWya+4G+oN5JhOe082VfPDMp19Q
         ri75BJdkRUIAWYPQmQk4aIdyUoPmQsy4k3na7KoD1hgLZmtaiq13jB81T/jmR0vt+Xdp
         GlytKeUEKQrnVBqUsRxaQFRYN+oeZNwJ6z+TPuSqZLR+N2M6go+KzYkICb+v7wdBD/6L
         w2lg==
X-Gm-Message-State: AAQBX9fwB8pqY9rYR83gaaVkKWJAyOG7cA09MZ0/wMZkeWL4cdnwrANA
        WAuL6FEz4oGFBvnzy+Qwo3k=
X-Google-Smtp-Source: AKy350Yu36TtUThSJ9RIwGKPPMbCyhpU0MLUm4TlwkNqMALQCkJHYxd8RXFtTUPFEa2XbFYYLlKrOA==
X-Received: by 2002:a17:902:cec6:b0:1a1:e112:4607 with SMTP id d6-20020a170902cec600b001a1e1124607mr3431694plg.50.1681222482287;
        Tue, 11 Apr 2023 07:14:42 -0700 (PDT)
Received: from localhost.localdomain (36-229-229-178.dynamic-ip.hinet.net. [36.229.229.178])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902988b00b001991f3d85acsm9691979plp.299.2023.04.11.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 07:14:42 -0700 (PDT)
From:   Lin Yu Chen <starpt.official@gmail.com>
To:     corbet@lwn.net
Cc:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lin Yu Chen <starpt.official@gmail.com>
Subject: [PATCH] docs: Fix typo in Documentation/RCU/checklist.rst
Date:   Tue, 11 Apr 2023 07:13:41 -0700
Message-Id: <20230411141341.74133-1-starpt.official@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit corrects the spelling of "not" to "note" to accurately
convey the intended meaning.

Signed-off-by: Lin Yu Chen <starpt.official@gmail.com>
---
 Documentation/RCU/checklist.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index cc361fb01ed4..bd3c58c44bef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.
 
-	Please not that you *cannot* rely on code known to be built
+	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
 	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
 
-- 
2.25.1

