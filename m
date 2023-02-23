Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 295B36A0196
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 04:43:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjBWDnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 22:43:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbjBWDnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 22:43:43 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015982194F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:43:30 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id ko13so11967433plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 19:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmZbWBcg/AW2Tz+32ksLqYO/e6dt8EO4hZXdp/nul3s=;
        b=jgmENm0qng91d/uZPHQSAWkoiVVxT4onyeHR5L5btjZajYusPq4nUw5afIJxAtioSW
         scnBMZU4SusEUc/10D4ADcSUzhExYbRW0FDBS+ZSQdsOjhNIzZIH6Gh54XACwmm/FuvQ
         Ds2udvU7ZUiKYeLH2IRyJpQYiosSYh30jezjIZ8ipOPb1XHpfjNwvLOuMqkQPF3HoGeN
         GOdbKCuAKw2blvJ3Pae92bvI/mkAabOd6Jji/0AN69Xlh2pxnsEHgzI7vb1kiHQyRLKK
         hwXFYBVsDd8ieMUUhHNPOfilqJEmd/zUIGzheKj8Hta9neoVwocb/mdaCyH+l/c73IIu
         slUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmZbWBcg/AW2Tz+32ksLqYO/e6dt8EO4hZXdp/nul3s=;
        b=3fZkR7K99jmZ5uqxNwu78hd6RoN2vId46XbtFw3rCRyj8AiOXAAYRFdbXCoMU+SurS
         OE2n39K5vsUSRv7J5JpBAd+03/TwZQmCGWDwwYMZXhbl58fK301qB9iV5MVrEO/fTjjm
         GFLom9DUq6IcGOf40HII/bRja23E1+ux046SnIb6ndbZSJzRhdOuZPqdgTf0Kk12l66V
         WocJTIj7VjT+hd2wblWpGvCdONwiNmlKP4G+z77hBVHOR0fGA+Q/K3Zyu+RR16qF6LX+
         nrPkqDf4CQc9X9r1xX2ddtuj+K+E0mduS1awXrpkuMGznsMpuqMBQKyiNgPRpltoncYW
         WFxg==
X-Gm-Message-State: AO0yUKVyjJHCe9jM1cu7YP5syLRE8xYkgy76dFghLQ+b5CJYJ6OSFz2i
        MCLtR7iRHt0btYu3u5cWD4cbYT1eg626L5hG
X-Google-Smtp-Source: AK7set+q4wdLmbrdYnGFANCbxREwGbuNbB5X3p6jbUJKYBm9j0HofsQcDFA0tDaKWvi/Ov5hXJcytw==
X-Received: by 2002:a05:6a20:5484:b0:bc:b3fa:ee70 with SMTP id i4-20020a056a20548400b000bcb3faee70mr13545163pzk.0.1677123809888;
        Wed, 22 Feb 2023 19:43:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001991e59fde6sm12491403plb.216.2023.02.22.19.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:43:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     code@siddh.me, willy@infradead.org,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        houtao1@huawei.com
In-Reply-To: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
References: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
Subject: Re: [PATCH-next v4] loop: loop_set_status_from_info() check before
 assignment
Message-Id: <167712380884.13855.10551951254719805732.b4-ty@kernel.dk>
Date:   Wed, 22 Feb 2023 20:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 21 Feb 2023 17:50:27 +0800, Zhong Jinghua wrote:
> In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
> be checked before reassignment, because if an overflow error occurs, the
> original correct value will be changed to the wrong value, and it will not
> be changed back.
> 
> More, the original patch did not solve the problem, the value was set and
> ioctl returned an error, but the subsequent io used the value in the loop
> driver, which still caused an alarm:
> 
> [...]

Applied, thanks!

[1/1] loop: loop_set_status_from_info() check before assignment
      commit: 9f6ad5d533d1c71e51bdd06a5712c4fbc8768dfa

Best regards,
-- 
Jens Axboe



