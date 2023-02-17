Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4A5269B400
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 21:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjBQUfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 15:35:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBQUfu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 15:35:50 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE144AFD2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:35:49 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id t8so2801541lft.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 12:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=F9aZaOyEyAOwvXZCotQI0lKbLpSBcihQLNCPQOuW8wM=;
        b=KPPm7lpyd3ibaAlvp8yNZlfqwX9w4r07nwtqaDWlmh11g8RtSwfEUlLhkRm44toJUk
         HNZdlJ2XwhL5eidCu5BosH+e8SaSNdTT1YjLPtBqZD7pASXxOmKtSpgz9jOY5a9h7nXT
         nbxCTtWHfoEZTnTBFc+5iqJuHyoDeOU42fSnpNatTWLcP0p+LgJJDBKrZjtnrpKbDAYs
         h7FqjivtlYBEqi4z4qtKo1NCyR+Wy7jSNrwcaUDfjzrrMb1DfElDSWjZjCjsprh2Mt0k
         B/G3qc1Vb2867RQga4gkmqV7kpF8VBsjMNieKMZrXLA/WLhrwq/eNymkpV3jZ0Em/YsQ
         W4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F9aZaOyEyAOwvXZCotQI0lKbLpSBcihQLNCPQOuW8wM=;
        b=0vfgJSxS+E/ahaNWhqpytfrpkxBZeR6mvOQXWyHBwj80yHz+VsCDjSaGH3k2lzsHdj
         0alGe2T3uGjU9iXy+8fAPzxVRKNi6KkjLPF+ei3JEHK1gMjurJPdSA/UEYedYo1Fywom
         GL4ddsQDtBsclPo2g1eAgrLVGsxZG/Egd6DN+e4VfwfJbuDMPnE15CsRxEd/7X/Vh5qA
         NrHEiK2UDgs4adikhDtBGEG9ksEHQotSex3sNG92GmvmWnTd9jKq+QsFYttyVcl4l2EH
         0quw/b+5YjBG+4rSRSEBBzgNenjT8LPxjh9dBZaCg48jgBIvd3y4lKtpbln/ss5cFBZk
         ihxA==
X-Gm-Message-State: AO0yUKWi8IGaoKmBrjhFcvSAVnni0hIcHxpCNqfVajvwdsKvlntqwNgU
        Umu+w6T/Ihm8DMftOUE1r3uGHQ==
X-Google-Smtp-Source: AK7set8n/UPS5msZ00ZFlIfojRH3y6BmdszOER3EIsbIXcqHoMPvRC1JHPdRKfBbabg2ZBQ1iSAF+A==
X-Received: by 2002:ac2:41cf:0:b0:4cc:8682:ec5c with SMTP id d15-20020ac241cf000000b004cc8682ec5cmr352964lfi.34.1676666147675;
        Fri, 17 Feb 2023 12:35:47 -0800 (PST)
Received: from localhost.localdomain (abxh184.neoplus.adsl.tpnet.pl. [83.9.1.184])
        by smtp.gmail.com with ESMTPSA id q28-20020ac2515c000000b004d8580b2470sm771498lfd.225.2023.02.17.12.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 12:35:47 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Qais Yousef <qyousef@layalina.io>,
        Vasily Averin <vasily.averin@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>, linux-kernel@vger.kernel.org
Subject: [PATCH] mailmap: Map Georgi Djakov's old Linaro address to his current one
Date:   Fri, 17 Feb 2023 21:35:16 +0100
Message-Id: <20230217203516.826424-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.1
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

Georgi's old email is still picked up by the likes of get_maintainer.pl
and it keeps bouncing every time one submits an interconnect patch.
Map it to his current @kernel.org one.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Cc: Georgi Djakov <djakov@kernel.org>
 .mailmap | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.mailmap b/.mailmap
index a872c9683958..fb65947d671d 100644
--- a/.mailmap
+++ b/.mailmap
@@ -150,6 +150,7 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
 Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
+Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
 Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.com>
-- 
2.39.1

