Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327A45B3ADE
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiIIOlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:41:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbiIIOlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:41:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77FC1A83D;
        Fri,  9 Sep 2022 07:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86240B824F3;
        Fri,  9 Sep 2022 14:41:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35409C433D7;
        Fri,  9 Sep 2022 14:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662734491;
        bh=pDF6CD/WdtmLsC5f7nZVdUYpLF0DXSpD2lwT2UkCrHY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Oye9TXCjm6FroeQGIcG7qdbbL0U64P7kPBp4KY5PBN94fUjKiZSK3VrYbtkDs56+c
         cUYmbzImBsa68VC1BkH1AT5Wk3O1rjaybNE1caG4P55HBRKY+14zVAnFNvv6Ctu9qJ
         LIS4ikbUMrDIN1h5+fEQQPM4/agCpcxsKn8QNkMd+Wd66Tp8NKLT+khEUoZ2cxxhdc
         VDFKbsm2LkcjJIGSFLTvs6L9sAY9DEqhuSB+Iq+DqyqgmC4rAdr8URTqAarsUYA5k+
         cwJ1bQYVRazwfXV7XoBUtav2PbgkBJ1F/2mXQYzurVQVDtPZRp8cn33cj3xYRfRxnx
         0mIHvlpVXeypg==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11eab59db71so4358006fac.11;
        Fri, 09 Sep 2022 07:41:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo17jQ2B9CJWAinuND6nFqvuPyrM2HDAAcyWKDC4Fvwjm7CvQYdz
        GiUTYImR6+vLQf0iAzU2ulma9eApzqxSvGX6iwc=
X-Google-Smtp-Source: AA6agR6+EQnoPxBIvpImza/d4R+Tj6tPh6AhtM51xa7vMyTem/ovG9YHmMcMxgIsmKqH6tk8zsP+oa3W3g3Lza7BVEM=
X-Received: by 2002:a05:6870:32d2:b0:127:f0b4:418f with SMTP id
 r18-20020a05687032d200b00127f0b4418fmr5404709oac.22.1662734490372; Fri, 09
 Sep 2022 07:41:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220908161516.4361-1-logang@deltatee.com>
In-Reply-To: <20220908161516.4361-1-logang@deltatee.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 9 Sep 2022 07:41:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7HrBNr9JZZoia_UyPyUG3yd_Kbb=F+P2F7iLmF0SvGKw@mail.gmail.com>
Message-ID: <CAPhsuW7HrBNr9JZZoia_UyPyUG3yd_Kbb=F+P2F7iLmF0SvGKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] A couple more bug fixes
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 8, 2022 at 9:15 AM Logan Gunthorpe <logang@deltatee.com> wrote:
>
> Hey,
>
> The first two patches are a resend of the two sent earlier with tags
> collected and a couple minor typos fixed.
>
> The third patch fixes the deadlock issue I brought up in another email.
>
> These patches are based on the current md/md-next branch (526bd69b9d3).
>
> Thanks,
>
> Logan

Applied to md-next. Thanks!

Song

>
> --
>
> David Sloan (1):
>   md/raid5: Remove unnecessary bio_put() in raid5_read_one_chunk()
>
> Logan Gunthorpe (2):
>   md: Remove extra mddev_get() in md_seq_start()
>   md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d
>
>  drivers/md/md.c    | 1 -
>  drivers/md/raid5.c | 5 ++++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
>
> base-commit: 526bd69b9d330eed1db59b2cf6a7d18caf866847
> --
> 2.30.2
