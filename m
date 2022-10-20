Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65D906056A1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 07:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbiJTFKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 01:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiJTFKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 01:10:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA9A15F932
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 22:10:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E70A619F9
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E14C433D6;
        Thu, 20 Oct 2022 05:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666242647;
        bh=tmUHpXKI/+lWtkthZy4lxPmYiKMB0DKJhhgSk82vlGs=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=s+i2cykB/wt6L62cS0b1x6RU8aGjsvZ3byaSEWoFSB1Ra/SqXe3bpp85mn2AcVO+e
         PBrRS78zAfBJOJyRJzz3cwxC/UY3hD8rg9+RhNm50FjYPmGfD4Q1tpVFFwSuc+zgTR
         3HUzm4co2uCLXCi95cpd0qKl5HfUjiTPptsCvfPkBHNUrGMUbVRmkOvfZFcgq2NKRz
         9sUcmBAksiy0wyJAOYwgaZoiCZZQyeYcQW5RsnpAskvBJZ2E/eaeImu2815xrQf+/1
         wZwNmMqU+Pc5yVo2dgvRoqrBlcARmNApsumfvaflfRU591AKniKC3zqCn3h6uXHIFF
         uCZH/p1UdbnmA==
Date:   Wed, 19 Oct 2022 22:10:44 -0700
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
Subject: Re: [PATCH 1/5] seccomp: don't use semaphore and wait_queue together
User-Agent: K-9 Mail for Android
In-Reply-To: <20221020011048.156415-2-avagin@gmail.com>
References: <20221020011048.156415-1-avagin@gmail.com> <20221020011048.156415-2-avagin@gmail.com>
Message-ID: <F4707F74-22D4-402B-8FC6-992AEADDFD33@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 19, 2022 6:10:44 PM PDT, Andrei Vagin <avagin@gmail=2Ecom> wrote=
:
>Here is no reason to use two different primitives that do similar things=
=2E
>
>Signed-off-by: Andrei Vagin <avagin@gmail=2Ecom>
>---
> kernel/seccomp=2Ec | 41 ++++++++++++++++++++++++++++++++++++-----
> 1 file changed, 36 insertions(+), 5 deletions(-)

The commit log does not justify adding 29 lines to "do similar things"=2E =
:) Can you describe the rationale and benefits here a bit more? I assume th=
is to use the the future new wake_up helper?


--=20
Kees Cook
