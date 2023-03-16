Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08F7E6BD2B4
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 15:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjCPOvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 10:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjCPOvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 10:51:44 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38BA6BEF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:41 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id g9so1370503qvt.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678978300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+c2VODMXDsgjnzYN1wpqme6CSn52whg1aII3mJI+P74=;
        b=I4nUZqrR9ZqTfpN6PC8CIUZdwxUE2nfnKe9cX3azTTY3agoJVtApZ3psCIw3R9BhvP
         7JS9NdPGgMHgot/oTDpHpzDV1Qca3Wxof4Z9QMdW7LzQJGbkftmn6zc4wTKHdGmaYV7I
         /fMh0lD1PD+0OSq8HExJ4f3sFfenKu4GmcO44ZtthbSUsQCT63eAFhISu6NkKdmS+Ofs
         3AH6nHzW13FhriDfKb56Wih/0eKmp93hieXsLwZu1Y3wDY2t/D8N3nm3lT0CymWDw2Kh
         ujTsYt0DmrZqayqAKa4icGm5ksfZO7u0moRa7uKCpkvZXuDUAsXn4zHm8R4JL5o3kEh6
         H53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678978300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+c2VODMXDsgjnzYN1wpqme6CSn52whg1aII3mJI+P74=;
        b=KcR8s1sNhrJlzPK2LV0Pt99j8oazIbKpa+ydQujHspn//0r1/ualhohoBvfZ+fBBe5
         FA1lf+rm48wP+N45PX6ss2hMP9Jq89fcW7a0D7axi4DGq1jBbVyR0WsLp99gxiAkoNh8
         /Q8Dy+jaFhMGqnlWgym1Wf2YuEd/nG5gEZnI4lUBBtHzRVDvCVWXJVy5bjWhwBqyvcsN
         PvISXrHGm0VuEr2yEhoYGDjc84qgv+bMTD0TzVbDXRYm4SigiDXa44V2QKS8uheAZxi/
         c4sSTECGpok04/mjtyKzenIZ5uoWxHRNOD365HHPf+IESbzTL9wL3yLaSHztOESPzDEW
         5rwA==
X-Gm-Message-State: AO0yUKV+xI9wgwWbrO5+S70MVAnkJp/bz2uwUfO0f5kJipGhit+SEiVU
        U5yvys8eVy9SAkvBAnzD4zQyKw==
X-Google-Smtp-Source: AK7set/spgJw1VRJnEotZNs7Ru/q+XbHnKrcPIJeLvgqAtonPtHvPALlEki5QRjkHfTmVDdnHd7YgQ==
X-Received: by 2002:a05:6214:4115:b0:5aa:6130:7c63 with SMTP id kc21-20020a056214411500b005aa61307c63mr20027187qvb.46.1678978300471;
        Thu, 16 Mar 2023 07:51:40 -0700 (PDT)
Received: from localhost.localdomain ([98.61.227.136])
        by smtp.gmail.com with ESMTPSA id n129-20020a37bd87000000b007456b2759efsm2844070qkf.28.2023.03.16.07.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 07:51:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     caleb.connolly@linaro.org, mka@chromium.org, evgreen@chromium.org,
        andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v3 0/4] net: ipa: minor bug fixes
Date:   Thu, 16 Mar 2023 09:51:32 -0500
Message-Id: <20230316145136.1795469-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Versions 2 and 3 of this series change the "Fixes" tags in patches
so they supply legitimate commit hashes.

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

