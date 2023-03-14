Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20E6B9212
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 12:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbjCNLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231346AbjCNLuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 07:50:46 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782BC6B30B;
        Tue, 14 Mar 2023 04:50:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32EBoXGV050742;
        Tue, 14 Mar 2023 06:50:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678794633;
        bh=8FgbK58JybAyDtGSU/0NOI0pYcGWkd9ysHycShu750M=;
        h=From:To:CC:Subject:In-Reply-To:References:Date;
        b=sRxen+dkbWG5GeZGuJy6gi8pC6y5XXErOBEs1st8qNtdh+m4GG9iZo1SrT+Dtldj6
         BT5loN739VgSNmpNtJ7fJ2XtjkSwcY1os60542oPYf8Z/gUyE1mSD5+GT8vHxMVrPc
         Ntx2muIJvTrLm8oT7ROR0lZ/rtKflxZTlZyaR2Ns=
Received: from DFLE107.ent.ti.com (dfle107.ent.ti.com [10.64.6.28])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32EBoXCL000645
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 14 Mar 2023 06:50:33 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 14
 Mar 2023 06:50:32 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 14 Mar 2023 06:50:32 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32EBoWg7108403;
        Tue, 14 Mar 2023 06:50:32 -0500
From:   Kamlesh Gurudasani <kamlesh@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <j-choudhary@ti.com>
Subject: Re: [PATCH 0/2] Add Crypto Support for J784S4 SoC
In-Reply-To: <20230313104721.407071-1-j-choudhary@ti.com>
References: <20230313104721.407071-1-j-choudhary@ti.com>
Date:   Tue, 14 Mar 2023 17:20:31 +0530
Message-ID: <87v8j3v9fc.fsf@kamlesh.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jayesh Choudhary <j-choudhary@ti.com> writes:

> This series adds the crypto node for sa2ul for j784s4 platform.
>
> First patch adds the device-id for NAVSS without which the probe
> for dma-controller fails due to 'ti,sci-dev-id' read failure.
> Second patch adds the crypto node.
>
> This series has functional dependency on j784s4 k3_soc_id[1] and
> PSIL-thread support[2] but it does not affect the boot.
>
> [1]:
> <https://lore.kernel.org/all/20230313065025.185320-1-j-choudhary@ti.com/>
>
> [2]:
> <https://lore.kernel.org/all/20230308201513.116638-1-j-choudhary@ti.com/>
>
> For testing the crypto support, crypto extra tests and self tests were
> enabled and tcrypt tests were used to verify SHA-1/256/512, AES and DES3
> algorithms.
>
> Testing log:
> <https://gist.github.com/Jayesh2000/4fe36337af6f9dc96a055359d5d6f4ca>
>
> Jayesh Choudhary (2):
>   arm64: dts: ti: k3-j784s4-main: Add 'ti,sci-dev-id' for main_navss
>   arm64: dts: ti: k3-j784s4-main: Enable crypto accelerator
>
>  arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> -- 
> 2.25.1
Both patches look good to me.

Reviewed-by: Kamlesh Gurudasani <kamlesh@ti.com>
