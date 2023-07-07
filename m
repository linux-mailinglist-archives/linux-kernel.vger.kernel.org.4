Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9822674ACA3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 10:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjGGIRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 04:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbjGGIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 04:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D451BEE;
        Fri,  7 Jul 2023 01:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C16CC617BD;
        Fri,  7 Jul 2023 08:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29431C433CB;
        Fri,  7 Jul 2023 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688717829;
        bh=W0/B/qPXHHa+Maje0tj77VdjJtAsDBCZCFAt6sYoe+Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BTVT7veMJvLo4F709L2dM/KUy/LCK9SNL/jMvpBufwbZAz72tSrKX4QYA9T44l7X3
         sO+bSEU8LjJYPo2f3XniEYRi77H6UVD/SJKar/kqPVQ0JU6Q2VYBbKKQzLC2/wXX8t
         YKQFjdiiRB6K1cvcE3qpp17LmFDyYMiaqfWHnpHP2pBPkeejQgmyw98izl2ZpacBes
         IaCx7GcQY7Q5DjnFTrxIbzV3OWc6lW55vO+dC5rhU2ghZlP5t3SoFqJndtDos9Z2ud
         ISRE5d5uLmmSaKH/dH7uFNh2XyzjU7wsgeSWz/4PmFkJhxH8OSnCmR4ItxO72ICrj2
         lM99PbYwSQnVg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso2503001e87.0;
        Fri, 07 Jul 2023 01:17:09 -0700 (PDT)
X-Gm-Message-State: ABy/qLb3/MidSrvv0n+MtBk8GQzeA4NTJKfBGuScc+wm/Hcoc4H9Ak8n
        CGk7nNLDfuOjck8H5hru9f7A9paAQbj5LMyscVE=
X-Google-Smtp-Source: APBJJlH/9Z3Z//zn7zLvEe/Ttc9mK0sXbxCZurgYU7BI4jX/uy9q4J+JkBbCSBOcOMmM70Qg0g/4GLEeoYOwPmAOiJ0=
X-Received: by 2002:a05:6512:b96:b0:4fb:a990:bb28 with SMTP id
 b22-20020a0565120b9600b004fba990bb28mr4618279lfv.18.1688717827070; Fri, 07
 Jul 2023 01:17:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230623173236.2513554-1-linan666@huaweicloud.com>
In-Reply-To: <20230623173236.2513554-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 16:16:54 +0800
X-Gmail-Original-Message-ID: <CAPhsuW616X_A49wGFY3QXy636eHN9-d_ryo2s9fN1R_ZpOUyEw@mail.gmail.com>
Message-ID: <CAPhsuW616X_A49wGFY3QXy636eHN9-d_ryo2s9fN1R_ZpOUyEw@mail.gmail.com>
Subject: Re: [PATCH 0/3] md/raid10: optimize and fix read error
To:     linan666@huaweicloud.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 5:34=E2=80=AFPM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> This patch series optimizes and fixes fix_read_error().
>
> Li Nan (3):
>   md/raid10: optimize fix_read_error
>   md: remove redundant check in fix_read_error()

Applied 1/3 and 2/3 to md-next. Thanks!

Song


>   md/raid10: handle replacement devices in fix_read_error
>
>  drivers/md/raid1.c  |  2 +-
>  drivers/md/raid10.c | 50 +++++++++++++++++++++++----------------------
>  2 files changed, 27 insertions(+), 25 deletions(-)
>
> --
> 2.39.2
>
