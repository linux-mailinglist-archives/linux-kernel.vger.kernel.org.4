Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C905670B4FD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjEVGZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 02:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjEVGZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 02:25:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A5CCF;
        Sun, 21 May 2023 23:25:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D090761BE2;
        Mon, 22 May 2023 06:25:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 365BDC433EF;
        Mon, 22 May 2023 06:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684736727;
        bh=53XIR8Q3XsiGYdYxtSDcQeqgsEPCAGvDlbxQeA1BQ6M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=EXFwzqEZ783ALOQeXFqvos+aAnLF8ZaOAss40WKXaWW2NjL3dSu7Wpvo3ogu2YdX7
         ZThkI7s+P971hRJFcXBmKnFfTdfIXodbzvrT0T2ZkH1IBZy6lXH1wCUL8nsO2Yeb12
         e9eNvliG6k8O8UFXGmde54Z2ftm8yreK4CSXOugC+84W1XYO3vtl1X5dh6LsjXT0Vz
         wQwpHUcAhBQ3wGNgEtXv2ebOsk9jiQvdeTuT0CKBrvSN7Nr4LlRHvA/PC/ZT7pbNeS
         F6sr/RSIcermTs0VCbMqP7vd7Hyx1L7kBsQn3EMgpXzwoAc2iyW5TDrmpliuZcadBU
         PoY2WANWnNjLg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2af316b4515so16897811fa.1;
        Sun, 21 May 2023 23:25:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDxQistE49233xgoriPVpkPzM93YydOtSyI6uonSPXpRFrRAWLY8
        wIKAxj2U6niJIY4q25TmCDoXtj6sI93NtUJALr0=
X-Google-Smtp-Source: ACHHUZ4kV9uaArtIiY9T/rwqocfA7tWGUTqvxwjkrOGj0A9zLKP+CgwP3zunDcRwSyS9ylVNpP/xecf7GKZhcF25UuE=
X-Received: by 2002:a2e:8695:0:b0:298:ad8e:e65 with SMTP id
 l21-20020a2e8695000000b00298ad8e0e65mr3326550lji.21.1684736725266; Sun, 21
 May 2023 23:25:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230512015610.821290-1-yukuai1@huaweicloud.com>
 <20230512015610.821290-2-yukuai1@huaweicloud.com> <CAPhsuW5YFnqkOFz2tU+GQT=TnVXc-RySECaj=FOHw2rEh5tz0g@mail.gmail.com>
 <aad4acb6-ccc7-560e-e251-3b4b28a862ef@huaweicloud.com>
In-Reply-To: <aad4acb6-ccc7-560e-e251-3b4b28a862ef@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Sun, 21 May 2023 23:25:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5y8O57U3_az-zOOEQcH3UQC9OQ4MWx755V58e4TX1wNQ@mail.gmail.com>
Message-ID: <CAPhsuW5y8O57U3_az-zOOEQcH3UQC9OQ4MWx755V58e4TX1wNQ@mail.gmail.com>
Subject: Re: [PATCH -next 1/5] md/raid5: don't allow replacement while reshape
 is not done
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     logang@deltatee.com, reddunur@online.de, jovetoo@gmail.com,
        dgilmour76@gmail.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
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

On Sun, May 21, 2023 at 8:46=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> w=
rote:
>
> Hi,
>
> =E5=9C=A8 2023/05/20 7:33, Song Liu =E5=86=99=E9=81=93:
> > On Thu, May 11, 2023 at 6:59=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.co=
m> wrote:
> >>
> >> From: Yu Kuai <yukuai3@huawei.com>
> >>
> >> Set rdev replacement has but not only two conditions:
> >>
> >> 1) MD_RECOVERY_RUNNING is not set;
> >> 2) rdev nr_pending is 0;
> >
> > The above is confusing. I updated it and applied the set to md-next.
>
> By the way, I'm willing to add regression test for these problems, and I
> already send two other tests and there are no response yet. Should the
> test wait for fixed patch to be applied to make progress?

Jes just had a baby, so there will be long delays with mdadm patches.
I am already using the new tests, so please keep sending them.

Thanks,
Song
