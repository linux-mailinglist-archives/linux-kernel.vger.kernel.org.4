Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7D2728F0F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:45:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFIEpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFIEpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:45:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8044730EC;
        Thu,  8 Jun 2023 21:45:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1496563EDA;
        Fri,  9 Jun 2023 04:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7131CC4339B;
        Fri,  9 Jun 2023 04:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686285908;
        bh=e2Kf3CZm3LThtjpSWVaiiuttVFBGhvsy4+xD67gkJUA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hrdTvcke1Ju8NjVihtWDgklzV3LhUyc6896/TtAoOOxtnrsGDZ/+2Y4Busv64mZui
         urT2JmrJdNpETdca0DVWU6+H8uJ7pSg46msej4t4krN7OHa9SeiXW7kN9Y0pZ+8aK7
         IK7R+tJ8E3gRIXiDIffKfpe5eRZPX3NWCklakSn3SttRqbUapg5y4nUL32+0r/vu4H
         VL5RmNsLNu56HgJDQMoNZzIEtDW2tut7RtIr0Rb5/7FJ7RcD2MawdayV11+P619d01
         y6koyijOBOlTvn9Wze6dSufccGeDW45ZGFspuzZ9tiIqf2SphBNdDIQYrgOIZxWYvd
         QmZbmztKW9z9g==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4f62b512fe2so1729872e87.1;
        Thu, 08 Jun 2023 21:45:08 -0700 (PDT)
X-Gm-Message-State: AC+VfDxk2/mtfHHOrsxVwkXbTNmA8ocG4Ka0xX1VQsdF7X6lalLWGzq3
        HaMWfmk5GsBdJAtnfd3LLvlM15eUZNUiVav3Ma0=
X-Google-Smtp-Source: ACHHUZ6HaFF03H53+7vGQJhIsVAaRL+rCqTGiTnj3esTnBlt6KHYOgFQdTsKM9JhvmvBMcUu7+cv00YuNa2U0huGCE0=
X-Received: by 2002:ac2:5b0d:0:b0:4f4:b3a6:4135 with SMTP id
 v13-20020ac25b0d000000b004f4b3a64135mr143022lfn.55.1686285906337; Thu, 08 Jun
 2023 21:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230529132037.2124527-1-yukuai1@huaweicloud.com> <0a38ddc1-b47e-04e8-dbf5-25afcd13fff4@huaweicloud.com>
In-Reply-To: <0a38ddc1-b47e-04e8-dbf5-25afcd13fff4@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Thu, 8 Jun 2023 21:44:53 -0700
X-Gmail-Original-Message-ID: <CAPhsuW65AFL=vbcubantu=O-6uVVeDHrO73Oun07DqnYHsv8CA@mail.gmail.com>
Message-ID: <CAPhsuW65AFL=vbcubantu=O-6uVVeDHrO73Oun07DqnYHsv8CA@mail.gmail.com>
Subject: Re: [PATCH -next v2 0/6] md: fix that MD_RECOVERY_RUNNING can be
 cleared while sync_thread is still running
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com, "yukuai (C)" <yukuai3@huawei.com>
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

On Wed, Jun 7, 2023 at 7:41=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> Hi,
>
> =E5=9C=A8 2023/05/29 21:20, Yu Kuai =E5=86=99=E9=81=93:
> > From: Yu Kuai <yukuai3@huawei.com>
> >
> > Changes in v2:
> >   - rebase for the latest md-next
> >
> > Patch 1 revert the commit because it will cause MD_RECOVERY_RUNNING to =
be
> > cleared while sync_thread is still running. The deadlock this patch tri=
es
> > to fix will be fixed by patch 2-5.
> >
> > Patch 6 enhance checking to prevent MD_RECOVERY_RUNNING to be cleared
> > while sync_thread is still running.
>
> Any suggestions on this patchset? I already sent regression test
> for the deadlock problem for both raid10 and raid456.

Sorry for the delay. I will look into this soon.

Thanks,
Song
