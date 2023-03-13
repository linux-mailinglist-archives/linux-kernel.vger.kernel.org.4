Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEF176B71B6
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:54:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCMIy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCMIxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:53:47 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BBB37562;
        Mon, 13 Mar 2023 01:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F3709CE0EC7;
        Mon, 13 Mar 2023 08:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FDC433D2;
        Mon, 13 Mar 2023 08:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678697456;
        bh=bxFy0g/YowhzcjpYqA4BX93LeqiKqvaOaDFo5v2nHiI=;
        h=From:To:Cc:Subject:Date:From;
        b=bmZlBiGfZQsvWp0xdybp7kstjy/o39a/uhiBPMNL306rvxbvxcH78L1ImqN13yCg3
         PpQPBoQxVq55fHN9irQB4UWUEjJDqV7AEzq3I5/YPVEYYJch/j37xwR0LNU+9w0/lr
         6+uWLVUvXOEDfz8NNOe7GVV/ez0eli+qY2he7yPq/fmz1aDZUQNN/8I9tk6XR/eyfq
         OnNkhUjytB87GQSz+yZV35ORB5QtdvS8GypyQcZBgI1IoKt4jcHrd6TDL6UmozRWPo
         hp6B6Gm7WU4ssb9wuoAVh6j1j1+B44Sw+fBiU4AQJC4qkk1s6TO0NaRyg+D3poy2lr
         1Wq67efW5Z42w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1pbduN-0006Hs-Re; Mon, 13 Mar 2023 09:51:56 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] interconnect: qcom: rpm: fix msm8996 interconnect registration
Date:   Mon, 13 Mar 2023 09:49:51 +0100
Message-Id: <20230313084953.24088-1-johan+linaro@kernel.org>
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

Christophe noticed that a recent patch adding a missing clock disable to
one of the Qualcomm rpm driver error paths was broken. This would lead
to the provider not being registered on msm8996 which is the only
platform using this code path.

Turns out, however, that the power domain attach during probe is bogus
and would always succeed as any power domain would already have been
attached by the platform bus code.

Georgi, the offending commit is currently in your icc-next (and local
icc-fixes) branch. Perhaps you can fold in the fixup unless you prefer
applying it on top.

The bogus PM domain lookup is redundant and confusing but should
otherwise be benign so the removal could be applied to either branch.

Johan


Johan Hovold (2):
  interconnect: qcom: rpm: fix msm8996 interconnect registration
  interconnect: qcom: rpm: drop bogus pm domain attach

 drivers/interconnect/qcom/icc-rpm.c | 5 -----
 drivers/interconnect/qcom/icc-rpm.h | 1 -
 drivers/interconnect/qcom/msm8996.c | 1 -
 3 files changed, 7 deletions(-)

-- 
2.39.2

