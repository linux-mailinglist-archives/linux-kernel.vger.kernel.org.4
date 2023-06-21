Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04177378FB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 04:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFUCSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 22:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFUCSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 22:18:43 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF996A4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:18:42 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-77e43dde8c9so96374239f.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 19:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687313922; x=1689905922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fuOwPpcYQb4MP65yyRypd9u+I57+FrjQ2fCg3krHDc=;
        b=AXH12JvcLd8HuCrLgKUeOf3+0TU23VwZxyY7y2iYZ8fuOjfvyPAIZIMZQpxuknVFCS
         7/qxuBU2XHErMvA53Pd2jC30gaIeNXvxBAaO+9NKJo7K4BsopBE+ncu3rmDpUA8sRZ8v
         KBoYS+BWR6lE4R32ilVMW+blWDkU2UVVNUEk8ammB2URu6A0qalrKmdERic3clcq6UX9
         54AJNi8QX6+D666AZv6xsAmAXqh8hH+M5ScmuL4+1OEdzx/p1fb06LXGN1wh8+NtSSCZ
         PkCqRExg4Rn+iAzYXdUbYVX4mIOPtUJyqAafu4u0En/hApz17bjL7D0mjDkB/wyeBrvP
         bD7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687313922; x=1689905922;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fuOwPpcYQb4MP65yyRypd9u+I57+FrjQ2fCg3krHDc=;
        b=ajEwIhjJf7tIOAMnYKYeJPZnzsTXy9VjmC4dU82IA4gJYIgzhoBQE3mE/ssH2enEsg
         z9Jhrk/YxCw5MELS2X/ci4DGMm/Y3QxjG3qDFIeWsHtI36Vnmmwqz04JlKd4Fl31zTjY
         zPgf5XIV/DNshG9EuICxC8jGPW0vcsNrgIlYeKypL5VmUM++sebi6larYju1mCVXeiqK
         mBECuP475Y3JOG3DIUdSHKjvM5belsXXOrsBKf2J4Z8jnqzsqgxyQfe9yMNgM8pjuPTK
         IqonRRDHHisIWZggxhE40RR9a6P0FHK/BOdbgR0OPcv19HjjVtB3TdNQGCMqYD8o/xgy
         2EUg==
X-Gm-Message-State: AC+VfDzmtX+jZPAk4ePUXkBQdz4JjzA/zkAscsGmS1z8WfwQeVsalmPp
        OXRONn9IexRjfXcx0IGSVvIK5XhFQoK4kcQF15k=
X-Google-Smtp-Source: ACHHUZ7iCrqLilLwcQIxw104GKQkZNloILHVIBPTCVx3QYc0AzAWfaMiHwr/0+iN4EtlRqocFkrsuN84t7Z9CNZp9u8=
X-Received: by 2002:a05:6602:399:b0:77e:3d2f:d1f8 with SMTP id
 f25-20020a056602039900b0077e3d2fd1f8mr7439021iov.10.1687313922277; Tue, 20
 Jun 2023 19:18:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230620022120.27448-1-jefexiaomi@xiaomi.com> <ZJFLfRCZuPXN+p9I@dhcp22.suse.cz>
In-Reply-To: <ZJFLfRCZuPXN+p9I@dhcp22.suse.cz>
From:   junfei fang <jefexiaomi@gmail.com>
Date:   Wed, 21 Jun 2023 10:18:31 +0800
Message-ID: <CAFtB3FY-0uyJchUtUPph-pUeQVRpddi-3xDSGzhJEhFqWck4XQ@mail.gmail.com>
Subject: Re: kasan cgroup user-after-free in get_mem_cgroup_from_mm
To:     Michal Hocko <mhocko@suse.com>
Cc:     andrew.zhu@mediatek.com, colin.peng@mediatek.com,
        wangbiao3@xiaomi.com, yangjianlong@xiaomi.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your prompt response.

We are using kernel-5.15 in our project and cannot change it.
Do you have any suggestions on how to fix this issue?
We appreciate your help.


Michal Hocko <mhocko@suse.com> =E4=BA=8E2023=E5=B9=B46=E6=9C=8820=E6=97=A5=
=E5=91=A8=E4=BA=8C 14:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue 20-06-23 10:21:20, jefexiaomi wrote:
> > Hi,
> >
> > We encountered three cases of 'cgroup use-after-free' issues in T SW ve=
rsion \
> > with kernel-5.15.
>
> This is a really old kernel. Can you reproduce with the current Linus
> tree?
> --
> Michal Hocko
> SUSE Labs
