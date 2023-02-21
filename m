Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C15269DDA7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbjBUKQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjBUKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:16:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E31C23334;
        Tue, 21 Feb 2023 02:16:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01A0B60FC8;
        Tue, 21 Feb 2023 10:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5799BC4339C;
        Tue, 21 Feb 2023 10:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676974605;
        bh=LUsoC6iSVQT5Y3MM/3YfkP1p/LvHRVSyJ+N/makA+N8=;
        h=From:To:Cc:Subject:Date:From;
        b=rcXnBgvhaj6iNKopEWQjVQr3aV4U3Ca/n+r22TxKwIJyrYcLABchJSvyK9nBAxfbh
         DT6GvN7i1hDH4Cc70yAAUXa1+Taa5/TYX6qjZiahdTllrZP10/EtnE0k4FtOTxBFPz
         Ghh1zezU4xyboYI4ZUFnPT2DS610X3SRE5NeqUUpdt3WdD5HTjnDO59YAEmybpZNxE
         4mjUudbWBy1BTeN0v6GSsiN9bIFAPlNhzKjOj62RtwjbS9TioWGvSKZ6iaQ9pc9CRW
         G6q6etakyCVKw4RXU6XcrJfZ2bgC2Dtq8ur+JnI9q6KsgywauRm7YpdnVmW6caiNSj
         eTrgbD87u43gg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pUPhX-0003oD-5w; Tue, 21 Feb 2023 11:16:47 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/4] drm/msm/adreno: fix runtime PM imbalance at unbind
Date:   Tue, 21 Feb 2023 11:14:26 +0100
Message-Id: <20230221101430.14546-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported by Bjorn, we can end up with an unbalanced runtime PM
disable count if unbind() is called before the drm device is opened
(e.g. if component bind fails due to the panel driver not having been
loaded yet).

As runtime PM must currently stay disabled until the firmware has been
loaded, fix this by making the runtime PM disable call at unbind()
conditional.

The rest of the series removes a bogus pm_runtime_set_active() call and
drops the redundant pm_runtime_disable() from adreno_gpu_cleanup().
Included is also a related indentation cleanup.

Johan


Johan Hovold (4):
  drm/msm/adreno: fix runtime PM imbalance at unbind
  drm/msm/adreno: drop bogus pm_runtime_set_active()
  drm/msm/adreno: drop redundant pm_runtime_disable()
  drm/msm/adreno: clean up component ops indentation

 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 ++++------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |  5 -----
 2 files changed, 4 insertions(+), 11 deletions(-)

-- 
2.39.2

