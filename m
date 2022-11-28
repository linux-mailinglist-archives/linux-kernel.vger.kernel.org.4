Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6109163B287
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 20:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbiK1Tua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 14:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232503AbiK1Tu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 14:50:26 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B85727CC0;
        Mon, 28 Nov 2022 11:50:26 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r18so10870498pgr.12;
        Mon, 28 Nov 2022 11:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sJLt7GYk8MNew0Yb20bEZ+PRRat8WSWw59NA0kHseaM=;
        b=EypCwZP3Sc5Sln+WMt2wq5hNGJgdOMl88TUeFZscGAi1HgNz4Oykk9qGsiDpaioOUW
         lhTiRrimi9Kcfm8GELBX12KMPEMwJi8DdKhKTFb42fbWFbfisBD+KvZYd4lDQOYTILC9
         t9/l9YW+tkaiZ1VNuA8+kfZbLaxT/lOZHNDLhcFSK+WWhFm0WnmgFZPFiy+0Kk0Z1826
         nak2YFyYkQ+5hWEYoEeZA37EovBcCBTVEl1DcnIgnT5z65IF27iLaQl+zcuhdTRZaw54
         m+m+BP18v55s5tCzqbQxHMAOc2wZQNoNibeD7XBgRgUEbIVz92SvfqSKsj8XUR/ssESK
         SHFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sJLt7GYk8MNew0Yb20bEZ+PRRat8WSWw59NA0kHseaM=;
        b=pQO3TJJhDsUWmXPV3mgI7TOQbY7Vpx/RUkNH9nQH2aS3x2wN2OXxTjF3Yl27dMGWjS
         oi1SmTnMMBccByUnipeRsefka0fJCRD8x0YPrvMDpff909oPCcEtGx+Sd0PcSeRVW6OU
         Lp7QvuTrvCUBWUOEGxTYAePctLCNhvZHv6us6oXXOhX3h0XazIT7bXUFpl/88clw/lue
         wdogiAYVtJaBaaO4GaHRnwu4agwzBQZofkCgbuoowrQY7o+pm3gAsxX9bHGo7X3g4dw1
         EdqCuOzDSMcaKuRv8l9DEgYh6hR40oZ/aEvn6EsF19uXMNP5GTQp2qqfnpAz8cf1XHfj
         vJKw==
X-Gm-Message-State: ANoB5pm3zWZEVtiHwdRM7m1JUl0ReEEspBvqTT8mHV494NlNnqnwvonO
        P196EjviFwNVC1lzCr1qznE=
X-Google-Smtp-Source: AA0mqf5L2uN6JBINOzcqWonoKjiK+3fVHUwU45wKEj5I0Ubnl4KU0BFZ10dO3Ihd+0qabvZOBCJxFQ==
X-Received: by 2002:a63:4e4c:0:b0:46f:dc59:aab6 with SMTP id o12-20020a634e4c000000b0046fdc59aab6mr48015580pgl.35.1669665025514;
        Mon, 28 Nov 2022 11:50:25 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fd7c:c075:f9ff:46c4])
        by smtp.gmail.com with ESMTPSA id m20-20020a170902c45400b001897de9bae3sm4315872plm.204.2022.11.28.11.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 11:50:24 -0800 (PST)
Date:   Mon, 28 Nov 2022 11:50:21 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 3/4] media: i2c: s5c73m3: remove support for platform data
Message-ID: <Y4UQ/VUC6TqMpvg2@google.com>
References: <20221115221145.2550572-1-dmitry.torokhov@gmail.com>
 <20221115221145.2550572-3-dmitry.torokhov@gmail.com>
 <9098a44c-8551-f42c-ac19-15ffa7174e37@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9098a44c-8551-f42c-ac19-15ffa7174e37@xs4all.nl>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On Mon, Nov 28, 2022 at 09:39:04AM +0100, Hans Verkuil wrote:
> Hi Dmitry,
> 
> I received multiple patches for this driver that switch it to using the gpiod
> API. I chose to go with Linus' patch [1]. Primarily because that one was
> reviewed/acked by more people.
> 
> That means also that this patch that removes the platform data no longer applies
> cleanly.
> 
> Can you post a v2 of this patch that sits on top of [1]?

Sure, I just sent out the v2.

Thanks.

-- 
Dmitry
