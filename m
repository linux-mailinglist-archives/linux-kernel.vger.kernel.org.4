Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809F66DE44C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 20:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjDKSuF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Apr 2023 14:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjDKSuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 14:50:02 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7038ED;
        Tue, 11 Apr 2023 11:50:01 -0700 (PDT)
Received: by mail-ej1-f46.google.com with SMTP id j17so13216129ejs.5;
        Tue, 11 Apr 2023 11:50:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681239000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w+TaIaODjml5dEA7Y057pqtaYonpYR4Ushac5ObDGuw=;
        b=YHwjGeBM16wwcHV/iUWUQ9GcYaTNJRSiqIPr9YQBIeLJv3VNrCfn+FSgRd4pYmrn1/
         PtGsMrdssgMpJQ11Wzh8TyRV4zjCzjumfKDMDzRuQlCWdySDV4vk5E9GyXT8AzDdO8k+
         qwrpEZ4nBEYVXmlKSHa6wa0CeQiVipMQfCE2FfNFHhIC049Lr5/iXUyI/oTkK72wrB2Y
         yKAFJS6Xa0dRKtGLG8kpBroNSgK0BE+2XUNUDOoKMNIbK9vLt+qlAlBiwcBBCOhKlwnW
         rxYOV3PSh/8ZVGpv76OQ095Jp89rhiq+Hu4O7VIO1PDTYWhXegmhIuM48TtLQV3/0PZ3
         VBdA==
X-Gm-Message-State: AAQBX9c0DNYUnAz4hW9FzqMVxh6n2LN+CH2g3qblRtKFTIE1BJwaiUAM
        GcYEGiPjS90gpgmWb0IfXQRG2ulf0NBILobwz1Y=
X-Google-Smtp-Source: AKy350Y4QeUKGLTjLx17+ABMp7zdmQh3Ej4SAzmDsCa7V9UXw4FcMgDxjc9C+90TOHCYmCgbY4uqxsaw22KxzEZR8EI=
X-Received: by 2002:a17:907:8a0e:b0:94e:7ce:4d1f with SMTP id
 sc14-20020a1709078a0e00b0094e07ce4d1fmr1944566ejc.2.1681239000272; Tue, 11
 Apr 2023 11:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230330141314.1364083-1-wyes.karny@amd.com> <CAJZ5v0jxwuAnTVdnThGmHmptB7qeKc34-keUOdHcugeADYSL+w@mail.gmail.com>
 <ZCZ5zjw+O3gS6trx@bhagirati.amd.com> <CAJZ5v0iwmvnTFVKhox11gKxM8UBR+=748zPB0tr_O5mPBbkpiA@mail.gmail.com>
 <ZCazdI9puSXLd0D4@bhagirati.amd.com>
In-Reply-To: <ZCazdI9puSXLd0D4@bhagirati.amd.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Apr 2023 20:49:49 +0200
Message-ID: <CAJZ5v0hLaqCuZ69HJ5J4Cm0NBn0SUQ_4AiE5c5tPkho1Ek=ZuQ@mail.gmail.com>
Subject: Re: [PATCH] amd-pstate: Fix amd_pstate mode switch
To:     Wyes Karny <wyes.karny@amd.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, viresh.kumar@linaro.org,
        ray.huang@amd.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexey Kardashevskiy <aik@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 12:18 PM Wyes Karny <wyes.karny@amd.com> wrote:
>
> On 31 Mar 11:11, Rafael J. Wysocki wrote:
> > On Fri, Mar 31, 2023 at 8:12 AM Wyes Karny <wyes.karny@amd.com> wrote:
> > >
> > > Hi Rafael,
> > >
> > > On 30 Mar 20:19, Rafael J. Wysocki wrote:
> > > > On Thu, Mar 30, 2023 at 4:13 PM Wyes Karny <wyes.karny@amd.com> wrote:
> > > > >
> > > > > amd_pstate mode can be changed by writing the mode name to the `status`
> > > > > sysfs. But some combinations are not working. Fix this issue by taking
> > > > > care of the edge cases.
> > > > >
> > > > > Before the fix the mode change combination test fails:
> > > > >
> > > > >  #./pst_test.sh
> > > > > Test passed: from: disable, to
> > > > > Test passed: from: disable, to disable
> > > > > Test failed: 1, From mode: disable, to mode: passive
> > > > > Test failed: 1, From mode: disable, to mode: active
> > > > > Test failed: 1, From mode: passive, to mode: active
> > > > > Test passed: from: passive, to disable
> > > > > Test failed: 1, From mode: passive, to mode: passive
> > > > > Test failed: 1, From mode: passive, to mode: active
> > > > > Test failed: 1, From mode: active, to mode: active
> > > > > Test passed: from: active, to disable
> > > > > Test failed: 1, From mode: active, to mode: passive
> > > > > Test failed: 1, From mode: active, to mode: active
> > > > >
> > > > > After the fix test passes:
> > > > >
> > > > >  #./pst_test.sh
> > > > > Test passed: from: disable, to
> > > > > Test passed: from: disable, to disable
> > > > > Test passed: from: disable, to passive
> > > > > Test passed: from: disable, to active
> > > > > Test passed: from: passive, to active
> > > > > Test passed: from: passive, to disable
> > > > > Test passed: from: passive, to passive
> > > > > Test passed: from: passive, to active
> > > > > Test passed: from: active, to active
> > > > > Test passed: from: active, to disable
> > > > > Test passed: from: active, to passive
> > > > > Test passed: from: active, to active
> > > > >
> > > > > Fixes: abd61c08ef349 ("cpufreq: amd-pstate: add driver working mode switch support")
> > > > >
> > > > > Acked-by: Huang Rui <ray.huang@amd.com>
> > > > > Reviewed-by: Alexey Kardashevskiy <aik@amd.com>
> > > > > Signed-off-by: Wyes Karny <wyes.karny@amd.com>
> > > > >
> > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > Cc: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > > > > Cc: Perry Yuan <Perry.Yuan@amd.com>
> > > >
> > > > This is all fine, but you need to tell me how it interacts with the
> > > > amd-pstate changes in linux-next.
> > > >
> > > > Does it affect the code in linux-next at all or is it only for 6.3-rc?
> > > >
> > >
> > > This is only for 6.3-rc.
> > > The commit 3ca7bc818d8c ("cpufreq: amd-pstate: Add guided mode control
> > > support via sysfs") in linux-next may not apply cleanly after this fix.
> > > Please let me know if I need to rebase and send the guided mode patches [1].
> > >
> > > [1]: https://lore.kernel.org/linux-pm/20230307112740.132338-1-wyes.karny@amd.com/
> >
> > Well, instead, you please let me know how to resolve the merge
> > conflict between the patch below and your series.
> >
> > Can I simply assume that the code added by commit 3ca7bc818d8c
> > replaces the code modified by the $subject patch?
>
> Yes, commit 3ca7bc818d8c replaces the whole `amd_pstate_update_status`
> function with new implementation.

OK, thanks!

$subject patch has been queued up for 6.3-rc7, thanks!
