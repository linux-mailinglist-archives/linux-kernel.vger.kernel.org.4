Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC57491E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 01:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGEX1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 19:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231608AbjGEX1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 19:27:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE47A171A;
        Wed,  5 Jul 2023 16:27:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B2DF6187C;
        Wed,  5 Jul 2023 23:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FE9CC433CA;
        Wed,  5 Jul 2023 23:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688599661;
        bh=71ABv5/JwaJZ55URTzD8vGgqeEszc1MgI9Tgv+MINjE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZONJDYYI4DfLy7Qsq2iruWU/TAy+MfhN8a+13GK2IWPkDZqio7bRNxa5SQs05lP4P
         cwPUPxti1OHDRjna7RLvlHvYzjGzNzbIQj3qP3y/Bn+msmAYu9HbnUfdOB0mW+oJ0Y
         xXd9KYSiaVMbhH8iXxtVbsReICsvqSFCZ93UbTBDH2SxezF1CiOXVRCeK6+eL9LKGf
         lv5Tdq9By8SoiBvDGs8LHavKem9Wb+MzUqre5RXfWHiAchuT+L/DCozo3/BlyhktAW
         7OLkwTDgnazo9mvhKgyHb/J//J+68K3lIP4d0Lf8VbQ7BmWtxd0vaabSh0ecr/t8zz
         aclhgVyMhnn3Q==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b6ef64342aso231811fa.3;
        Wed, 05 Jul 2023 16:27:41 -0700 (PDT)
X-Gm-Message-State: ABy/qLZ15zN9i0RK29N24/YPEZcU9AmIcYDkhPFpv4CaynvygCJuwO56
        xE1BiyzvzmSOMJMehNsGnW17NxHUoZ1nVel/ew==
X-Google-Smtp-Source: APBJJlEpNIPlBGdtVBVr58J7X3ky87DEhp6DbA9itW5/VGUcmhmKpi6TWJGAkGRnBuBFSJRhMLcgVJySm3N6emm2tmc=
X-Received: by 2002:a2e:a170:0:b0:2b6:e958:d03 with SMTP id
 u16-20020a2ea170000000b002b6e9580d03mr124735ljl.30.1688599659474; Wed, 05 Jul
 2023 16:27:39 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <1687955688-20809-11-git-send-email-quic_mojha@quicinc.com>
 <CAL_Jsq+O70mnreuS1m54RKM+uZu_z1L87RT8sKBYEw5uvowGJg@mail.gmail.com> <e0fef1b0-3fa1-08c1-3c0e-aca30c9da266@quicinc.com>
In-Reply-To: <e0fef1b0-3fa1-08c1-3c0e-aca30c9da266@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 5 Jul 2023 17:27:27 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FEAYXJTfMKQ6nOKzZLJH49x=XroNCYnkqa=RHuQ99qg@mail.gmail.com>
Message-ID: <CAL_Jsq+FEAYXJTfMKQ6nOKzZLJH49x=XroNCYnkqa=RHuQ99qg@mail.gmail.com>
Subject: Re: [PATCH v4 10/21] soc: qcom: Add qcom's pstore minidump driver support
To:     Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     corbet@lwn.net, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, mathieu.poirier@linaro.org,
        catalin.marinas@arm.com, will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 3:16=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc.com=
> wrote:
>
>
>
> On 6/29/2023 4:27 AM, Rob Herring wrote:
> > On Wed, Jun 28, 2023 at 6:37=E2=80=AFAM Mukesh Ojha <quic_mojha@quicinc=
.com> wrote:
> >>
> >> This driver was inspired from the fact pstore ram region should be
> >> fixed and boot firmware need to have awarness about this region,
> >> so that it will be persistent across boot. But, there are many
> >> QCOM SoC which does not support warm boot from hardware but they
> >> have minidump support from the software, and for them, there is
> >> no need of this pstore ram region to be fixed, but at the same
> >> time have interest in the pstore frontends data. So, this driver
> >> get the dynamic reserved region from the ram and register the
> >> ramoops platform device.
> >>
> >>   +---------+     +---------+   +--------+     +---------+
> >>   | console |     | pmsg    |   | ftrace |     | dmesg   |
> >>   +---------+     +---------+   +--------+     +---------+
> >>         |             |             |              |
> >>         |             |             |              |
> >>         +------------------------------------------+
> >>                            |
> >>                           \ /
> >>                    +----------------+
> >>              (1)   |pstore frontends|
> >>                    +----------------+
> >>                            |
> >>                           \ /
> >>                   +------------------- +
> >>              (2)  | pstore backend(ram)|
> >>                   +--------------------+
> >>                            |
> >>                           \ /
> >>                   +--------------------+
> >>              (3)  |qcom_pstore_minidump|
> >>                   +--------------------+
> >>                            |
> >>                           \ /
> >>                     +---------------+
> >>              (4)    | qcom_minidump |
> >>                     +---------------+
> >>
> >> This driver will route all the pstore front data to the stored
> >> in qcom pstore reserved region and the reason of showing an
> >> arrow from (3) to (4) as qcom_pstore_minidump driver will register
> >> all the available frontends region with qcom minidump driver
> >> in upcoming patch.
> >>
> >> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> >> ---
> >>   drivers/soc/qcom/Kconfig                | 12 +++++
> >>   drivers/soc/qcom/Makefile               |  1 +
> >>   drivers/soc/qcom/qcom_pstore_minidump.c | 85 +++++++++++++++++++++++=
++++++++++
> >
> > drivers/soc/ is the dumping ground for things with no other place. As
> > this is a pstore driver, it belongs with pstore.
>
> The inspiration of this driver was taken from
> drivers/platform/chrome/chromeos_pstore.c, do you think that is misplaced=
 ?

The difference is really that's nothing more than platform specific
logic to instantiate a normal ramoops device. It's kind of ugly, yes,
but it's still just a normal ramoops device in the end. Your case is
that plus all the extra parts for minidump.

Rob
