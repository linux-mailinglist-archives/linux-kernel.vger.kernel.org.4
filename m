Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212C55B394B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 15:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbiIINlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 09:41:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbiIINkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 09:40:46 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF049F8F6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 06:40:39 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k9so2870392wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 06:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=l/8cXar681flBGzxgbG6UuPD2UpWX85uZYv3ng5pRwQ=;
        b=xZP7AcRPFPttHhSHgUojl13iCFA4//waZdPgpzMGeyfFB4Q5UEfU+u5hZ2PQTyid0c
         jDrIKuismD9DhjHJ0MxzYXgGPU4QZUokPTxgShwNRG3O8/b/vwPhNXg8lfMeIfkzBkVp
         FTjgWGyk59Hssb9L1Fjb69eLAhOCrhJx0GeL1XFcmwKwhPWNTi3mfQhKFRGSfGkEMeXi
         /pLIe7qmopDioQ8A76AKp69haLz7ALj7iX0maI2tY1l33H08JBZDXDZROM681PG9oz5O
         reRTth3+2YvUBNg3ZxEbT0VY8xNGlZbKKMnqgruglRkgxugfvgcVAUxNzqKl+Z2/oYaM
         VuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=l/8cXar681flBGzxgbG6UuPD2UpWX85uZYv3ng5pRwQ=;
        b=VaQ/FwtrGCnl2FkJfBYS2YByx/RAfH07WRmZTuhU3i1aFltp/w9/uPN1n7DS/vttmA
         uW0nQv/g7MBidUme3wk3C3CanQH69r6qT0FzAi9Q1dUOIr4iJxN5MXkSyLlPbHIYckMp
         G4NrQe+grN02ab4I4yF5QRXTtswT/dtC2I89VthcsR+bclYWDTqic2MlNeR4RQZGdyzI
         oTPu2VnsqyhGbUX2Ci7mOX+Fa/OWw3PBc+U3yE5tZ5SHWgxl4giOM/cZmx1PVG9lYv3k
         52NvntyTKdY/007CQorQ282/umqcFK7RPjEzmbASESojO8PbveH5dyVw0qPEiMESsCN1
         BQGA==
X-Gm-Message-State: ACgBeo0eh6SeIqSCI0LdoKvRVyyYhv/6h8rIeqMSZ7DHSF5Ue5fbg/C2
        VTn4aGZ/cnXSOst6M/W6+73xJQ==
X-Google-Smtp-Source: AA6agR7LhQJJ7nlAY9bZ5I3UdVH9iuqeYV1eJviGAwfIYRDWwaBuiIO1FkL7e7G7/dgCRhR7jpnbYQ==
X-Received: by 2002:a5d:4d0a:0:b0:228:d9c0:5abe with SMTP id z10-20020a5d4d0a000000b00228d9c05abemr8401736wrt.693.1662730837061;
        Fri, 09 Sep 2022 06:40:37 -0700 (PDT)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003a604a29a34sm660622wmq.35.2022.09.09.06.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Sep 2022 06:40:35 -0700 (PDT)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ekansh Gupta <ekangupt@qti.qualcomm.com>,
        Bharath Kumar <bkumar@qti.qualcomm.com>,
        Himateja Reddy <hmreddy@quicinc.com>,
        Anirudh Raghavendra <araghave@quicinc.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Subject: [PATCH v3 00/10] misc: fastrpc: Add audiopd support
Date:   Fri,  9 Sep 2022 16:39:28 +0300
Message-Id: <20220909133938.3518520-1-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds audiopd support to fastrpc.

The v2 of this patchset is here:
https://lore.kernel.org/all/20220902154900.3404524-1-abel.vesa@linaro.org/

Abel Vesa (10):
  misc: fastrpc: Rename audio protection domain to root
  misc: fastrpc: Add reserved mem support
  dt-bindings: misc: fastrpc: Document memory-region property
  misc: fastrpc: Add fastrpc_remote_heap_alloc
  misc: fastrpc: Use fastrpc_map_put in fastrpc_map_create on fail
  misc: fastrpc: Rework fastrpc_req_munmap
  misc: fastrpc: Add support for audiopd
  misc: fastrpc: Safekeep mmaps on interrupted invoke
  misc: fastrpc: Add mmap request assigning for static PD pool
  misc: fastrpc: Add dma_mask to fastrpc_channel_ctx

 .../bindings/misc/qcom,fastrpc.yaml           |   5 +
 drivers/misc/fastrpc.c                        | 260 +++++++++++++++---
 include/uapi/misc/fastrpc.h                   |   7 +
 3 files changed, 240 insertions(+), 32 deletions(-)

-- 
2.34.1

