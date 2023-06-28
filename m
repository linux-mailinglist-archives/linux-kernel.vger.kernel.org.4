Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C4A741C40
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 01:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjF1XM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 19:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbjF1XMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 19:12:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 840331FFB;
        Wed, 28 Jun 2023 16:12:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 12EFA6148B;
        Wed, 28 Jun 2023 23:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71A48C433CB;
        Wed, 28 Jun 2023 23:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687993941;
        bh=VtoAF6nuCa4Fxj4WgDnwmAot+ZQSC5M1c1smWPa+7s4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZMut3JVteUhuboOHyxQn2/OnmHzUHTDI7P5S69np/0sSNjWKL8xCAKh1QCBWT/H3c
         AkhD8qwR9f4ceDA4eQFcxfG9R2MzFkkzpmjx+cTJlheZ+gIEW2kZXyMImjX926Df6o
         Ryd6MguGXwa8irs4lKVuhqyKjQV/skz00UJLeVADdJNEiZm2lDTE+wIrbC9uNkdzQ5
         R+vVZlwfGoaLiJN1VsH0kKapglMuQvPMoX3uOOtkvHQ5rZ8QuRZRF52sv5TklWqzBz
         kbTJlr6uzeM64DUw8XY50SABgKR46yFeqYila9O/AG/FQUtP+SDCkD0kKZqLyt+RuI
         W5DgXISkURJcg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2b69ea3b29fso946411fa.3;
        Wed, 28 Jun 2023 16:12:21 -0700 (PDT)
X-Gm-Message-State: AC+VfDzGMh5ZKE2fPqWCI6o2wX+uDoEcucjgHZU0jEJ2SJp+Of0ctGn6
        poStpg4n0WL7eMIIzdxVyv+GN+Jb9Oz3JAY5BQ==
X-Google-Smtp-Source: ACHHUZ6Fzpg/so1UAEGwnBtL4zBjBnbpHjF3CA2AlhadTbCPzhJfaOQGQ18vYiqiQMB+CX6Xq5p+Wl0G+/tQFXQKP78=
X-Received: by 2002:a2e:9107:0:b0:2b5:9b3b:f7ea with SMTP id
 m7-20020a2e9107000000b002b59b3bf7eamr11189150ljg.41.1687993939392; Wed, 28
 Jun 2023 16:12:19 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com> <2023062814-chance-flounder-f002@gregkh>
In-Reply-To: <2023062814-chance-flounder-f002@gregkh>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 28 Jun 2023 17:12:06 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
Message-ID: <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related support
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 9:45=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Wed, Jun 28, 2023 at 06:04:27PM +0530, Mukesh Ojha wrote:
> > Minidump is a best effort mechanism to collect useful and predefined da=
ta
> > for first level of debugging on end user devices running on Qualcomm So=
Cs.
> > It is built on the premise that System on Chip (SoC) or subsystem part =
of
> > SoC crashes, due to a range of hardware and software bugs. Hence, the
> > ability to collect accurate data is only a best-effort. The data collec=
ted
> > could be invalid or corrupted, data collection itself could fail, and s=
o on.
> >
> > Qualcomm devices in engineering mode provides a mechanism for generatin=
g
> > full system ramdumps for post mortem debugging. But in some cases it's
> > however not feasible to capture the entire content of RAM. The minidump
> > mechanism provides the means for selecting which snippets should be
> > included in the ramdump.
> >
> > Minidump kernel driver implementation is divided into two parts for
> > simplicity, one is minidump core which can also be called minidump
> > frontend(As API gets exported from this driver for registration with
> > backend) and the other part is minidump backend i.e, where the underlyi=
ng
> > implementation of minidump will be there. There could be different way
> > how the backend is implemented like Shared memory, Memory mapped IO
> > or Resource manager(gunyah) based where the guest region information is
> > passed to hypervisor via hypercalls.
> >
> >     Minidump Client-1     Client-2      Client-5    Client-n
> >              |               |              |             |
> >              |               |    ...       |   ...       |
> >              |               |              |             |
> >              |               |              |             |
> >              |               |              |             |
> >              |               |              |             |
> >              |               |              |             |
> >              |               |              |             |
> >              |           +---+--------------+----+        |
> >              +-----------+  qcom_minidump(core)  +--------+
> >                          |                       |
> >                          +------+-----+------+---+
> >                                 |     |      |
> >                                 |     |      |
> >                 +---------------+     |      +--------------------+
> >                 |                     |                           |
> >                 |                     |                           |
> >                 |                     |                           |
> >                 v                     v                           v
> >      +-------------------+      +-------------------+     +------------=
------+
> >      |qcom_minidump_smem |      |qcom_minidump_mmio |     | qcom_minidu=
mp_rm |
> >      |                   |      |                   |     |            =
      |
> >      +-------------------+      +-------------------+     +------------=
------+
> >        Shared memory              Memory mapped IO           Resource m=
anager
> >         (backend)                   (backend)                   (backen=
d)
> >
> >
> > Here, we will be giving all analogy of backend with SMEM as it is the
> > only implemented backend at present but general idea remains the same.
>
> If you only have one "backend" then you don't need the extra compexity
> here at all, just remove that whole middle layer please and make this
> much simpler and smaller and easier to review and possibly accept.

pstore already supports backends. Why aren't the above backends just
pstore backends rather than having an intermediate pstore backend in
RAM which then somehow gets moved into these minidump backends.

> We don't add layers when they are not needed, and never when there is no
> actual user.  If you need the extra "complexity" later, then add it
> later when it is needed as who knows when that will ever be.
>
> Please redo this series based on that, thanks.

My bigger issue with this whole series is what would this all look
like if every SoC vendor upstreamed their own custom dumping
mechanism. That would be a mess. (I have similar opinions on the
$soc-vendor hypervisors.)

Rob
