Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862B56BA0DC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 21:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbjCNUiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 16:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCNUit (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 16:38:49 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7D01B322
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:38:47 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id y3so13323286qvn.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 13:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678826326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K+VJT5XjlpwSB3Rr7WCNyE9jbOJcwAZ64R4PwLUCFfo=;
        b=FT+U50aYfKpkbHSpwNd8+f39NQWRVqBlmGN9Xm5zd6zz1vDQBXMmBOaKfk41DH+7V2
         PHHfk2+Bm+oXTq+nn+FLNB0aSB6Al65rk+iOpadO8mBSAPmi/m7E2qdeopMluuAXO+WQ
         57COnRrx9ISl+7nIWSMDUDZJRBxQwL1ahpj9xoixNF1uBSOuJAUx/nOu2opgfptwOqFE
         Qv0YtuBNPx4GXiNjS7zloaILPcPqkrEzcIhezWx567igyx/50fcqHRZ4Y4nZDoBo3EVO
         NWm+RwNqrAPffgq+Q3uuhlXcX5tIEgnGhJXk+mcw5g7O5j7WPrkq/JanDZ474XiDZiYG
         NseA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678826326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K+VJT5XjlpwSB3Rr7WCNyE9jbOJcwAZ64R4PwLUCFfo=;
        b=e9jZ4yzuBJL0UzHoSupqzCbQUovdZmICQoI25ItsyNOAwv1aS80rMbncC7fO71pQS/
         DIxR73NlKGpPlPOzGXvZUTH0ifXmSIcInX2MwjONXBnQxJEKNih/12F27+ChWW59lcrZ
         EW9tq0Si/UWoQs5hSEMtrbUJFjw1KEtCbxTmACA29+Mp/oQNCy1lgDoDKuEKKgdvABYV
         9haz29NNQwOMse4iH3AjGXIH0516Sgvjex5U02rSXPE8FONKDBmU0HFjJUoYczc9SjKU
         5vv72KtrsjAJfPIQppC2FDEnJFDfFFaruhp6ivW4NjGvpZ8UOd90N7Nzf1ZfUjzCq6EO
         eWYA==
X-Gm-Message-State: AO0yUKXZEy+j5feuLofRiquxdTeniGJHyyXfCCgIwbkdyFhMkdRcxB5q
        /Nzs2dsc3Ah894a8PMQZ2bEHtA==
X-Google-Smtp-Source: AK7set+4cvV3uB8Us3zIfqydslRFFAGro5l9PRHQNjJgsjwb73t7BLtnRF6N9l+N/F6PcZG6QiawXg==
X-Received: by 2002:ad4:5aa9:0:b0:5aa:fd43:1fbe with SMTP id u9-20020ad45aa9000000b005aafd431fbemr10644506qvg.46.1678826326252;
        Tue, 14 Mar 2023 13:38:46 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id c2-20020a379a02000000b00745ca1c0eb6sm1947828qke.2.2023.03.14.13.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 13:38:45 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net 0/4] net: ipa: minor bug fixes
Date:   Tue, 14 Mar 2023 15:38:37 -0500
Message-Id: <20230314203841.1574172-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The four patches in this series fix some errors, though none of them
cause any compile or runtime problems.

The first changes the files included by "drivers/net/ipa/reg.h" to
ensure everything it requires is included with the file.  It also
stops unnecessarily including another file.  The prerequisites are
apparently satisfied other ways, currently.

The second adds two struct declarations to "gsi_reg.h", to ensure
they're declared before they're used later in the file.  Again, it
seems these declarations are currently resolved wherever this file
is included.

The third removes register definitions that were added for IPA v5.0
that are not needed.  And the last updates some validity checks for
IPA v5.0 registers.  No IPA v5.0 platforms are yet supported, so the
issues resolved here were never harmful.

					-Alex

Alex Elder (4):
  net: ipa: reg: include <linux/bug.h>
  net: ipa: add two missing declarations
  net: ipa: kill FILT_ROUT_CACHE_CFG IPA register
  net: ipa: fix some register validity checks

 drivers/net/ipa/gsi_reg.c |  9 ++++++++-
 drivers/net/ipa/gsi_reg.h |  4 ++++
 drivers/net/ipa/ipa_reg.c | 28 ++++++++++++++++++----------
 drivers/net/ipa/ipa_reg.h | 21 ++++++---------------
 drivers/net/ipa/reg.h     |  3 ++-
 5 files changed, 38 insertions(+), 27 deletions(-)

-- 
2.34.1

