Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F105F3F2D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 11:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230451AbiJDJHg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 05:07:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJDJH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 05:07:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D8F3ED5D;
        Tue,  4 Oct 2022 02:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1664874442; x=1696410442;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NSUQY5nVgXC5NaPWE9HMRTlZB17OmXxjLCXe6g6c7jU=;
  b=xp5SHFvAcZA6Me4K1g4V3/GKx+sGemMjy7xqZb3b9dO5MhVi+tIlIpam
   s8tTZgJLIxvSSeHRu3qlVTqw8LaIqIgjxs8RRMILQOPY+QA99T5pdXX6F
   lACW2wc9UDNtqzz36lFd4RT4XVlfH1pUkLEgfSEr87/WFzCFCTy9JRls6
   M0Wq2tdiSNIK9lCHY5U+EuQtK7+IbfVvP7TzrGw8Bs86KVJq2l+lpq37Y
   JgabYqqxl1bxBq1s2IdxIcVCp9zNWtxB5UdPh1A8GE4+MMz6lxtywEX1k
   li5jfk8su/19tuqfYCAs84x9WNmr8W0ze7HkONlAXfiV0sVESk1LD9HuI
   g==;
X-IronPort-AV: E=Sophos;i="5.93,367,1654585200"; 
   d="scan'208";a="180252842"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2022 02:07:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 4 Oct 2022 02:07:21 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.12 via Frontend
 Transport; Tue, 4 Oct 2022 02:07:21 -0700
Date:   Tue, 4 Oct 2022 11:11:53 +0200
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <p.zabel@pengutronix.de>
Subject: Re: [PATCH -next v2 1/2] pinctrl: ocelot: add missing
 destroy_workqueue() in error path in ocelot_pinctrl_probe()
Message-ID: <20221004091153.eag6watgujngeows@soft-dev3-1.localhost>
References: <20220917024634.1021861-1-yangyingliang@huawei.com>
 <CACRpkdZdv2ATT8yTGKomXAUq5Pnkcex3Az4prVQVv87BTPs=CQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <CACRpkdZdv2ATT8yTGKomXAUq5Pnkcex3Az4prVQVv87BTPs=CQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 10/04/2022 09:09, Linus Walleij wrote:

Hi Linus,

> 
> On Sat, Sep 17, 2022 at 4:39 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
> 
> > Add the missing destroy_workqueue() before return from ocelot_pinctrl_probe()
> > in error path.
> >
> > Fixes: c297561bc98a ("pinctrl: ocelot: Fix interrupt controller")
> > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > ---
> > v2:
> >   move alloc_ordered_workqueue() after ocelot_pinctrl_register().
> 
> Horatiu does this v2 look like you want it? Reviewed-by?

I have noticed that Yang has sent another version (v3)[1] where he makes
uses of devm_add_action_or_reset.

[1] https://lore.kernel.org/all/20220925021258.1492905-1-yangyingliang@huawei.com/T/

> 
> Yours,
> Linus Walleij

-- 
/Horatiu
