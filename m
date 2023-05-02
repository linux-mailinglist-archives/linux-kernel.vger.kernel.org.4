Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC76F4717
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234590AbjEBPZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbjEBPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:25:03 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160391AE
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:25:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f315712406so174816275e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 08:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683041100; x=1685633100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kBy/QmnNBp+fcXYUyA4O+ycWM9Zaq3z2mE+GGhFeBus=;
        b=HvK4PAyAOIJAFBpEQ2pH0UnJkh6yAL3rTTriL0ikb0Ptk3fZ4rgRQ+1nlfT4W0zAw4
         4ynP0hCJ9X5toP2AmPE5K+svnlb6GW0ThcwP6ZXB4lG1mbE0ph55gyfjvEy2QssRy6vB
         NVLT6cHaulNbukzHg8UdIyqk5EKeDYfQwihIN3GU3wz1i8KZIA0DqaYKctioNvq5Pbh8
         68wlTPBFs2CWeOShg31X9mXwZCUxm1L6VNeAXeXGlEWJpK/3utrMkeMw/GVb2Y+btvWF
         ZELlqwZdzptRPNIHHlUK2WXsWk4DtcGmT3W3aa0Os4nzxozoJiw21IJ85qQDEH1KT+fz
         7D6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683041100; x=1685633100;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBy/QmnNBp+fcXYUyA4O+ycWM9Zaq3z2mE+GGhFeBus=;
        b=Jl6vhS4ZVDfmKAUHpQlVEhJhfS6s55pTP1tAbAdvEbEabbaLx/NcbSa6oIi5ezdYdJ
         MgpGp714WC9c0PY4Ta8mLaRnA0tr8QquImrBzEQDAQG92SdZ4jYTXcuUV8k/7o1hBA2X
         OrYGKJ4Vp0xDcuEOYbTz3FvMhLcqBh8npTDYBG14RCzSeb9dYACYsPlZeRvqQI0ouQL/
         hzZr3DBfMHT4lN95uF6xQZeIHNkXeNOwQnZYpVdEHGNksOUk6V1VpXUQZqrvEYb4RLZw
         C9Q6PMPHS/rBvMqHM98n5E0T38cEMGiThLs/KT6p7E72nyMrGsJdk7bmZCAC7KluegFP
         duig==
X-Gm-Message-State: AC+VfDz2bXxCdysTnd/D+1UtZHJnEJNeBy0nzeRHav3HSsXWTS/57nZt
        xrYcx/odljOlLMFFTjoo1CES7w==
X-Google-Smtp-Source: ACHHUZ6THdDvoY3MkBCJBORkxsrFyWNGVFk7lmDTd8ZivNKIPwFhlp84Q8fc2kfGT3l0owP5kfZm7Q==
X-Received: by 2002:a05:600c:3d18:b0:3f1:7b63:bf0e with SMTP id bh24-20020a05600c3d1800b003f17b63bf0emr15725163wmb.18.1683041100576;
        Tue, 02 May 2023 08:25:00 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ef64affec7sm35805117wmg.22.2023.05.02.08.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 08:24:58 -0700 (PDT)
Date:   Tue, 2 May 2023 18:24:53 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Brandon Ross Pollack <brpol@chromium.org>
Cc:     Dan Carpenter <error27@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org,
        ojeda@kernel.org, alex.gaynor@gmail.com, keescook@chromium.org,
        nathan@kernel.org
Subject: Re: [PATCH] .gitignore: ignore smatch generated files
Message-ID: <969f9704-6781-4bd6-a0ee-46c7110a2c93@kili.mountain>
References: <20230427023345.1369433-1-brpol@chromium.org>
 <CANiq72nxNtLvx1J-50F8D05QQjx4FBPkrhg6pysc25RL6--Zhw@mail.gmail.com>
 <CA+_b7DLoTEn6_2auTVN9Wj62ogOFXnhf7kTmh_KCZPkCBfJsSw@mail.gmail.com>
 <CALWYx-bvyzN3nGtGpLKyoayWLtzKwJGCtdFMfg=6bJSP2qYNGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALWYx-bvyzN3nGtGpLKyoayWLtzKwJGCtdFMfg=6bJSP2qYNGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 11:55:17AM +0900, Brandon Ross Pollack wrote:
> On Thu, Apr 27, 2023 at 8:20 PM Dan Carpenter <error27@gmail.com> wrote:
> >
> > Thanks for this.  To be honest, I hadn't remembered that Smatch
> > still generates trinity_smatch.[ch].  I would prefer to just delete that
> > stuff.  Another idea is maybe Smatch could put everything in a
> > smatch/ directory?  That feels like maybe it would be nicer?
> 
> Sure, that'd be great as well.  I'm pretty sure that smatch outputs
> these files from whatever directory you run from, that's why I did the
> overall pattern rather than a path pattern.
> 
> Should we just patch smatch to not output trinity* files and output to
> a directory and change this patch to mask out the directory?

I've deleted the trinity stuff.  Let's just apply the rest as-is.

regards,
dan carpenter

