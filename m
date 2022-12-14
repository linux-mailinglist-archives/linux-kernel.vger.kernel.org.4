Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8998364CC9E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:46:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238645AbiLNOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:46:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiLNOqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:46:40 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD28E2F3;
        Wed, 14 Dec 2022 06:46:39 -0800 (PST)
Received: by mail-qk1-f178.google.com with SMTP id j26so1330089qki.10;
        Wed, 14 Dec 2022 06:46:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rY6jbE/H0PQNdl9LS+tXuuHoSxKiT9WS05UFkLfr0q0=;
        b=MO5N0/KFrd2D9+QJfUYEknVNS16jCYfwn6Hy1koQW8zHPPdEHAorZ4E7sNpgSQELLn
         YTWPMlYHIv+SGgHwEl6IHIJ5D57JChj0KtZEpJhtDW+xMlTv9bXEwBptP19IyhkGucnO
         fXcpp6/611gqZcLorR/IFmbnx1Jgf5m/eGJxYYcaSDIBRF/8g83ibIjA/q8PEKmSxtDh
         CiU+B3PM4wyZg4VGi7y97dsgoYlJiuTzj512BIK7ecv24w0Vqx1lfG6q+nIYhhqm/G9X
         sGhYZFjH/xhwoTaQ03TolA6t4HQ2YhXBEuboXM22nZvsCo+1FLba0Dqe5Vo51a0q00VM
         BDvA==
X-Gm-Message-State: ANoB5pkcOtxVedLX0ykpWgzXeihmudY4dhps2sxXXdfnkIytKM+0ghPq
        d9wtEGntxWZlwyKkbSILH8EyWUNEteAo1SkbNYm48TvY
X-Google-Smtp-Source: AA0mqf4/oOAt+huU8lWJ99gyk2crm+ZP9URJJjJtMEVvnQz7kQttco4QvaDct8jmmMXkFBUxLah0qPetQ7/4aKxbp6Y=
X-Received: by 2002:a05:620a:b90:b0:6ff:8f5a:1d37 with SMTP id
 k16-20020a05620a0b9000b006ff8f5a1d37mr673635qkh.501.1671029198934; Wed, 14
 Dec 2022 06:46:38 -0800 (PST)
MIME-Version: 1.0
References: <20221214131617.2447-1-johan+linaro@kernel.org>
 <CAJZ5v0gY-Lhgf_1Kfg6P5O8s+YMkP4TxggxyS=LU9jVgJikAkg@mail.gmail.com> <cc48a248-5dc1-eba8-d91b-ee24300bab52@linaro.org>
In-Reply-To: <cc48a248-5dc1-eba8-d91b-ee24300bab52@linaro.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 15:46:27 +0100
Message-ID: <CAJZ5v0iLQLcPEj4uzxFOBCgHjqxT7COYvQJh9cGhEFijqEZeow@mail.gmail.com>
Subject: Re: [PATCH 0/4] thermal: fix locking regressions in linux-next
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 14, 2022 at 3:37 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 14/12/2022 15:02, Rafael J. Wysocki wrote:
> > On Wed, Dec 14, 2022 at 2:18 PM Johan Hovold <johan+linaro@kernel.org> wrote:
> >>
> >> This series fixes some of the fallout after the thermal changes that
> >> just landed in linux-next.
> >>
> >> Lockdep reported a lock inversion in one of the Qualcomm drivers and a
> >> closer review revealed that the changes had also broken the sysfs
> >> interface for at least three drivers.
> >>
> >> Note that a simple revert of the offending patches was not an option as
> >> some of the infrastructure that the old implementation relied on has
> >> also been removed.
> >
> > I've dropped that material from my linux-next branch and Daniel,
> > please also remove it from your branch that is pulled by linux-next so
> > that it doesn't show up in there until 6.2-rc1 is out.
> >
> > It clearly is not ready for merging in its current form.
>
> I rebased a linux-next branch without the generic trip points rework.

Thanks!

> It can be inverted with the other changes without conflicts.

Sounds good.

> I've pushed the branch in case you want to have a look. If you think it
> is acceptable in this form, I can send a tagged PR for 6.2-rc1 again.

It looks OK, so please send a PR.

> > It is still present in my bleeding-edge branch, though, so please
> > apply the patches from Johan on top of it and send a new PR to me, so
> > I can add it back to my linux-next branch once 6.2-rc1 appears.
> >
> > It would be good to check the code again too for any more similar fallout.
>
> I've been through already, the exynos fix is not necessary. But anyway,
> I agree we should keep these changes for the next release, it is better.

Awesome, thanks!
