Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7F3637106
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 04:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiKXD33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 22:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKXD30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 22:29:26 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE072315A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:29:26 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id 140so511659pfz.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 19:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OmuXcKmldYRY28tpKWc73DfpA+ietCh+0m3vXs6nbEA=;
        b=jrY37vWZL4+NOOfkanXW3qrLGEkmc22drVUGGSGnSrEUb7lNU58z74RCJJq8ByvOgx
         kfcI+Zw84SsdVCmDlCnDo080wNCi2fJ+hjGXWE9Om8/rCKXDZTqTEH8upfkXsAy/ZHZ0
         oBHW2vcOyDgzkck2VgyrrxfKAgq1m/6Q//1r0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmuXcKmldYRY28tpKWc73DfpA+ietCh+0m3vXs6nbEA=;
        b=gQNMRvJjGHHY9TnXT8ngrE2jIvpND6CJbb6uAaqXKnns3RWhrpxhfftYpkE5tzYtPW
         v2DwwF4+C71ODgdfga7GLnTtOAN0acmhLLQ/GeY7YYAqJcv0XALD7Po0lnQJCeT1df26
         sHG/Znw3nEexDY+SeEr7jSR3+uiQaZ6q12gcJmhOHkD03jh2TILxgrgqxktX8N2v564h
         qQqJdeOZWvrOWBh4Pe9djuzegcWLNQrKStrAFguSU0mvXMffygHm8cCFQNoLNPEfg2Z7
         ZZ/CDZbZKpAPUmi2RJgTELbhtY1vgSvREMka3BHjHqFMRrfuh++qh1j3p5bjQZsVL028
         7ULg==
X-Gm-Message-State: ANoB5pl94wCCLFt3Ek+gGy8LrPIGgXpmH5b/Z0Ck8FACVaAQeiqMXHPw
        CkVwcpXEPU/RIPMmRwiAnIFHsw==
X-Google-Smtp-Source: AA0mqf5h13umXS7U64Q4Uu8DQLf6O5O36DEWu+XlFHRpZVeEGeEfj4Zqoraa/UHHKWSCjWjtaLx7jQ==
X-Received: by 2002:aa7:961c:0:b0:574:76d8:aecb with SMTP id q28-20020aa7961c000000b0057476d8aecbmr3334418pfg.78.1669260566002;
        Wed, 23 Nov 2022 19:29:26 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:438d:8b02:662d:50b3])
        by smtp.gmail.com with ESMTPSA id l7-20020a170902f68700b00177fb862a87sm15336419plg.20.2022.11.23.19.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 19:29:25 -0800 (PST)
Date:   Thu, 24 Nov 2022 12:29:20 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        minchan@kernel.org, ngupta@vflare.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com
Subject: Re: [PATCH v6 4/6] zsmalloc: Add a LRU to zs_pool to keep track of
 zspages in LRU order
Message-ID: <Y37lEFTvfJr4MIQl@google.com>
References: <20221119001536.2086599-1-nphamcs@gmail.com>
 <20221119001536.2086599-5-nphamcs@gmail.com>
 <Y3wreqR1IRWFtSUz@google.com>
 <Y30KIbewtg+b5JTq@cmpxchg.org>
 <Y32Yl/Emcw/2a51t@google.com>
 <CAJD7tkZM1KwQpkS5fTaL0A4=VLv=HEWxCc1kd45s49-s4__e1Q@mail.gmail.com>
 <CAJD7tkaWmusZ3V0Jh-zvaW3Ypt5Jn1GvzXryDjy58HSQWW74Gg@mail.gmail.com>
 <Y35KtVaR/FKNAhKY@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y35KtVaR/FKNAhKY@cmpxchg.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/23 11:30), Johannes Weiner wrote:
> Like Yosry said, the plan is to implement an object-LRU next as part
> of the generalized LRU for zsmalloc, zbud and z3fold.
> 
> For now, the zspage LRU is an improvement to no-LRU. Our production
> experiments confirmed that.

Sounds good!
