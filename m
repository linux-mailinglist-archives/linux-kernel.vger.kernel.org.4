Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88D672803B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:41:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236282AbjFHMlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjFHMlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:41:04 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB85E43
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:41:03 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5440e98616cso1218703a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686228062; x=1688820062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o6uvPLwieY5RkBOZk+PD7M8YvflhokrnPtugOrS3QNE=;
        b=Mx3sJVE2F1ORzjGqe3xy6X7wsCEApK1+VCCgRvjXycaGUApi2Tp0szjSn8M0PPbOrY
         L6ZT2JbB809hrtAlSMLtJWgI0nHKoi/twmYAH9M+c9GMxpGAo8IGutngAyddmrMKefPf
         RCBU4mnCL8+y9Yt8bpiSs2ZXdu8RQpYfL+zv2Gdo/ZaxOJSXFBTVqBrjamKKAnk98XpL
         A7o0ukDCFy0RxCHOvs0/9rVuq8Zu9N2PmEmZ1tpwMEr4hiD84QamxF/SauHaF9MhLS8B
         H5kQh9NyXsLSH3lUag3Ko/bg3fjlMsun8spM10a3OnrUJn+QiGsJ/VHlyT4g7Qu0l+ww
         rEGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686228062; x=1688820062;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o6uvPLwieY5RkBOZk+PD7M8YvflhokrnPtugOrS3QNE=;
        b=b7qnQZHKQs2rCGk2Ki+65mVLruLUN8S684qTkdee1QKET+cRemuua+C2S67z6vR6l3
         9wIgz7nIWC2tAvX4+orYfWtmf2YC2oAcVO7SZfEa8yeA8p58EfthcMgaV9azB0R7hhsi
         PodSlCw1BhHuyWXH4+usqVXI5/Auyo3nJln7iVuaEINRyPbRA8+E7qvG44WuEM6Jcb+e
         nUOLepMnhgajCLu9vs5og7mz6Jm5hF/CkuQyZaF20iQVXaCUogHgHkpMbdLQBoOGshCh
         fUmxQONgSEs3o9RbApoaIIEbfKJDQtlChp5h75c/676FeKHnnW6dF63Ln9bHMWWrLpsE
         sYdQ==
X-Gm-Message-State: AC+VfDxnnjlVCmXvazHNSSiHOoFbr36/n0mT34YJAyV8pAmjnRW3i4+Y
        KvDH2zTgyh/sxLgJvCvRB4tO
X-Google-Smtp-Source: ACHHUZ5poAB/V7RXQ3dOzoAJckBX+G4y1Bj7UJT9KsKdnWi22t9GzGjV2GyemH6S7dwhra7PXiL1qQ==
X-Received: by 2002:a17:90b:314c:b0:25b:83ca:2b75 with SMTP id ip12-20020a17090b314c00b0025b83ca2b75mr176896pjb.3.1686228062475;
        Thu, 08 Jun 2023 05:41:02 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a01de00b00259a3c99978sm1285622pjd.17.2023.06.08.05.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:41:02 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:10:57 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20230608124057.GD5672@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org>
 <eb4b45ab-1f51-47e9-a286-a9e26461ebed@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb4b45ab-1f51-47e9-a286-a9e26461ebed@lunn.ch>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:13:32PM +0200, Andrew Lunn wrote:
> On Wed, Jun 07, 2023 at 09:49:22AM -0700, Jakub Kicinski wrote:
> > On Wed,  7 Jun 2023 20:54:25 +0530 Manivannan Sadhasivam wrote:
> > > This series adds a network driver for the Modem Host Interface (MHI) endpoint
> > > devices that provides network interfaces to the PCIe based Qualcomm endpoint
> > > devices supporting MHI bus (like Modems). This driver allows the MHI endpoint
> > > devices to establish IP communication with the host machines (x86, ARM64) over
> > > MHI bus.
> > > 
> > > On the host side, the existing mhi_net driver provides the network connectivity
> > > to the host.
> > 
> > Why are you posting the next version before the discussion on the
> > previous one concluded? :|
> > 
> > In any case, I'm opposed to reuse of the networking stack to talk
> > to firmware. It's a local device. The networking subsystem doesn't
> > have to cater to fake networks. Please carry:
> > 
> > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Remote Processor Messaging (rpmsg) Framework does seem to be what is
> supposed to be used for these sorts of situations. Not that i know
> much about it.
> 

Rpmsg is another messaging protocol used for talking to the remote processor.
MHI is somewhat similar in terms of usecase but it is a proprietary protocol
used by Qcom for their devices.

- Mani

>      Andrew

-- 
மணிவண்ணன் சதாசிவம்
