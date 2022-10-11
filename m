Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6075FB8CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiJKRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJKRBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:01:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E643ACB;
        Tue, 11 Oct 2022 10:01:23 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id b15so13031272pje.1;
        Tue, 11 Oct 2022 10:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNUc9BCmM4ZwS+3MShdvVycW+/epRqCLnKrcQEgJCgM=;
        b=YJ/6NJK2TloyXgRYChIznahV5jEDNbFFN2v0rhH2MuPWwZTw3wKq4lvSTKEMZjEXZq
         aKVUuManztmDOjqYBhWmTFHrqs+e6wBy3OXRgY+XNhuPnj06FMK/q6kEtZfM9NivCioK
         D2lDyYrkQxl4sBfjMmz+RCvjvYuSSKoIl+bbfDcSQz6hmnb4wr8CT1RAKYcr5FqBJc2p
         6AmnjdF1xWcl31+FE4b1M3lkshkdmNV62NCliLYzunMdUWBOZ17gWIchkP0mx6fdMwQm
         qogdogzqwNVfe0PQzx9hoxxMihVFlaQxxEwLBIPLTwuA9dGIBRmdXLwk+LJ7BDc9Am7K
         cxhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gNUc9BCmM4ZwS+3MShdvVycW+/epRqCLnKrcQEgJCgM=;
        b=DR1b2HBHRnTe+so75++OJ4an+zj/MJZAJ64UgJwZIuixn9jDJCOoH5IyOpVQ7Leyzv
         0EQc4ZZ7H2kJR0hVgstQso8dhfnRZhX0hBZhRrDvnpeWGz3wtEm9+ySDe++QCBBU8Cck
         DjTdlKT+PueLD1+D1+HpfEmpd8LPrzgzGJ6zKXyT0iz68+EfgJYXqCBkGVNTVWeJuae4
         1nT+nAqJRqGT8RGTAYbPBFkodZYqO+rXDyLbBrGpyyOC5WjCa6UsO0Q4vi+i1DWhqpMw
         mRG2Frivg7dOVt9qboJh7LYBwdQDWdD2st3YIax9pCgQ+9IklyGADf6+x7wWYWVf6ffJ
         DJUg==
X-Gm-Message-State: ACrzQf2jvsDh+4DY8M06Me1hHxh6PQVF2ZxefPu9ktRMv3aPyqEcm0kq
        Y4ZATe8Jrvd5nD9CFwAensc=
X-Google-Smtp-Source: AMsMyM4y/9VvY9YDRGPbNhKsH/73GaZPOuC5rkwd6CGJRKXQif9WWu/vl6DX2nRUmyhflQpZE2g25A==
X-Received: by 2002:a17:90a:72c4:b0:20d:51af:3fc4 with SMTP id l4-20020a17090a72c400b0020d51af3fc4mr124084pjk.38.1665507682669;
        Tue, 11 Oct 2022 10:01:22 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090a2a4500b001f2ef3c7956sm11221474pjg.25.2022.10.11.10.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:01:22 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 07:01:20 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 5/5] blk-iocost: read 'ioc->params' inside
 'ioc->lock' in ioc_timer_fn()
Message-ID: <Y0WhYBXCe5Do6A4z@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-6-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011083547.1831389-6-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:35:47PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 'ioc->params' is updated in ioc_refresh_params(), which is proteced by
> 'ioc->lock', however, ioc_timer_fn() read params outside the lock.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
