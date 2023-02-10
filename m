Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CB4691796
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 05:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjBJEaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 23:30:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjBJEaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 23:30:05 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9775A9F3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 20:30:04 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id r8so5307182pls.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 20:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1+orT4ztclZFNeCn2/cy+EXNwVVJ1UrZTaDdZ6P0C/o=;
        b=aAAiWdGnMxnDRNbU5mdVTMZfAj2VmYwtwi/2Mq+6pJrMbYq+beEtgHtSQZoWFp5AtN
         MG9B3T4ELnrnKOkWlbY3MDklUfjouY525ejhFWqzYIZKJNmZGHrPp3VL7OVBFLQF6E9w
         9o7hU++lFUoiPp82yExpHfDSW3tbhbNPdiuXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1+orT4ztclZFNeCn2/cy+EXNwVVJ1UrZTaDdZ6P0C/o=;
        b=6y53/bnE75Grl3FBOfqeZwRPrRgulCulatbDUhQlkuLI1LgciLCIPV9b9z+Z6lMyi+
         23FJcAM0MhqhoezMBUweqX0bcHC+9vl/buuzjth1U+VXG981hsLIwGa+AFqhfeM1gIEe
         LMyGpQ7BY1KL6oHrXqiEd4/kwUaO73n2OWc283qLjAeaX/U/lsEsNn/s1bdSj4anM9Vp
         u1bFf0C4RjN8NE+l6WdHRLrR0W0ti3x2D1wBKyV3/ohOUgBZ/APYk6/mRqqHo3mnaEnz
         YWRSY/x4SiOEquT3Cj6yGbMY8vyMIXAexuA+xDzpVFUNmm0iraOiLjvNAp/OKy+e+5A8
         Zj3g==
X-Gm-Message-State: AO0yUKUsDPTEuQSQG3HxUNDGSQ5vrufmNhrfBjST3ZfCsxqNzXsTp4TS
        Bk4ogeT43Ep5TlT7814z+ZhiKg==
X-Google-Smtp-Source: AK7set8Cp6nq/nt1N09xKj07/QV1E6l7rUVOI6hkrCyDB0iP/iQ4q0BS7XhK1tEgEVwAbRzYTU4y+Q==
X-Received: by 2002:a17:902:d0d2:b0:19a:703d:c1cb with SMTP id n18-20020a170902d0d200b0019a703dc1cbmr1314390pln.11.1676003403650;
        Thu, 09 Feb 2023 20:30:03 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b00199136ded1dsm2336072plq.112.2023.02.09.20.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 20:30:03 -0800 (PST)
Date:   Fri, 10 Feb 2023 13:29:59 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness
 grouping
Message-ID: <Y+XIR64RyVv0EfTx@google.com>
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org>
 <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com>
 <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/09 20:25), Yosry Ahmed wrote:
> > On (23/02/07 10:47), Sergey Senozhatsky wrote:
[..]
> > Forgot to mention, I was also thinking about extending zsmalloc stats
> > file and providing values for each fullness group per class, as opposed
> > to current ALMOST_EMPTY and ALMOST_FULL stats, which don't tell much.
> 
> Makes sense.
> 
> >
> > I can get rid of static const arrays and pass "begin / end" group IDs to
> > functions that iterate fullness lists and pick the first head page, but
> > I think that enum values will stay.
> 
> Do they have to stay for a technical reason or just to make reviews simpler?

We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
show class's fullness stats.
