Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A0C69A6B3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjBQIPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:15:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjBQIPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:15:03 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964D430B03
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:15:01 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id a12so259170wro.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:15:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1676621700;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+UgwFxSgxIJILWARrs481ZAdhvNlwcsdh1EkJyq83tI=;
        b=dkym0gOtjXISIIA2/js32L75SO6xjqrglvsxLv/RBeJiFim3ybeD/erVkoEv/wyia9
         ce6kNP9RbzYLozqRABCQ9xLUWPjRoojC1Op+MdNAiAsb5plyH4qtBXI+tOl+n3qkncRC
         jjlUcRunVW57kAfTHx4yN0tMmkLYGIqdCc/Hg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676621700;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+UgwFxSgxIJILWARrs481ZAdhvNlwcsdh1EkJyq83tI=;
        b=JD3egqheXPjfyXhiT9RBHrW7v406Oy4PvqXkQ84o3lzbhr3a3cmu+0xQQSSDh9s+wd
         SpxhqVO4H1Kshvhl4FPT9pr7KLXQMaNGyqoojn0GCQIM1M6YtHE5PYDVhuiQHHydmqSR
         bJ/NvW10vCZ1StLRKyRDn+vA2+6rQ2TpsO8uAjqh1EqDvzIEcyXbBBsD9FvuQVuUsHsU
         zaShtw70WZWt2ZYfYzfySGxzZ7GYJqnwQbMdez3A3/tUqlelqPQVEVzp9ooSxwxPBF4u
         dkoWuSHO6rm54cdfE5C480waVObupTx2z05QMlKGz93lHkCgoZLw7x2VeFFKwk00wFAu
         FcdA==
X-Gm-Message-State: AO0yUKVIcWD1SwlTAiFOSZW8m9iCFHvjyc12oQV/xaDa15/7dRfjhid5
        +PPVZL7MkZR0enr1InvNXTm3cQ==
X-Google-Smtp-Source: AK7set/PS5/nY+BFhQH71PSQXsx7Wf1XHZSWVqvTIw/BCFEWkDz18d7IDx3eDBBtiLOZp1mWnvrAgA==
X-Received: by 2002:a5d:438e:0:b0:2c5:8b8d:e5df with SMTP id i14-20020a5d438e000000b002c58b8de5dfmr3071212wrq.1.1676621699993;
        Fri, 17 Feb 2023 00:14:59 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a8-20020a5d5088000000b002c567881dbcsm3518647wrt.48.2023.02.17.00.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 00:14:59 -0800 (PST)
Date:   Fri, 17 Feb 2023 09:14:52 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, neil.armstrong@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] gpu/drm/panel: Add Sony TD4353 JDI panel driver
Message-ID: <Y+83fOHFK2qPXP1S@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        neil.armstrong@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org,
        marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230119163201.580858-1-konrad.dybcio@linaro.org>
 <20230119163201.580858-2-konrad.dybcio@linaro.org>
 <725a5727-fdde-e3ae-a448-2679c5c4c7f4@linaro.org>
 <CAKMK7uFpc3Kg=Ym6ee_JTZo-0h2ig7Twtf2uwE7oV-1c6YRP=Q@mail.gmail.com>
 <8ab061aa-a2fa-3070-a756-5682eb40a425@linaro.org>
 <CAKMK7uHd7Lefc+ZjvuHtrttkQFYDF8XSsKUV2gfGs9=cw1GTKw@mail.gmail.com>
 <Y+6UHxHaiF6Aw4du@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+6UHxHaiF6Aw4du@ravnborg.org>
X-Operating-System: Linux phenom 5.19.0-2-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 09:37:51PM +0100, Sam Ravnborg wrote:
> On Thu, Feb 16, 2023 at 01:49:23PM +0100, Daniel Vetter wrote:
> > On Thu, 16 Feb 2023 at 13:47, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> > >
> > > On 16/02/2023 13:32, Daniel Vetter wrote:
> > > > On Thu, 16 Feb 2023 at 12:59, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> > > >>
> > > >>
> > > >>
> > > >> On 19.01.2023 17:32, Konrad Dybcio wrote:
> > > >>> From: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > >>>
> > > >>> Add support for the Sony TD4353 JDI 2160x1080 display panel used in
> > > >>> some Sony Xperia XZ2 and XZ2 Compact smartphones. Due to the specifics
> > > >>> of smartphone manufacturing, it is impossible to retrieve a better name
> > > >>> for this panel.
> > > >>>
> > > >>> This revision adds support for the default 60 Hz configuration, however
> > > >>> there could possibly be some room for expansion, as the display panels
> > > >>> used on Sony devices have historically been capable of >2x refresh rate
> > > >>> overclocking.
> > > >>>
> > > >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
> > > >>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > > >>> Reviewed-by: Marijn Suijten <marijn.suijten@somainline.org>
> > > >>> ---
> > > >> Are there any outstanding issues with this driver, or perhaps I did
> > > >> not CC some important list? It has gotten very little activity ever
> > > >> since its initial submission around Sept'22..
> > > >
> > > > Sam is usually picking up panel drivers these days, but maybe we need
> > > > a bit more help in this area? If anyone from linaro has a handful of
> > > > drm patches landed in upstream they could apply for drm-misc commit
> > > > rights and help push these. I think linaro has lost a few of the
> > > > drm-misc committers so things tend to be stuck a bit more :-/
> > >
> > > I usually wait for Sam to comment before applying my panel patches drivers to drm-misc-next,
> > > but yeah panels would need some more help...
> > >
> > > If needed I can add myself to the panel drivers maintainance aswell.
> > 
> > I think that would be great, maybe just send out the MAINTAINERS patch
> > and ask Sam to ack?
> 
> That would be great, and I am more than happy to ack it.
> According to MAINTAINERS Thierry is the panel maintainer and I am reviewer.
> So you should ask Thierry to ack it too.

Tbh with the commit right model the difference between reviewer/maintainer
is kinda not there, and I think Thierry's entry simply goes back to the
time drm-panel was still a separate git tree. But yeah more acks doesn't
hurt.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
