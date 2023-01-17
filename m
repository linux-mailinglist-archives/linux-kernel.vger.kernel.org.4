Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56B066E87B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 22:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjAQVcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 16:32:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjAQVas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 16:30:48 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4752386B
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:56:22 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id c124so35430084ybb.13
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 11:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yX6+3HvGi/JBBED3BjbKlXKbkX2c1+XYkVkvZbiTdCU=;
        b=wujQrJi0Tdd+VhGfQqZVZqhwx+Ul+ejY7IxFv3l9huv8Es/bU1LVJey2dIVE+fQhKL
         dpxucrVRKEYY/CtFJFrqfjAgO2Z2pAT03z7Oj3GfuM1deOAdUyO937O+csOrem/dSHPP
         81YVjR+14tCr1pOjSYavYY5yMkxWO0dxCL6tVY3Og2dABY91X5QdUSUmpDi816rxsXMH
         M3ZDmVljGyjziRsU4cKM0dXynYOSC8YBPoZy6auWnGzf46FTqUk7Nkr7IMM0BF1RYwEe
         RCNdrxe/N1Nt/GqDuuIHFfnn2b42VPZSshgErZ905lUbwcPGWcRNEGWUcE8lmaGU+0mS
         YK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yX6+3HvGi/JBBED3BjbKlXKbkX2c1+XYkVkvZbiTdCU=;
        b=18h89uw4ZRi2GKK4YzletMzgnsSzv1XNsRvzWGDSnsnMnKPSMENRISU7zYfBdKiwA7
         BAT8E9U6/XWFfKPnGV3BSzCsTeIoJTeOUgjqBuCZhEt9r9r2s6KX5mAaT2mLpK+vE1HE
         6ZnDSDWQiaTQ9TScJc8JBFx6Y7IjFWg8794/i0L1J0QIcLYb7IwaOGmqxlmQcFoWPQN5
         rYan0ZAg4PtnePctp/fk1ctpQGfe2JHEBSyGilsTUXZCu0R83oTQo4qQNjCdn5ZIpRIA
         t6pfRitJI0AHIiTbRerR4pTDdFD1lRMTTj95HhCAQi4LZQuzfO5Gley7gf/x73zUQveN
         7YdA==
X-Gm-Message-State: AFqh2krCKmebX6mQr1lOnj3aygxvw/vVY3V1coBoWVEefYz74NWb2BDZ
        uNdMx8Ge2taK9tCH+ywaN/mmFlGQ0bs3PoSsY9DZag==
X-Google-Smtp-Source: AMrXdXvw2NwEdkD84Kl+3D0H20OO2m6B58bilFAkTCSITgzXtflWJDmamOP5hHStt88AvYwjFedz6X6mkWriMDj0FDs=
X-Received: by 2002:a25:ca81:0:b0:7d2:891e:ee59 with SMTP id
 a123-20020a25ca81000000b007d2891eee59mr594922ybg.152.1673985381327; Tue, 17
 Jan 2023 11:56:21 -0800 (PST)
MIME-Version: 1.0
References: <20230103145339.40501-1-andriy.shevchenko@linux.intel.com> <Y8bG5N6uf5XLoiuH@smile.fi.intel.com>
In-Reply-To: <Y8bG5N6uf5XLoiuH@smile.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 17 Jan 2023 21:56:10 +0200
Message-ID: <CAA8EJprAbNDTKW5L5dV9aQQrh1x7wUqNWOogWK9rvPUp5N2ihg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] thermal: qcom-spmi-adc-tm5: Use asm intead of asm-generic
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linexp.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Jan 2023 at 18:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, Jan 03, 2023 at 04:53:39PM +0200, Andy Shevchenko wrote:
> > There is no point to specify asm-generic for the unaligned.h.
> > Drop the 'generic' suffix.
>
> Any comments?

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
