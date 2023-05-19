Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6117870A29B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjESWB7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:01:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjESWB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:01:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA0DB8;
        Fri, 19 May 2023 15:01:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF1D665AF2;
        Fri, 19 May 2023 22:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C376C4339C;
        Fri, 19 May 2023 22:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684533716;
        bh=zP5YbzLCW3H0+E9nltMtNoB/5VTVg3nEDMBHv7bodmA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bsV1NvDfvlFGN6APD8QVM8hE+rypkD09e2/VlWPZdED6Qp6dqxNZE1rxZJYzxCpFV
         9oVE8jUCYY95Te4GcNIoE1td5uN91V6EzfEdIAD/08zds04vYu6AUpKN/qZ/5orvBB
         KqIOtCGuoJBBL/8pyRH1+rZU06mXvHW4MucelwUs3vf+pi3jVIzP9F3B4vutUvJVTb
         K6KahXfBHmEbEN0OV7hfsot3XhkM8FSmPAiQRECczdesMGBNRE4YNMQo1O/RprNMCf
         Y4ahONiGYF7CEtwgeejjeoh+E5hx9jLiiDr2fAa3t86eAY9MTXI8H98poBe6+002K/
         YRaigv7zSz1Yg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-4efe8b3f3f7so4271911e87.2;
        Fri, 19 May 2023 15:01:56 -0700 (PDT)
X-Gm-Message-State: AC+VfDza118GaZuIZBNO9s/noqkDBlmQaYZ0/wxH+3M8PUsdS23CMY33
        9fbuqcZ1EUAJmLT2WKWKo+j6CXgZXPoi+7vZkQE=
X-Google-Smtp-Source: ACHHUZ61GFQXgASCQYjDCJyi45K5KlKEUFmHKNXXkbtTeByodchdOGGwTLqGV1P53cPWhRppnf/U/xGLBeSFZhVbX/g=
X-Received: by 2002:ac2:547c:0:b0:4ef:f01d:5a96 with SMTP id
 e28-20020ac2547c000000b004eff01d5a96mr1016203lfn.21.1684533714316; Fri, 19
 May 2023 15:01:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230515134808.3936750-1-linan666@huaweicloud.com> <20230515134808.3936750-3-linan666@huaweicloud.com>
In-Reply-To: <20230515134808.3936750-3-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 15:01:42 -0700
X-Gmail-Original-Message-ID: <CAPhsuW53EAK406k+PoLWi2z6SPLJBWa8r4rgXqoYKFRXm-kPSg@mail.gmail.com>
Message-ID: <CAPhsuW53EAK406k+PoLWi2z6SPLJBWa8r4rgXqoYKFRXm-kPSg@mail.gmail.com>
Subject: Re: [PATCH OLK-5.10 v3 2/4] md/raid10: fix overflow in safe_delay_store
To:     linan666@huaweicloud.com
Cc:     neilb@suse.de, Rob.Becker@riverbed.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 6:49=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> There is no input check when echo md/safe_mode_delay and overflow will
> occur. There is risk of overflow in strict_strtoul_scaled(), too. Fix it
> by using kstrtoul instead of parsing word one by one.
>
> Fixes: 72e02075a33f ("md: factor out parsing of fixed-point numbers")
> Signed-off-by: Li Nan <linan122@huawei.com>
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/md/md.c | 76 +++++++++++++++++++++++++++++++------------------
>  1 file changed, 48 insertions(+), 28 deletions(-)

This patch adds more complexity, which I don't really think is necessary.
Can we just check for overflow in safe_delay_store()?

Thanks,
Song
