Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB26603E59
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiJSJNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiJSJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:10:29 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D43CC2CBD
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:02:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id q9so15662768pgq.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 02:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=W82ENRi/vWm2336iUxijeBhhPjgIoPANGK5XokAwjLM=;
        b=AfZbhz6SL2hrtwh9lZFyL6cCLHpURECSAaG31B/o5dwTITxUgeqQidPyFMafuRAWzE
         2iKiwoQbLrrjGZBvRWNh6Q2r5yw1rl8E9+ISOzb8HQoqAPVKj53pDitXacv83EUhtfAo
         vO5oHmi8u17MiKlbizxhlEi/6X5Vr0lZwDwSQKhRbz/sOUsfKMxKUd3ox3TN0DWx0rTK
         T34VJ43DFjRpB/1/4nc2GEEppkiicx08BXBc8Nu6cS0vppBBYDdWeZb8YCUc5gy+fr+v
         dM4vMHpq2Gj/aRctQOJakIAx0GdXlmnGVwoo+mpDA2+/Q7sKolagnWGvmaICH7/nzu4Q
         ad4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W82ENRi/vWm2336iUxijeBhhPjgIoPANGK5XokAwjLM=;
        b=PXOj+Y6Up9Wh6vMyodE1mNdp8A6SdZZtCv9MEvO9fZaE4PNIPUWwuStkrNap7uzP+J
         eaM4AIYnSI8i2rXmaDzzcq6aIXIUkqBH1rqO+9fT/WFQdUOc204TJIZ1FaKSt6WeC2c7
         0xUr5pcBw1MPsloJTyivyMN5XTDEyuTowpm42/odCZiZfO+hMxe6FDbCfLSdxV1KL8n9
         VAL+KVGQFJGw1Qzskj36XL8P032Uixg0YKfXNSFlVYufxnULI+Ggpb0+QIKcWekckIdR
         a66NwmoKYmyN72Aaz1PfE3uFM6ehkH18RLEr+BotkMEJxkwqo/MXJh6O/4rBlC2y5031
         421A==
X-Gm-Message-State: ACrzQf3eVuROVyy4eWoPPpAu4W6cEfKZKE4cdcUmpLcWKz6NNJ3o9yH4
        1d6gJSY1NhTK4XlubYMIhPktrNVzzMyAn9faI5A=
X-Google-Smtp-Source: AMsMyM6RTDhb7E9g5FHm/PpzD9A77KswvYCfiS1Xl0yUhM+9dmkn3sZYwkY9aT6Vn0KQgnkycF0OCA==
X-Received: by 2002:a63:a06:0:b0:458:2853:45e4 with SMTP id 6-20020a630a06000000b00458285345e4mr6175346pgk.20.1666169491395;
        Wed, 19 Oct 2022 01:51:31 -0700 (PDT)
Received: from leoy-huanghe.lan (211-75-219-199.hinet-ip.hinet.net. [211.75.219.199])
        by smtp.gmail.com with ESMTPSA id t16-20020a170902e85000b00179eaf275d5sm10278662plg.27.2022.10.19.01.51.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Oct 2022 01:51:30 -0700 (PDT)
Date:   Wed, 19 Oct 2022 16:51:25 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v9 02/13] perf test: Add build infra for perf test tools
 for CoreSight tests
Message-ID: <Y0+6jbL1oC4jk8Ja@leoy-huanghe.lan>
References: <20220909152803.2317006-1-carsten.haitzler@foss.arm.com>
 <20220909152803.2317006-3-carsten.haitzler@foss.arm.com>
 <Yz67SHpIN5NggKEk@kernel.org>
 <Yz6/zlchVnNsVlzJ@kernel.org>
 <Yz7RAgMN6WGnD3OZ@leoy-yangtze.lan>
 <e9f980a7-fba8-4610-a058-b74e51d6ab24@foss.arm.com>
 <Y0AfK7sVphNkQA4q@kernel.org>
 <0b3afc5d-c4a1-8a50-45c3-20c706c3ecfd@foss.arm.com>
 <Y0QkIjO4pvPuzeMB@kernel.org>
 <9f2d2032-8859-4388-489a-ba5cd2cee432@foss.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f2d2032-8859-4388-489a-ba5cd2cee432@foss.arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 09:11:20AM +0100, Carsten Haitzler wrote:
> 
> 
> On 10/10/22 14:54, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Oct 10, 2022 at 08:02:29AM +0100, Carsten Haitzler escreveu:
> > > On 10/7/22 13:44, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Oct 07, 2022 at 12:34:51PM +0100, Carsten Haitzler escreveu:
> > > > > On 10/6/22 13:58, Leo Yan wrote:
> > > > > oh sorry - indeed i didn't see this problem coming after fixing the
> > > > > conflicts. i've got an update of the patches that fix that. should i just
> > > > > send through the 2 updates patches as a v10 or the whole series?
> > 
> > > > No need, I did some fixes taking into account the comments on this
> > > > thread, we can go on and fix things from what I have now at
> > > > acme/perf/core, which I'll send to Linus today.
> > > oh cool. i'll let patches sit for now - let me know if there's anything you
> > > want/need from me.
> > 
> > Not right now, I'm now just waiting for Linus to merge what I sent, then
> > you can continue from upstream.
> 
> I'm not sure what you have sent to Linus? The patch series? Specific
> patches?

I think the whole patch set has been merged into Linux mainline;
after git pull the Linux mainline code and you could see:

$ git log --oneline --author="Carsten Haitzle"
dc2e0fb00bb2 perf test coresight: Add relevant documentation about ARM64 CoreSight testing
43c688cb3241 perf test: Add git ignore for tmp and output files of ARM CoreSight tests
b65c6477f6bb perf test coresight: Add unroll thread test shell script
fc0a0ea03980 perf test coresight: Add unroll thread test tool
74c62b8d6161 perf test coresight: Add thread loop test shell scripts
e9664b96c6c0 perf test coresight: Add thread loop test tool
b76692fea7f2 perf test coresight: Add memcpy thread test shell script
f1288bdb6d48 perf test coresight: Add memcpy thread test tool
6ea586b1e3dc perf test: Add git ignore for perf data generated by the ARM CoreSight tests
fdc25cc59c71 perf test: Add arm64 asm pureloop test shell script
8b97519711c3 perf test: Add asm pureloop test tool
34bec35cbbb2 perf test: Add build infra for perf test tools for ARM CoreSight tests
c63317ab14b0 perf test: Add CoreSight shell lib shared code for future tests
7391db645938 perf test: Refactor shell tests allowing subdirs

Thanks,
Leo
