Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2FB74A344
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231642AbjGFRkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjGFRki (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:40:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C93211E;
        Thu,  6 Jul 2023 10:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BE64610A4;
        Thu,  6 Jul 2023 17:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC02C433CC;
        Thu,  6 Jul 2023 17:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688665219;
        bh=OafE7RfQPhCn8tz1LRoCXIwPX8fW355ojJh3GXDoLxg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vKaOglrQuoab84EHenMv3upxX9VjaL2ESZ5qhceANzLE9Dib+Fw2fJmKKyBW5viGp
         xl3DY5S18g0EzXYOSHXeupXBotaUOw2gwrd5odDeIw8lTRM1XcBKLtFs9P9Z49kjt6
         rdy+GnSvj80wAljeJscpKhnBogmq16beIU94wbHueiQNwQl1mrAZ/6tpMjXIoRXrzv
         r51VOY1e+2swB3HPcjKhlUoo29LfX+l2tX2BRIXWisaewYbIZ5q01tA97PAF563zxU
         Uh7w8cH0fucVFYJhnD96sZ8dDN0x+Roiywe7uxUOZv/KPkx+9RLRzB0RNl3IdBcvGt
         B+3OJEagOFUOA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b703cbfaf5so15491041fa.1;
        Thu, 06 Jul 2023 10:40:19 -0700 (PDT)
X-Gm-Message-State: ABy/qLZJymvt6CmIlHrasR5RAbmeclR2RS4UGb+/za1yWFZysGiwsrRk
        0ViID54TPsVas1gW8ds4y4TMfbHG28Ne/za6Ug==
X-Google-Smtp-Source: APBJJlFLFNiNJigyFmziwL1wFkrKwaYKPPN5OlsHTXZ5q/hFDchpxmkQpAARprOA+JxtkSg2vaCjxysk/E9zGT8Ut40=
X-Received: by 2002:a2e:8885:0:b0:2b6:e9e1:f62f with SMTP id
 k5-20020a2e8885000000b002b6e9e1f62fmr1875581lji.5.1688665217743; Thu, 06 Jul
 2023 10:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <1687955688-20809-1-git-send-email-quic_mojha@quicinc.com>
 <2023062814-chance-flounder-f002@gregkh> <CAL_JsqLO9yey2-4FcWsaGxijiS6hGL0SH9VoMuiyei-u9=Cv=w@mail.gmail.com>
 <cc30660f-dd72-aade-6346-a93c6ad4b695@quicinc.com> <29af84dc-7db8-0c43-07b6-eb743cf25e57@linaro.org>
 <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com>
In-Reply-To: <957a3cdb-6091-8679-ddb0-296db2347291@quicinc.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Jul 2023 11:40:05 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
Message-ID: <CAL_JsqK7MHR09U5h01=Gf1ZLeDVCgZdN-W1hQRH3AX+E94_uUg@mail.gmail.com>
Subject: Re: [PATCH v4 00/21] Add Qualcomm Minidump kernel driver related support
To:     Trilok Soni <quic_tsoni@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>,
        Greg KH <gregkh@linuxfoundation.org>, corbet@lwn.net,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        mathieu.poirier@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, linus.walleij@linaro.org,
        andy.shevchenko@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        Alex Elder <elder@linaro.org>
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

On Mon, Jul 3, 2023 at 3:06=E2=80=AFPM Trilok Soni <quic_tsoni@quicinc.com>=
 wrote:
>
> On 7/2/2023 1:29 AM, Krzysztof Kozlowski wrote:
> > On 30/06/2023 18:04, Mukesh Ojha wrote:
> >>>
> >>>> We don't add layers when they are not needed, and never when there i=
s no
> >>>> actual user.  If you need the extra "complexity" later, then add it
> >>>> later when it is needed as who knows when that will ever be.
> >>>>
> >>>> Please redo this series based on that, thanks.
> >>>
> >>> My bigger issue with this whole series is what would this all look
> >>> like if every SoC vendor upstreamed their own custom dumping
> >>> mechanism. That would be a mess. (I have similar opinions on the
> >>> $soc-vendor hypervisors.)
> >
> > Mukesh,
> >
> > LPC CFP is still open. There will be also Android and Kernel Debugging
> > LPC microconference tracks. Coming with a unified solution could be a
> > great topic for LPC. Solutions targeting only one user are quite often
> > frowned upon.
>
> LPC is far out and in November. Can we not have others speak up if they
> have the similar solution now? We can expand this to linux-kernel and
> ask for the other SOC vendors to chime in. I am sure that we may have
> existing solutions which came in for the one user first like Intel RDT
> if I remember. I am sure ARM MPAM usecase was present at that time but
> Intel RDT based solution which was x86 specific but accepted.

RDT predated MPAM. resctrl is the kernel feature, and it supports
Intel and AMD which are not identical. resctrl is being (extensively)
refactored to add in MPAM support.

You are not the first here like Intel RDT, so I fail to see the
parallel with minidump. We have an existing logging to persistent
storage mechanism which is pstore. You should integrate into that
rather than grafting something on to the side or underneath.

Rob
