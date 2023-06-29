Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37351742B87
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbjF2RtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2Rs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:48:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E871BD4;
        Thu, 29 Jun 2023 10:48:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE65615C9;
        Thu, 29 Jun 2023 17:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC30C433C0;
        Thu, 29 Jun 2023 17:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688060929;
        bh=e7AV+MUBxfSS3TEZj/CHWeSCSsUVANe6xjYnRS+3u8I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KyNk21GqYhyomIfhG5WO1joAglGFA+1QpkPkODxlGDx24tACUU5uhBE7kiXuFZ5Nd
         rIYAwfhyrD1RBzlcz0WS2dyFsje8bDRLOmp/CPKFUityPwIDO3XqbooBJFGkYIBQW2
         ovYb7kZ6WQxXfjccsMo3emaBn7ArusyxNh4iZYw5aYxeXfieE2zctPlKyHgon/nzVq
         /8Q7EqlumCG+ocZNkh9YJiXhx3orptEEmgUqIMinWhRNfGOx4YsRjKDMtZHD7+t7hF
         yickcPsRKIKxMVGxZAJpNlWyCodD/mhd2yVkocydgCGjTFkKuj7BbrqIfRQ5B6SSJd
         OSqmdKpe7NXTw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2b69ff54321so15318291fa.2;
        Thu, 29 Jun 2023 10:48:49 -0700 (PDT)
X-Gm-Message-State: ABy/qLaf6wudfYEhPWi0yREH3rEpvaUtG8ofz7XmKeBwlQaIuzTUzKEd
        tCJPS3YelUGKfyslLaQ5vnJrP4DNJghm5WpA+w==
X-Google-Smtp-Source: APBJJlGqzHtwy5i941q5YklFBRqkNlkZW6UGGvJGSnv0KprRCHbzCVPrAOZgXOPnB+oDxk23f2nAflOdSr8TbsZ8c9o=
X-Received: by 2002:a2e:9dc7:0:b0:2b5:8a3f:4eb with SMTP id
 x7-20020a2e9dc7000000b002b58a3f04ebmr252781ljj.53.1688060927263; Thu, 29 Jun
 2023 10:48:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230627135615.GF10378@google.com> <CAL_JsqL3T6pjnTFgFvbYMeATD6cjhc-Sm0vZW2cv5k+w9Oxjuw@mail.gmail.com>
 <ZJry8QTka8m6ag/j@fedora> <20230627163344.GG10378@google.com>
 <CAL_Jsq+Z64tuMO8a2Y=2GrXZ8q0L4Z2avCiphsn0HOOC71Dzjg@mail.gmail.com>
 <20230628134013.GH10378@google.com> <472a4d86-3bfb-4c2b-a099-f1254dd01e24@sirena.org.uk>
 <20230629072500.GA2110266@google.com> <d070eecd-cb3b-4968-803e-1817a1a4359a@sirena.org.uk>
 <20230629155134.GB2110266@google.com> <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
In-Reply-To: <7987cbbe-55bc-49a9-b63a-7f1906bf5f74@sirena.org.uk>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 29 Jun 2023 11:48:34 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
Message-ID: <CAL_Jsq+AQrv7EGMtEkB-2cBCvA4mLHuMbyQ=f39yQkYPkvfVww@mail.gmail.com>
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC Support
To:     Mark Brown <broonie@kernel.org>
Cc:     Lee Jones <lee@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        "Sahin, Okan" <Okan.Sahin@analog.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
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

On Thu, Jun 29, 2023 at 10:00=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Jun 29, 2023 at 04:51:34PM +0100, Lee Jones wrote:
> > On Thu, 29 Jun 2023, Mark Brown wrote:
>
> > > The thing that's causing a lot of the issues here is that you're only
> > > applying the serieses en masse, blocking things on getting absolutely
> > > everything lined up (including this time over a merge window).  I rea=
lly
> > > don't understand why you feel you're forced to batch everything toget=
her
> > > like this.
>
> > https://lore.kernel.org/all/CAL_Jsq+Z64tuMO8a2Y=3D2GrXZ8q0L4Z2avCiphsn0=
HOOC71Dzjg@mail.gmail.com/
>
> That says it's a bit unusual to use a separate branch with a PR, it
> doesn't say anything about it being the end of the world to pick up
> parts of a series that are ready without picking up the whole lot,
> especially when we're getting to the merge window.

There's some risk the core part could change affecting the sub
components after you pick it up, or that the author just abandons
getting the core part upstream and we're left with a dead driver.

I'm fine if the sub-components are picked up first (and land in next
first), but the MFD binding picked up first is a problem usually. And
that has happened multiple times. Also, it does mean the MFD branch
will have binding warnings, but that's Lee's problem if he cares
(probably not).

Rob
