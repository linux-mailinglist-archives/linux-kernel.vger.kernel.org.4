Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B96570A2AD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 00:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjESWHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 18:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjESWHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 18:07:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74055121;
        Fri, 19 May 2023 15:07:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DB3161B8E;
        Fri, 19 May 2023 22:07:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F60FC433D2;
        Fri, 19 May 2023 22:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684534064;
        bh=cwtMKNc7g+u1PEhQvV8b9nMBwF20gi4zaYJxK0R+El8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aq0ulOkABWyvoL4xYBYd6VvTLtimaPXaFXs3fKhXQQKCGlM+A61Iseea1v+snyKev
         A5R4IzpXKmymazXLT2U2j4Au14pmQDd2D+qpkCv3RtxGdf7hA8DqAmvF1d2XiB2kLS
         ls21Wo3M43OzoI2mGZAdZzlJ2v+QOLhjLzNtS8K9E1dzq1x1WmBMk5PnTms7dvGIfU
         X7HScaO7gmnbkv20/E1bXt8XQxrRRI2fPT2yyE+h3JzbQO83OXq5uCtRxLJLHlmv6B
         ag4mt4GCHpxLLWIwGiaUx5ut8bXlTPybJ56/gYhgJVand9tdBfa2ymz46XkIFKIhji
         i2zNMp0/Wkm3w==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2af2696fd1cso12229171fa.2;
        Fri, 19 May 2023 15:07:44 -0700 (PDT)
X-Gm-Message-State: AC+VfDybvtTT5BG2ZPcQaIttoscvJHnJao+FazINsKrY5hB7wqyirQpf
        yS6Vnc3T9mEXSHMNDVmoRAq7IFW6Xih5BCG/fso=
X-Google-Smtp-Source: ACHHUZ7XIWxxaERb03rLpuOsmhZ3XsiBSvWSkxnf/3UdjvDEEgtu0D42KIzPNPCVtgdwk4uuAeYPkqsrD5CRuOcxjds=
X-Received: by 2002:ac2:5333:0:b0:4ed:d2cf:857b with SMTP id
 f19-20020ac25333000000b004edd2cf857bmr1237996lfh.5.1684534062506; Fri, 19 May
 2023 15:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230515134808.3936750-1-linan666@huaweicloud.com>
In-Reply-To: <20230515134808.3936750-1-linan666@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 19 May 2023 15:07:30 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7m5hFY2L=2_FA-Qq3Yxr0a4r_QHdXSeZQ8kLgXMvj1sA@mail.gmail.com>
Message-ID: <CAPhsuW7m5hFY2L=2_FA-Qq3Yxr0a4r_QHdXSeZQ8kLgXMvj1sA@mail.gmail.com>
Subject: Re: [PATCH OLK-5.10 v3 0/4] md: bugfix of writing raid sysfs
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
> The patch series fix the bug of writing raid sysfs.
>
> Changes in v2:
>  - in patch 1, move check out of md_bitmap_checkpage().
>  - in patch 2, use div64_u64() and DIV64_U64_ROUND_UP() instead of direct=
ly
>    '/', and chang old_delay/old_delay to unsigned int.
>  - in patch 4, use 'goto' to make changes more readable.
>
> Changes in v2:
>  - add patch "md/raid10: optimize check_decay_read_errors()".
>  - in patch 2, return ret-value of strict_strtoul_scaled if error occurs.
>  - in patch 3, optimize format.
>
> Li Nan (4):
>   md/raid10: fix slab-out-of-bounds in md_bitmap_get_counter
>   md/raid10: fix overflow in safe_delay_store
>   md/raid10: fix wrong setting of max_corr_read_errors
>   md/raid10: optimize check_decay_read_errors()

I applied 1/4 to md-next.

Thanks,
Song
