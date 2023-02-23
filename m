Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBD56A1401
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 00:53:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjBWXxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 18:53:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBWXxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 18:53:34 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABA4ECF6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:53:33 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id u20so4114377pfm.7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 15:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677196413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1I60B2Lt/0FzuWu/7GjmsvEbAqwqUGpYps2gfO1SLc=;
        b=I9t8BJKsBwcmztPZYHnnr99l2QXIa43BpfQNtIwNKfNzbqaGF6y23VKayPuxikMDFg
         eY3kxv/xCIf/JsqpXCGKvTEHJ/05M56W0UDDc/wsusEHox39ydixgyeWyitCPUiySgzI
         OEqRPNxlNOT5AEbCuW/qQEGs9qSh4VkiLtGpmsFtc5mQrCEtWJSoTkyrnTR5CDFzTw7w
         H1TVFjPA+S8z2rOOoJMpVbqZBkVfSRtcl0c9myBs7E9QtuZFoj0L/c1HyZyxZvF6xPm6
         Er1uXF0IFrnGKTJBxFXKzVCEvp/+BcSxiG80whP73tQJABGTLFDS4NIVAsxCr8rKnecb
         7frg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677196413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1I60B2Lt/0FzuWu/7GjmsvEbAqwqUGpYps2gfO1SLc=;
        b=heb14b3ATgXrd8TE5t2fYOt7VvZiB84iNT75MYOY0eVAUM+k0AALGwreg0zsJmSqny
         Ta4Dku7rsdMzaIo+8fDlSQvX3uhHvs+H1XyaGRpUoK7VbMn7Hj3rwt0jYhXaHNuF+KSp
         0hCd+wDtWB+t8NMPVTx7tW3qPwPZJkLckM0XmVQh57iEGz/YwxutSfv6OVnJLnPZ/psG
         Tm8mTXmBMtkQNy48yvZ8nuEgZWXbC2EbLCe019SmaDlKwm3CFjrxtYAT5x0a6exwOOn1
         k2Z32OuTOnm6MShKNZj+kSfURI4ViHK3ITEhuTU0rRGlzRCQcdgx21w+/zhURT1hmS2k
         dwnQ==
X-Gm-Message-State: AO0yUKUXTNxWnL8HTabP09l96eKdBfsMAUY1i0SXStcqaihHcE51MHQ2
        eQnep680J53n4iDtCnGdR68=
X-Google-Smtp-Source: AK7set8hLPjTBMwY6wWJMSOibdZqs8ygHjZPLL8d2LbLUa09dRVU8AoVW/sQbi17vTSpC9R8/I2S4g==
X-Received: by 2002:a62:8494:0:b0:5a9:bf42:fcc5 with SMTP id k142-20020a628494000000b005a9bf42fcc5mr15718796pfd.0.1677196413079;
        Thu, 23 Feb 2023 15:53:33 -0800 (PST)
Received: from google.com ([2620:15c:211:201:be5:a687:1e9d:ec53])
        by smtp.gmail.com with ESMTPSA id e6-20020a62ee06000000b00580fb018e4bsm5394832pfi.211.2023.02.23.15.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 15:53:32 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 23 Feb 2023 15:53:30 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <Y/f8esHswgLtjkee@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230223030451.543162-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 12:04:45PM +0900, Sergey Senozhatsky wrote:
> 	Hi,
> 
> Existing zsmalloc page fullness grouping leads to suboptimal page
> selection for both zs_malloc() and zs_compact(). This patchset
> reworks zsmalloc fullness grouping/classification.
> 
> Additinally it also implements new compaction algorithm that is
> expected to use CPU-cycles (as it potentially does fewer memcpy-s
> in zs_object_copy()).
> 
> TEST
> ====
> 
> It's very challenging to reliably test this series. I ended up
> developing my own synthetic test that has 100% reproducibility.
> The test generates significan fragmentation (for each size class)
> and then performs compaction for each class individually and tracks
> the number of memcpy() in zs_object_copy(), so that we can compare
> the amount work compaction does on per-class basis.
> 
> Total amount of work (zram mm_stat objs_moved)
> ----------------------------------------------
> 
> Old fullness grouping, old compaction algorithm:
> 323977 memcpy() in zs_object_copy().
> 
> Old fullness grouping, new compaction algorithm:
> 262944 memcpy() in zs_object_copy().
> 
> New fullness grouping, new compaction algorithm:
> 213978 memcpy() in zs_object_copy().
> 
> 
> Per-class compaction memcpy() comparison (T-test)

Just curiosity: What's the T-test?

> -------------------------------------------------
> 
> x Old fullness grouping, old compaction algorithm
> + Old fullness grouping, new compaction algorithm
> 
>     N           Min           Max        Median           Avg        Stddev
> x 140           349          3513          2461     2314.1214     806.03271
> + 140           289          2778          2006     1878.1714     641.02073
> Difference at 95.0% confidence
> 	-435.95 +/- 170.595
> 	-18.8387% +/- 7.37193%
> 	(Student's t, pooled s = 728.216)
> 
> 
> x Old fullness grouping, old compaction algorithm
> + New fullness grouping, new compaction algorithm
> 
>     N           Min           Max        Median           Avg        Stddev
> x 140           349          3513          2461     2314.1214     806.03271
> + 140           226          2279          1644     1528.4143     524.85268
> Difference at 95.0% confidence
> 	-785.707 +/- 159.331
> 	-33.9527% +/- 6.88516%
> 	(Student's t, pooled s = 680.132)

What's the different with result above? Did you just run two times and
shows they are consistent or this is new result based on different
testing?

Anyway, this is really nice improvement. The comment I had in thread
are just minors.

Thanks, Sergey!
