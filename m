Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD9964A7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbiLLTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiLLTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:04:50 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA42AE78
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:04:46 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id b9so869242ljr.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 11:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zydLZcfCewAxkV+txLg6VC1hirMY9ZM+fwulGxJs800=;
        b=cEDGdGyfvessttcNM48sbtYnFnSO+rePrtV76YuQveo628SMkLUjWo++Vh0S681z+0
         8ybeN+jH+j24U0xgueMVxaLfyPmDBslCTuZz5e8fCF+u0pe5Z9UBOiLch1rcwKFXXJcp
         wfsaLKsX6NQTSG9cPP4DHiJMv4xGOat8vXIA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:user-agent
         :from:references:in-reply-to:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zydLZcfCewAxkV+txLg6VC1hirMY9ZM+fwulGxJs800=;
        b=wur1QMaDKd3/w34O/eWr18qIh+jNsPXlMEj5UOLzRQ+eEvj6RJqlKRsSbSefdKlarZ
         ZjkbzB4BdaKHG4LAarDCBhtugMkbP58oo6uiwR3rwLBBiTxvLXx/DdCoVbvxcctRN00Q
         XPv6BtNRXiFG6MFL1n3kQW1RuwEqe42oqbw8MDRr3H2imFu2z8lg5ocfKOP3yG/fR7EO
         qxybW0w11jGNwjn0uzBzyDJKHU70QXVAh8IIk+bK976B5AVOnqIdLR+oE4mMerYl3T4N
         rkVz7qxzb3XAc66dGzYOMmbo6Zg9IS5pNQQ0wXvM3Z67oLSGUiPuVTcq/tjmaegWWIob
         qPAA==
X-Gm-Message-State: ANoB5pkDzlpB4RRgNTXrX7qlAx7tByMsf9mfj8+GAknN0YYQ544H/kHm
        xOihcFBTBIuvZ7xcayiD67Vqv/yhnz2QZ7JZBjYwrg==
X-Google-Smtp-Source: AA0mqf6la3kqAj9TggukgY0yN93h32X6ykJ7/ZSozHHSHSJHYjO5qvRMzgYhvE1Vnk8m4I0Ts8tC7rsoadFz6lRai/M=
X-Received: by 2002:a2e:bd88:0:b0:279:86e:7a09 with SMTP id
 o8-20020a2ebd88000000b00279086e7a09mr31064274ljq.277.1670871885165; Mon, 12
 Dec 2022 11:04:45 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Dec 2022 14:04:44 -0500
MIME-Version: 1.0
In-Reply-To: <60034623-a681-4398-fe19-660006245e3b@quicinc.com>
References: <1669897248-23052-1-git-send-email-quic_srivasam@quicinc.com>
 <CAE-0n520=mjdc4H1m8au0iBo2qEeaL8OrF1HCP0bXORe2Wa_7w@mail.gmail.com>
 <ec403926-24ef-947d-2a1c-6cbf0e31ab89@quicinc.com> <CAE-0n50VYGNF_rGzyb_2Jd8dY8cFx3BeOw0s-ywELkRqEEig4g@mail.gmail.com>
 <60034623-a681-4398-fe19-660006245e3b@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 12 Dec 2022 14:04:44 -0500
Message-ID: <CAE-0n52cNite8-4HDoQcsZ+UvZFkJU8c5oUjxPB5ag5WP6E9=g@mail.gmail.com>
Subject: Re: [PATCH] remoteproc: elf_loader: Update resource table name check
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, bgoswami@quicinc.com,
        broonie@kernel.org, devicetree@vger.kernel.org,
        judyhsiao@chromium.org, krzysztof.kozlowski@linaro.org,
        lgirdwood@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        mathieu.poirier@linaro.org, perex@perex.cz, quic_plai@quicinc.com,
        quic_rohkumar@quicinc.com, robh+dt@kernel.org,
        srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Srinivasa Rao Mandadapu (2022-12-12 05:49:29)
>
> On 12/10/2022 2:22 AM, Stephen Boyd wrote:
> Thanks for your time Stephen!!!
> > Quoting Srinivasa Rao Mandadapu (2022-12-08 05:40:54)
> >> On 12/7/2022 7:25 AM, Stephen Boyd wrote:
> >> Thanks for Your Time Stephen!!!
> >>> Quoting Srinivasa Rao Mandadapu (2022-12-01 04:20:48)
> >>>> Update resource table name check with sub string search instead of
> >>>> complete string search.
> >>>> In general Qualcomm binary contains, section header name
> >>>> (e.g. .resource_table), amended with extra string to differentiate
> >>>> with other sections.
> >>>> So far Android adsp binaries are being authenticated using TZ,
> >>>> hence this mismatch hasn't created any problem.
> >>>> In recent developments, ADSP binary is being used in Chrome based
> >>>> platforms, which doesn't have TZ path, hence resource table is
> >>>> required for memory sandboxing.
> >>>>
> >>> Does this need a Fixes tag?
> >> I don't think so. I feel It's kind of enhancement.
> >>>> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> >>>> ---
> >>>>    drivers/remoteproc/remoteproc_elf_loader.c | 2 +-
> >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/re=
moteproc/remoteproc_elf_loader.c
> >>>> index 5a412d7..0feb120 100644
> >>>> --- a/drivers/remoteproc/remoteproc_elf_loader.c
> >>>> +++ b/drivers/remoteproc/remoteproc_elf_loader.c
> >>>> @@ -272,7 +272,7 @@ find_table(struct device *dev, const struct firm=
ware *fw)
> >>>>                   u64 offset =3D elf_shdr_get_sh_offset(class, shdr)=
;
> >>>>                   u32 name =3D elf_shdr_get_sh_name(class, shdr);
> >>>>
> >>>> -               if (strcmp(name_table + name, ".resource_table"))
> >>>> +               if (!strstr(name_table + name, ".resource_table"))
> >>> Was the strcmp not working before because the 'name_table' has someth=
ing
> >>> else in it? It really looks like your elf file is malformed.
> >> Actually, DSP binary is prepared by combining different elfs. So Secti=
on
> >> header names are appended with
> >>
> >> something else to distinguish same section name of different elfs, by
> >> using some Qualcomm specific QURT scripts.
> >> Hence final binary contains resource_table name appended with module
> >> specific name.
> >>
> >> So this patch is required to handle such modified name.
> >>
> > Can you clarify how the section header name looks? Probably you can
> > objdump the section here and provide that information to help us
> > understand.
>
> Here is the Section header info.
>
> $ readelf -SW bootimage_relocflag_kodiak.adsp.prodQ.pbn
> There are 65 section headers, starting at offset 0x434:
> readelf: Error: File contains multiple dynamic symbol tables
>
[...]
>  =C2=A0 [60] .start.ac_bin_process PROGBITS
>  =C2=A0 [61] .resource_table.ac_bin_process PROGBITS

Cool, the readelf output is helpful. Please rewrite the commit text to
include this detail. It wasn't obvious to me what 'amended' meant. You
probably mean "appended", which clarifies that it has a string added to
the end. I'm also not sure why TZ or not TZ matters for the resource
table section. It may be meaningful to you, but to others it doesn't
have any relation to this resource table appending scheme so it is not
helpful by itself.

Either way, this is not up to me as I'm not the maintainer of
remoteproc. I peeked at the documentation, but this section
name isn't clearly defined. It seems to just be how it has been for a
long time. Maybe you can also update the documentation
(Documentation/staging/remoteproc.rst) to indicate that this elf section
can have anything appended after it, but it must start with
".resource_table"? That would help everyone. And I don't know why that's
in the staging directory. Bjorn?

Finally, I'd prefer the use of strstarts() instead so it is clear what
you're trying to implement.
