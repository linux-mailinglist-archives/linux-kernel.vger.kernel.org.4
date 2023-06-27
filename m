Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621D073FF8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:19:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbjF0PT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjF0PTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:19:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCBC1735;
        Tue, 27 Jun 2023 08:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1D7F611B5;
        Tue, 27 Jun 2023 15:19:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2B3C433C0;
        Tue, 27 Jun 2023 15:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687879187;
        bh=lVWplkh8U/rtw5laIs2YyXP5mG+eDZDGoYnqUxrwS4k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q5TmZ6xn2YYy+K9DIrVHxqng95klWdB7m7T0I7jI0pQvvfRJz5uMHDViWO7XvrlsF
         Hj7sfUIBs5Akk20UnTLPHTioO+9ePGKg8NMROhhpEaWjfl+Ay52mbUj1ugXMozx4OL
         pviPLrMhe6A+Rl4KN3mRU/qbs4JO+6Fhahewp7YYvsi3tQ19ThP8B6yTFjWMYKs2w+
         ZCSz3khQctEd5g5mKNHHfhFV6AJaHz/3+m1VQfXt+PbmutlT5/6+OyzPGo0QNFhiqH
         2hIUIThRVt0P87xykwgEY0Aj7nxEvBnZfUZr6W5vOHHcjNyxeyNt2e5v/5YIisoyEc
         PN/YHbBaTbdug==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEATp-00046p-3i; Tue, 27 Jun 2023 17:19:45 +0200
Date:   Tue, 27 Jun 2023 17:19:45 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, quic_harshq@quicinc.com,
        ahalaney@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH v9 00/10] Add multiport support for DWC3 controllers
Message-ID: <ZJr-EbunGzNopVj0@hovoldconsulting.com>
References: <20230621043628.21485-1-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621043628.21485-1-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:06:18AM +0530, Krishna Kurapati wrote:
> Currently the DWC3 driver supports only single port controller which
> requires at most two PHYs ie HS and SS PHYs. There are SoCs that has
> DWC3 controller with multiple ports that can operate in host mode.
> Some of the port supports both SS+HS and other port supports only HS
> mode.
> 
> This change primarily refactors the Phy logic in core driver to allow
> multiport support with Generic Phy's.
> 
> Chananges have been tested on  QCOM SoC SA8295P which has 4 ports (2
> are HS+SS capable and 2 are HS only capable).
> 
> Changes in v9:
> Added IRQ support for DP/DM/SS MP Irq's of SC8280
> Refactored code to read port count by accessing xhci registers
> 

You obviously did many more changes in v9. Please amend this list for v9
and be more specific when submitting v10.

Johan
