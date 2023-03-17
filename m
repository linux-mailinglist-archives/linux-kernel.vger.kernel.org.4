Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D90616BF354
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjCQU6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjCQU6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:58:19 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7A2399D6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:58:16 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54184571389so116381257b3.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 13:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679086696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78yALmTsSciSeto27pgZIDoTUCcCZg0Xi7D0VKEquOI=;
        b=ReNqhlEAqD/sjcsPCojeM9w+k8jN3tbhjOvqFb5lB6b1itAJPunkb/lHyjF8e2zKyT
         JDo7lBArgVDBe0QdACN1oz12hmgq1mcaaUzJ4pX6igZKfxBSsbueysICZR/nxsoSeLsA
         fW4NL4S7AAmQIppB1LVJeo0iFltJzFmISdTpePZCIZ11udmbpU+XWOkvLaItCnrEkg4Z
         aTvXk7Lcfan9TvvbJWh7rPgUQb+TkyC7tDJGoX56xfEqSsDHiVzT0IO97mCFgLOjsSQt
         Y29K+xdi48dUhkt7rp1yj+yvJ/BL+7dUci2Po0wG2FDdQttm7+3Vlx02uUlpYCt0YDf6
         Btnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679086696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78yALmTsSciSeto27pgZIDoTUCcCZg0Xi7D0VKEquOI=;
        b=YiG7l4FBCLLIxgegS9SorB80c9wf0EnUC3kCM5vWEEp5rqTVvS4JDNlOKVdRo76ev9
         iiYBQiuGwjBDin2q/bA9wlTyKIr3aBOJ569niSM1tGkZXbnh++9VPGcDs+yySe2ebVK0
         R292mSWJhdFsXhwMg5KwiSPLSnTvtJO3L8WOV2Fo1/3y0NvQEoMURP16ZilWeyRCSahg
         PmU1F/Xg8IjDSa2TZVaUXazyMle0/yoPAbKm0G0uO8zDkp6VEchFty2MJV+IH4q8r+Ob
         LcQuUKX9E+qZ13KD5cfqxrW+qii0483P0g8jHhHfP6hR2n1gdjaFZw6tjgr0CxqFgxLs
         2qFw==
X-Gm-Message-State: AO0yUKUqgB/WzZ63I+35BCnIrGWbM1VLK3Pww0lSnf+yA3jaWsPSXRAa
        JUfPNEMTYAneHzI5Qk6CSrz4VrxJteby4D1xKks94kEqC623a3/I
X-Google-Smtp-Source: AK7set/ZRWZmr4fK9BRzq5dNAUC2K47cgi7Bwlzsv/gVUp7p6JUstQoJ4CPHuimwv8Pv/cAkKKJ7oBLmS6UNDDVaUFQ=
X-Received: by 2002:a81:c645:0:b0:53d:2772:65d with SMTP id
 q5-20020a81c645000000b0053d2772065dmr5177050ywj.9.1679086695996; Fri, 17 Mar
 2023 13:58:15 -0700 (PDT)
MIME-Version: 1.0
References: <1679070482-8391-1-git-send-email-quic_mojha@quicinc.com> <1679070482-8391-3-git-send-email-quic_mojha@quicinc.com>
In-Reply-To: <1679070482-8391-3-git-send-email-quic_mojha@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 17 Mar 2023 21:58:04 +0100
Message-ID: <CACRpkdbA27buNiOTz6ad4gyS4FCvcoYru6QB5k9Lqwiu72sf9g@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] pinctrl: qcom: Use qcom_scm_io_update_field()
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 5:28=E2=80=AFPM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:

> Use qcom_scm_io_update_field() exported function introduced
> in last commit.
>
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>

Fine by me, but I want you to first consider switching the
custom register accessors to regmap.

Yours,
Linus Walleij
