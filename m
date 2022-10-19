Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73DF9604768
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbiJSNiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 09:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiJSNhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 09:37:03 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CFB1C73DF;
        Wed, 19 Oct 2022 06:25:35 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id de14so11331484qvb.5;
        Wed, 19 Oct 2022 06:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7iighK5Vy8gk68F3waxRSbAxA6Pg0MUIOL+FTDyriE=;
        b=lbc9f9Wr+MxLszujk7YIHVD2gIxmji8gDF55GhCbPXbTOpfzYHEsnDjvr1XFtAAzxV
         Y230q/KlHHmUXvK3oExUPFGpbAg9HHpMkx6OH9mPYsMXi13fzWhYiOFM+IMR4B8yEP1D
         9JJY6OahJHSBXLuTKl/GUtPET1uHHnkJDZq10D/aoA36LYCUq+fZNoyhTB9tqdn+VAhN
         v+iHvX6jec4+IbEEz5fCtwuBYlErlW3ND0SAcqBCBzZiY92ScZhMcmvBzKSPw8JUjg+t
         McRoVrIA8cfeZjo4gzebr/jfJ4eYJjz1YtGoIJY0Eq+y+sgbcy4tMfWClGQIgk7QAZtS
         dvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7iighK5Vy8gk68F3waxRSbAxA6Pg0MUIOL+FTDyriE=;
        b=e2mgUax02FZKM1Ta2e9juNyssL73wbo52PZt2OxVXnWHcXN1VVE9yZ7hWTVg3typo2
         C5hygdefyFo+/92gQdlMtCnVXeex+IWrAomiIimffh8xByes0SJ1mLcFW4Xre4Iqm2p3
         rHzQwnCjl4r2Gh9MK7dytMuLnUUwHpvqNR3iDGNpm7egiAXpeDLkvIOoNLlIkKVgQCFs
         PFQl6Bl3YFt4Wl1zDe70wYetuVh1rX3s0U2LcRadl3KWu/ljQxpdHP4XeFpReCPtba/n
         q81kvrnw67pwsL0AjDhgu06p0oLViQkL/sRVd3i29ElZ7+xNf4XneWVGh+o5H2Xd2J6Y
         PMjA==
X-Gm-Message-State: ACrzQf0VF3nBxKVRlJRb5qGt+Gog4RunxT464J0QUk2ODxRV2QpTMpzS
        AsZDs8Tq2Fs/iIEWo8Zkq3s7bhNPa8pJv5n3qHLgnuu3kro=
X-Google-Smtp-Source: AMsMyM5FowDKe50QjwKrcEleklOnkrieNhZVyIYLQkfP/nWqKKKYRKt4DD88fda3BWm31Sggvpw7FDP/DgFU3SFuKGs=
X-Received: by 2002:a05:6214:300c:b0:4b3:cefd:fae0 with SMTP id
 ke12-20020a056214300c00b004b3cefdfae0mr6498909qvb.48.1666185897084; Wed, 19
 Oct 2022 06:24:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221019125254.952588-1-mitja@lxnav.com>
In-Reply-To: <20221019125254.952588-1-mitja@lxnav.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 19 Oct 2022 16:24:21 +0300
Message-ID: <CAHp75Vd5p5tT52JA9HXaJ5opspXJJS2JECQUAUs9bqQVzc_+2Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: pressure: ms5611: fixed value compensation bug
To:     Mitja Spes <mitja@lxnav.com>
Cc:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 3:55 PM Mitja Spes <mitja@lxnav.com> wrote:
>
> When using multiple instances of this driver the compensation PROM was
> overwritten by the last initialized sensor. Now each sensor has own PROM

its own

> storage.

This change is just a good example why the chip_info should always be
static const, so the volatile data should come through the different
sources.

-- 
With Best Regards,
Andy Shevchenko
