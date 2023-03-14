Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4196B88F2
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 04:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjCNDZI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Mar 2023 23:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjCNDZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 23:25:01 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E26888A4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 20:24:42 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id A38DC24E359;
        Tue, 14 Mar 2023 11:24:40 +0800 (CST)
Received: from EXMBX167.cuchost.com (172.16.6.77) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 11:24:40 +0800
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX167.cuchost.com
 (172.16.6.77) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 14 Mar
 2023 11:24:40 +0800
Received: from EXMBX068.cuchost.com ([fe80::90c7:30cd:8828:91f7]) by
 EXMBX068.cuchost.com ([fe80::90c7:30cd:8828:91f7%16]) with mapi id
 15.00.1497.044; Tue, 14 Mar 2023 11:24:39 +0800
From:   JiaJie Ho <jiajie.ho@starfivetech.com>
To:     Hillf Danton <hdanton@sina.com>
CC:     Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH v3 4/4] crypto: starfive - Add hash and HMAC support
Thread-Topic: [PATCH v3 4/4] crypto: starfive - Add hash and HMAC support
Thread-Index: AQHZVbQZd9+lAcQFW0yunvw0rKV1eK7440YAgAC0knA=
Date:   Tue, 14 Mar 2023 03:24:39 +0000
Message-ID: <a00427747c094f16acc78b536508bd16@EXMBX068.cuchost.com>
References: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
 <20230314001744.1911-1-hdanton@sina.com>
In-Reply-To: <20230314001744.1911-1-hdanton@sina.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On 13 Mar 2023 21:56:46 +0800 Jia Jie Ho <jiajie.ho@starfivetech.com>
> > +static int starfive_hash_xmit_dma(struct starfive_cryp_ctx *ctx) {

[...]
> > +	dmaengine_slave_config(cryp->tx, &cryp->cfg_in);
> > +
> > +	in_desc = dmaengine_prep_slave_sg(cryp->tx, rctx->in_sg,
> > +					  rctx->in_sg_len,
> DMA_MEM_TO_DEV,
> > +					  DMA_PREP_INTERRUPT  |
> DMA_CTRL_ACK);
> > +
> > +	if (!in_desc)
> > +		return -EINVAL;
> > +
> > +	reinit_completion(&cryp->tx_comp);
> 
> What breaks without reinit?

Hi Hillf, 
So far, I don't see errors without the reinit.
I kept the reinit to reset the done field in case there is a prior transfer.
I'll remove this if it is not needed.

> > +
> > +	in_desc->callback = starfive_hash_dma_callback;
> > +	in_desc->callback_param = cryp;
> > +
> > +	cookie = dmaengine_submit(in_desc);
> > +	dma_async_issue_pending(cryp->tx);
> > +
> > +	if (!wait_for_completion_timeout(&cryp->tx_comp,
> > +					 msecs_to_jiffies(10000))) {
> > +		dev_err(cryp->dev, "wait_for_completion_timeout error,
> cookie = %x\n",
> > +			dma_async_is_tx_complete(cryp->rx, cookie,
> > +						 NULL, NULL));
> 
> What prevents wakeup from coming in case of timeout?

Usually, timeout is caused by failure to complete all data transfer.
It might be due to errors in dma chan setup or in case the hardware hangs.

Thanks for taking time looking into the patch.

Best regards,
Jia Jie
