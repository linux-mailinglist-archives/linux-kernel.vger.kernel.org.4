Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1C16C1452
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjCTOGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjCTOF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:05:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6DA3C15;
        Mon, 20 Mar 2023 07:05:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F21B96151A;
        Mon, 20 Mar 2023 14:05:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A8AC433AA;
        Mon, 20 Mar 2023 14:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679321155;
        bh=BQx8aUl7GLoq/qgDAS8nVwKZ9Vn7FKwuFxwItO3PCP0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=mayXoqmJjcxaDkUKWupUUGhvhO9+cCSHMV2JNu8Ku/A0Mfnm8T5TSQrUni5J85nyt
         QqOXImkzYfuBXg3JjwHBufuQoWkov8eNYHviaCWHkrdh24Xi+SImYK1uBd5dyWWbHH
         Tz8EI7767ikZmooyCorp1Ru+nejcnJBRk0BX4kG9kEwafELIOMZo7ZsbwV+2wh5SLA
         TNzaqtUy+gXS84soB/z4ew6LwMk/dEG9tXCiyU1HXCa0fkC/IeRaNzWEVsw4GwJTge
         rGWtol9+r39Ql5Z9ttR7575hEB53/X+TMsvKl0C2OXW2hC8EOkiCA6G0vvtf5wh+om
         ev2iJpSPWFkfA==
Received: by mail-ua1-f44.google.com with SMTP id 89so7996520uao.0;
        Mon, 20 Mar 2023 07:05:55 -0700 (PDT)
X-Gm-Message-State: AO0yUKVUHMoSqAtIKxWbFi9fbKTP3zov6O5jVNEluSDNypyD/gB4g22e
        VjNzV3kPe8V4Vg6RtWP18eeTJd7TL1LR71WLKg==
X-Google-Smtp-Source: AK7set8KpE3+llxGpjySVigXjI5p31ZGTqkP+0UwGIrVC3LsLtO04RucwbkyTavWeO9OiCygzYpQ8IOMAOBgRZidHCs=
X-Received: by 2002:a1f:1690:0:b0:432:95d0:abaf with SMTP id
 138-20020a1f1690000000b0043295d0abafmr3969353vkw.3.1679321153900; Mon, 20 Mar
 2023 07:05:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230317030501.1811905-1-anshuman.khandual@arm.com>
 <20230317030501.1811905-7-anshuman.khandual@arm.com> <CAL_JsqK8vnwTZ3-nTd-S+dpCrQebAUm-NRiaJBE6KkoAVq=Ovg@mail.gmail.com>
 <b1518e16-d74b-719c-a0fc-bc172a6011c4@arm.com> <CAL_JsqKQWL4Y9zZj5x11QUB=8N9GLKo26EX=fVxXes_gShYf7Q@mail.gmail.com>
 <aa4090eb-4d9a-3c3b-afab-94d7132af0c7@arm.com>
In-Reply-To: <aa4090eb-4d9a-3c3b-afab-94d7132af0c7@arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 20 Mar 2023 09:05:42 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+bJJBi++tpqPMoNTVUswvwFJq=kQj5zHuf-rDphbDwkQ@mail.gmail.com>
Message-ID: <CAL_Jsq+bJJBi++tpqPMoNTVUswvwFJq=kQj5zHuf-rDphbDwkQ@mail.gmail.com>
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

On Mon, Mar 20, 2023 at 5:37=E2=80=AFAM Suzuki K Poulose <suzuki.poulose@ar=
m.com> wrote:
>
>
> On 17/03/2023 20:06, Rob Herring wrote:
> > On Fri, Mar 17, 2023 at 11:03=E2=80=AFAM Suzuki K Poulose
> > <suzuki.poulose@arm.com> wrote:
> >>
> >> Hi Rob
> >>
> >> Thanks for your response.
> >>
> >> On 17/03/2023 14:52, Rob Herring wrote:
> >>> On Thu, Mar 16, 2023 at 10:06=E2=80=AFPM Anshuman Khandual
> >>> <anshuman.khandual@arm.com> wrote:
> >>>>
> >>>> Allow other drivers to claim a device, disregarding the "priority" o=
f
> >>>> "arm,primecell". e.g., CoreSight ETM4x devices could be accessed via=
 MMIO
> >>>> (AMBA Bus) or via CPU system instructions.
> >>>
> >>> The OS can pick which one, use both, or this is a system integration
> >>> time decision?
> >>
> >> Not an OS choice. Historically, this has always been MMIO accessed but
> >> with v8.4 TraceFiltering support, CPUs are encouraged to use system
> >> instructions and obsolete MMIO. So, yes, MMIO is still possible but
> >> something that is discouraged and have to be decided at system
> >> integration time.
> >>
> >>>
> >>>> The CoreSight ETM4x platform
> >>>> driver can now handle both types of devices. In order to make sure t=
he
> >>>> driver gets to handle the "MMIO based" devices, which always had the
> >>>> "arm,primecell" compatible, we have two options :
> >>>>
> >>>> 1) Remove the "arm,primecell" from the DTS. But this may be problema=
tic
> >>>>    for an older kernel without the support.
> >>>>
> >>>> 2) The other option is to allow OF code to "ignore" the arm,primecel=
l
> >>>> priority for a selected list of compatibles. This would make sure th=
at
> >>>> both older kernels and the new kernels work fine without breaking
> >>>> the functionality. The new DTS could always have the "arm,primecell"
> >>>> removed.
> >>>
> >>> 3) Drop patches 6 and 7 and just register as both AMBA and platform
> >>> drivers. It's just some extra boilerplate. I would also do different
> >>> compatible strings for CPU system instruction version (assuming this
> >>> is an integration time decision).
> >>
> >> The system instruction (and the reigster layouts) are all part of the
> >> ETMv4/ETE architecture and specific capabilities/features are
> >> discoverable, just like the Arm CPUs. Thus we don't need special
> >> versions within the ETMv4x or ETE minor versions. As of now, we have
> >> one for etm4x and another for ete.
> >
> > I just meant 2 new compatible strings. One each for ETMv4x and ETE,
> > but different from the 2 existing ones. It is different h/w presented
> > to the OS, so different compatible.
> >
>
> Sorry, was not very clear here.
>
> Right now, we have :
>
> 1) arm,coresight-etm4x && arm,primecell - For AMBA based devices
> 2) arm,coresight-etm4x-sysreg   - For system instruction based
> 3) arm,embedded-trace-extension - For ETE

Ah, so we already have that...

>
>
> >> One problem with the AMBA driver in place is having to keep on adding
> >> new PIDs for the CPUs. The other option is to have a blanket mask
> >> for matching the PIDs with AMBA_UCI_ID checks.
> >
> > But if MMIO access is discouraged, then new h/w would use the platform
> > driver(s), not the amba driver, and you won't have to add PIDs.
>
> Yes for v8.4 onwards. Alternatively, the newer DTS could skip
> arm,primecell in the entry and that would kick the platform driver
> in. So, that should be fine I guess.

Except that the new dts would not work with older kernels.

I'm now lost as to what problem this series is trying to solve. Will
reply further on cover letter...

Rob
