Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7046016DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 21:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230261AbiJQTDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 15:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiJQTDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 15:03:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 110F675CE7;
        Mon, 17 Oct 2022 12:03:36 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c24so11626514pls.9;
        Mon, 17 Oct 2022 12:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3BMycGNfRa5ROS0hbmq3Pvmc1mwuNEkWexZaQuhsaY=;
        b=EP5PaR13gIQf5w4smA+LxCuJFo9ltpABPa3ZCotYT4UdiLCio2xHHBjYXr03B7U72A
         VUx6o0vueDWECfyWlQXW4OjmVk+OkwH3u45yvEy28BKfCkejMolRx7tYGVelbGNj/lvv
         EJcv1yMsh5VN43+kkwtNLFOX+/pV0toOgcnmr16N0/Kt5S0zU/eGFcmvioZ3JUv/Tat3
         f+9tBPd/70lkcq8k2fxVUadND+SrxLyYtDVVPyuGNLymbEvwFX448uvbhbvop34rBVdX
         Pp2vySckz58E+uhgkwOYgMQIt6BKJsrYk80we9LXTK7lt3QOGItp2w/jhez5l0L0rhVY
         0PkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3BMycGNfRa5ROS0hbmq3Pvmc1mwuNEkWexZaQuhsaY=;
        b=ax4rpIda49duLVFDoTyJ963rp1qJYhNZG4F9WccFJviD3l9iDWfUH7xBEmU/1SX+Lm
         sAFLSj65fVjCAoXe+SxE3T+FiyPBwilF+vAGPemIMlbfclIUrRftPYg9mcaTgMjV5w/R
         AI0TDRn5lCGyI5O0vP5IdzO4SVPtYngbre61KQw3bhamALU16awQyIAtC2hELgtJpy7A
         cSqC9Fw1PNUUr2X8tH6MQfGwK05L0MDDJmi2TO9mw8eNwUMZmPDxZXhVYFmhqblTHSsD
         SBwP14M/QwnRsUJfmei88F7McVIp050bC+C+cFuL5eW5L3zBklAQg1k6IZN/J0kpu9NL
         aBBA==
X-Gm-Message-State: ACrzQf0Rz7xi8CJgfGnlGk6VoUpFUZ6i2sW2nXvpt5gXGL3thdmJyIzf
        osB3i1SydyPnl6BR8uCyMgjRICOIN+AW4A==
X-Google-Smtp-Source: AMsMyM5O6qEy0m8EHNYSQ1nlSd0S263M3qfhYkt9MJpdVZ9ERQz7EXVIYD3bE9+BR+TOr6laAmB/IA==
X-Received: by 2002:a17:90b:2241:b0:20d:b273:26af with SMTP id hk1-20020a17090b224100b0020db27326afmr14694780pjb.245.1666033415461;
        Mon, 17 Oct 2022 12:03:35 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b0017f7bef8cfasm6971161ple.281.2022.10.17.12.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 12:03:35 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Oct 2022 09:03:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] blk-iocost: Trace vtime_base_rate instead of
 vtime_rate
Message-ID: <Y02nBcwomc+9xZ+l@slm.duckdns.org>
References: <20221017020011.25016-1-shikemeng@huawei.com>
 <20221017020011.25016-4-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017020011.25016-4-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 10:00:06AM +0800, Kemeng Shi wrote:
> Since commit ac33e91e2daca ("blk-iocost: implement vtime loss
> compensation") rename original vtime_base to vtime_base_rate
> and current vtime_base is original vtime_base with compensation.
              ^
              vtime_rate

There are multiple places with the same mistake. Can you please fix the
patch description?

> The current rate showed in tracepoint is mixed with vtime_base
> and vtime_base_rate:
> 1) In function ioc_adjust_base_vrate, the first trace_iocost_ioc_vrate_adj
> shows vtime_base, the second trace_iocost_ioc_vrate_adj shows
> vtime_base_rate.
> 2) In function iocg_activate shows vtime_base by calling
> TRACE_IOCG_PATH(iocg_activate...
> 3) In function ioc_check_iocgs shows vtime_base by calling
> TRACE_IOCG_PATH(iocg_idle...
> 
> Trace vtime_base_rate instead of vtime_rate as:
> 1) Before commit ac33e91e2daca ("blk-iocost: implement vtime loss
> compensation"), the traced rate is without compensation, so still
> show rate without compensation.
> 2) The vtime_base_rate is more stable while vtime_rate heavily depends on
> excess budeget on current period which may change abruptly in next period.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

Other than that,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
