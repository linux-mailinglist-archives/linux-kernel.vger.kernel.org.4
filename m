Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013DE64CBCB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 15:02:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238631AbiLNOCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 09:02:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbiLNOCZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 09:02:25 -0500
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58511E3EC;
        Wed, 14 Dec 2022 06:02:23 -0800 (PST)
Received: by mail-qv1-f43.google.com with SMTP id u10so12557814qvp.4;
        Wed, 14 Dec 2022 06:02:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5J5l9PHNH3hAPkvemcjxbJ/Q/3nbdWjzIYM+AXgHrFA=;
        b=41HwYnyiwXLeTftAUEDCuwO0jDXGdJSaNNA/PUjeDm1t7SP/+iAE8nkCz3nVe1c82c
         BTJE0LqAKmmZ0XImyC0AFkE/qKttl4RthV3++9xuRFjoH/1Wc60hB1SutgEECG1T9xQn
         yOiq8HXQ8zMWKlOKpxdKrWUEhJyOf7Dive8ow3TaG7ndEL76YnL6lT+TbHGomJnfdkQ2
         7+jMOf4QYs20+KZTjoWqGSs3cKOzr2sAQ+CfOrrYNdWAoGsu5B0YjDDk8FHQ7wa3zsuC
         qAHmmjW43IFDcPsj/CIAxKuiDDF+dP1om4kybQD9b/1kGdfusr2OFp4GJ8qDI0Qb+opa
         TnGQ==
X-Gm-Message-State: ANoB5pm8KhXimx/uROFW7Cge42Sj+RgPZSuM/LeNduxfMGu6vnt+AMef
        64AZmUNjHg/lXLWB6/gJO9ai3Ns85S7wBZD5VC4=
X-Google-Smtp-Source: AA0mqf7xzEzMqCeas0yquK7x82mUOIhnAdFVlNjmSgz6/8Cv2sAjkGMVNZQlSV+dzJnDteLF4AnlNeFIX5JoxiM/ciE=
X-Received: by 2002:ad4:534b:0:b0:4b1:8429:a8a7 with SMTP id
 v11-20020ad4534b000000b004b18429a8a7mr69941479qvs.52.1671026543044; Wed, 14
 Dec 2022 06:02:23 -0800 (PST)
MIME-Version: 1.0
References: <20221214131617.2447-1-johan+linaro@kernel.org>
In-Reply-To: <20221214131617.2447-1-johan+linaro@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Dec 2022 15:02:12 +0100
Message-ID: <CAJZ5v0gY-Lhgf_1Kfg6P5O8s+YMkP4TxggxyS=LU9jVgJikAkg@mail.gmail.com>
Subject: Re: [PATCH 0/4] thermal: fix locking regressions in linux-next
To:     Johan Hovold <johan+linaro@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
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

On Wed, Dec 14, 2022 at 2:18 PM Johan Hovold <johan+linaro@kernel.org> wrote:
>
> This series fixes some of the fallout after the thermal changes that
> just landed in linux-next.
>
> Lockdep reported a lock inversion in one of the Qualcomm drivers and a
> closer review revealed that the changes had also broken the sysfs
> interface for at least three drivers.
>
> Note that a simple revert of the offending patches was not an option as
> some of the infrastructure that the old implementation relied on has
> also been removed.

I've dropped that material from my linux-next branch and Daniel,
please also remove it from your branch that is pulled by linux-next so
that it doesn't show up in there until 6.2-rc1 is out.

It clearly is not ready for merging in its current form.

It is still present in my bleeding-edge branch, though, so please
apply the patches from Johan on top of it and send a new PR to me, so
I can add it back to my linux-next branch once 6.2-rc1 appears.

It would be good to check the code again too for any more similar fallout.

Thanks!
