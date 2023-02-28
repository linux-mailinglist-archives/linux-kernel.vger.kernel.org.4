Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95FEB6A52B8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 06:55:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbjB1FvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 00:51:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjB1FvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 00:51:19 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F81C327
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:51:18 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id f19-20020a9d5f13000000b00693ce5a2f3eso4943192oti.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677563476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KVO9D3it9baXxwOs3sdGaxeINko9L5QuRxlEmbnRx9I=;
        b=jPOIf+aDnaBftghWwitaHLIz/kDaPp5HR9dVZxEGLytOjTWy8AmU81Wrm/E4hrxEIE
         W594uK45226OyK8dp0Opk3ke9fmm/6DI1LZw+wnH6CbtEQkdIWoWwzKb+FbcnbLsR1Si
         5Ll66iSkPX3QABLvctic4MfbyptliFGq+TLfzVm1w5YwOc+YjIO+FSXc76f8zUmPFful
         WmJdAKGbIIy9VxHqR0o0YPM3K1O5B8gtO/1VoVJDteHvpdDUFEC3QmtlqnpEjKBdZT47
         YVEUoAxptdYt4Lmshx7k/KdXv0FtLW+t3Atn9flJ9PB1YRgKlXVzVQn8U2YpCH/s8TwU
         Di7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677563476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVO9D3it9baXxwOs3sdGaxeINko9L5QuRxlEmbnRx9I=;
        b=1ZoiyZu5ZV4Pfhw4tNNAESQKSEkTPKJhCiiCpIHrMi7qdWsVgEXgtnnhkuxH2KaRXF
         1M7p4EJHJ7mGzH+Q5duPqAk3n1VzEKjCrW2vK5EMHLeWJIbfy5RlC9SJ5y0m9zHbNlv7
         vZs9TyFaoXgYJtoLtQDP1qlbr85OTH1DJ81s59lAU0VCK+mMKDHCXtqOVn4HwTDipOFs
         KYiQSTclNWRZNdL3b80uvTmaod8G2DXJJrigxsTm6wCTsU5pG5o8bU6oCnm8pEwuKcBY
         BbVALxlcmZd+vqvtUOtsCMvqYGnB3EWQeAgJKrdbMdrlXv32T3EjNdGhIeKkrUtP7+7F
         UzCQ==
X-Gm-Message-State: AO0yUKUjEUzsqRUdK2IeGQIShd9qgUZLkWsEhkpvf+JElTGXJ+yDttRF
        nBr5QJDzIPbPGXUC2MBqHMlFt9gNufVDumUxnhmIhA==
X-Google-Smtp-Source: AK7set8xPfpIn1P5Zdq04cHzmCCh/Wgn+RuC1dRItO5lpXetxNt5SGHlyR3GxK/vU+AEmzlQZeJGZGBTkEslWnFfFpo=
X-Received: by 2002:a9d:315:0:b0:690:ed96:e019 with SMTP id
 21-20020a9d0315000000b00690ed96e019mr562300otv.4.1677563476282; Mon, 27 Feb
 2023 21:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20230208093322.75816-1-hsiangkao@linux.alibaba.com>
 <Y/ewpGQkpWvOf7qh@gmail.com> <ca1e604a-92ba-023b-8896-dcad9413081d@linux.alibaba.com>
 <8e067230-ce1b-1c75-0c23-87b926357f96@linux.alibaba.com> <CAB=BE-SQZA7gETEvxnHmy0FDQ182fUSRoa0bJBNouN33SFx3hQ@mail.gmail.com>
 <CAB=BE-Svf7TMPs-eA+sVuGtYjVWfKd1Nd_AkA9im4Op7TCLW3g@mail.gmail.com> <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
In-Reply-To: <1f926a20-6b45-137d-4e78-30025ba33574@linux.alibaba.com>
From:   Sandeep Dhavale <dhavale@google.com>
Date:   Mon, 27 Feb 2023 21:51:05 -0800
Message-ID: <CAB=BE-SBtO6vcoyLNA9F-9VaN5R0t3o_Zn+FW8GbO6wyUqFneQ@mail.gmail.com>
Subject: Re: [PATCH v5] erofs: add per-cpu threads for decompression as an option
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>,
        Yue Hu <huyue2@coolpad.com>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 27, 2023 at 9:01=E2=80=AFPM Gao Xiang <hsiangkao@linux.alibaba.=
com> wrote:
>
> Hi Sandeep,
>
> On 2023/2/28 12:47, Sandeep Dhavale via Linux-erofs wrote:
> > Hi all,
> > I completed the tests and the results are consistent with
> > our previous observation. We can see that removing WQ_UNBOUND
> > helps but the scheduling latency by using high priority per cpu
> > kthreads is even lower. Below is the table.
> >
> > |---------------------+-------+-------+------+-------|
> > | Table               | avg   | med   | min  | max   |
> > |---------------------+-------+-------+------+-------|
> > | Default erofs       | 19323 | 19758 | 3986 | 35051 |
> > |---------------------+-------+-------+------+-------|
> > | !WQ_UNBOUND         | 11202 | 10798 | 3493 | 19822 |
> > |---------------------+-------+-------+------+-------|
> > | hipri pcpu kthreads | 7182  | 7017  | 2463 | 12300 |
> > |---------------------+-------+-------+------+-------|
>
> May I ask did it test with different setup since the test results
> in the original commit message are:
>
Hi Gao,
Yes I did the test on the different (older) hardware than my original testi=
ng
(but the same one Nathan had used) to remove that as a variable.

Thanks,
Sandeep.

> +-------------------------+-----------+----------------+---------+
> |                         | workqueue | kthread_worker |  diff   |
> +-------------------------+-----------+----------------+---------+
> | Average (us)            |     15253 |           2914 | -80.89% |
> | Median (us)             |     14001 |           2912 | -79.20% |
> | Minimum (us)            |      3117 |           1027 | -67.05% |
> | Maximum (us)            |     30170 |           3805 | -87.39% |
> | Standard deviation (us) |      7166 |            359 |         |
> +-------------------------+-----------+----------------+---------+
>
> Otherwise it looks good to me for now, hopefully helpful to Android
> users.
>
> Thanks,
> Gao Xiang
>
> >
> >
> > Thanks,
> > Sandeep.
