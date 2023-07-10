Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0359974D4D3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjGJL5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjGJL52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:57:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EEDD1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688990200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=V5nvWHxOS1jlxX2P24Kbt+E8BFVKb+2zALHkjYGPjbU=;
        b=HNQ1hywyKyOZk4wbqGxwgHlgbSvyjIKxdOmOC3HbZKwHrhg5QOQ/imYhfJulsjgYb+2P9A
        knLbG1PEcfHwJ3QPHf06gfMj7SQjHZnIcAEw4avT4+QxfEmlQbe9WGx1Df2IcBvhvdKkCV
        4o69kAQyJLx7L4FDIIQNbkjEV9WIm9g=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-z-hvf6EoPNa5iEey5TAd7g-1; Mon, 10 Jul 2023 07:56:39 -0400
X-MC-Unique: z-hvf6EoPNa5iEey5TAd7g-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b6f0527454so38002171fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:56:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688990197; x=1691582197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5nvWHxOS1jlxX2P24Kbt+E8BFVKb+2zALHkjYGPjbU=;
        b=d/TFiK1+dPeZYkoAjqeBRXHeZTEvYuGdPjsJ0+r96kzqwnSFt27mdP9OhSEg7QFjq9
         jztvDSD9R690DP9gKpZPq3rEulv4g1q4cLt1bBbMDOxkuzIN1F7PeGlzEX9Kjrw/nsjd
         7FZAP++fkAH6VRcHrR8iHCG9w6ozw3h1D43dQPRK/8VntvP8D2Cgpvmx8HAMDNf1H0lc
         iIgeqA9fORm3PRYFq9qWjShVGeL28icXcCeKmo9wl0VWlFwXl48HFNqtZl2dXr/TVWbE
         WJrV4tj/sfP51GrHh8ys6fjO5WNRB0gf87OSsxlE1zXeAD6rOoPw9NZDnECIijoRGLGM
         Y87A==
X-Gm-Message-State: ABy/qLaI7jNdBXUDwoJRNl0/D6KY0KULaXMPh+8sj/+QdEqFB68oQpAY
        Aq+byoC1QMee0t+ZIKDt3WefM4knD4bhiZRtTWWeW7sD5ltHNX83o+jeFmM3pEk+tvXjralqLMD
        3kDUj6sXMd6eS7MXeHboZhBd8
X-Received: by 2002:a05:651c:205:b0:2b6:c394:91dd with SMTP id y5-20020a05651c020500b002b6c39491ddmr9535757ljn.10.1688990197749;
        Mon, 10 Jul 2023 04:56:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHHaINIY4IeEyczmZRw/E4sGNkyu+QGYkdJrKccjKWG8MejGXh5QlhRs3Cdy+GKrd5vo6ELuw==
X-Received: by 2002:a05:651c:205:b0:2b6:c394:91dd with SMTP id y5-20020a05651c020500b002b6c39491ddmr9535744ljn.10.1688990197329;
        Mon, 10 Jul 2023 04:56:37 -0700 (PDT)
Received: from localhost.localdomain ([151.29.137.73])
        by smtp.gmail.com with ESMTPSA id g8-20020a170906594800b009930308425csm6046503ejr.31.2023.07.10.04.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 04:56:36 -0700 (PDT)
Date:   Mon, 10 Jul 2023 13:56:34 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Mike Galbraith <efault@gmx.de>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RT] i915 sleeping function from atomic in gen6_reset_engines()
Message-ID: <ZKvx8hVLJ0OY3M5z@localhost.localdomain>
References: <Y86wDg/EZfJOnlwJ@localhost.localdomain>
 <ZKuxdVJcsHdcbmYs@localhost.localdomain>
 <ae3f172d49bcf1af3c0e566bbc4f2967c9e65f2e.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae3f172d49bcf1af3c0e566bbc4f2967c9e65f2e.camel@gmx.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/23 12:09, Mike Galbraith wrote:
> On Mon, 2023-07-10 at 09:21 +0200, Juri Lelli wrote:
> > Hi!
> >
> > On 23/01/23 17:04, Juri Lelli wrote:
> > > Hi,
> > >
> > > I've just noticed the following while testing v6.2-rc3-rt1.
> >
> > I'm still seeing the following on v6.4-rt6.
> >
> > I believe 20211006164628.s2mtsdd2jdbfyf7g@linutronix.de should cure it,
> > but I don't think it did go anywhere?
> 
> The raw lock cyclictest deltas don't look great.  I shut it up with the
> below.  For my i915 equipped lappy, a raw lock fix would be just fine,
> its cyclictest numbers already being well south of 'oh dear'.

Right, thanks for sharing!

Looks like Sebastian is on holiday, so I guess we'll need to wait till
he's back to see which solution he prefer.

Best,
Juri

