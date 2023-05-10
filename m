Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9886FE222
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjEJQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjEJQHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:07:53 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA21BCA
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:07:52 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115e652eeso51357247b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1683734871; x=1686326871;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=b4Rid9FL2qAsOfwFHnvreGzE7hpGc3/BOKYFO/I4yNo=;
        b=V4AA29NRPewU1ZhOmn3VFXOOGq37KDAuoo7UNU5R7ExMHImNBy9FS7iX4ObVgciPYl
         KfJgfg8BBBrDxgGZaeAwhIo2ouqnjeSzozhJ1HTrD+zihyF1vOIDIyP00GqXyXzDF7Bt
         RzGyO/iyjGR79BXvQZBeOZqS92rgMbIgPO0MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683734871; x=1686326871;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4Rid9FL2qAsOfwFHnvreGzE7hpGc3/BOKYFO/I4yNo=;
        b=YdQPwumZunDg6zmliL909MgZ4jZHCYjfOqEL9KVminf0Nf0H/11RQQ+RrpmJAQTspX
         B7qdodKrs/hrsPJbpokDZ0trFfmd9TdQsDSfX6HExUytdBFqdtOcylCXCxiP9ixupIW1
         N9Z7fh4JOPb/2hOrxsQYy8bz5hmfyPWPMO3AcV8UliZvSR29cLee4PDWOTXeGR1mWgVa
         f4wkdoP5loLvy6tvyp1SgIJUC98URwBw1v2yy6eLJ0YpBM8TvYPeTUdCPJlNLYhnpBNq
         rTmFMsJUUX+wZ5dVavLQ2y0M6/KAWsg1CDug5VhMmlaxbJ7jSmgJ1w4a154h+joG2YSZ
         KMeA==
X-Gm-Message-State: AC+VfDxlzkFH46/N8dkWG3gGA7efL1SfbF8rK5QT7n5wAmkuOc/P+Q+O
        oJU8gJ+KA/K8DlGXFJI1QVhYHw==
X-Google-Smtp-Source: ACHHUZ5+j8NHGrND6rHUUvMUU0NsbO8Y17i87N6pNb81axKEXdFyWS5TYCNRpHHrsGYhiCksGDmhNA==
X-Received: by 2002:a17:903:1ca:b0:1ad:bccc:af77 with SMTP id e10-20020a17090301ca00b001adbcccaf77mr295388plh.18.1683734871402;
        Wed, 10 May 2023 09:07:51 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903244900b001ac94b33ab1sm3975861pls.304.2023.05.10.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 09:07:50 -0700 (PDT)
Message-ID: <645bc156.170a0220.62d12.7fb3@mx.google.com>
X-Google-Original-Message-ID: <202305100907.@keescook>
Date:   Wed, 10 May 2023 09:07:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexander Potapenko <glider@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, elver@google.com, dvyukov@google.com,
        kasan-dev@googlegroups.com, andy@kernel.org,
        ndesaulniers@google.com, nathan@kernel.org
Subject: Re: [PATCH] string: use __builtin_memcpy() in strlcpy/strlcat
References: <20230424112313.3408363-1-glider@google.com>
 <6446ad55.170a0220.c82cd.cedc@mx.google.com>
 <CAG_fn=UzQ-jnQrxzvLE6EV37zSVCOGPmsVTxyfp1wXzBir4vAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG_fn=UzQ-jnQrxzvLE6EV37zSVCOGPmsVTxyfp1wXzBir4vAg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 28, 2023 at 03:48:28PM +0200, Alexander Potapenko wrote:
> >
> > I *think* this isn't a problem for CONFIG_FORTIFY, since these will be
> > replaced and checked separately -- but it still seems strange that you
> > need to explicitly use __builtin_memcpy.
> >
> > Does this end up changing fortify coverage?
> 
> Is fortify relevant here? Note that the whole file is compiled with
> __NO_FORTIFY.

Yeah, agreed. I think I was just curious if that got verified. I'm good
with this.

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
