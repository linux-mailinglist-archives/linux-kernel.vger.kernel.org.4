Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD66C24AB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 23:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCTWUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 18:20:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjCTWUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 18:20:11 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604A3754A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:29 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c18so14046138ple.11
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 15:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679350709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RtNlHvoQMaVv/dozA/BthInPSN442N/1J5oP/tOY4+c=;
        b=sSZs+H5I+LRhKeLPAp76IZjxcWtFI8ncSieV5M1bs2iCtjzieDb3vTSsn62wZ77EvH
         46BKFcKF6z25XNsMMIPw+t9bRsVpOb+2G5KZGxCnN1MkhncgkDKVCn6pUKRsPR0FDlo3
         X5IDNfvcldMTp1A+ilN3CnUHSxdsWCa8uJ2UqhNxW8INtg4WNdytkXJsItCv148cHtjD
         xUvM9KbXeF2xaLAoSOKrXTTKfXQ0yQj2WyYL104mbwE/Xfp1PgR8z/8JisXQA8DPrSuI
         8uw+tFGyVfQaG/G/Ink4AvQKVbFtgFyYgMrVnx6eItKVvBTB1TXTuQsJqgLNFoK9J5uQ
         DP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679350709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RtNlHvoQMaVv/dozA/BthInPSN442N/1J5oP/tOY4+c=;
        b=jGqeHnp2LUJbctEueFXeIyqqAg7HE5iEGG7eD1fpVeyaU40R43Q11tkxdTmYK7nmMI
         tbd+mOpvIRNkgI4r1pDaG7ZIKwZgI8iePiyEd4WWDZKzZfpM2A9Xv2N/BYDGG5TdxU78
         70k3KMfETd/GeHiAhPdE1/nJ16GMtqrcvwJdykvuJtxsU4RQFPSrOi0kxwxo0KSpjbC3
         yiSXtQ6KxJ39umvOvbNaTGvMIw89IRFEIPokaWgd9IydTgojIRScZBf2/inL1DgrAmKX
         1FV8xHAfRUYCdZ1HSfl9DU0X6IxckkbalOlRJY/cKoQqGnONMrROyW1nFTYpQqsadLXo
         mQCA==
X-Gm-Message-State: AO0yUKWPpDU7+qLebV92nlRD5iNZvQPzSqVcbGuIUoEuEeZ4oSk38UDB
        FdNhXgjCScIQkKg1T8cEkIegpw==
X-Google-Smtp-Source: AK7set+bDv8ICfEy1QdT4thKkqCwduccw2mTy+wgcIpOTHrXPdu/uwkpo/eTLScseRGQ4qOd+VsbZw==
X-Received: by 2002:a05:6a20:7f8e:b0:d5:213a:476e with SMTP id d14-20020a056a207f8e00b000d5213a476emr22916516pzj.51.1679350708903;
        Mon, 20 Mar 2023 15:18:28 -0700 (PDT)
Received: from p14s.cg.shawcable.net ([2604:3d09:148c:c800:4ab5:5131:bafc:4428])
        by smtp.gmail.com with ESMTPSA id e15-20020a62aa0f000000b006259e883ee9sm4459196pff.189.2023.03.20.15.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 15:18:28 -0700 (PDT)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     andersson@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, patrice.chotard@foss.st.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        arnaud.pouliquen@st.com, hongxing.zhu@nxp.com, peng.fan@nxp.com,
        shengjiu.wang@nxp.com, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] remoteproc: Call of_node_put() on iteration error 
Date:   Mon, 20 Mar 2023 16:18:21 -0600
Message-Id: <20230320221826.2728078-1-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
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

This patchset adds missing calls to of_put_node() when prematurely
exiting from a loop driven by of_phandle_iterator_next().

Some help reviewing this set would be appreciated.

Thanks,
Mathieu

Mathieu Poirier (5):
  remoteproc: stm32: Call of_node_put() on iteration error
  remoteproc: st: Call of_node_put() on iteration error
  remoteproc: rcar_rproc: Call of_node_put() on iteration error
  remoteproc: imx_rproc: Call of_node_put() on iteration error
  retmoteproc: imx_dsp_rproc: Call of_node_put() on iteration error

 drivers/remoteproc/imx_dsp_rproc.c | 12 +++++++++---
 drivers/remoteproc/imx_rproc.c     |  7 +++++--
 drivers/remoteproc/rcar_rproc.c    |  9 +++++++--
 drivers/remoteproc/st_remoteproc.c |  5 ++++-
 drivers/remoteproc/stm32_rproc.c   |  6 +++++-
 5 files changed, 30 insertions(+), 9 deletions(-)

-- 
2.25.1

