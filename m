Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E552620257
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiKGWgA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:36:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbiKGWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:35:58 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE1B29C83
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 14:35:57 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so16162859pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 14:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ScCG4xySl+iVdb3fADGlRx/eKjLXF30jrWX/i1bgXJs=;
        b=nzuTWt2r7F2EccPeNgiYTPeTar5wjblrT687MlvLcPBgETTl0nIs6hxBIgdEXBUYhZ
         C/r5k2chl2CVI4e17lFHcVRz9t71RXev8R3G9Zvfm1UQ6T3NM++yesn8dxapWtAKdOUT
         Y9jwlaASUyHiIY1UTpQCVrANRSsqOTYP3NXjy1ZcpbulDTQjo/cf6VBg6kW7ab7+FgsX
         iicuRJ537mhvLVCEtBe8k0LBCUs5eridjyUbpQSl2+edKRWipSOINEL+5pMMf7badaQi
         JQLfZnTdvyOc2O3IaizLul5iJB4KhxMN9LViOLqens1yQ9rWq+Ls5a5scTXqiICqjhcJ
         Y4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ScCG4xySl+iVdb3fADGlRx/eKjLXF30jrWX/i1bgXJs=;
        b=lt2dIYENamk4YmhwePC2P6kUl19bIscJTnSL0QaMvJzmnnvfRDdxcYuYe8LuOniNuT
         X3NWKBtUTZNwWzH4QdfISvKX1ijC0WeGE/C65YYC5YqHYsQNUuHb5V8qnOv7MUfa0dUu
         NJl8myR7Y8ZJr1YrFYOuDk92M2Nrxb2VFvnnKsyVWcss0LjCxJgyReE5FkRUqQ3KgMtZ
         4pmevlsBU9I8zpn4U435eqw74Qx+V3ra3J78hvvcKrHOVJwxFAVbz9rz8rfqyS67sZFH
         jdnDLOJepOMVKodaWY5wlHNppq5mV9SQqxISJ251HfZPgBgPur0xAKeaXEHb807eFCk5
         KfRA==
X-Gm-Message-State: ANoB5pk05ZrQTJE99x2Sp5/LBY3+UGX9RoKvahLN/SnMxfDksHfICJ+q
        HDihAYnNQGqimH20/gknbAw=
X-Google-Smtp-Source: AA0mqf5fPwg+u5G0WX6I3elzKWc92F38WOU80BIX7vGpfIsnEwxT1BjfPHEMZKZp948SucURtPpzPw==
X-Received: by 2002:a17:903:230f:b0:188:649b:a0c9 with SMTP id d15-20020a170903230f00b00188649ba0c9mr678532plh.150.1667860556986;
        Mon, 07 Nov 2022 14:35:56 -0800 (PST)
Received: from google.com ([2620:15c:211:201:594a:f636:e461:590b])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b005618189b0ffsm5003579pfl.104.2022.11.07.14.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 14:35:56 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Mon, 7 Nov 2022 14:35:54 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     senozhatsky@chromium.org, hannes@cmpxchg.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, ngupta@vflare.org,
        akpm@linux-foundation.org, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com
Subject: Re: [PATCH 2/5] zsmalloc: Consolidate zs_pool's migrate_lock and
 size_class's locks
Message-ID: <Y2mISkYYjst0qxkY@google.com>
References: <Y2SN5tMH8CqYHsYK@google.com>
 <20221107213114.916231-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107213114.916231-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:31:14PM -0800, Nhat Pham wrote:
> We have benchmarked the lock consolidation to see the performance effect of
> this change on zram. First, we ran a synthetic FS workload on a server machine
> with 36 cores (same machine for all runs), using this benchmark script:
> 
> https://github.com/josefbacik/fs_mark
> 
> using 32 threads, and cranking the pressure up to > 80% FS usage.
> 
> Here is the result (unit is file/second):
> 
> With lock consolidation (btrfs):
> Average: 13520.2, Median: 13531.0, Stddev: 137.5961482019028
> 
> Without lock consolidation (btrfs):
> Average: 13487.2, Median: 13575.0, Stddev: 309.08283679298665
> 
> With lock consolidation (ext4):
> Average: 16824.4, Median: 16839.0, Stddev: 89.97388510006668
> 
> Without lock consolidation (ext4)
> Average: 16958.0, Median: 16986.0, Stddev: 194.7370021336469
> 
> As you can see, we observe a 0.3% regression for btrfs, and a 0.9% regression
> for ext4. This is a small, barely measurable difference in my opinion.
> 
> For a more realistic scenario, we also tries building the kernel on zram.
> Here is the time it takes (in seconds):
> 
> With lock consolidation (btrfs):
> real
> Average: 319.6, Median: 320.0, Stddev: 0.8944271909999159
> user
> Average: 6894.2, Median: 6895.0, Stddev: 25.528415540334656
> sys
> Average: 521.4, Median: 522.0, Stddev: 1.51657508881031
> 
> Without lock consolidation (btrfs):
> real
> Average: 319.8, Median: 320.0, Stddev: 0.8366600265340756
> user
> Average: 6896.6, Median: 6899.0, Stddev: 16.04057355583023
> sys
> Average: 520.6, Median: 521.0, Stddev: 1.140175425099138
> 
> With lock consolidation (ext4):
> real
> Average: 320.0, Median: 319.0, Stddev: 1.4142135623730951
> user
> Average: 6896.8, Median: 6878.0, Stddev: 28.621670111997307
> sys
> Average: 521.2, Median: 521.0, Stddev: 1.7888543819998317
> 
> Without lock consolidation (ext4)
> real
> Average: 319.6, Median: 319.0, Stddev: 0.8944271909999159
> user
> Average: 6886.2, Median: 6887.0, Stddev: 16.93221781102523
> sys
> Average: 520.4, Median: 520.0, Stddev: 1.140175425099138
> 
> The difference is entirely within the noise of a typical run on zram. This
> hardly justifies the complexity of maintaining both the pool lock and the class
> lock. In fact, for writeback, we would need to introduce yet another lock to

I am glad to make the zsmalloc lock scheme simpler without meaning
regression since it introduced a lot mess. Please include the test
result in description.

Thanks for the testing, Nhat.
