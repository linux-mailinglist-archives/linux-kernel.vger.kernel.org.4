Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104526F6AD8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:06:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjEDMGk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjEDMGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:06:38 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A380144B6
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 05:06:12 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f315735514so60219975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1683201971; x=1685793971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kpKcjSg5vqqsnKH/yTedumgltcvVZ8m32D88kZ3aoDg=;
        b=ESzvuy/VrPJGnTMt3Tat+zFw9GNqc1x7koKO3A56v+A3rOvj1aPT8pi5bt7z3k7Bt0
         w3micn2UGmUtmieqlfj3SB+lp6Ycd9zJ8oquelTwPga7FR0cQekElC325zhl/myQ5Y0q
         qtk4WHDVZhXh4evgCtuUY8uLJCqlzi0ZZ5IRndYHXcM6ggTSwo3SgHoyrJRXKfFN22Yi
         p6hwBQTKKE879hgHkJGmWp+meYksn7miD/VLzIQJ+erEo+xo4xdPQEWilXhjj1jEfrzb
         yRbBDsunDcnYfHBn03QU9a0Chkit3iGPBosfr4DT/6puvLOaRmXuyTmF6Zy72ZH9+ACP
         lMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683201971; x=1685793971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kpKcjSg5vqqsnKH/yTedumgltcvVZ8m32D88kZ3aoDg=;
        b=lq+7QigfAbUFJeVTRJRKQFGhfUBEJgU0BkCFK1m/CM5FNUg4ZhOJ+yaYQ7y5pS0H5e
         LGhAqrp0RXCVisfV2lseN/yeAbU6XXhSV6EtjO2tbLQ/tN2mo1sIB9JJ9VncsIqk8S4a
         CquYOnz+qRtfbbh3J9UCFF2mfvNpBLKkFwvT0Ebg0ktjI9+/s+dWHVyFSMRXbNQIvc97
         g/lYOx8amHHpGEXFSdBDYb6hZwi3inFA6WFVERGcoKl2VgFnmTqgv62m3uzQbixbDzGq
         EcHcGZ1RuDQdjf4R+oLu5JSQ0q3k1eYeTlz/ysyKbBRDLFR6E/e56T5KgZ/RIb7MUYCs
         18zg==
X-Gm-Message-State: AC+VfDwnLQHmbPoA63facCsgULtf38vkJduS79FSPTEIvI2sQwdafkdZ
        pJM6i7oBq7sjBzkcB5pVucDQ45F1OaRuEWq4BCNBFg==
X-Google-Smtp-Source: ACHHUZ5ZxZCr4XjHy4yR4UAZitMN9KGEZkBVkdAufgmbQbw1HiUK8e5eBimXGyHXugh7p6Ju8XBKwgpUzbrS0QlAES0=
X-Received: by 2002:adf:f4cf:0:b0:307:5091:5b96 with SMTP id
 h15-20020adff4cf000000b0030750915b96mr627945wrp.22.1683201971039; Thu, 04 May
 2023 05:06:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230426034001.16-1-cuiyunhui@bytedance.com> <CAMj1kXEKh9O-ndk3QFibJMYfMbG7vm-cLN2vVQM5eDsYK84NzQ@mail.gmail.com>
 <CAEEQ3wkJB5CKm33mHXUOPX5makYOHF8By6FYGnNzRkM-Mo72OQ@mail.gmail.com>
 <ZEj33QLZqEeL+/y4@FVFF77S0Q05N> <CAEEQ3wmDBJkfOeKCQfcnuE+1=1K0D2pzu+Sn+zPEWk+RHs0NFQ@mail.gmail.com>
 <CAP6exY+ydbzh1EkWTFejzwaW+PA-ySVO2Qj+CVJ1XbSMce2S9Q@mail.gmail.com>
 <ZEpbTE4gcsf8meXc@FVFF77S0Q05N> <CAMj1kXH5kZJ6ff=PRCRDLCBcw2AkEnRL_L1ABuvu5n71=unvAw@mail.gmail.com>
 <CAEEQ3w=495snOz3UNBO4dpgyfZs3jQoRKo4QRAXXqR5-0j4SWA@mail.gmail.com>
 <CAP6exYK9ytcgqcy2gFyOGvbxd7DPGQNs=m7nNgnfunnh8et9aQ@mail.gmail.com> <CAMj1kXGB4yXCdzts2=G_-hadoka9F2BU1gvVxeLEs5ifSbqgog@mail.gmail.com>
In-Reply-To: <CAMj1kXGB4yXCdzts2=G_-hadoka9F2BU1gvVxeLEs5ifSbqgog@mail.gmail.com>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Thu, 4 May 2023 20:05:59 +0800
Message-ID: <CAEEQ3wmcPMf44g2zRLRW3jKgd1ostpjQp=JMmwWdyYrhGQJnjA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] firmware: added a firmware information
 passing method FFI
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     ron minnich <rminnich@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, rafael@kernel.org,
        lenb@kernel.org, jdelvare@suse.com, yc.hung@mediatek.com,
        angelogioacchino.delregno@collabora.com,
        allen-kh.cheng@mediatek.com, pierre-louis.bossart@linux.intel.com,
        tinghan.shen@mediatek.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ron, Ard

On Sat, Apr 29, 2023 at 2:03=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Fri, 28 Apr 2023 at 17:09, ron minnich <rminnich@gmail.com> wrote:
> >
> > There is lots of text in the preceding notes :-), which is nice because=
 we're clearly looking at something that matters!
> >
> > But, note, ARM Chromebooks run Linux, and I checked with the firmware t=
eam just now:
> > "Right. We're not using UEFI or ACPI or SMBIOS or DMI or any of that on=
 Arm. Just the Device Tree."
> >
> > So I do not agree that we need UEFI tables due to some presumed semanti=
cs that they implement, because: several tens of millions of ARM chromebook=
s running Linux show otherwise.
> >
> > We've got a chance here to move to self describing data, and I think we=
 need to take it. It will be a long time before we get this chance again.
> >

> However, introducing such a binding for SMBIOS is perfectly
> reasonable, although I would suggest that we don't copy the
> SMBIOS/SMBIOS3 entry point address into the device tree (as this patch
> does), but properly describe the memory region that contains the
> actual SMBIOS structured data directly, along with its version. This
> might be reused by other DT based platforms as well.

Could you help to give me an example to add smbios in the memmap
region description?

Even after adding to the memmap region, it needs to be connected to
the current dmi_scan_machine()?
Or add another dmi code under the fdt framework?


> Doing the same for ACPI is where we'll get into trouble, given that
> we'd end up with two conflicting hardware descriptions and unfulfilled
> dependencies on EFI specific data structures, and it is not the
> kernel's job to reason about which h/w description should take
> precedence, or to make guesses about memory types. So I fully agree
> with Ron that moving to device tree is a much better choice here -
> that way, you can avoid ACPI and UEFI altogether

Thanks for your suggestions, I don't quite get what needs to be moved
to dts? Could you explain in detail?
Is it to realize the content of acpi based on the dts framework?

Thanks,
Yunhui
