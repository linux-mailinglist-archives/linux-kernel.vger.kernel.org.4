Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14327712A08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244234AbjEZPzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244177AbjEZPz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:55:27 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E28187
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:55:24 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-19a13476ffeso867777fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1685116524; x=1687708524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8O2VAHT1Q5P5Pgk50I1J96RI5j3ZSie/eadSrSbFNko=;
        b=jwSC26BizZAjvFIshcFKmupMVqGHlRlnMLfTaQJSuCCf60jdsw02ubmbJYqn1sHmPM
         np3EA8DGAopS00pX3RwwpfFW8jF6ch1WtBvqSWqKJQVVL/mJOJtWE5DFYyj0+beyuxfH
         enC6CA2x8s4D2FIP77sVhGl8frpdAi+hq8TNp4dFakp4EohZd5rqGgANa1aPlgKGIkcn
         tZtMtMOKCptjohex/NhcaW27FGFdwG3xtyVtPSJGWKWBjOOCJjb9FqC+Hj6Tn7+EXPEf
         Tpl41Xm7Xc2gl6IqmQxjheo3Zywnbqc+Ob12sHPzQHsuH79ukA0VKMUMzMqFEyEVOVlT
         TBCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685116524; x=1687708524;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8O2VAHT1Q5P5Pgk50I1J96RI5j3ZSie/eadSrSbFNko=;
        b=QrlwtZvJb+f0srFkZaVO5fJmI1+V/Ykr8q5Q2fRP4jRvUaabAssEhKkbV2G6djsBSL
         NvzvxkovWSJB4FXOrNN2IjxxOoXfIJEqVj8JgwNFX9NcIM3CDbLeq8JMGSyguNHcKkvZ
         bKAOwfzidC55gRCFHlNL08exWn0m92v6HeIuk9JoFIyduiCJtAKbBsdBXgXheg5k0ATG
         yj8kLN8jXkDeQhUfPhv2hZcz6K3abUg2KrRg20w8CBi+SD36OzAH+TvqUVnUDOO6GPFQ
         R3Lvfma72NCmjVVFFeRyXOtkBF4Sbr97f+OBgoZa7h6Y1beWN7/Yacgld9kTwVPI4MZT
         RzwQ==
X-Gm-Message-State: AC+VfDycLC6FCd8q28bDcgS43zX/U6PSgPJMwk4oyb3xdDJakfxg/Lbj
        k2ymtxp/WJufZz01zc2IclGKDh5gta8J/su7K8ZsXg==
X-Google-Smtp-Source: ACHHUZ5dwPnfRHYMjjBz/CPMvAN7Myf0ephebY3nmamWZ7lpDLsKegvxqQhUh6bPVxe5amIhiiJGbyzs8kbSld42+Zg=
X-Received: by 2002:a05:6871:40c:b0:19e:b750:f024 with SMTP id
 d12-20020a056871040c00b0019eb750f024mr1072820oag.4.1685116523866; Fri, 26 May
 2023 08:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230526145519.2282062-1-vineeth@bitbyteword.org> <20230526172959.5440b9dd@nowhere>
In-Reply-To: <20230526172959.5440b9dd@nowhere>
From:   Vineeth Remanan Pillai <vineeth@bitbyteword.org>
Date:   Fri, 26 May 2023 11:55:13 -0400
Message-ID: <CAO7JXPgLFgXANqXY7L-YLbijxJCOgUKmd8nUQizb62JorOXGhA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] sched/deadline: Fix bandwidth reclaim equation in GRUB
To:     luca abeni <luca.abeni@santannapisa.it>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        youssefesmat@google.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 26, 2023 at 11:30=E2=80=AFAM luca abeni <luca.abeni@santannapis=
a.it> wrote:
> [...]
> > + * but as "dq =3D -(max{u, (1 - Uinact - Uextra)} / Umax) dt",
>
> ...But I think this is wrong (should be "Umax - ...", not "1 - ...").
> I think patch 2/2 has the same issue.
>
Oops sorry, I missed this. Will send the fixed patch as a
reply to the original v4.

Thanks,
Vineeth
