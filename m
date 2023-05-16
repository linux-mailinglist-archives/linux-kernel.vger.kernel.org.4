Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32548705B0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjEPXN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjEPXNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:13:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29C849CC;
        Tue, 16 May 2023 16:13:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58518635D3;
        Tue, 16 May 2023 23:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6527EC4339B;
        Tue, 16 May 2023 23:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684278797;
        bh=TF+bBIjOZCl8rJnA/ryDiM3hourzs5LjpwgA2d5LjGg=;
        h=Date:From:To:Subject:From;
        b=nmU1akdGqJ/msV6ntbqjR4k4tFrVad9txDs+bmiHN0UrlEGF6zKACsLCYIyQZTFgu
         RZBzKWRWYt7TmzDQ9FpTzqFQsmPiMpPdGYb1LzcqUOkDgCtpcq1NnKMj6Xacsx5t/A
         V2kvb4v5iI7ibTn8KTm54bDAZxUsj9/GYoxhuhdXoXz1XJbRfQBpN1s5NmpsXWJz2J
         2h8aJFPuglOOyuiqgP1u7sBZ6MvcKEyNMbVGsv/p2Y2A0g1YuxxTSaXut63kfgXB3w
         I2VO/F9oM/WQHzsErYROe77Ka5vOcJpK5QiFKholWc8R/Kq6bFSqPhC/t6QQr9/g5J
         Mf4tmB/NDMaiQ==
Date:   Tue, 16 May 2023 17:14:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH 0/2][next] media: venus: hfi_cmds: Replace one-element array
 with flexible-array member
Message-ID: <cover.1684278538.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series aims to replace one-element arrays with flexible-array
members in struct hfi_session_set_buffers_pkt.

This helps with the ongoing efforts to tighten the FORTIFY_SOURCE
routines on memcpy() and help us make progress towards globally
enabling -fstrict-flex-arrays=3 [1].

Link: https://github.com/KSPP/linux/issues/79
Link: https://github.com/KSPP/linux/issues/160
Link: https://github.com/KSPP/linux/issues/292
Link: https://gcc.gnu.org/pipermail/gcc-patches/2022-October/602902.html [1]

Gustavo A. R. Silva (2):
  media: venus: hfi_cmds: Replace one-element array with flexible-array
    member
  media: venus: hfi_cmds: Use struct_size() helper

 drivers/media/platform/qcom/venus/hfi_cmds.c | 16 ++++++++--------
 drivers/media/platform/qcom/venus/hfi_cmds.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.34.1

