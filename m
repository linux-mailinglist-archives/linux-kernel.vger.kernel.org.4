Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2CA65969B
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 10:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbiL3JQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 04:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiL3JQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 04:16:30 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC07DF4F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Dec 2022 01:16:29 -0800 (PST)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1672391787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0YVvYHzhfhVLC1h+Hk5/AdGM7+lfwHu5eJUyiyijxE=;
        b=fXxK0Zq/6DQtLZRcmVE5W9LLUbEXWe8PezyuDVSm/8JdKiAEyRTU03Kf9iliXuOLvfnWyf
        6Vvb0K0EeDyAJxvpVM7rb4Vh8mCLK+LqvLeprkxclueO/0kQZUz0QSu1jL+OKxK2GuCGU1
        3bHSlqdpY5/+Tl3nq3FwR3eaK7+r9Mo=
Date:   Fri, 30 Dec 2022 09:16:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fc13e5c0dba372ddb1435c959e7dc41f@linux.dev>
Subject: Re: [PATCH] ARM: Remove redundant arch_cpu_idle_prepare()
To:     rmk+kernel@armlinux.org.uk, keescook@chromium.org,
        gregkh@linuxfoundation.org, Jason@zx2c4.com, djwong@kernel.org,
        ebiederm@xmission.com, thunder.leizhen@huawei.com, ardb@kernel.org,
        wangkefeng.wang@huawei.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221201031306.2782204-1-yajun.deng@linux.dev>
References: <20221201031306.2782204-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

December 1, 2022 11:13 AM, "Yajun Deng" <yajun.deng@linux.dev> wrote:=0A=
=0A> arch_cpu_idle_prepare() was only called by cpu_startup_entry() and i=
t is=0A> just a wrapper for local_fiq_enable().=0A> =0A> The local_fiq_en=
able() was already called before cpu_startup_entry().=0A> =0A> So remove =
redundant arch_cpu_idle_prepare().=0A> =0A> Signed-off-by: Yajun Deng <ya=
jun.deng@linux.dev>=0A> ---=0A> arch/arm/kernel/process.c | 5 -----=0A> 1=
 file changed, 5 deletions(-)=0A> =0A> diff --git a/arch/arm/kernel/proce=
ss.c b/arch/arm/kernel/process.c=0A> index f811733a8fc5..e3f490ab95f4 100=
644=0A> --- a/arch/arm/kernel/process.c=0A> +++ b/arch/arm/kernel/process=
.c=0A> @@ -81,11 +81,6 @@ void arch_cpu_idle(void)=0A> raw_local_irq_enab=
le();=0A> }=0A> =0A> -void arch_cpu_idle_prepare(void)=0A> -{=0A> - local=
_fiq_enable();=0A> -}=0A> -=0A> void arch_cpu_idle_enter(void)=0A> {=0A> =
ledtrig_cpu(CPU_LED_IDLE_START);=0A> -- =0A> 2.25.1=0A=0APing.
