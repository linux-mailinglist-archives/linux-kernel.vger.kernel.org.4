Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C547560567A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 06:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJTEyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 00:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiJTEyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 00:54:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2EE2F0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 21:54:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3443BB825E4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B300C433C1;
        Thu, 20 Oct 2022 04:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666241656;
        bh=fGfCi8J3KIZC1kRbA3mkbdFCKwICM/HeVp4yKhcz0mg=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=MHIHt0uODg+eNGSnvpSlvz7R9E+j+E3/SpVf0cYzgnN+jh/peWzJmz31uqQ9WJj1z
         7Y/eEIzZ08Yp5Or5Lld7pwVyId4+X1zPtubfEbBSfK4zNbsHuyvxlYyqQLA/yWcCnq
         q1cgLiQJzPLufInxDg6ARTMHGJO4Dck2236Q//GKd1m757Tl357P3y412M30V4wGsP
         FpKZ27PuH2l0+786k4VNwenAd8VQ8paMz6RonMj7qqDENnAHm61Y1KnNXq1YxcF8G0
         zP8xacPy3CB61I2O995mQbL7pyAmZdjDwL+tGEp0TRBJvXFJwiqdPRCFMCqoOfoVmz
         twB2TWnSL3N1A==
Date:   Wed, 19 Oct 2022 21:54:15 -0700
From:   Kees Cook <kees@kernel.org>
To:     Andrei Vagin <avagin@gmail.com>, linux-kernel@vger.kernel.org
CC:     Andy Lutomirski <luto@amacapital.net>,
        Christian Brauner <brauner@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Oskolkov <posk@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tycho Andersen <tycho@tycho.pizza>,
        Will Drewry <wad@chromium.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH 2/5] sched: add WF_CURRENT_CPU and externise ttwu
User-Agent: K-9 Mail for Android
In-Reply-To: <20221020011048.156415-3-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com> <20221020011048.156415-3-avagin@gmail.com>
Message-ID: <714DD165-E237-4599-9EE8-477B01AB4365@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 19, 2022 6:10:45 PM PDT, Andrei Vagin <avagin@gmail=2Ecom> wrote=
:
>From: Peter Oskolkov <posk@google=2Ecom>
>
>Add WF_CURRENT_CPU wake flag that advices the scheduler to
>move the wakee to the current CPU=2E This is useful for fast on-CPU
>context switching use cases such as UMCG=2E

UMCG is https://lwn=2Enet/Articles/879398/ ?

>In addition, make ttwu external rather than static so that
>the flag could be passed to it from outside of sched/core=2Ec=2E
>
>Signed-off-by: Peter Oskolkov <posk@google=2Ecom>
>Signed-off-by: Andrei Vagin <avagin@gmail=2Ecom>
>---
> kernel/sched/core=2Ec  |  3 +--
> kernel/sched/fair=2Ec  |  4 ++++
> kernel/sched/sched=2Eh | 13 ++++++++-----
> 3 files changed, 13 insertions(+), 7 deletions(-)

This would need an Ack from the sched maintainers=2E=2E=2E


--=20
Kees Cook
