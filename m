Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BFCF67CC39
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236891AbjAZNcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236857AbjAZNcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:32:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E495565BD;
        Thu, 26 Jan 2023 05:32:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 81A2A617EC;
        Thu, 26 Jan 2023 13:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE3F3C433EF;
        Thu, 26 Jan 2023 13:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674739953;
        bh=dZYhjLBi/PfRQMVe8P8hNYdier7KYYimYCEFOUOp6A4=;
        h=From:To:Cc:Subject:Date:From;
        b=pyBubzjfF8akyVx47yerXs6obztqc5t1FAmomf6bTb+n7f5zFyL+pccrJhpxnNsLt
         grHZ8oAqHc8i4oNt3B/ysYeEig+WI4H1SFuGYSQJEoQlEfHHD6/hxEvDYWUF3tkGss
         ogx1BE3WT44/ex/wBS7ho7+tqcLJA8hospfIlfrhbkGxVSvB4lXFQZlxuVOY1+zg4G
         nrdDaNKP7S/g5rwIx7hrrx+XoclfPvz3TDXiKBzviaerCtaWhaZTEt2ttHFLmJ/qoQ
         jVG5ez4dW1uspOaEV2Ajh/fr87JRYPqPjOIXR+WfFiouIY4fK4M8NbDqdUFtpkZL/g
         c1E370qdcpcKg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pL2Mp-0007Ai-Ne; Thu, 26 Jan 2023 14:32:40 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] nvmem: qcom-spmi-sdam: fix module autoloading
Date:   Thu, 26 Jan 2023 14:30:32 +0100
Message-Id: <20230126133034.27491-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.1
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

The Qualcomm SDAM nvme driver did not have a module device table, which
prevents userspace from autoloading the driver when built as a module.

The driver was also being registered at subsys init time when built in
despite the fact that it can also be built as a module, which makes
little sense. There are currently no in-tree users of this driver and
there's no reason why we can't just let driver core sort out the probe
order.

Note that this driver will be used to implement support for the PMIC RTC
on Qualcomm platforms where the time registers are read-only (sic).

Johan


Johan Hovold (2):
  nvmem: qcom-spmi-sdam: fix module autoloading
  nvmem: qcom-spmi-sdam: register at device init time

 drivers/nvmem/qcom-spmi-sdam.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

-- 
2.39.1

