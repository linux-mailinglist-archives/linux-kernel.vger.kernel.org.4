Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD274ADB6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 11:17:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbjGGJRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 05:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbjGGJRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 05:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECE71FED;
        Fri,  7 Jul 2023 02:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D974618EE;
        Fri,  7 Jul 2023 09:17:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D88DC433CC;
        Fri,  7 Jul 2023 09:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688721463;
        bh=y9q2qXbwompfnqc3ko09F3B4CHKaOegjl3Lb2/TKMQg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CWJW6nfV1LLHdqEpf3qlp9YaZJ0AZSsErl6uz34df51iUBbBTIWxBYBMDOyLtGBaC
         UuYrpUPoialz+UxcbsdL0X1WYnwnx3sMf0uAZXrvYGrX6FNbvJGrhDQj6ZfCOCdpby
         M6XC9z5VuJ9Ov8NYy4/9b4nJk6j3FLhdWvUjk9Bo3K6/cS7f3ef37fCzQT8YBMLVFo
         OAsQgHOMTArtJo9WcSzJwNk8wMYhFrFMf+gM7llQDFF0+Q2mdrYDt3GSigYMUFh1gi
         muGprjg4OPbJkhwSdQno66o/B6IQiFVbv/Do0jTW11EIExCtWdj5R+AjJKJqoc7VYY
         K/mdsGk2/NhSA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso25632271fa.3;
        Fri, 07 Jul 2023 02:17:43 -0700 (PDT)
X-Gm-Message-State: ABy/qLZPDHye3mMNLGdc0urAU46kqCc6/Hv0rCOFCNHiC7IdOVBxwySM
        SCzUeKHXt33SzkIi/IztAJt35+bWeSnyzH5iUGE=
X-Google-Smtp-Source: APBJJlE87ltranMk+CAh0mG2TM1pdUHhZ3aMI3em6uPeDshWbQDvhk1ixsXNMSET75hla1kfWvJp4TEpy52dKYrm+cI=
X-Received: by 2002:a2e:3312:0:b0:2b6:a05a:c5c with SMTP id
 d18-20020a2e3312000000b002b6a05a0c5cmr3369555ljc.1.1688721461492; Fri, 07 Jul
 2023 02:17:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230706083727.608914-1-yukuai1@huaweicloud.com>
In-Reply-To: <20230706083727.608914-1-yukuai1@huaweicloud.com>
From:   Song Liu <song@kernel.org>
Date:   Fri, 7 Jul 2023 17:17:29 +0800
X-Gmail-Original-Message-ID: <CAPhsuW5OpiFoMupDOpxns3ZwC-MXwYk6P5McKXWbaHPD8TVJJA@mail.gmail.com>
Message-ID: <CAPhsuW5OpiFoMupDOpxns3ZwC-MXwYk6P5McKXWbaHPD8TVJJA@mail.gmail.com>
Subject: Re: [PATCH -next 0/2] md/md-bimap: hold 'reconfig_mutex' in backlog_store()
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     guoqing.jiang@linux.dev, neilb@suse.com,
        linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
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

On Thu, Jul 6, 2023 at 4:38=E2=80=AFPM Yu Kuai <yukuai1@huaweicloud.com> wr=
ote:
>
> From: Yu Kuai <yukuai3@huawei.com>
>
> Yu Kuai (2):
>   md/md-bitmap: remove unnecessary local variable in backlog_store()
>   md/md-bitmap: hold 'reconfig_mutex' in backlog_store()
>
>  drivers/md/md-bitmap.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
>

Applied to md-next. Thanks!

Song
