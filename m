Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D158733F16
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 09:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbjFQHQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 03:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbjFQHQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 03:16:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93375C5;
        Sat, 17 Jun 2023 00:16:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D2E61120;
        Sat, 17 Jun 2023 07:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6C6C433C0;
        Sat, 17 Jun 2023 07:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686986206;
        bh=SXMxzkupl69XgQE1gIRNMtbifDnHxKajI1lVuAlonhI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pR9bjbOFinCB4jeZ+6kRKbxOCYZNNR4jPikGiYb/Q5EDZK7KRVBI+lFOSVwqD8w5Q
         vzg3xmAjpYJg2W3sDGRBzkh90n734ANb7DUTsjNAXsziVxxtbndq+3S+dDcnvzsafD
         7OVzrKCUKz+syiDlVQyu2xeffY/I46oS04G1wbKcuaKW4pPMzK1WJhuDZydpaeGGoI
         r0PErEKExgQj0AkaSJ7EyT5HW8TcZTP7eRzXFB3iomZs8i0Z4bcAgBKeNo7xfq+tli
         cT0NiW5cXDq1orS53xzviD4aONKfYKtwZMq3cfxGV64NOK/Nby6JO9MAyr5nxuNPRV
         WuHcOk04Oh2aA==
Date:   Sat, 17 Jun 2023 00:16:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 00/23] arm64: qcom: sa8775p-ride: enable the first
 ethernet port
Message-ID: <20230617001644.4e093326@kernel.org>
In-Reply-To: <20230615121419.175862-1-brgl@bgdev.pl>
References: <20230615121419.175862-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jun 2023 14:13:56 +0200 Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> There are three ethernet ports on sa8775p-ride. This series contains changes
> required to enable one of the two 1Gb ports (the third one is 10Gb). We need
> to add a new driver for the internal SerDes PHY, introduce several extensions
> to the MAC driver (while at it: tweak coding style a bit etc.) and finally
> add the relevant DT nodes.

Did I already ask you how do you envision this getting merged?
You have patches here for at least 3 different trees it seems.
Can you post the stmmac driver changes + bindings as a separate series?

>  drivers/phy/qualcomm/phy-qcom-sgmii-eth.c     | 451 ++++++++++++++++++

Noob question - what's the distinction between drivers/phy and
drivers/net/phy (or actually perhaps drivers/net/pcs in this case)? 
