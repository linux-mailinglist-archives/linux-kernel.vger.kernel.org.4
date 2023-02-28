Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE56A6244
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 23:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjB1WSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 17:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjB1WR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 17:17:59 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F6335B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:17:58 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id s18so6616476pgq.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 14:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677622678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3TsJNEj+w0WsDhaHaz9OByZ+6JnTWJIfxuRnHUbFWs0=;
        b=OPbyvuAVTRMTCsj63D8xErzTFv0rlOI3wd5ikM2cxA7qPvoqQEHv+CXJfhAP/vhnFh
         cMasZIfQhweBi9Af5qam8hxAJvHBP9TKNa5ORC5CY2eh3F3RLBapTszQMY90+7vWHDh5
         nbpJMcj28gCRI6xuEUBlDDPkDf32oHyIv/uWs7CDlp3bXXODLn4ljfjop2dvUQqEzfTn
         s5iBHudEOhn7dMK8fDnK1a57fu5hNXD16XkC1Qpgl42mD7MYm3HCw0+U8CvHuwOgpSKh
         /45n1SGAxzn/qNW42HyvRNOMlv8DYOcCDEuYK/e7l2vn1m5ZSBcjeEK524ONI+7DcS28
         uY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677622678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TsJNEj+w0WsDhaHaz9OByZ+6JnTWJIfxuRnHUbFWs0=;
        b=KU1ybcDphpJEwPM6PRDkUJSaz5oN6rKwH/sctUGK4zzpYGi0frgNK6niPqaOJpmQiK
         Bmnf2NH0TnpaQZzUi0szEZ17DUeUdtHwqP7ZnEKdu9YgU7n45BcwOQU9stS5jNN9++mQ
         JB92crF8vHB3dCw8DCyDUhYI0vzp+/wkWWCFh8ZMk5w0GNLxFxA4jnD02MpvdhVNYRJW
         HSlE+ir35IejsKrsyooaUZk5XXbRyy3DD3GAK1Jsp/3/qcQbU69uHkELnPdv9lzzgGn5
         P+O+1a/UKrOPPWjeqxDk43KGWYVhKQQNkoohdg/cU4su9QT/HqVNlH7pwC0W5aifSKE1
         halg==
X-Gm-Message-State: AO0yUKUzkHyQnbpJ2U9ydrkroFKxdMF7m6Cwi29V6sJ86jhWxWvJpvIc
        QZnX2otdOOq44sVHSJxicr/GNmdpZ3o=
X-Google-Smtp-Source: AK7set+2cLaqXQJw0ub7AUxXbSMsxiqYTB5BkABxLbWrjOq1H086A90IDf8WBiCSKu1anwANMC0xbw==
X-Received: by 2002:aa7:981d:0:b0:5a9:c1f9:dc70 with SMTP id e29-20020aa7981d000000b005a9c1f9dc70mr3362094pfl.30.1677622677660;
        Tue, 28 Feb 2023 14:17:57 -0800 (PST)
Received: from google.com ([2620:15c:211:201:639:82f5:b510:3494])
        by smtp.gmail.com with ESMTPSA id i2-20020aa787c2000000b005abbfa874d9sm6483760pfo.88.2023.02.28.14.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 14:17:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 28 Feb 2023 14:17:55 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <Y/59k9T3akHc4JZW@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <Y/f8esHswgLtjkee@google.com>
 <Y/rXFc4dI+190uJa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/rXFc4dI+190uJa@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 26, 2023 at 12:50:45PM +0900, Sergey Senozhatsky wrote:
> On (23/02/23 15:53), Minchan Kim wrote:
> > > TEST
> > > ====
> > > 
> > > It's very challenging to reliably test this series. I ended up
> > > developing my own synthetic test that has 100% reproducibility.
> > > The test generates significan fragmentation (for each size class)
> > > and then performs compaction for each class individually and tracks
> > > the number of memcpy() in zs_object_copy(), so that we can compare
> > > the amount work compaction does on per-class basis.
> > > 
> > > Total amount of work (zram mm_stat objs_moved)
> > > ----------------------------------------------
> > > 
> > > Old fullness grouping, old compaction algorithm:
> > > 323977 memcpy() in zs_object_copy().
> > > 
> > > Old fullness grouping, new compaction algorithm:
> > > 262944 memcpy() in zs_object_copy().
> > > 
> > > New fullness grouping, new compaction algorithm:
> > > 213978 memcpy() in zs_object_copy().
> > > 
> > > 
> > > Per-class compaction memcpy() comparison (T-test)
> > 
> > Just curiosity: What's the T-test?
> 
> T-test is a statistical method used to compare the means
> of two independent groups or samples and determine if the
> difference between them is statistically significant.
> 
> > > x Old fullness grouping, old compaction algorithm
> > > + Old fullness grouping, new compaction algorithm
> > > 
> > >     N           Min           Max        Median           Avg        Stddev
> > > x 140           349          3513          2461     2314.1214     806.03271
> > > + 140           289          2778          2006     1878.1714     641.02073
> > > Difference at 95.0% confidence
> > > 	-435.95 +/- 170.595
> > > 	-18.8387% +/- 7.37193%
> > > 	(Student's t, pooled s = 728.216)
> > > 
> > > 
> > > x Old fullness grouping, old compaction algorithm
> > > + New fullness grouping, new compaction algorithm
> > > 
> > >     N           Min           Max        Median           Avg        Stddev
> > > x 140           349          3513          2461     2314.1214     806.03271
> > > + 140           226          2279          1644     1528.4143     524.85268
> > > Difference at 95.0% confidence
> > > 	-785.707 +/- 159.331
> > > 	-33.9527% +/- 6.88516%
> > > 	(Student's t, pooled s = 680.132)
> > 
> > What's the different with result above? Did you just run two times and
> > shows they are consistent or this is new result based on different
> > testing?
> 
> The test is exactly the same, it is designed to have 0 variability, it
> creates exactly same fragmentation during each run, so we always compare
> apples to apples. What is being changed (and hence tested) are fullness
> grouping and compaction algorithm.
> 
> The first one tests the effect of new compaction algorithm alone:
> old fullness grouping and old compaction algorithm VS old fullness
> grouping and new compaction algorithm. The data show that with
> sufficient level of confidence (95%) we can claim that new compaction
> does make a statstically significant improvement and reduce the number
> of memcpy() calls (by 18.3% in this particular case).
> 
> The second one tests the effect of new fullness grouping and new
> compaction algorithm. The data show that with sufficient level of
> confidence we can claim that new fullness grouping and new compaction
> do make a statstically significant improvement and reduce the number
> of memcpy() calls (by 33.9% in this particular case).

Thanks for the explanation, Sergey.

Please include the testing result data in the description of the patch
you made significant change to achieve it as well as cover letter.

Otherwise, zsmalloc-remove-insert_zspage-inuse-optimization.patch
has every data now but that patch didn't make such an improvement.
