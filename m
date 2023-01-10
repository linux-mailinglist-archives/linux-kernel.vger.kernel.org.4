Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9D664B32
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 19:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239715AbjAJSjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 13:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbjAJSiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 13:38:25 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F229843192;
        Tue, 10 Jan 2023 10:33:51 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id c26so5109703pfp.10;
        Tue, 10 Jan 2023 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KsouuxBuiJc8vCJmbxhsGZquFChD89mMF5fleuPLAHA=;
        b=D1xx5iOXYizVGZVmUvuz9gRyo14PnGlDQ6ranZeCRfesSPH8+Qnz4auvd5EtnC0PE8
         MgHP/5WpYr/2G7BerNwWDjje1kCygPwKyDHSkS1+JGa7oAnZ9bcnrPKioWVbtH4I8Ryn
         db3M9NylNS+zcLnako5DP2hGo/vHzlHySxJQqhz7coImcT/ibiJhXMNUudg7tzekFWsN
         LmEPtrzPrTqeCbF4HrZ8seNfARqO4pGKuC0b7MVsdctCiRtutKrpXYypFDvmcppzvHUT
         ou2I6QDlhQqfwxIpNdSaMXod5hCHrKWtixZdSqaqAiji9CtnHmno4Oq5afQtpYf7CLrL
         JHag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KsouuxBuiJc8vCJmbxhsGZquFChD89mMF5fleuPLAHA=;
        b=VMH+148sM1EmukXsp7IMol80NAhg5oaWUjvyeavGk+bKVFMC1wzsSkG0YUvF1RA3MC
         /Au98wJjedrE/peCe+46WSIFe6Mqff9o2NEda5M5Krx4u7zJycgsSiJD7WNiz6Rsr3hI
         uF7JuzWUPlUNhzRGE/e6z2WnrIHL81pL/2e97Za2zdnMnUGzTnNDbTIKoaOTn150MHSK
         w/BHKOiKMZye07LwmopyMX/3x6Gop4HVVeF1vw6F3FcivfnWcDmK9gWyK5pYnkM23XUN
         71ZonbivI7j4N4oO+WojphK3VHrzEyXwFjWDtW0vuAbHK8Temgh9Qa6UELv8SO5MAT4G
         UBDA==
X-Gm-Message-State: AFqh2kqTGymroRQrvhG7HT1b+OVlwSz8TzS+bMhF8zjMVUcHlIeh1lhw
        Xd2E+DI0DBQQMvXF4FKmEtQ=
X-Google-Smtp-Source: AMrXdXsWYPTxoousUtpq9sVyFa/er9qVXOf9kYAZG7rErauBT29M3xD6Lax0ObNnEeh1iAkFj72Obg==
X-Received: by 2002:a62:2903:0:b0:56b:f51d:820a with SMTP id p3-20020a622903000000b0056bf51d820amr67420322pfp.7.1673375631351;
        Tue, 10 Jan 2023 10:33:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p62-20020a622941000000b0058130f1eca1sm8348609pfp.182.2023.01.10.10.33.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 10:33:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 10 Jan 2023 08:33:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] blkcg: Restructure blkg_conf_prep() and friends
Message-ID: <Y72vjbufcqtRdl2C@slm.duckdns.org>
References: <20230105212432.289569-1-tj@kernel.org>
 <20230105212432.289569-3-tj@kernel.org>
 <20230110070929.GH10289@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110070929.GH10289@lst.de>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 08:09:29AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 05, 2023 at 11:24:30AM -1000, Tejun Heo wrote:
> > * blkg_conf_open_bdev() is updated to take a pointer to blkg_conf_ctx like
> >   blkg_conf_prep() and can be called multiple times safely. Instead of
> >   modifying the double pointer to input string directly,
> >   blkg_conf_open_bdev() now sets blkg_conf_ctx->body.
> 
> This looks pretty awkward for the externals callers of blkcg_conf_open_bdev
> in blk-iocost.  I'd either keep the calling conventions as they are
> at the moment, or just open code blkcg_conf_open_bdev in blk-iocost.

Because we're coming in from cgroupfs, we aren't synchronizing properly
against blkdevs going away. For all config attempt coming in from cgroup
side, we'll need to synchronize explicitly and these config helper blocks
look like a good place to do so. Please take a look at the thread with Yu
Kuai. Imma update the comment to include that but yeah let's keep it this
way for that.

Thanks.

-- 
tejun
