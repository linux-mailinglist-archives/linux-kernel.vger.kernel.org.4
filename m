Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 889725BBA73
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 22:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiIQUqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 16:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIQUqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 16:46:33 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C50FF27FD1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:46:30 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id a21so13557699ljq.7
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 13:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date;
        bh=KuXvhF9KldhDK2ZH0oBRmMUJV90s+/AHiLgTmmdgWUQ=;
        b=EyHfgV0/wR81r4wjhBrSg96m0SNDpoYVE4lR2aG4jebgecvwYyLOEVn1Cy6/Cgkg7M
         ZLMVZVz128bIjkZ744+UiUoGkpXsh+GrfJj7WbHVHmeaVCR5uwvFWkBinO6BjZDPWyQn
         /iNPfLwlpvqg3vRXelV3A36EQPL8y9gLl7eaanFukRUMKvm2uBI4ea4XOmCx0nJpZBt4
         HWfzpEIAUvqKQUqtHUM/edriFafUwUoGmHQE177MxYIlkUr326+awJ9iCvLEgf/uIgEh
         dMdbM4kN9/TtAbYZQU0lvPV2TIza48r9cKv28VLv3RxuK31VU29bFTD+tPv0kzy49tIV
         ZUFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date;
        bh=KuXvhF9KldhDK2ZH0oBRmMUJV90s+/AHiLgTmmdgWUQ=;
        b=BhNGJVK2t6iLc0FexDrHM4UQt0FNqXAJ+2My7zmREOH2ie4KQkF1gLMjiKcBVK588S
         ctLOJ7Teay4YfDIBcEO0XlKhmXweynoWNtV/dFYOarsflEUHgJfNr3fwW/aXiZJjwdp6
         al1Z1U2gfwFWOBYX1mHBm5nS6dfCI2fi3WlIPIBujeWCLG1UzJ1YGnVUfFhXOpW25A+/
         SZ7uoCmzlPcCdJbgrqhp+8WsXnVB0NiSI8k751MgpwupdizD5Kb3MTyZ+gPUN+CVX86Z
         77w3lkNXvVemvzgwtqrRI4MdXzJe1A/qmWW26T45lmmkAs3flaJh5sYUb16fSIWSYoLx
         IU5w==
X-Gm-Message-State: ACrzQf3fBaiV4Z7OyZ1fjyA7i+aUsuCgHB5yvgOWMPN/HVhKOfJNRrh1
        2H0X7XnB8heOu8F37eqqotSytQ==
X-Google-Smtp-Source: AMsMyM7MO114St+nXQYxfZqj20JfkM6MHWUpKUy5NeFyDAftKvGhetvKelcxFuYxojuXxHTyHF4o+A==
X-Received: by 2002:a2e:8881:0:b0:255:7790:25e6 with SMTP id k1-20020a2e8881000000b00255779025e6mr3090895lji.525.1663447589100;
        Sat, 17 Sep 2022 13:46:29 -0700 (PDT)
Received: from [127.0.0.1] ([188.162.64.169])
        by smtp.gmail.com with ESMTPSA id p3-20020a05651238c300b00498f36bce07sm4258485lft.214.2022.09.17.13.46.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Sep 2022 13:46:28 -0700 (PDT)
Date:   Sat, 17 Sep 2022 23:46:23 +0300
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Takashi Iwai <tiwai@suse.de>,
        Christian Brauner <brauner@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Marc Herbert <marc.herbert@intel.com>,
        James Smart <jsmart2021@gmail.com>,
        Justin Tee <justin.tee@broadcom.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_2/5=5D_dt-bindings=3A_arm=3A_msm=3A_C?= =?US-ASCII?Q?onvert_kpss-acc_driver_Documentation_to_yaml?=
User-Agent: K-9 Mail for Android
In-Reply-To: <63262383.df0a0220.27cbb.1c41@mx.google.com>
References: <20220916191715.GA1079300-robh@kernel.org> <6324d1be.050a0220.9d842.7b47@mx.google.com> <CAA8EJprEQOsm4TxGWJYZo04D1PagT3QmhDdYQkEid-KSP-tpTw@mail.gmail.com> <6324d8e1.170a0220.aba35.ba4f@mx.google.com> <CAA8EJpowLvkuiYupqS0WEhnMR8q=R1YUUFgdFVCAx1PXyoo1xw@mail.gmail.com> <6324dc1b.df0a0220.97787.083c@mx.google.com> <CAA8EJpo08WoQ_LYOtg5C2BB=Q6GR_cftLjaWHWjYD6BjfDZcsg@mail.gmail.com> <6324f087.1c0a0220.7123d.8665@mx.google.com> <CAA8EJprhLUybqmPhFmit6LGaNOxz=-9+8xADXowJuzU5BtjjtA@mail.gmail.com> <632618ac.050a0220.bda86.d7a8@mx.google.com> <63262383.df0a0220.27cbb.1c41@mx.google.com>
Message-ID: <7F54CF10-F2EF-46C6-B291-9339FE5D10E4@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 17 September 2022 22:44:00 GMT+03:00, Christian Marangi <ansuelsmth@gma=
il=2Ecom> wrote:
>On Sat, Sep 17, 2022 at 08:57:44PM +0200, Christian Marangi wrote:
>> On Sat, Sep 17, 2022 at 04:45:21PM +0300, Dmitry Baryshkov wrote:
>> > On Sat, 17 Sept 2022 at 00:54, Christian Marangi <ansuelsmth@gmail=2E=
com> wrote:
>> > >
>> > > On Fri, Sep 16, 2022 at 11:31:49PM +0300, Dmitry Baryshkov wrote:
>> > > > On Fri, 16 Sept 2022 at 23:27, Christian Marangi <ansuelsmth@gmai=
l=2Ecom> wrote:
>> > > > >
>> > > > > On Fri, Sep 16, 2022 at 11:22:17PM +0300, Dmitry Baryshkov wrot=
e:
>> > > > > > On Fri, 16 Sept 2022 at 23:13, Christian Marangi <ansuelsmth@=
gmail=2Ecom> wrote:
>> > > > > > >
>> > > > > > > On Fri, Sep 16, 2022 at 11:06:35PM +0300, Dmitry Baryshkov =
wrote:
>> > > > > > > > On Fri, 16 Sept 2022 at 22:43, Christian Marangi <ansuels=
mth@gmail=2Ecom> wrote:
>> > > > > > > > >
>> > > > > > > > > On Fri, Sep 16, 2022 at 02:17:15PM -0500, Rob Herring w=
rote:
>> > > > > > > > > > On Wed, Sep 14, 2022 at 04:22:53PM +0200, Christian M=
arangi wrote:
>> > > > > > > > > > > Convert kpss-acc driver Documentation to yaml=2E
>> > > > > > > > > > > The original Documentation was wrong all along=2E F=
ix it while we are
>> > > > > > > > > > > converting it=2E
>> > > > > > > > > > > The example was wrong as kpss-acc-v2 should only ex=
pose the regs but we
>> > > > > > > > > > > don't have any driver that expose additional clocks=
=2E The kpss-acc driver
>> > > > > > > > > > > is only specific to v1=2E For this exact reason, li=
mit all the additional
>> > > > > > > > > > > bindings (clocks, clock-names, clock-output-names a=
nd #clock-cells) to
>> > > > > > > > > > > v1 and also flag that these bindings should NOT be =
used for v2=2E
>> > > > > > > > > >
>> > > > > > > > > > Odd that a clock controller has no clocks, but okay=
=2E
>> > > > > > > > > >
>> > > > > > > > >
>> > > > > > > > > As said in the commit v2 is only used for regs=2E v2 it=
's only used in
>> > > > > > > > > arch/arm/mach-qcom/platsmp=2Ec to setup stuff cpu hotpl=
ug and bringup=2E
>> > > > > > > > >
>> > > > > > > > > Should we split the 2 driver? To me the acc naming seem=
s to be just
>> > > > > > > > > recycled for v2 and it's not really a clk controller=2E
>> > > > > > > > >
>> > > > > > > > > So keeping v2 in arm/msm/qcom,kpss-acc-v2=2Eyaml and v1=
 moved to clock?
>> > > > > > > >
>> > > > > > > > I suspect that qcom,kpss-acc-v2 is misnamed as the "clock=
-controller"=2E
>> > > > > > > > According to msm-3=2E10, these regions are used by the Kr=
ait core
>> > > > > > > > regulators=2E
>> > > > > > > >
>> > > > > > >
>> > > > > > > Well we need to understand how to handle this=2E=2E=2E chan=
ge the compatible
>> > > > > > > it's a nono for sure=2E In platsmp=2Ec they are used for cp=
u power control
>> > > > > > > so could be that they are actually used to regulators=2E I =
would honestly
>> > > > > > > move v1 to clock and leave v2 to arm/msm but I'm not cetain=
 on what name
>> > > > > > > to assign to the 2 yaml=2E
>> > > > > > >
>> > > > > > > What do you think?
>> > > > > >
>> > > > > > This is fine for me=2E If somebody gets better understanding =
of
>> > > > > > underlying hardware and works on actually using these blocks,=
 he will
>> > > > > > update the bindings=2E
>> > > > > >
>> > > > > > My only suggestion would be to rename kpss-acc-v2 nodes to
>> > > > > > 'power-controller@address' and document them so=2E
>> > > > > >
>> > > > >
>> > > > > Ok so something like this?
>> > > > >
>> > > > >     power-controller@f9088000 {
>> > > > >       compatible =3D "qcom,kpss-acc-v2";
>> > > > >       reg =3D <0xf9088000 0x1000>,
>> > > > >             <0xf9008000 0x1000>;
>> > > > >     };
>> > > > >
>> > > > > (and I will have to fix dtbs warning as they will be unmatched =
I think=2E)
>> > > > > Yaml naming:
>> > > > > qcom,kpss-acc-v1=2Eyaml
>> > > > > qcom,kpss-acc-v2=2Eyaml
>> > > > > Right?
>> > > >
>> > > > Sounds good to me=2E
>> > > >
>> > > > I'd even say clock/qcom,kpss-acc-v1=2Eyaml and
>> > > > arm/msm/qcom,kpss-acc-v2=2Eyaml or maybe power/qcom,kpss-acc-v2=
=2Eyaml
>> > > >
>> > >
>> > > Wonder if the gcc driver should have the same tretement? It's also =
a
>> > > clock-controller driver that doesn't use clock at all=2E=2E=2E Do y=
ou have
>> > > some info about it?
>> >=20
>> > As far as I understand, the kpss-gcc is a normal clock controller,
>> > isn't it? It provides clocks to other devices=2E
>> >=20
>>=20
>> Hi again=2E=2E=2E Having acc-v2 as power-controller would require to se=
t
>> #power-domain-cells =3D <0>;

Why? I don't think so=2E Rob/Krzysztof, please correct me if I'm wrong=2E

>>=20
>> Would that be acceptable? Considering it wouldn't expose any PM domain?
>>=20
>> About kpss-gcc we have some device that for some reason doesn't have th=
e
>> required clocks defined in the dts=2E I checked the related gcc and no =
PXO
>> defined and no pll8_vote clock defined=2E (the affected dts are all lis=
ted
>> in the related Documentation)
>>=20
>> No idea how they currently work with the kpss-gcc driver as these
>> parents are missing=2E Guess the driver just fails to probe?
>> So this was the question if you had more info about it=2E=2E=2E since t=
o me it
>> seems just another gcc v2 that doesn't expose clocks but it's just a
>> power-controller just like acc-v2=2E=20
>>=20
>> --=20
>> 	Ansuel
>
>(Also sorry for the double email)
>I'm checking the regs for apq8084 for example (from the dtsi)
>Are we really sure they are power-controller?

It looks like it's a regularor on steroids=2E See krait-regulator=2Ec and =
corresponding bindings in msm-3=2E10/3=2E14=2E So I'd use either the regula=
tor or the power-controller (with significant bias towards controller)

>Checking the regs it seems they just changed the location and they
>placed clock-controller and right after the power-controller=2E
>So one can get confused and say that 0xf9=2E=2E=2E can be all related to =
power
>controller=2E I posted the regs for reference=2E
>
>acc0 0xf9088000 0x1000
>saw0 0xf9089000 0x1000
>
>acc1 0xf9098000 0x1000
>saw1 0xf9099000 0x1000
>
>acc2 0xf90a8000 0x1000
>saw2 0xf90b9000 0x1000
>
>Anyway while at it there seems to be a bit of confusion about the naming
>here=2E=2E=2E We have on ipq8064 and ipq4019 the saw node set as regulato=
r and
>with the regulator binding but on msm8974 and apq8084 the saw node set
>as power-controller (with the l2 node with the regulator binding)=2E
>
>Think we should chose a name and fix every dts=2E
>So the main question here is=2E=2E=2E
>Should we keep acc as clock-controller or change it to power-controller
>(for v2)?
>
>Should we change saw node to regulator or power-controller?
>
>From what I know acc are used to enable the cpu so it seems sane to keep
>them as clock-controller (even if v2 doesn't export clock)
>Saw node handle power (and in theory even low power state) so it seems
>sane to change them to power-controller=2E
>
>Currently we have no warning for saw node as they are not converted to
>yaml but as soon as someone convert the txt to yaml then we will have
>all sort of inconsistency so better take a decision now instead of
>convert saw to yaml and then change acc node again to fix them for good=
=2E


The saw is definitely a bigger thing than just a regularor (or a set of th=
em)=2E It is used to control pmics, it handles low-power states, so `power-=
controller'=2E

--=20
With best wishes
Dmitry
