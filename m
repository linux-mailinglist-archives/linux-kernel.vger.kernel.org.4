Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAD8740AB5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 10:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjF1IKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 04:10:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjF1IGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:06:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97EF198;
        Wed, 28 Jun 2023 01:04:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 93DF46133B;
        Wed, 28 Jun 2023 07:49:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7511C433C9;
        Wed, 28 Jun 2023 07:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687938552;
        bh=dMPfHf1WanGtgCkRNc8s8fHX9o1lxEd1S+vhVrf+Rnw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vf3GvOxHmfc3IrUcippeNuf03xnie0Mv5V8E68+tdrTgldOp6komTU/du8m++Pyvy
         i8jKQIMHjT6+RsN34VeCnijjWgW+/d+SXvpSrLJu/QLaVnHq7FHglUdys/F4keGBUV
         VF3bjmXqZsmRIPI7RxGJdMUE4geXAqcV8fRnA4ZiTl/4Xlt6Q3QmThCSauvSS47L7G
         FC01+rj18oglpwyP7oDaHHyBBh1KUdh8bqxBANMj0T4cKb2qGpyKLHqSl4j5GS4/sl
         ZsWgM6Y40afoAYLt9rUhWWYpRN/qS+xQassT+goLTArPu/XiDhULhadHd1ahCidf3j
         RqWoL9A+pvXFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1qEPvM-0002XF-2g; Wed, 28 Jun 2023 09:49:12 +0200
Date:   Wed, 28 Jun 2023 09:49:12 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Marko <robimarko@gmail.com>,
        Das Srinagesh <quic_gurus@quicinc.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 0/2] Hook up 8280 SCM icc
Message-ID: <ZJvl-J4aQQozown1@hovoldconsulting.com>
References: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622-topic-8280scmicc-v1-0-6ef318919ea5@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 05:56:14PM +0200, Konrad Dybcio wrote:
> The icc handle for SCM was missing on 8280. Add it.

> Konrad Dybcio (2):
>       dt-bindings: firmware: qcom,scm: Allow interconnect on SC8280XP
>       arm64: dts: qcom: sc8280xp: Add missing SCM interconnect

Appears to work and matches the vendor dts, but no sign of any
"performance benefit" as mentioned in 65b7ebda5028 ("firmware: qcom_scm:
Add bw voting support to the SCM interface") during fw load at boot.

Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
Tested-by: Johan Hovold <johan+linaro@kernel.org>

Johan
