Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B14D7261A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240390AbjFGNsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 09:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240238AbjFGNr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 09:47:58 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25871BE2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 06:47:56 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-777b1b5ff50so133677639f.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1686145675; x=1688737675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Igbil4rQ+bksY47TEj8Cy1rhyNXKg8xa0jQJqvVvp7E=;
        b=eHS9dZgPSMn88aCtAZNwchhK4VxtP6ZilnYohBfTTvLdD6mLOp+lZFqoglDdtulnwD
         On7mPzxvlxu2rbcy1CthZ4Uj0c0MN/tDSZDoYdFIy/rrX4cidB2xkmYSU9CIBycjRhz8
         Lf00h091Tnt4AaJdQDOnuvurCWGgwLniOziPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145675; x=1688737675;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Igbil4rQ+bksY47TEj8Cy1rhyNXKg8xa0jQJqvVvp7E=;
        b=JHD28PxBDbLBQ+PGq5wVfEe9egvOUroegetp00P8RHb9Tv++nLMhZo2PNCMFxJNOTN
         DXNf6KWvEnSdpFznlfOcROJNs63U6KL9ERx8QGM+/NvQn26gRD+u4hM+ZrKJbNP0VT9M
         HTz+Y9Ph+Hqfko6phENyFJadVHvH0UzbPCecVFknWAwm6HHDAg50sS4FldaonurV3PUc
         PrMjJZE9PWalWL3DzSJov/C8GhNScACwNhNMCxF0jjYDk97bSzPF64vDjiRsj/i8O1pe
         XvFPsBsXaz3yDD5DmzEeoKYLnhnBzkr/MzCccRccDN/K0hmHTd1qORMqakdhWX4CUrEj
         7nZw==
X-Gm-Message-State: AC+VfDxflIrhNI9ET80WDmpEyYdYYDg0uw4x0tCj3ZPCxMLUJg8HQp7H
        nEYd9zdULD44j1qL0hc5qKUTkki2PjeL02mcDrA=
X-Google-Smtp-Source: ACHHUZ4qATKds3LWnnfGbdxaldlR3JjNJaAqCz4hA+gIGsmVy+rwrMvppZepQ1A68jDRmyhPjdGPew==
X-Received: by 2002:a5d:9390:0:b0:760:a3c7:1a86 with SMTP id c16-20020a5d9390000000b00760a3c71a86mr5623051iol.16.1686145675323;
        Wed, 07 Jun 2023 06:47:55 -0700 (PDT)
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com. [209.85.166.174])
        by smtp.gmail.com with ESMTPSA id dq31-20020a0566384d1f00b0041f5061884asm2350278jab.29.2023.06.07.06.47.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 06:47:54 -0700 (PDT)
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-33dea7d5424so105695ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 06:47:53 -0700 (PDT)
X-Received: by 2002:a05:6e02:12c4:b0:33d:8c8a:cd0e with SMTP id
 i4-20020a056e0212c400b0033d8c8acd0emr223924ilm.20.1686145673358; Wed, 07 Jun
 2023 06:47:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAMi1Hd05z8uBotO4vs7Ropmt7W2gSA__tTu_=X1t0mze7bXrhg@mail.gmail.com>
 <CAD=FV=VSFDe445WEVTHXxU1WS_HGUV5jR5E8_Vgd4eyhn3rHyA@mail.gmail.com>
 <CAMi1Hd28FJUjB8A-9YF7xpKOzSyNWXX3qung4aDjpLBhOvw_eA@mail.gmail.com>
 <CAD=FV=W13L0H88G1gt8qRnXfpV-_7E9QfHufN_a23_B1bb=aww@mail.gmail.com>
 <CAMi1Hd1WCtNvNaY_kVMx5F8T0nMVHvsjk9LsSETCMWWQyaq_Vw@mail.gmail.com>
 <CAD=FV=W5Y_SHp0y2MEs8d1k255bm_PXdRYEmYei+g79pjnzYuA@mail.gmail.com>
 <CAMi1Hd2OeL940r7jq0=Z_oxE8MYVioy0YnJXQC_5e0vJONd2sQ@mail.gmail.com>
 <1bc79c48-7cba-476d-9a7e-5754a88fcdae@sirena.org.uk> <CAMi1Hd2BLB6H3QRLB5svRTkGoXaUeEsakNsmfCOjbDBcCEeqkA@mail.gmail.com>
 <CAD=FV=UKyjRNZG-ED2meUAR9aXdco+AbUTHiKixTzjCkaJbjTg@mail.gmail.com> <bb5c828a-b8c5-40a0-9b67-44e73abcbef0@sirena.org.uk>
In-Reply-To: <bb5c828a-b8c5-40a0-9b67-44e73abcbef0@sirena.org.uk>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 7 Jun 2023 06:47:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXOse+yRUmZBUOkfpWXPRKBw2R-+BVzPGcuwwFV_VqQw@mail.gmail.com>
Message-ID: <CAD=FV=UXOse+yRUmZBUOkfpWXPRKBw2R-+BVzPGcuwwFV_VqQw@mail.gmail.com>
Subject: Re: [PATCH] regulator: qcom-rpmh: Revert "regulator: qcom-rpmh: Use PROBE_FORCE_SYNCHRONOUS"
To:     Mark Brown <broonie@kernel.org>
Cc:     Amit Pundir <amit.pundir@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Saravana Kannan <saravanak@google.com>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 7, 2023 at 6:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> On Tue, Jun 06, 2023 at 04:29:29PM -0700, Doug Anderson wrote:
>
> > 2. Try adding some delays to some of the regulators with
> > "regulator-enable-ramp-delay" and/or "regulator-settling-time-us".
> > Without a scope, it'll be tricky to figure out exactly which
> > regulators might need delays, but you could at least confirm if the
> > "overkill" approach of having all the regulators have some delay
> > helps... I guess you could also try putting a big delay for "ldo26".
> > If that works, you could try moving it up (again using a bisect style
> > approach) to see where the delay matters?
>
> This is information which should be in the datasheets for the part.

I was thinking more of something board-specific, not part specific. In
theory with RPMH this is also all supposed to be abstracted out into
the firmware code that sets up RPMH which magically takes care of
things like this, but it certainly could be wrong.
