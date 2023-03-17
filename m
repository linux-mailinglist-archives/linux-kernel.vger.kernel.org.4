Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA66BF222
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 21:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCQUHc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCQUH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 16:07:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BD2C926C;
        Fri, 17 Mar 2023 13:07:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D285B826C3;
        Fri, 17 Mar 2023 20:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB64C433D2;
        Fri, 17 Mar 2023 20:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679083617;
        bh=Mgg4bDFRGesX8yNPgO7fnJobvuTc6xBNxQK+2C4ouDI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mj37XDLMC7EUXqDoyspDOe+cTo7fK8qaE3rF9zRvgUMuJ+eVZCbfFBM20pI0k2hK9
         SeTWZh80Ysa65/PNCcfI90guofNqwhevO3UwVG5LzQPaf9l8Hskg0si41nMkgj38XU
         +fB23CYd+GdjpOfO3G5R6N3D2iYDRbuzNwyWvES5rGhq8yR2tSGf9x5f8aqTY+ixMT
         coEo5i+keOnhpZ9agnFOZzOK3wtBF4NwWuycJcl1eSlkuuPw3J89YLUl1w0/0X6HJy
         rdqK4wNvsKs10k4+bof4G69+P37fYCLCdGydm3wD52E6xocOcqngizlyIUSFic6FR4
         P1UCI/rEu449g==
Received: by mail-ua1-f44.google.com with SMTP id i22so4118059uat.8;
        Fri, 17 Mar 2023 13:06:57 -0700 (PDT)
X-Gm-Message-State: AO0yUKV46y+oHdJsIlTZ4zs//QzqM+roNFYqhG1wTGXAxZKOwQGPfZB3
        3y1aPCw//kEF59aAP3yJXGCwWDF3xDiBXeM5gA==
X-Google-Smtp-Source: AK7set9V2TUxO+XXHuoP7ORPvTwFeu0As3/hkSPDWT8VpWzStpv3mMm61AnJtMT8sVYYfD0AKS6SlVxHvn/8/Q9dvOA=
X-Received: by 2002:a1f:a04d:0:b0:432:872c:cee0 with SMTP id
 j74-20020a1fa04d000000b00432872ccee0mr535116vke.3.1679083616598; Fri, 17 Mar
 2023 13:06:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <20230317030501.1811905-7-anshuman.khandual@arm.com> <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
 <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com>
In-Reply-To: <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 17 Mar 2023 15:06:45 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKQWL4Y9zZj5x11QUB=8N9GLKo26EX=fVxXes_gShYf7Q@mail.gmail.com>
Message-ID: <CAL_JsqKQWL4Y9zZj5x11QUB=8N9GLKo26EX=fVxXes_gShYf7Q@mail.gmail.com>
Subject: Re: [PATCH 6/7] of/platform: Skip coresight etm4x devices from AMBA bus
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        scclevenger@os.amperecomputing.com,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 11:03=E2=80=AFAM Suzuki K Poulose
<suzuki.poulose@arm.com> wrote:
>
> Hi Rob
>
> Thanks for your response.
>
> On 17/03/2023 14:52, Rob Herring wrote:
> > On Thu, Mar 16, 2023 at 10:06=E2=80=AFPM Anshuman Khandual
> > <anshuman.khandual@arm.com> wrote:
> >>
> >> Allow other drivers to claim a device, disregarding the "priority" of
> >> "arm,primecell". e.g., CoreSight ETM4x devices could be accessed via M=
MIO
> >> (AMBA Bus) or via CPU system instructions.
> >
> > The OS can pick which one, use both, or this is a system integration
> > time decision?
>
> Not an OS choice. Historically, this has always been MMIO accessed but
> with v8.4 TraceFiltering support, CPUs are encouraged to use system
> instructions and obsolete MMIO. So, yes, MMIO is still possible but
> something that is discouraged and have to be decided at system
> integration time.
>
> >
> >> The CoreSight ETM4x platform
> >> driver can now handle both types of devices. In order to make sure the
> >> driver gets to handle the "MMIO based" devices, which always had the
> >> "arm,primecell" compatible, we have two options :
> >>
> >> 1) Remove the "arm,primecell" from the DTS. But this may be problemati=
c
> >>   for an older kernel without the support.
> >>
> >> 2) The other option is to allow OF code to "ignore" the arm,primecell
> >> priority for a selected list of compatibles. This would make sure that
> >> both older kernels and the new kernels work fine without breaking
> >> the functionality. The new DTS could always have the "arm,primecell"
> >> removed.
> >
> > 3) Drop patches 6 and 7 and just register as both AMBA and platform
> > drivers. It's just some extra boilerplate. I would also do different
> > compatible strings for CPU system instruction version (assuming this
> > is an integration time decision).
>
> The system instruction (and the reigster layouts) are all part of the
> ETMv4/ETE architecture and specific capabilities/features are
> discoverable, just like the Arm CPUs. Thus we don't need special
> versions within the ETMv4x or ETE minor versions. As of now, we have
> one for etm4x and another for ete.

I just meant 2 new compatible strings. One each for ETMv4x and ETE,
but different from the 2 existing ones. It is different h/w presented
to the OS, so different compatible.

> One problem with the AMBA driver in place is having to keep on adding
> new PIDs for the CPUs. The other option is to have a blanket mask
> for matching the PIDs with AMBA_UCI_ID checks.

But if MMIO access is discouraged, then new h/w would use the platform
driver(s), not the amba driver, and you won't have to add PIDs.

Rob
