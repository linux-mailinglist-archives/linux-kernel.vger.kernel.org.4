Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2B763908F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 21:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbiKYUSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 15:18:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiKYUST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 15:18:19 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3D754748
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:18:19 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w9so3103219qtv.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 12:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20210112.gappssmtp.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSTiRuRI06TOhxoFYQqmDv6+abbfogCNsszYj5jDKOA=;
        b=jz7dOfy3kSV390xTmbsxq8OVKph6kV4B1GUS62uX8AMaLz9Vmpv20Ju/pH63AEDaH1
         pXDa3sPYxxm6Fij1jRsq9Ca1NkxWIQB3RI/HA3IO+V5jCCzEw45m2rPIKWkm1Ny9+Eb4
         AyER7qyxHWaeLPjZAhNNhL9kdkjne/WvO2Yo331coGRImXVfP2QrqMaqPZqEU0rAbzkd
         c5W6gnMNcqNGwsNa6DcS1DGwmS6uwq3o59dj4e2OCJPvWYfcC21lMOyzAxdVxPMutmYh
         6TSapGXLwxtarNQvdwNt5BpgOsnZVcaPd1es7arvMPx0B5dNNpDNDOjfbIEusM1v8mjh
         jqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSTiRuRI06TOhxoFYQqmDv6+abbfogCNsszYj5jDKOA=;
        b=QiBa7hIp1CsfFWlRsj/N/uygyWrnxb9x4HRiYapNmtqPnrNh3IMYzvOrxayDVVkSeO
         +CQxMoNkY0wQHm0fudNngFJcTjr63HrIGeVPFreLHoU3olD8rZsi+DiNhikN9I6MMxgi
         rTwTR2dijY1j0QHloQBc2fDv/3ZOg6vlgRsysqT5D9Y5bNzVN3RiCcbX1deR+992m6ts
         dOjpTzK1ESSHnbu1RN83BUoLzfaC9maKAsgz30E+WyT6YODGecgRXS8vnPSnUFxTu2A3
         H3WXoU6L43V0Exf8XXHKDlhxBhn3dP8OlDiah7tNXRflzlTdlgq5zAOzDq8o3lqn4rVK
         yEBQ==
X-Gm-Message-State: ANoB5pncl2W0ISN3nC/DgLk2GDsRh8RyxioM1GzNkIzy24KpQkuZZPIZ
        KTJDMj1kzX+ZDUtirqNDdnuimw==
X-Google-Smtp-Source: AA0mqf48jVxmakZdn6axSd1lKtJcu73ds9O8bWEdIHympGZG1PjmH2cdWfrtyPb94LllVYiymUXREg==
X-Received: by 2002:ac8:5ece:0:b0:3a5:6f39:4bd8 with SMTP id s14-20020ac85ece000000b003a56f394bd8mr37639589qtx.228.1669407498320;
        Fri, 25 Nov 2022 12:18:18 -0800 (PST)
Received: from nicolas-tpx395.localdomain (192-222-136-102.qc.cable.ebox.net. [192.222.136.102])
        by smtp.gmail.com with ESMTPSA id de16-20020a05620a371000b006b615cd8c13sm3333344qkb.106.2022.11.25.12.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 12:18:18 -0800 (PST)
Message-ID: <7e979311cb5199c4ba9dbf1b0aad027e25563614.camel@ndufresne.ca>
Subject: Re: [PATCH v11 1/3] perf/amlogic: Add support for Amlogic meson G12
 SoC DDR PMU driver
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Will Deacon <will@kernel.org>,
        Jiucheng Xu <jiucheng.xu@amlogic.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        Chris Healy <healych@amzon.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Date:   Fri, 25 Nov 2022 15:18:16 -0500
In-Reply-To: <20221118164157.GA4802@willie-the-truck>
References: <20221117083419.2084264-1-jiucheng.xu@amlogic.com>
         <20221118164157.GA4802@willie-the-truck>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 18 novembre 2022 =C3=A0 16:41 +0000, Will Deacon a =C3=A9crit=
=C2=A0:
> On Thu, Nov 17, 2022 at 04:34:15PM +0800, Jiucheng Xu wrote:
> > Add support for Amlogic Meson G12 Series SOC - DDR bandwidth PMU driver
> > framework and interfaces. The PMU can not only monitor the total DDR
> > bandwidth, but also individual IP module bandwidth.
> >=20
> > Signed-off-by: Jiucheng Xu <jiucheng.xu@amlogic.com>
> > Tested-by: Chris Healy <healych@amzon.com>
>=20
> amzon.com?
>=20
> > +static umode_t meson_ddr_perf_format_attr_visible(struct kobject *kobj=
,
> > +						  struct attribute *attr,
> > +						  int n)
> > +{
> > +	struct pmu *pmu =3D dev_get_drvdata(kobj_to_dev(kobj));
> > +	struct ddr_pmu *ddr_pmu =3D to_ddr_pmu(pmu);
> > +	const u64 *capability =3D ddr_pmu->info.hw_info->capability;
> > +	struct device_attribute *dev_attr;
> > +	int id;
> > +	char value[20]; // config1:xxx, 20 is enough
> > +
> > +	dev_attr =3D container_of(attr, struct device_attribute, attr);
> > +	dev_attr->show(NULL, NULL, value);
> > +
> > +	if (sscanf(value, "config1:%d", &id) =3D=3D 1)
> > +		return capability[0] & (1 << id) ? attr->mode : 0;
> > +
> > +	if (sscanf(value, "config2:%d", &id) =3D=3D 1)
> > +		return capability[1] & (1 << id) ? attr->mode : 0;
>=20
> Should these be '(1ULL << id)' to avoid shifting beyond the side of the
> 32-bit type?

Found:
  typedef unsigned short		umode_t;

I'd suggest the BIT() macro then, very easy to read and should work for thi=
s
case.

>=20
> Will
>=20
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

