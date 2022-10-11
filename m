Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931FF5FB8E0
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 19:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiJKRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJKRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 13:03:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180DF4B0E3;
        Tue, 11 Oct 2022 10:03:15 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id l4so13780168plb.8;
        Tue, 11 Oct 2022 10:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5eXkoC9hAZJwJzWJaLG/RPjzvK4h+pLW6Xg5hPVy600=;
        b=iYIPyuqdrLz2UyjdXFjDeb0hETXTPidp/mChDGbvxDMNB+xoeQAn85ZsTJU1vOtqj7
         untbFhiQQN4GIcgDGQ/ZuFL8NHS6z/n55L+CRwPjh6z2Bdb4mt9E/SGT6i22HBH6I6ks
         oIh3/SJCxdGaHZDRoJHGzc7L3PmwIy+tyThiLbvg4XTUZpwd6ANUACtD0VKK8jPAG4Ht
         r7Rf0pEC+W+a4v3+ufHam17HZyP10NyNrUW7EtGjwjER6ClQ5MEqUFWSNgXpnaJFckqh
         eywMK3eq+U84OzuWXX8m4PGYzGnCtg83IRdiZjzhuV5vIvzJt6RMeV1++UsC0b14BJlg
         6Fmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eXkoC9hAZJwJzWJaLG/RPjzvK4h+pLW6Xg5hPVy600=;
        b=CdeIcy1VdTuu+RFlzu9423KJ9rRZn8Yt1/aHjUtpgrlElw56iLqO6maXCYr1w5Epkt
         4JhxdxA/n3Y0zr8A+WYLZb9vDXMUTcA42Q5337XfbuaBQvAMtkaHAXmJK4C49/EXKNjS
         B8AiL9jquUbOaTHvy6r9lTmaWcGTXWf37YXBfSmtF+p5ESdL99knqQA4d63oZtaAeDKI
         nfcz++pUD4qI4CzwLWxI1Nn9mf+5KKo3usxoBxsuWkIII4ctVbqMVrIiaDkgFR+rbxHy
         YX5zO6NLklX7ZoJQmjW+kU4otNmSbeUdD7Ol3XQKjuxEkLeKSJKLZy13Eb+/AsJAb8zS
         Jahg==
X-Gm-Message-State: ACrzQf0bAUaBg8CQxa782rI8D+VrwfdBSZ50vxVQDBFHUhbdKUHhP6qV
        UTlG6RMdlYAKFaR19w4Vrm8=
X-Google-Smtp-Source: AMsMyM5dqWu7bG5Za91UAlHvYwA0HOoPggytg6ysGIpjemmkJf/l0R6jLjhKUxbWuPsrD93BnEKjfA==
X-Received: by 2002:a17:903:1c3:b0:177:ef4b:c614 with SMTP id e3-20020a17090301c300b00177ef4bc614mr24860401plh.17.1665507795331;
        Tue, 11 Oct 2022 10:03:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g2-20020aa79f02000000b0056160437e88sm9353506pfr.20.2022.10.11.10.03.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 10:03:14 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 11 Oct 2022 07:03:13 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -next 3/5] blk-iocost: prevent configuration update
 concurrent with io throttling
Message-ID: <Y0Wh0fQBkKlhEiYi@slm.duckdns.org>
References: <20221011083547.1831389-1-yukuai1@huaweicloud.com>
 <20221011083547.1831389-4-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221011083547.1831389-4-yukuai1@huaweicloud.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 04:35:45PM +0800, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> This won't cause any severe problem currently, however, this doesn't
> seems appropriate:
> 
> 1) 'ioc->params' is read from multiple places without holding
> 'ioc->lock', unexpected value might be read if writing it concurrently.
> 
> 2) If configuration is changed while io is throttling, the functionality
> might be affected. For example, if module params is updated and cost
> becomes smaller, waiting for timer that is caculated under old
> configuration is not appropriate.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
