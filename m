Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47CE670E062
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237384AbjEWPZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbjEWPZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:25:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEE3FA
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:56 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f60444238cso25905745e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 08:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684855555; x=1687447555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Piyx6ST0UP7axHcp7EiweewnE9nu5kyI+xrojBB9Hm8=;
        b=FMKiVIKzPP2tc2C/0IArQcJ2FjJPJY0DrQKiz5ooAxjVR0grlQ5xrbdZgZLncPD4yo
         ALezl0DiiKYfMyqPVXtZbWW8xLNnXaXyDH2Dwhy4v8CBJ6lkkjRdu5yeHEJ579tLUF2n
         w++lV6cNOv5pdQq8rxQtwi0MbJvLRsO3rfPCV+q6iRiJTI1NRI8bOoKAWw7UddcTfvCL
         dJ6b94ykASl1NOzu3WCFzSZwfxYMsOBF0q26WgdtsXXZcJ5975whnuHbo59wM56PAmVS
         UbKhjBdpJOmqWYv1xHbT/ujsveH/DtksDEcNOOl7WW08Da7+U32E/Ov6W1je/xlkkH0T
         G3SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684855555; x=1687447555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Piyx6ST0UP7axHcp7EiweewnE9nu5kyI+xrojBB9Hm8=;
        b=Ewdc8X/GSrY/TDQmXQZH6uCS09+ih7ZFCnpuuE7jQU26dTgcoA7jd5SMsdbC8nfe0J
         HzcPMqbLDERqUIaC+M5tX3Cl4VWrOuE8Mf8qLQAKK66rOuukHpBzwhHrfQvFKK5ClRWD
         43uAKnj2AMHw9PfzgTg0BDDtCrX/A4VskO+cbGhFk3Uk2LEJ5UjL5DCBqGlk+i/vm07j
         J9lxkQNHhrvFQpIob4kkCwumxTnu03aNPzjiAUzFhh5rtqx0eFaBIPdLCbrVI+21yK1G
         5P7zLoFgQPlBYnXHPoM9rnYYy3ztTo+6OI2kATmWj3y5oSzCPckK96Rxcq4yJATpukdh
         Sn4A==
X-Gm-Message-State: AC+VfDwAAfZMTbkToU19jaEeLnT3K3Ja73lAdGC0xQunn6VLXbhg1UfY
        4Sq8rWnmaYVwL5QqgMdkc/ohuFtqUl32Fp5GWkM=
X-Google-Smtp-Source: ACHHUZ4Tr9Ljscv136YCq8c2gC53OWukAsVGgpsMnn55ZQts4mFcjoDA8oEhrOohrk11sko6shtyRA==
X-Received: by 2002:a1c:7c01:0:b0:3f5:db0f:4a74 with SMTP id x1-20020a1c7c01000000b003f5db0f4a74mr10703716wmc.21.1684855554775;
        Tue, 23 May 2023 08:25:54 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f20-20020a7bc8d4000000b003f6038faa19sm8303887wml.19.2023.05.23.08.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 08:25:54 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/4] misc: fastrpc: fixes for 6.4
Date:   Tue, 23 May 2023 16:25:46 +0100
Message-Id: <20230523152550.438363-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,
Here are some FastRPC fixes.

Fixes are mainly around using remote heaps and cases around cleaning
state during device removal.

Can you please queue them up for 6.4.

Thanks,
Srini

Ekansh Gupta (2):
  misc: fastrpc: Pass proper scm arguments for secure map request
  misc: fastrpc: Reassign memory ownership only for remote heap

Richard Acayan (2):
  misc: fastrpc: return -EPIPE to invocations on device removal
  misc: fastrpc: reject new invocations during device removal

 drivers/misc/fastrpc.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

-- 
2.25.1

