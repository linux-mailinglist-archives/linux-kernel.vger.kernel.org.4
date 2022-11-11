Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437C96255E1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 09:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbiKKI52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 03:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiKKI5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 03:57:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBAC7833D;
        Fri, 11 Nov 2022 00:57:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8A0C061EFA;
        Fri, 11 Nov 2022 08:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6F1C43143;
        Fri, 11 Nov 2022 08:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668157042;
        bh=6lx4EuPQGDBHFiojMWKakUIRIo8dAD0np6BpOOEOAUI=;
        h=From:To:Cc:Subject:Date:From;
        b=qKzF3q0UwDaurz6612AAcMaD3CizUEFgCMp2/9GG4FugPV/lByzLqOt7sUEO4aZs5
         hNrnNFcnk9GAtwzw9Fo5AxxL5dpXfIXDU2/B5hTo+mevirP1ASf2CvupQyfRrqbpvb
         Aue7vgnHK1bOAlPB0NzNDFDzuZ+ABqngF3lWJ748Ekm4Hx6413/Gu70SH9CoXdJ6jc
         ajMgwNNy6fqIPQ/3xvdh+sHJ1hBxejlATMantBS+sRnLxJDm/7zUX0kOP9Nroz6GXO
         zegoqQQk28UJ0Bvo39kLqh/irUqeUcEzE6ynbD6aSlewU6x9ak58XmHnrVSKpx4dfy
         HR3JSEcM2egoQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1otPqI-0002Tn-56; Fri, 11 Nov 2022 09:56:54 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 00/22] phy: qcom-qmp-combo: preparatory cleanups (set 2/3)
Date:   Fri, 11 Nov 2022 09:56:21 +0100
Message-Id: <20221111085643.9478-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.37.4
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

Here's a set of preparatory cleanups needed to fix the devicetree
binding and add (proper) support for SC8280XP to the combo driver but
that are otherwise self-contained.

The full series is over forty patches and I'll be posting these in three
parts of which this is the second. In an effort to get all of these into
6.2, I'll also be submitting all three series before waiting for the
previous ones to be applied.

This series specifically separates the USB and DP PHY ops
implementations, and merges the USB and DP driver data and
configurations.

Johan


Johan Hovold (22):
  phy: qcom-qmp-combo: sort device-id table
  phy: qcom-qmp-combo: move device-id table
  phy: qcom-qmp-combo: move pm ops
  phy: qcom-qmp-combo: rename PHY ops structures
  phy: qcom-qmp-combo: drop unused DP PHY mode op
  phy: qcom-qmp-combo: rename USB PHY ops
  phy: qcom-qmp-combo: drop unnecessary debug message
  phy: qcom-qmp-combo: separate USB and DP init ops
  phy: qcom-qmp-combo: rename DP PHY ops
  phy: qcom-qmp-combo: separate USB and DP power-on ops
  phy: qcom-qmp-combo: clean up serdes initialisation
  phy: qcom-qmp-combo: separate USB and DP devicetree parsing
  phy: qcom-qmp-combo: add dedicated DP iomem pointers
  phy: qcom-qmp-combo: clean up DP configurations
  phy: qcom-qmp-combo: rename sc8280xp config
  phy: qcom-qmp-combo: add DP configuration tables
  phy: qcom-qmp-combo: merge USB and DP configurations
  phy: qcom-qmp-combo: merge driver data
  phy: qcom-qmp-combo: clean up device-tree parsing
  phy: qcom-qmp-combo: clean up probe initialisation
  phy: qcom-qmp-combo: clean up PHY init
  phy: qcom-qmp-combo: clean up DP callback names

 drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 1328 ++++++++++-----------
 1 file changed, 611 insertions(+), 717 deletions(-)

-- 
2.37.4

