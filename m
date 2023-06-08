Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A31072802D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbjFHMhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjFHMh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:37:28 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20FA7E62
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 05:37:26 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-256422ad25dso283503a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 05:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686227845; x=1688819845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vF7BJHmnxG54wdpwiHNjVAE0LjJI9FuEL9uTFxii16I=;
        b=Aiihaxqbz67spa16+ZNOJjy54FXq89dppdCCz9Lcbhkd1yMhtCvLFtvwjOBywkj95T
         gZo1sybXE7ojr4Mpm+2zdshpW7LLYICvQXmckN7RsoPdmf+ajw2t3ShsnENqNzpyL0jc
         n3TUh5i2XOfPD9zSWWou5wq+rd5FQ9VRL/C5w0rT/oHrYuFtHyXO9VEqP600FaiZQNuC
         wvmkXmP6rYdrESm3zrPXrqjiXGjz+GD/R64YTsoi8kCuMzvm2d6lZHjPGm2UhG/xAV+Q
         N001B3KB1Yv8ywbvOgjN8qmr29lrg22Q+MsgF2mpA+k/RfVRIPRwxwrcWXqgvDa+MZkx
         FjOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686227845; x=1688819845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vF7BJHmnxG54wdpwiHNjVAE0LjJI9FuEL9uTFxii16I=;
        b=Kfc57/2FMSB/bxuaxoLOOiG9sLSXQWLzC81gm6+9l1Hj98KT+YjPPULAsPQBj2xMZ7
         UWte1il7TPtY76O6fny++7Fi1LdCAZo2PVh92f2vpNq+y1DM/lxej1NwoWcwBVW18Xk6
         4cGHLob/Hq+x6HtEcxGkvX3XvwlcXV1zUQSXGIz9N/vbMZpEnTw5CQjmW9ZiCH4Fyc8J
         /GD7ZH+gHD8/GL89ZotC27KQN2ohXVtvA/eWtsd12/dajlvI6c5mkLq6r2HoRs7/ddk7
         /fXCGuqx4zoTE/03NRTJUm2+iqask27k9o+l+wG6FIwCK014KJ1Uvxyxk0htD+OelzvS
         6lcQ==
X-Gm-Message-State: AC+VfDyG30gDFWYmBqyUyfDTtecUXwn/EPFoxomcbL6PpEFnUjGDrubI
        etMsq5qrsuAikkdaMccf/bgg
X-Google-Smtp-Source: ACHHUZ6tZyhqvp7cqUQlsZZN44LfD6nkDhNPmbUYwX0UZxMiBiudwS0spmZHcsUdiFOa9lkqBcSCYg==
X-Received: by 2002:a17:90a:fa42:b0:259:e35f:ab2e with SMTP id dt2-20020a17090afa4200b00259e35fab2emr1853190pjb.4.1686227845577;
        Thu, 08 Jun 2023 05:37:25 -0700 (PDT)
Received: from thinkpad ([117.202.186.138])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090a19d600b0024c1ac09394sm1288861pjj.19.2023.06.08.05.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 05:37:25 -0700 (PDT)
Date:   Thu, 8 Jun 2023 18:07:20 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        loic.poulain@linaro.org
Subject: Re: [PATCH v2 0/2] Add MHI Endpoint network driver
Message-ID: <20230608123720.GC5672@thinkpad>
References: <20230607152427.108607-1-manivannan.sadhasivam@linaro.org>
 <20230607094922.43106896@kernel.org>
 <20230607171153.GA109456@thinkpad>
 <20230607104350.03a51711@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230607104350.03a51711@kernel.org>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 10:43:50AM -0700, Jakub Kicinski wrote:
> On Wed, 7 Jun 2023 22:41:53 +0530 Manivannan Sadhasivam wrote:
> > > In any case, I'm opposed to reuse of the networking stack to talk
> > > to firmware. It's a local device. The networking subsystem doesn't
> > > have to cater to fake networks. Please carry:
> > > 
> > > Nacked-by: Jakub Kicinski <kuba@kernel.org>
> > > 
> > > if there are future submissions.  
> > 
> > Why shouldn't it be? With this kind of setup one could share the data connectivity
> > available in the device with the host over IP tunneling. If the IP source in the
> > device (like modem DSP) has no way to be shared with the host, then those IP
> > packets could be tunneled through this interface for providing connectivity to
> > the host.
> > 
> > I believe this is a common usecase among the PCIe based wireless endpoint
> > devices.
> 
> We can handwave our way into many scenarios and terrible architectures.
> I don't see any compelling reason to merge this.

These kind of usecases exist in the products out there in the market. Regarding
your comment on "opposed to reuse of the network stack to talk to firmware", it
not the just the firmware, it is the device in general that is talking to the
host over this interface. And I don't see how different it is from the host
perspective.

And these kind of scenarios exist with all types of interfaces like usb-gadget,
virtio etc... So not sure why the rule is different for networking subsystem.

- Mani

-- 
மணிவண்ணன் சதாசிவம்
