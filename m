Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0A5A66314C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237503AbjAIUTS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:19:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237817AbjAIUS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:18:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF35F34D67;
        Mon,  9 Jan 2023 12:18:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29799B80FA3;
        Mon,  9 Jan 2023 20:18:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A24C433F0;
        Mon,  9 Jan 2023 20:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673295533;
        bh=fKmzDa8xWu0AAMUhY9kDg0odlBMun7WpnzbGtGHCOBE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oDX2C9i+FDRvpquD0Tm76+Ztd1AH/yS/g3Qg7WHgxgYL29Ye/phnNYpv6xEpWwKQd
         JFkLncU8U/jqrN9TiunGb0Sx7rtJBsQjfJUv6/3OJh1oOagbURdbzilqMRkXx05cGT
         24r5PMAvpKBzBIKcNP6ycQLhO+AC7wPoOldLkZH/s2TmcZuCUy+nl6bew7FhvtUsP7
         wMo43JkxcraKxsM/4ISzDPaCz++NYL2cfLYyD2xiLF8bmRIjpXGDfMcvlSDIrCmHAp
         vIGicqV03wqm+0XB+dtNuM4qoJ+/jdj78Mp4Zn8Cn7qKSmPtFVNk0TptynUg3Awio7
         /ZLLBqlUUNrHg==
Received: by mail-ua1-f54.google.com with SMTP id l13so2312166uai.8;
        Mon, 09 Jan 2023 12:18:53 -0800 (PST)
X-Gm-Message-State: AFqh2kqyPZU5RJ8uAhWKXUAQRLKBUX0Z0lp7Ux2ppz0OtEo+T27iXfdn
        Aq9x80pbhY3GKADzSWnY6h36QMlAc8ct6n9+Ng==
X-Google-Smtp-Source: AMrXdXs6BTZ+8D74o0hJQvodxrknKckEnyT3FIAUEDSl4Nm2U6u2mch8LVVAz/MbaiofQWil2sRw59UL0KIBA4Gu1cs=
X-Received: by 2002:a05:6130:2ac:b0:573:d2a:e6cf with SMTP id
 q44-20020a05613002ac00b005730d2ae6cfmr3918699uac.36.1673295532626; Mon, 09
 Jan 2023 12:18:52 -0800 (PST)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v4-0-327f860daf28@kernel.org>
 <20220825-arm-spe-v8-7-v4-3-327f860daf28@kernel.org> <Y7xsDXFlNjiQ1AIe@sirena.org.uk>
In-Reply-To: <Y7xsDXFlNjiQ1AIe@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 9 Jan 2023 14:18:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLFSMzmTSAjtWWotzFy=JLr+rjim4F_X5thWK9ji6z22g@mail.gmail.com>
Message-ID: <CAL_JsqLFSMzmTSAjtWWotzFy=JLr+rjim4F_X5thWK9ji6z22g@mail.gmail.com>
Subject: Re: [PATCH v4 3/8] arm64/sysreg: Convert SPE registers to automatic generation
To:     Mark Brown <broonie@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-perf-users@vger.kernel.org,
        James Clark <james.clark@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 9, 2023 at 1:33 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Mon, Jan 09, 2023 at 01:26:19PM -0600, Rob Herring wrote:
> > Convert all the SPE register defines to automatic generation. No
> > functional changes.
> >
> > New registers and fields for SPEv1.2 are added with the conversion.
> >
> > Some of the PMBSR MSS field defines are kept as the automatic generation
> > has no way to create multiple names for the same register bits. The
> > meaning of the MSS field depends on other bits.
> >
> > Tested-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v4:
> >  - Rebase on v6.2-rc1
> > v3:
> >  - Make some fields enums and add some missing fields
>
> What changed to invalidate my Reviewed-by?
>
>    https://lore.kernel.org/all/Y2kgC9QlBwvXTLe6@sirena.org.uk/

Ugg, sorry. Nothing changed, I just forgot to add it.

Rob
