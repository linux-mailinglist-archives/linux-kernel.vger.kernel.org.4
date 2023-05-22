Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A7E70C4A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbjEVRuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbjEVRue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CD0115;
        Mon, 22 May 2023 10:50:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 38030625C6;
        Mon, 22 May 2023 17:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04ABC433A1;
        Mon, 22 May 2023 17:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684777827;
        bh=dsFZ5PVgq9fTFieENigW13l6w9ESiydtMhSrGCI5I/Y=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hXzcOpgdUEybB19Zikm4EJD8RAgCCzJorksBBn1rirEc6w5CNttm4J2qCNb4/lCRH
         5A3LBd7+Kt3dzFodt2p4TE+XFnJA76DKIxxo8Y2E5wtjzsVPTGRFfj8TZI7dt0HXaN
         Ee3ttQXM5F/Gv5HJ+qt6aJNK3E7rcPLOhSbIE+9WXJhgmGVtWJluZpGio5G4g6tTqU
         Urydy414xANla0XBuyjcdOsBb9MEPrwogBhBeXiwX9+9lzHoqYVYIssTdx/joxQjHp
         gjDyt0ulDNo9rqCY0oxZhghLdx/QVh5d896YsiYu6TO2mXl4Dx9ArAIT39KPg4KQHm
         0Ff9yPwqzhRHA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f3b4ed6fdeso2962509e87.3;
        Mon, 22 May 2023 10:50:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDxXBIz1yFCRcVDUGnBpIReY7sHIqK9zS/UxokqIx9ZTjziMXyWk
        yWScBxMUYG0KQIYC6h3bFPwsMRrew2PBAQM+qrg=
X-Google-Smtp-Source: ACHHUZ5lSX0Lg4WijYEVRXtt2iUQF2Hs/IdEN9/HQCTfHcYhhquMNRnDPdJTp+M3mZJtTjRbMg9BSY2zUAZd9MiQ2Ww=
X-Received: by 2002:ac2:4556:0:b0:4f1:3d9f:1b4f with SMTP id
 j22-20020ac24556000000b004f13d9f1b4fmr3613992lfm.49.1684777825538; Mon, 22
 May 2023 10:50:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230522072535.1523740-1-linan666@huaweicloud.com>
In-Reply-To: <20230522072535.1523740-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Mon, 22 May 2023 10:50:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW456SReTmaWPa9pjtdWqOhCs5F1N-QKuyT3m=RqhA=1Sg@mail.gmail.com>
Message-ID: <CAPhsuW456SReTmaWPa9pjtdWqOhCs5F1N-QKuyT3m=RqhA=1Sg@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] md: bugfix of writing raid sysfs
To:     linan666@huaweicloud.com
Cc:     neilb@suse.de, Rob.Becker@riverbed.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linan122@huawei.com,
        yukuai3@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
        yangerkun@huawei.com
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

On Mon, May 22, 2023 at 12:27=E2=80=AFAM <linan666@huaweicloud.com> wrote:
>
> From: Li Nan <linan122@huawei.com>
>
> The patch series fix the bug of writing raid sysfs.
>
> Changes in v4:
>  - in patch 1, check overflow in safe_delay_store() directly.
>  - in patch 2, check input number instead of using unsigned int.
>
> Li Nan (3):
>   md/raid10: fix overflow of md/safe_mode_delay
>   md/raid10: fix wrong setting of max_corr_read_errors
>   md/raid10: optimize check_decay_read_errors()

Applied 1/3 and 2/3 to md-next.

Thanks,
Song

>
>  drivers/md/md.c     |  9 ++++++---
>  drivers/md/raid10.c | 41 ++++++++++++++++++++++++-----------------
>  2 files changed, 30 insertions(+), 20 deletions(-)
>
> --
> 2.31.1
>
