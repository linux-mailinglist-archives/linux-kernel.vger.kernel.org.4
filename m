Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE406A66D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 04:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCAD56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 22:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjCAD54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 22:57:56 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040CD3AB5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:57:56 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id y11so8532435plg.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 19:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2HoRzTg7ErB9W9UorVSr1GHoG5oE6lLKfcW7PASEOqo=;
        b=Cugfhb/KcXRRvqQQDCG2wJQ62E4qMO66FT4ARfY8sYgU0QLxupZVsqVepb/P2CZeM1
         PFyA+BICMK2gtEBGDCxkrnBdVjjfQHMTJmiyXGG/wgGQAbLkFwloggB3BsKD7C6pExek
         eUY9Z+ZYfVXaLNH6IThAJGqsAYR1WFa8lx2Hc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2HoRzTg7ErB9W9UorVSr1GHoG5oE6lLKfcW7PASEOqo=;
        b=MBgiyEK2P0q8l1V+qnbG5bO7RAS7IPI1S6xfo8KKqOCLxQ/szyNTSB5T1H/3f/cnYO
         LKO/7IRNIwCDONb6Z8h3kJ/EAcaPgIST6UUWLZvDP044wMthLccTSrguAll+Lg9tCiph
         1uUg5JM62g2L8iKYKxsN+gkSSNlpUkcwYzdFOHLUX6Lb0CnFAmdEbuQiZ5Jrtq1HKSNY
         RX72WJ2P8YJyBeiOAvxMGbgjHE+J2H7Cxw2I64k7CUa9xxoFhQMFu3UYdgz92n0GjAsb
         bTlNca3cZkBRhiSRiM4itLku2M5q/bc7a0TRO25nxgywASXHd45xKU3t3v1kVaNsR4xi
         12zg==
X-Gm-Message-State: AO0yUKW4tMXxMYcBtw1PPAtbkMIb5LWeRaNXTApfhx/mgJau3mndfK39
        rA16+zyPn/OORM3qGRCp1u/brg==
X-Google-Smtp-Source: AK7set/Cuio4LtAyIlbjTfHTIUL4qhMq9JlNmNv+WkOXQydt3PvO8+vdHQe03SmAzlT7Q5gXrnuvQw==
X-Received: by 2002:a05:6a20:6982:b0:cc:4db0:f2c7 with SMTP id t2-20020a056a20698200b000cc4db0f2c7mr7694487pzk.23.1677643075479;
        Tue, 28 Feb 2023 19:57:55 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id p5-20020aa78605000000b005a8bc154bf4sm6776887pfn.39.2023.02.28.19.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 19:57:55 -0800 (PST)
Date:   Wed, 1 Mar 2023 12:57:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCHv2 0/6] zsmalloc: fine-grained fullness and new compaction
 algorithm
Message-ID: <Y/7NP3LG+L7CKsLu@google.com>
References: <20230223030451.543162-1-senozhatsky@chromium.org>
 <Y/f8esHswgLtjkee@google.com>
 <Y/rXFc4dI+190uJa@google.com>
 <Y/59k9T3akHc4JZW@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y/59k9T3akHc4JZW@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/02/28 14:17), Minchan Kim wrote:
> Thanks for the explanation, Sergey.
> 
> Please include the testing result data in the description of the patch
> you made significant change to achieve it as well as cover letter.

OK, I can include it into the "new compaction algorithm" patch.
