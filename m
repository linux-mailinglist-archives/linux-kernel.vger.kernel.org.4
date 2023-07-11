Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395974F977
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 22:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230381AbjGKU6x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 16:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230398AbjGKU6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 16:58:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FFD1709
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689109084;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=f+hIo3oC9fPc83S0WFvpQBdDffxEHtx3wU0gPObo34Y=;
        b=Ddwi4WcbvYdl9J5pRzVzBAMxiEqynnbuzK26TEgjpER/U6zs/+Ct+8gTljUhRqa/AkMj/0
        iqrnqvKJAp8PwQs9+tyJX7J9vKkEHQXt3GztgGXxr6MVLgklXfJZ0Ek6X6aofjeFi8JjM0
        AJf/a/5tZLKUTSyfm06hnYQ1od4lijA=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-kATfmpPxOuW178GWf-eToA-1; Tue, 11 Jul 2023 16:58:03 -0400
X-MC-Unique: kATfmpPxOuW178GWf-eToA-1
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-5618857518dso50202617b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 13:58:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689109082; x=1691701082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+hIo3oC9fPc83S0WFvpQBdDffxEHtx3wU0gPObo34Y=;
        b=FNDf8BIK0c89g3es9jqbOrQTgUc54Lnjw8cMszIh96XTiqVSlKaXk+LcpLzrOoVZTv
         NSCg0zBxErGzj6Rb3/K1l1V+5NR5ov2DXShPhIG5TJqyHAxHq7DEDVUFPuExqgFE+b1b
         nueduv/ISwYfL3u80CXjJqqhkp1q6rv4C3AT8+Z4td/SYNxRJbzwItUOObU/npbCGwf0
         igY2QsjL5O370B+3YTuBBXksXYssnbUiO6rUY/s2+Qfy/bxv+Kqmz/ZjzJm5m6AMQeGW
         yoWuz7WGGyzSQLbdjANGLnl4qqWzZTxmWdIQzQoFDF35Ry3NtZBKC/SpXWkt7/GldQXB
         leeg==
X-Gm-Message-State: ABy/qLYky3hBVZpwKGD7R4K94+OSJuE+b08v+n38mWdQzQn8+Cdx3jex
        XbQWTBpwC0p/Gv4eIlLid96T1oYvcQN0awLEuVQqot7rbWbHg6vH9gK6NLvcEEfoAm17PnXi1Uq
        wKJMLEtSN+pgUnDREXR2WMzpcVlsO+n1W4y9yJoMcyljOlqUCbUiPQKP0YRo+lrDe3ZHbrPAB80
        ZRKBn8BdkT
X-Received: by 2002:a0d:e284:0:b0:570:28a9:fe40 with SMTP id l126-20020a0de284000000b0057028a9fe40mr16227311ywe.5.1689109082715;
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGA6n45gkHkTv6XI6HgkyWTiJIRi19JmwhiTyxapecnmiZP7znNfnQP5MUvwPurdzpN+R7zUA==
X-Received: by 2002:a0d:e284:0:b0:570:28a9:fe40 with SMTP id l126-20020a0de284000000b0057028a9fe40mr16227284ywe.5.1689109082375;
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j136-20020a81928e000000b00545a08184cesm785353ywg.94.2023.07.11.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 13:58:02 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, jsuraj@qti.qualcomm.com,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH RFC/RFT net-next 0/3] net: stmmac: Increase clk_ptp_ref rate
Date:   Tue, 11 Jul 2023 15:35:29 -0500
Message-ID: <20230711205732.364954-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DO NOT MERGE, patch 2 and 3 are duplications at differing levels
(platform vs driver wide). They work fine together but it makes no sense
to take both.

Disclosure: I don't know much about PTP beyond what you can google in an
afternoon, don't have access to documentation about the stmmac IP,
and have only tested that (based on code comments and git commit
history) the programming of the subsecond register (and the clock rate)
makes more sense with these changes.

I'm hoping to start some discussion and get some insight about this.
Recently I found myself discussing PTP and some possible changes from
downstream that might need to be upstreamed. In doing so, I noticed that
the PTP reference clock (clk_ptp_ref) was running at a much lower value
than was being discussed. Digging in a bit, nobody is calling
clk_set_rate() of any value on clk_ptp_ref, so you get whatever the
default rate is when enabled. On Qualcomm platforms I have access to
this results in a 19.2 MHz clock instead of a possible 230.4 MHz clock.

This series proposes setting the clock rate. Patch 2 is the "safe"
approach where a platform must handle it, patch 3 is the big hammer
where we max out the clock for all users. I think patch 2 is using
a proper callback (I want to document those a bit in the future to make
it easier for future folks using them). My guess is that doing this
driver wide might be undesirable for some reasons I'm not
aware of (right now I blindly request the max frequency but the IP
could have an upper limit here, platform maintainers maybe upset if
their careful validation at prior frequencies changes, etc).

I've only tested that the Qualcomm boards I have access to in a remote
lab still work (i.e. throughput testing, etc) and that the PTP
programming is now what I expected it to be theoretically.

I'd really appreciate someone with the ability (and know how!) to test
PTP tried this on at least the Qualcomm platforms. Bonus points if
someone explains how one would even test PTP networks like this.

Thanks,
Andrew

Andrew Halaney (3):
  net: stmmac: Make ptp_clk_freq_config variable type explicit
  net: stmmac: dwmac-qcom-ethqos: Use max frequency for clk_ptp_ref
  net: stmmac: Use the max frequency possible for clk_ptp_ref

 .../net/ethernet/stmicro/stmmac/dwmac-intel.c  |  3 +--
 .../stmicro/stmmac/dwmac-qcom-ethqos.c         | 18 ++++++++++++++++++
 .../ethernet/stmicro/stmmac/stmmac_platform.c  |  5 +++++
 include/linux/stmmac.h                         |  4 +++-
 4 files changed, 27 insertions(+), 3 deletions(-)

-- 
2.41.0

