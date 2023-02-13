Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9DD694AF4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbjBMPWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:22:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBMPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:22:42 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A13776A4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:22:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o15so9316768wrc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 07:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OmhJkgqYmrDqLIrRFgRlLdFts/Jpp0gX66gIU9/3eDY=;
        b=xOyFUJ3baKz7MXLkxC+UTGbC0QwtWQggfdhmjh5rG3ahbkUoOPdDVdsWXawq4/p3Iz
         tYQbNPg/yA8/ZXf8Z+JIYo7kbgmjXUFNUH+dCZyHqRHeoMTPj4PL8sqSyywGb5W3rG/T
         da8oKtkuOprc1D5+DF93X79gGq6d5vchDUAsJAyeqN9eppw/cNFyFwsh3f7XhpC2r65p
         ShxYZKh05afGO1sEMKcACypCctt7wQ74XgrVfQD5nL/F8+/ha5U60kOptD6rD+zu0ntm
         pjliVvjAGxaKfUJZzHiPxWuoAa8ysKcUiuGhDDE5GT9ovjVnTHdJFx7H9u8CVuHLntoL
         WKMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OmhJkgqYmrDqLIrRFgRlLdFts/Jpp0gX66gIU9/3eDY=;
        b=8OxB/o/8QjL/GLU1U0kKYyBupE5OwgantwEg1f+UncfKW/wMi9P145psSr2yBZTnYH
         XeF2w8aVmARdw5SJ8riTOYHmLOvvbo8GNoIEwxCnsyGdZLRpT6z+AFcJCUk/6o2wJydK
         ub0MkAmqvUzynnAlf6lIeFdU5bqiExgu7PEDZYxxHj1d8r+Q4tBJdQBxX3FSz+9ctEWB
         kdWMehpJl33PpOH9lUyKkmQdrC0K+sx0fUszrgzMCLB2OsVwLAVVG8neTvx3dNpOsXUL
         2jt4S/4YoUDT+aM9Jbi4KbcX4NVzyF3qNyWBBzNFXJ4VamKalSN65E8xrCDGfGhxgRW7
         ysqg==
X-Gm-Message-State: AO0yUKUExHo8GWH8YiU2dL8EITg5m84RlKjDrK1/MyATz9wL0Vpg3LaY
        Kid7K6rIHsfCwIWd10aI9nWLuCIw0nvwF3JNvgoahQ==
X-Google-Smtp-Source: AK7set9JkH14QTEwGaq4KFu+VqFIachUi1Fh0L8MdCMrl2ydRSHmZ9d+uS6d/UB2x0KLECB+1AGPxXDz7Cp+Q7qU/l0=
X-Received: by 2002:adf:db88:0:b0:2bf:b414:7f44 with SMTP id
 u8-20020adfdb88000000b002bfb4147f44mr1693794wri.12.1676301758558; Mon, 13 Feb
 2023 07:22:38 -0800 (PST)
MIME-Version: 1.0
References: <20220812143055.12938-2-olivier.masse@nxp.com> <30534fadb8172088eddef46ae71d87c167cbf32e.camel@nxp.com>
 <CAFA6WYOMCswgHHxsgc9Hgi7rmTPaZDqce=BixvYoFTfL0bTFDQ@mail.gmail.com>
 <PA4PR04MB75204E8D2B959893A04D55F388D69@PA4PR04MB7520.eurprd04.prod.outlook.com>
 <CAFA6WYPGT8xZnB1idcxcHT1bvM=0kwFssBQbn063-qg=czM-ZQ@mail.gmail.com>
 <CAN5uoS8XgvAKVwKHx-uOe3hAa4Jrd5FJt6xNOG5s-simkRND9w@mail.gmail.com>
 <c86d1a46af6e076038b3f0c2dd68213ff1e8b254.camel@nxp.com> <CAN5uoS-A8EovbnxvcXqiYHcy95d-PTYUZvnNr3=kf84AGkG8Kw@mail.gmail.com>
 <f3ccd7ad-0bbb-be39-c989-765552e2c6af@linaro.org> <PA4PR04MB75207FF08A6C2EEC1944FFFE88D79@PA4PR04MB7520.eurprd04.prod.outlook.com>
 <Y+oYundNEN9TDiQ8@jade> <PA4PR04MB752097BD63A2151DC5658D4688DD9@PA4PR04MB7520.eurprd04.prod.outlook.com>
In-Reply-To: <PA4PR04MB752097BD63A2151DC5658D4688DD9@PA4PR04MB7520.eurprd04.prod.outlook.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 13 Feb 2023 16:22:26 +0100
Message-ID: <CAHUa44G9XhOMfiQ4TpiQWAKSXodG09ivarcYYjS3eg254xcavA@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register tee_shm
 from a dmabuf file descriptor
To:     Cyrille Fleury <cyrille.fleury@nxp.com>
Cc:     Jerome Forissier <jerome.forissier@linaro.org>,
        Etienne Carriere <etienne.carriere@linaro.org>,
        Olivier Masse <olivier.masse@nxp.com>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "fredgc@google.com" <fredgc@google.com>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "afd@ti.com" <afd@ti.com>,
        "op-tee@lists.trustedfirmware.org" <op-tee@lists.trustedfirmware.org>,
        "joakim.bech@linaro.org" <joakim.bech@linaro.org>,
        "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>,
        Peter Griffin <peter.griffin@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        =?UTF-8?Q?Cl=C3=A9ment_Faure?= <clement.faure@nxp.com>,
        "christian.koenig@amd.com" <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cyrille,

On Mon, Feb 13, 2023 at 1:41 PM Cyrille Fleury <cyrille.fleury@nxp.com> wro=
te:
>
> Hi,
>
> >>
> >>
> >> -----Original Message-----
> >> From: Jerome Forissier <jerome.forissier@linaro.org>
> >> Sent: Friday, February 3, 2023 1:32 PM
> >> To: Etienne Carriere <etienne.carriere@linaro.org>; Olivier Masse
> >> <olivier.masse@nxp.com>
> >> Cc: sumit.garg@linaro.org; linux-media@vger.kernel.org;
> >> fredgc@google.com; linaro-mm-sig@lists.linaro.org; afd@ti.com;
> >> op-tee@lists.trustedfirmware.org; jens.wiklander@linaro.org;
> >> joakim.bech@linaro.org; sumit.semwal@linaro.org; Cyrille Fleury
> >> <cyrille.fleury@nxp.com>; Peter Griffin <peter.griffin@linaro.org>;
> >> linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Cl=C3=
=A9ment
> >> Faure <clement.faure@nxp.com>; christian.koenig@amd.com
> >> Subject: Re: [EXT] Re: [PATCH v2 1/1] tee: new ioctl to a register
> >> tee_shm from a dmabuf file descriptor
> >>
> >> On 2/3/23 15:12, Cyrille Fleury wrote:
> >> Hi all,
> >>
> >> >On 2/3/23 12:37, Etienne Carriere wrote:
> >> >> Hell all,
> >> >>
> >> >> +jerome f.
> >> >>
> >> >> On Fri, 3 Feb 2023 at 12:01, Olivier Masse <olivier.masse@nxp.com> =
wrote:
> >> >>>
> >> >>> On jeu., 2023-02-02 at 10:58 +0100, Etienne Carriere wrote:
> >> >>>> Caution: EXT Email
> >> >>>>
> >> >>>> On Thu, 2 Feb 2023 at 09:35, Sumit Garg <sumit.garg@linaro.org>
> >> >>>> wrote:
> >> >>>>> Hi Cyrille,
> >> >>>>>
> >> >>>>> Please don't top post as it makes it harder to follow-up.
> >> >>>>>
> >> >>>>> On Thu, 2 Feb 2023 at 13:26, Cyrille Fleury
> >> >>>>> <cyrille.fleury@nxp.com
> >> >>>>>> wrote:
> >> >>>>>> Hi Sumit, all
> >> >>>>>>
> >> >>>>>> Upstream OP-TEE should support registering a dmabuf since a
> >> >>>>>> while, given how widely dmabuf is used in Linux for passing
> >> >>>>>> buffers around between devices.
> >> >>>>>>
> >> >>>>>> Purpose of the new register_tee_shm ioctl is to allow OPTEE to
> >> >>>>>> use memory allocated from the exiting linux dma buffer. We
> >> >>>>>> don't need to have secure dma-heap up streamed.
> >> >>>>>>
> >> >>>>>> You mentioned secure dma-buffer, but secure dma-buffer is a
> >> >>>>>> dma- buffer, so the work to be done for secure or "regular" dma
> >> >>>>>> buffers by the register_tee_shm ioctl is 100% the same.
> >> >>>>>>
> >> >>>>>> The scope of this ioctl is limited to what existing upstream
> >> >>>>>> dma- buffers are:
> >> >>>>>>         -> sharing buffers for hardware (DMA) access across
> >> >>>>>> multiple device drivers and subsystems, and for synchronizing
> >> >>>>>> asynchronous hardware access.
> >> >>>>>>        -> It means continuous memory only.
> >> >>>>>>
> >> >>>>>> So if we reduce the scope of register tee_shm to exiting dma-
> >> >>>>>> buffer area, the current patch does the job.
> >> >>>>>
> >> >>>>> Do you have a corresponding real world use-case supported by
> >> >>>>> upstream OP-TEE? AFAIK, the Secure Data Path (SDP) use-case is
> >> >>>>> the one supported in OP-TEE upstream but without secure dmabuf
> >> >>>>> heap [1] available, the new ioctl can't be exercised.
> >> >>>>>
> >> >>>>> [1]
> >> >>>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%
> >> >>>>> 2Fg%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a4=
1e
> >> >>>>> dd81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> >> >>>>> 38118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLC
> >> >>>>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda
> >> >>>>> ta=3DtBh3qNiinzTn%2BgqE8IvGw%2BYvRvo8ztDt4W4O0noEkk8%3D&reserved=
=3D0
> >> >>>>> ithub.com%2FOP-TEE%2Foptee_test%2Fblob%2Fmaster%2Fhost%2Fxtest%2
> >> >>>>> Fsd
> >> >>>>> p_basic.h%23L15&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff9=
62
> >> >>>>> fb5
> >> >>>>> 8f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7
> >> >>>>> C0%
> >> >>>>> 7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDA
> >> >>>>> iLC
> >> >>>>> JQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sda
> >> >>>>> ta=3D
> >> >>>>> UNB88rvmhQ5qRoIGN%2FpS4cQTES5joM8AjoyAAYzPKl0%3D&reserved=3D0
> >> >>>>
> >> >>>> OP-TEE has some SDP test taht can exercice SDP: 'xtest
> >> >>>> regression_1014'.
> >> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2
> >> >>>> Fgi%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41=
ed
> >> >>>> d81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> >> >>>> 118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> >> >>>> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D%
> >> >>>> 2FDGLzwTOc5%2F30%2BLy4bBVckK0fRJRsvuGcUvp6bfW9Tg%3D&reserved=3D0
> >> >>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fr
> >> >>>> egr
> >> >>>> ession_1000.c%23L1256&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7=
C9
> >> >>>> ff9
> >> >>>> 62fb58f6401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7
> >> >>>> C0%
> >> >>>> 7C0%7C638110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw
> >> >>>> MDA
> >> >>>> iLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&s
> >> >>>> dat
> >> >>>> a=3De%2B40rwWvtvVFG8aWZNeu%2FgjMXXvZ3pRhJfHLkdurovs%3D&reserved=
=3D0
> >> >>>>
> >> >>>> The test relies on old staged ION + local secure dmabuf heaps no
> >> >>>> more maintained, so this test is currently not functional.
> >> >>>> If we upgrade the test to mainline dmabuf alloc means, and apply
> >> >>>> the change discussed here, we should be able to regularly test
> >> >>>> SDP in OP-TEE project CI.
> >> >>>> The part to update is the userland allocation of the dmabuf:
> >> >>>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F=
%2
> >> >>>> Fgi%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41=
ed
> >> >>>> d81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638
> >> >>>> 118829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQI
> >> >>>> joiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=
=3D%
> >> >>>> 2FDGLzwTOc5%2F30%2BLy4bBVckK0fRJRsvuGcUvp6bfW9Tg%3D&reserved=3D0
> >> >>>> thub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fs
> >> >>>> dp_
> >> >>>> basic.c%23L91&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962f=
b5
> >> >>>> 8f6
> >> >>>> 401c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7
> >> >>>> C63
> >> >>>> 8110243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ
> >> >>>> Ijo
> >> >>>> iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D5=
rP
> >> >>>> V1j
> >> >>>> qzqjVh2N5pdUW41YwF6EkgIDwfhyfYkgmtdZI%3D&reserved=3D0
> >> >>>>
> >> >>>>
> >> >>>
> >> >>> the test was already updated to support secure dma heap with
> >> >>> Kernel version 5.11 and higher. the userland allocation could be f=
ind here:
> >> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2F
> >> >>> git%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41e=
dd
> >> >>> 81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63811
> >> >>> 8829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DdUN=
us
> >> >>> R9w0TlzTRiqUUhU8yo%2BUF7QPhsx5t8GQuAA1SU%3D&reserved=3D0
> >> >>> hub.com%2FOP-TEE%2Foptee_test%2Fblob%2F3.20.0%2Fhost%2Fxtest%2Fsdp
> >> >>> _ba
> >> >>> sic.c%23L153&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb5=
8f
> >> >>> 640
> >> >>> 1c597808db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63
> >> >>> 811
> >> >>> 0243232457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2l
> >> >>> uMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D01H96n=
47
> >> >>> K6R
> >> >>> mBKZQhRdcqX3nE5VBHOXNfGuMmmkVSvc%3D&reserved=3D0
> >> >>>
> >> >>
> >> >> Oh, right. So fine, optee_test is ready for the new flavor of
> >> >> secure buffer fd's.
> >> >>
> >> >>
> >> >>> This upgrade need a Linux dma-buf patch:
> >> >>> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%=
2F
> >> >>> lor%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C057d956d144a41e=
dd
> >> >>> 81808db0db1c7f9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63811
> >> >>> 8829451030288%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoi
> >> >>> V2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3D4io=
mH
> >> >>> K4kPt6A4OmyioiIFD360bGh39o0d2%2BJGyI3WYM%3D&reserved=3D0
> >> >>> e.kernel.org%2Fall%2F20220805154139.2qkqxwklufjpsfdx%4000037740335
> >> >>> 3%2
> >> >>> FT%2F&data=3D05%7C01%7Ccyrille.fleury%40nxp.com%7C9ff962fb58f6401c=
59
> >> >>> 780
> >> >>> 8db05e2a64b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638110243
> >> >>> 232
> >> >>> 457377%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzI
> >> >>> iLC
> >> >>> JBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&sdata=3DyCS%2BDcuGp%2=
Ba
> >> >>> fAL
> >> >>> tpw74O1bI0K%2Fwnt%2FOw5ob1ngfDA0E%3D&reserved=3D0
> >> >>
> >> >> @Jens, @Jerome, do we want to pick the 2 necessary Linux patches in
> >> >> our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise
> >> >> SDP in our CI and be ready if dma-buf secure heaps (ref right
> >> >> above) is accepted and merged in mainline kernel?.
> >> >
> >> >How would that help? I mean, when the kernel patches are merged and
> >> >if things break we can make the necessary adjustments in the
> >> >optee_test app or whatever, but in the meantime I don't see much
> >> >point. I suppose the people who are actively developing the patches
> >> >do make sure it works with OP-TEE ;-)
> >> >
> >> >Regards,
> >> >--
> >> >Jerome
> >>
> >> As mentioned in the cover letter, this IOCTL got tested by Jens Wiklan=
der <jens.wiklander@linaro.org>, using Linaro reference board from Hikey 66=
20:
> >> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fli=
st
> >> s.trustedfirmware.org%2Farchives%2Flist%2Fop-tee%40lists.trustedfirmwa
> >> re.org%2Fthread%2FI3TZN4TBDOUVE567VMMN2TAXGWZNY7S3%2F&data=3D05%7C01%7=
Cc
> >> yrille.fleury%40nxp.com%7C057d956d144a41edd81808db0db1c7f9%7C686ea1d3b
> >> c2b4c6fa92cd99c5c301635%7C0%7C0%7C638118829451030288%7CUnknown%7CTWFpb
> >> GZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0
> >> %3D%7C3000%7C%7C%7C&sdata=3DEHEVIdfHacDVq%2BCdSYg0Tkm1ekQLEI6Vra4elN0%=
2F
> >> %2F6I%3D&reserved=3D0
> >> It also works on i.MX8M EVK boards.
> >>
> >> My understanding today is we are good to upstream this patch, knowing:
> >>      - Upstream OPTEE driver should support registering a dmabuf since=
 a while, given how widely dmabuf is used in Linux for passing buffers arou=
nd between devices.
> >>      - review is OK
> >>      - test environment is already available in optee-test
> >>      - it has been tested on 2 different platforms
> >>      - the scope of the new ioctl is limited to existing feature in
> >> dma-buffer
> >>
> >> What is missing from this list preventing to upstream ?
> >
> >Please address the comments from Etienne and post a new version of the p=
atch based on the latest kernel. Please try to improve the language in the =
commit message.
> >
> >Is it possible to update the tests so this can be tested on QEMU in our =
CI loop? That should help to get the review restarted.
> >
> >Thanks,
> >Jens
> >
>
> Hi Jens
>  Could you point the Etienne comment(s) not addressed by the pull request=
 to add register tee_shm ioctl to linux optee-driver?
>   Last comments from Etienne:
>         -> Oh, right. So fine, optee_test is ready for the new flavor of =
secure buffer fd's.
>         -> @Jens, @Jerome, do we want to pick the 2 necessary Linux patch=
es in our Linux kernel fork (github.com/linaro-swg/linux.git) to exercise S=
DP in our CI and be ready if dma-buf secure heaps (ref right above) is acce=
pted and merged in mainline kernel?.

https://lore.kernel.org/lkml/CAN5uoS-nT1Bi0dhf74Hpv9LS6XPeTCdZ7sujAKNjacZ+P=
Nh4xA@mail.gmail.com/

There are four comments quite a bit down into the patch.

Cheers,
Jens
