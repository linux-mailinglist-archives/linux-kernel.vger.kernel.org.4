Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984A36AA77B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 03:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjCDCCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 21:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCDCB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 21:01:58 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB025A6EA
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 18:01:57 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id a9so4624762plh.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 18:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+G4ef65CSgKpxodjySBoOq5VwIhCSm6EqLMcA3UHuRg=;
        b=h+yV8yvoyJXkMqyOgspcWKCRZNDgusSMt1YNnrOA+zRsFudDnbHltOBoCMZKBO5aJd
         J610cdtZjvhAb6Oj3u/diuevcD/P7pqcglfrlTlL4JWp0siYEH/4ayEA0xWzXkUfSX39
         8AxPS4aD0VE1CdazIiEZy7T72vWTm+ge93Lyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+G4ef65CSgKpxodjySBoOq5VwIhCSm6EqLMcA3UHuRg=;
        b=1u1tIaN4rcRG29dGtDYxBUNFwMo5RqmgLA2TQR+eq4yRxAUviW6/QbJw/o+yQlOF4l
         O+137q81zVSfe/ZJg0RpNC0lJaauscIrHuPMQspsGM2vz4KBNXGJziObdWgZxc8xYuSM
         ad0NMVafRNc4ev470o/0wzPjrooNQ2Wd4B7PaYgA8qLC2lazL4AdpknHRJI5z24by4Ha
         CwtPQj4l3GxttNe2wGX29ztSbvsFi7j5mMGZ9rUvT+WZVpt7dvAPWuKrTo5PBd/jkzZH
         ZzjAojgdkpQk9XdA6PHfcI4pDdJI/RkialxYfFPw2Wlitv/b2hwpqMV0fpPuJGX9Slr6
         vC/g==
X-Gm-Message-State: AO0yUKXClLlg1h8w5gAuyxiL269QMwfyiG/OTN2fgb2Kd2jN9oJ3jxqx
        jWx5EBttR+VLfQhDIi/3HFOblg==
X-Google-Smtp-Source: AK7set8CJ8UOVdkGOdOjj8r2Kp6R1M9AS8cfkNqVfBkDuY5AQd5bHWb0G1Q5hw+hWhqThqn0XdIMig==
X-Received: by 2002:a17:90b:1e0f:b0:237:c209:5b14 with SMTP id pg15-20020a17090b1e0f00b00237c2095b14mr3574252pjb.22.1677895317278;
        Fri, 03 Mar 2023 18:01:57 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id f22-20020a17090ac29600b002372107fc3fsm2175363pjt.0.2023.03.03.18.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 18:01:56 -0800 (PST)
Date:   Sat, 4 Mar 2023 11:01:52 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 2/4] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <20230304020152.GB5231@google.com>
References: <20230303073130.1950714-1-senozhatsky@chromium.org>
 <20230303073130.1950714-3-senozhatsky@chromium.org>
 <CAJD7tka5VnRBUnpzoAX6eNuRocSbdGFBfmEx1pxQaDHT9UyMtg@mail.gmail.com>
 <CAJD7tkbhy=JUFsFbGuG7OKgEcLSdCaBBtL-bZn92sP6Wk_sN4A@mail.gmail.com>
 <20230303152833.24d7a42102bd712e09f95cd5@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230303152833.24d7a42102bd712e09f95cd5@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/03/03 15:28), Andrew Morton wrote:
> Date: Fri, 3 Mar 2023 15:28:33 -0800
> From: Andrew Morton <akpm@linux-foundation.org>
> To: Yosry Ahmed <yosryahmed@google.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Minchan Kim
>  <minchan@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
> Subject: Re: [PATCHv3 2/4] zsmalloc: fine-grained inuse ratio based
>  fullness grouping
> Message-Id: <20230303152833.24d7a42102bd712e09f95cd5@linux-foundation.org>
> X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
> 
> On Fri, 3 Mar 2023 08:58:55 -0800 Yosry Ahmed <yosryahmed@google.com> wrote:
> 
> > > > +               for (fg = ZS_INUSE_RATIO_70; fg <= ZS_INUSE_RATIO_99; fg++)
> > > > +                       class_almost_full = zs_stat_get(class, fg);
> > > > +               for (fg = ZS_INUSE_RATIO_10; fg < ZS_INUSE_RATIO_70; fg++)
> > > > +                       class_almost_empty = zs_stat_get(class, fg);
> > >
> > > Aren't these supposed to be += ?

Good catch Yosry! Thanks for taking a look.

> I'll fix that up anyway, to avoid a bisection hole.  And in case [patch 4/4]
> gets dropped from the series or is later reverted or whatever.

Thanks Andrew, should I just send out a v4 with 3/4 and 4/4 fixed up?
