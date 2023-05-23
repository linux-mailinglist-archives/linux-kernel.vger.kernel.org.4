Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7807070E4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 20:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235832AbjEWSmp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 14:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjEWSmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 14:42:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D41C91;
        Tue, 23 May 2023 11:42:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B57C662CE0;
        Tue, 23 May 2023 18:42:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18974C433D2;
        Tue, 23 May 2023 18:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684867362;
        bh=v8YE8s5U/ap0GHg7YD6rvGKGTml4XQpktCbrArDr6ow=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nyp5R/mmKk19wh/bOEfVm50hft7ft5pr4TKgFKEp6+KvuamiMCnFNumuuXbZubGT2
         e/u4hXsItgNpgCHbVFiNKEDTAcsx495RaTJWY3pYKinEiaB3TPJoFcCV/+aft8a0Mx
         fJOntpHUw+WImVu9ybc4vMBGhd9+5Xq1ut/xDj2TFFUUcUb19Yhbt1sX/WnFhL1tIV
         FoQ8q76UGQp65H58QIy/aPnBqO6ifXZUiJBociJBBusZIK/GnafPKIbOHq3NoXdCLb
         CJlCfBjCDzJKYlkML5BJLVloxl/jihPSmiho+iBOz50nHO6PeBzTsY5I4Z4mg5Fp2p
         UrkIe68epGj1A==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2af2db78b38so2126871fa.3;
        Tue, 23 May 2023 11:42:41 -0700 (PDT)
X-Gm-Message-State: AC+VfDxtlIoL2wUswb9mA+ijsVQqYyYsKapDTfWsfHjtz+LAs6uELd2K
        4JuazMZ1+7N12CdDGs2sJmlvFVOGFH+8CIot4Uo=
X-Google-Smtp-Source: ACHHUZ6VML8HxeN5iFoOUCSN11/EEpU2KnBamOiDiG6JmrhnwQgPeM+JTOy7nwRa7VicD9aeIA4Cx1Ez+zqaJbn8b+Y=
X-Received: by 2002:a2e:9149:0:b0:2ac:98ba:a52e with SMTP id
 q9-20020a2e9149000000b002ac98baa52emr5576115ljg.44.1684867360082; Tue, 23 May
 2023 11:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230523021017.3048783-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230523021017.3048783-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 23 May 2023 11:42:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4KL=t6Y8B51CuYQ1YYUbqECp3A_Jx2uEe2LEoyuzSJqg@mail.gmail.com>
Message-ID: <CAPhsuW4KL=t6Y8B51CuYQ1YYUbqECp3A_Jx2uEe2LEoyuzSJqg@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] md: protect md_thread with rcu
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yukuai3@huawei.com,
        yi.zhang@huawei.com, yangerkun@huawei.com
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

On Mon, May 22, 2023 at 7:13=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Changes in v8:
>  - fix that another unrelated patch is merged into this patchset
>  - update commit message for patch 5
>  - rebase on the top of another patch from me: [PATCH v3] md: fix duplica=
te filename for rdev

Applied to md-next.

Thanks,
Song
