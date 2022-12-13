Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 196E964B24A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 10:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234782AbiLMJZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 04:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234860AbiLMJZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 04:25:26 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD22F2C
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:25:23 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id p8so3888549lfu.11
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 01:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DtRmYtMNHKnkR6bi6ueuHO103FUFfPv8+meEwjdmbw=;
        b=eHiyCsUJNyXUkeoYD3u3bIB6wPOea4+yX6vISQxfMqEP7D4H3VuNz1yTIcpAXnyX+D
         OVzu3VK7K+QbP4n2UyLQRmYFkN6TtRVZhLlJnojtCuEtiG8CwRI6ra9RKIL7I9x6NxXC
         uLk2R+dkVTSxlXOhKFJE7d768mbBOq3OpzQIE96QCaSDJhHQP5xy5JBg4abMqUh/jDin
         6PZxcdWgQPpwbwhdIL8iE+scdFyTH5sTZ9wIxQiAyXKLuLln4EAr64i4kfQyhQMzG6dS
         DO8lE5yKa6pLUWaFvEV/9pYshb6BmbqMjM13FTDKadzfS1pFz5uqI9SqoSnHqJVuOnqD
         /2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DtRmYtMNHKnkR6bi6ueuHO103FUFfPv8+meEwjdmbw=;
        b=LH/3IWlwDEkNnOQncddPYx37MbukKwhIbpgTKCXHjgaw4iuKlKSR2qpEePuwb9qZJp
         y4+txsAIzv+m4NfVPOYskCw5yWfwfElAXcAxOPaGE8T94j+ROUyJEcN+XJVum0t+jHjh
         BYprWMlGuFBXkoy3CZcAww8IS24HP9+PN0dX3EQ/9FgFGSRL6HfgZB9vo9oDrjV2HVej
         zf7Z7niMbUF/nvF9csW7Yfl3RR3wWOYuBfHWMpyRYpGymBjrfREf9hANbzP1+XFnlhzY
         RpjKAGHMrXx8hozZTeQoZyh35N8xcfChE6K12k8JYbNguadXMRb46og5QGR/i1zSyA43
         ulvA==
X-Gm-Message-State: ANoB5pnJxfwW7xh0EVFBafRANyQ/LUfPP3F3XlkUzdhJMMvp8BpCc8Bk
        aDUJwoASF5J2L5qkA2LMYtEzmUjQwn02yaraO68=
X-Google-Smtp-Source: AA0mqf42qnt1Sspgxd1CUIRY0s0hRKG3TTBrCD9Lac0deO3xWdNGTJXsxjpNFgrwMcjMAxXDRsp3c3P+CF/I0Uv1RI8=
X-Received: by 2002:ac2:5459:0:b0:4b5:6f84:ab9c with SMTP id
 d25-20020ac25459000000b004b56f84ab9cmr6939004lfn.201.1670923521844; Tue, 13
 Dec 2022 01:25:21 -0800 (PST)
MIME-Version: 1.0
References: <20221211121852.112127-1-Yuwei.Guan@zeekrlife.com> <Y5XZAg6X8nK7/vBi@debian.me>
In-Reply-To: <Y5XZAg6X8nK7/vBi@debian.me>
From:   Yuwei Guan <ssawgyw@gmail.com>
Date:   Tue, 13 Dec 2022 17:24:46 +0800
Message-ID: <CALJQGLkZgjvk+ysvFKHx6gr=dMQwUa-jOae3F3AJSy1Syczkqw@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: continuous counting for 'issued' in __issue_discard_cmd_orderly()
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yuwei.Guan@zeekrlife.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> =E4=BA=8E2022=E5=B9=B412=E6=9C=8811=E6=
=97=A5=E5=91=A8=E6=97=A5 21:20=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sun, Dec 11, 2022 at 08:18:52PM +0800, Yuwei Guan wrote:
> > As the 'dcc->discard_granularity' and 'dcc->max_ordered_discard' can be=
 set
> > at the user space, and if the 'dcc->max_ordered_discard' is set larger =
than
> > 'dcc->discard_granularity' in DPOLICY_BG mode, or it's a volume device,
> > discard_granularity can be tuned to 1 in f2fs_tuning_parameters(),
> > it will may send more requests than the number of 'dpolicy->max_request=
s'
> > in issue_discard_thread().
> >
>
> You don't know how to stop sentences (aka "abusing" comma), so I read
> above as uber-long sentence. Care to reword? There are many cases when I
> have to reply with such rewording, but this time I choose not to do
> because I'm lazy at the time I write this reply.
>
Hi Bagas,
Thanks for your review.
Sorry for submitting a poorly described patch,
I will update a v3 patch to rewrite the issue description and solution.
> > This patch will fix the issue.
>
> Fix by what? I don't understand the code.
>
> >
> > Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
>
> You send from your Gmail address but have SoB from either personal email
> domain or is this a random company? If it is the latter, please talk
> with your company to fix the mail system so that you can send from its
> domain (and receive traffic from mailing lists). In any case, your email
> address in From header and SoB must match.
>
The email system has been fixed,
and the email addresses will match in the future.
> Thanks.
>
> --
> An old man doll... just what I always wanted! - Clara
