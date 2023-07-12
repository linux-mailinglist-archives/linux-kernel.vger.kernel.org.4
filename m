Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DBD27505A1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 13:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjGLLJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 07:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjGLLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 07:09:49 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55DC01703
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:09:48 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8b4749013so50317665ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 04:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689160188; x=1691752188;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbKFLGGxnO5TsvoMTajzHD0NXptuvXCtrTMuAdwT1mY=;
        b=XXLfuSnhT9hjGYE+SPfEcjSdPv40QUS+tTjfpr6MX/dToYh9QpBQ/kyZv/5PnHxqRG
         AzwfrV87nVqIpApe8T+59F5ngK1reElykSPE0NVp46eTotAVpfcpxnZfGQ8NWjNXVPi1
         No627XMUFrkD0+FBRViBI4zuRa9wOezxXq/qI5EFJgd5LZXuwjWgNjBx4JqoaHvvLIMy
         miVDRnNK4LRl+SmdevpV69x5nGiH7sU9UxlYxaAfIKEkfY3WkmhBpGO4GRSCTwlQhGUA
         EBPEp9+jxMDfmMimgIMUVCQqdDDSA/2Jx9jQhmgEpaIZ7pQXnGh/6aZInncrG32LM+5p
         Yxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689160188; x=1691752188;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbKFLGGxnO5TsvoMTajzHD0NXptuvXCtrTMuAdwT1mY=;
        b=ISy0grWXbrfjNFNzr2y5zPx9RClCrvGams7u/ggJhsbpaGytwhixd59PTcSJ3SP79i
         9YNgPLUeMuzXJTzHE8ssd92X3T2ThXL7Zqvc6t2k9lChrYiDR2s468X0UxaBySQHskU6
         hJjI1sQfwpyBfSZNpAEl0es79QUpe45Ugf1fu6OHZC6khaAITY+mHgnpNAIe7gS6YVFX
         DuhgI9Wgi9LxJt4GFvJXsDU+uf08hrVrDydrX/OLO5mnS4jX6I8a19zYXM9V/2SjCdr9
         k4K6MqI+H1vBPau5+BVRHMExOkjmoiKvegYqCHvQFCwKOvWjZlNgNIJAfDA68Z0Pjzip
         EtDw==
X-Gm-Message-State: ABy/qLYNSNrKqR3Ft8V2LvOWXecRRARRhKP5gPKoH+kFNtwz0MPNiI5P
        JDVd5IXnlNS5S92SymYYbNqWzg==
X-Google-Smtp-Source: APBJJlEkj+4MqB2CPiTfqApDhEK6QrNrJLvp3vE6L50wX4eg7NswLMhoNs9Gwav0qsQEF28PHRA1CQ==
X-Received: by 2002:a17:903:11c8:b0:1b8:3601:9bf7 with SMTP id q8-20020a17090311c800b001b836019bf7mr22217656plh.24.1689160187849;
        Wed, 12 Jul 2023 04:09:47 -0700 (PDT)
Received: from hsinchu16 (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709027b8f00b001b9df74ba5asm3674375pll.210.2023.07.12.04.09.45
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jul 2023 04:09:47 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:09:43 +0800
From:   Eric Lin <eric.lin@sifive.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, vincent.chen@sifive.com,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Message-ID: <20230712110908.GA23216@hsinchu16>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
 <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
 <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
 <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 01, 2023 at 10:22:25AM +0200, Krzysztof Kozlowski wrote:
> On 28/06/2023 18:31, Eric Lin wrote:
> 
> >>>>
> >>>>> +      - enum:
> >>>>> +          - sifive,pL2Cache0
> >>>>> +          - sifive,pL2Cache1
> >>>>
> >>>> What is "0" and "1" here? What do these compatibles represent? Why they
> >>>> do not have any SoC related part?
> >>>
> >>> The pL2Cache1 has minor changes in hardware, but it can use the same
> >>> pl2 cache driver.
> >>
> >> Then why aren't they compatible?
> >>
> > 
> > The pL2Cache1 has removed some unused bits in the register compared to
> > pl2Cache0.
> > From the hardware perspective, they are not compatible but they can
> > share the same pl2 cache driver in software.
> 
> So they are compatible... If they were not compatible, you wouldn't be
> able to use the same match in the driver.
> 
> > Thus, we would like to keep both. It would be great if you can provide
> > some suggestions. Thanks.
> 
> I propose to make them compatible, like every other piece of SoC. I
> don't see any benefit of having them separate.
> 

Hi Krzysztof,

Sorry for the late reply.
The pl2 cache is our internal platform IP and is not part of any SoC. 

The reason why this driver is compatible with the hardware "pl2cache0" and hardware "pl2cache1"
is that it doesn't program the different parts of the config register
However, our internal software (e.g., bare-metal software) will program these different parts,
so it needs to rely on the different compatible string to identify the hardware.
  
Additionally, we would like the compatible strings to reflect which hardware is being used Thanks.

Best regards,
Eric Lin

> Best regards,
> Krzysztof
> 
