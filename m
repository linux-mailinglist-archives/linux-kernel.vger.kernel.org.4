Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 681B86014B1
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbiJQRXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 13:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiJQRXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 13:23:17 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5AC71986
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:23:15 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id bb5so8115320qtb.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+SEO6vfxiud9noRziv9aQrD1AXg6nct4mTi/PkkKZhU=;
        b=TevJIWxJKIujgIiWUkwjTCBogHB6CQC5h2eJkmXP/IYKYG8r3uAm1K+3RIq8ww2yPy
         mIXdAErNaWHHEqLmpFDqiC8aSieuZ4b3MmV6ia5yeZ4q0jIhJB4Kjs4e7hRZN72d1oBv
         6xf6PWfS8p5iy7vJorxHgQ6TYG11QysB8xvs4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+SEO6vfxiud9noRziv9aQrD1AXg6nct4mTi/PkkKZhU=;
        b=fo5hK4FdEGLFED6LtVm+/b1ju1aoZzMqtsqcRWemMtO6O2AN7v+JgXCcRmD4ffgli7
         xM8c8k0rE7cWxuLi9XZxipWkUiyByEFbkzfxLLlm4iW2vqx5f47hUo9q9+ukTT9XsQvd
         KAxKYpp8+xPVpmoVTMIv279aB+aiBzLRGf0r5WSfZ9KwlzniAUujMxnJG7KwDqs2NisM
         kBjEVfEpiVjh7lYRfMpscBHfLMaBhh6JALfffRTK6w/tTkx8jXtJ3ksoslcUmf+9n3kO
         fqFzIJldfANm0nEPG/IpUyERH2WRTG8BHWGkX+Pw1A6e92fBOJ98wsxoUxlmbe+P3HO9
         Mt9w==
X-Gm-Message-State: ACrzQf1czh5VagXf34N36XlAzDselyzBzEfViGbZNVtRb8Ih5dzg6E/m
        YaAcAqOH3jcMaBhXEbdRU1C87LyCLNa2oj4N
X-Google-Smtp-Source: AMsMyM7tKcqXRVG615kYKZw/FjMVPXwlubu6N3sqHuS8oE9ZlprUKkYEhrFQAiPrVWZKkmVVC/139g==
X-Received: by 2002:a05:622a:a:b0:35d:4dba:eda1 with SMTP id x10-20020a05622a000a00b0035d4dbaeda1mr9636950qtw.43.1666027394196;
        Mon, 17 Oct 2022 10:23:14 -0700 (PDT)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com. [209.85.160.180])
        by smtp.gmail.com with ESMTPSA id ff13-20020a05622a4d8d00b00397e97baa96sm297710qtb.0.2022.10.17.10.23.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 10:23:11 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id r19so8136776qtx.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 10:23:11 -0700 (PDT)
X-Received: by 2002:a05:622a:58d:b0:39c:d5e3:2346 with SMTP id
 c13-20020a05622a058d00b0039cd5e32346mr9579593qtb.227.1666027390840; Mon, 17
 Oct 2022 10:23:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220926220134.2633692-1-khazhy@google.com> <fff022da-72f2-0fdb-e792-8d75069441cc@opensource.wdc.com>
 <CACGdZYKh4TXSaAAzJa13xsMH=tFzb4dYrPzOS3HHLLU8K-362g@mail.gmail.com>
 <7e3a521e-acf7-c3a8-a29b-c51874862344@opensource.wdc.com> <CACGdZYKvTLd0g2yBuFX+++XeSa6aapuAwOM7e63zhKgdKFEGEw@mail.gmail.com>
 <Y0PHsxmsWHFYiLPK@infradead.org>
In-Reply-To: <Y0PHsxmsWHFYiLPK@infradead.org>
From:   Khazhy Kumykov <khazhy@chromium.org>
Date:   Mon, 17 Oct 2022 10:22:59 -0700
X-Gmail-Original-Message-ID: <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
Message-ID: <CACGdZYKcpHG_bWew_K78CgwDYMQAGfXX+QU4-9PNoV1j2E1a0g@mail.gmail.com>
Subject: Re: [PATCH] block: allow specifying default iosched in config
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:20 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Oct 04, 2022 at 04:15:20PM -0700, Khazhy Kumykov wrote:
> > The kernel already picks and hardcodes a default scheduler, my
> > thinking is: why not let folks choose? This was allowed in the old
> > block layer since 2005.
>
> You can choose it using CONFIG_CMDLINE.  We can't add a config option
> for every bloody default as that simply does not scale.

Are you referring to elevator=? It looks like that needs to be
re-wired for blk-mq, but seems like a reasonable solution. I'll send a
new patch out.

Thanks,
Khazhy
