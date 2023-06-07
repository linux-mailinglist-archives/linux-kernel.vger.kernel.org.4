Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA28725CDC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 13:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbjFGLRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 07:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbjFGLRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 07:17:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EFAE62;
        Wed,  7 Jun 2023 04:17:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BCD163DB0;
        Wed,  7 Jun 2023 11:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DD1C433D2;
        Wed,  7 Jun 2023 11:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686136623;
        bh=8FGn7roe0ypJLHcbQ2uIfQnhmgbdqM4GY7q9Gx4ZKuk=;
        h=From:To:Cc:Subject:Date:From;
        b=a2X0ZIQpxsagDbxhmgnGmNaUc05kt63lVUMQHV5O47vDS7uaifFdAhZKtvlcWPrZK
         quUb5duTd884UDAj4rfiGEsQsYLpvDSNRyAPN0h2Ps/UxjfkXisuOKRf/oMqbVemvb
         OLDFF3rLCNpKHPtfMiyctYJwnre1c0nqswOZ4Ygvs8JgAANicQf7im+VTWRqSB9Yz/
         iXTGtUvk9wKJtZeUyp4oN4a0/LpGCR/mLCNdPl/UB8SN/YfpoSBDKefKUeO1ZkEduK
         AHvHK+xrA7e7O9jbICklu7VY60CjngTMPJNqtpN3ayZ095zu3P1JrAb3S5moWl5SVM
         iOP1CQtEFJmqg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1q6rAM-0008LQ-AV; Wed, 07 Jun 2023 13:17:26 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/2] USB: dwc3: qcom: fix NULL-deref on suspend
Date:   Wed,  7 Jun 2023 12:05:38 +0200
Message-Id: <20230607100540.31045-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some dwc3 glue drivers are currently accessing the driver data of the
child core device directly, which is clearly a bad idea as the child may
not have probed yet or may have been unbound from its driver.

This series fixes some of the symptoms of these layering violations as
fixing the glue drivers properly is going to take a fair bit of work.

Johan


Johan Hovold (2):
  USB: dwc3: qcom: fix NULL-deref on suspend
  USB: dwc3: fix use-after-free on core driver unbind

 drivers/usb/dwc3/core.c      |  5 +++++
 drivers/usb/dwc3/dwc3-qcom.c | 11 ++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

-- 
2.39.3

