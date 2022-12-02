Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE863FF1E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 04:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiLBDiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 22:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbiLBDia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 22:38:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0029BBBFC
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 19:36:04 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u12so4987482wrr.11
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 19:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3IEJJUdCdGG8U1WrhDSRoS/ptvIHsxOFNuOE68d/I0=;
        b=oneK4l5oRB68i/urz6v9XuyXXIAzS8mXuk7hrFMm6ySyZDysNQoJkWSAtrpATrU1gE
         qu/ph2JckzhdE/sll6ROKUMH9k5HMpskTdvwS9yz/9SpZh9V2uIvX4RqAVXyO88WNMHo
         YEIxENk68RvtdLvRiPzRNzEoUkRKGenRv7jwE013/jqnejh97o7+cnccW3SUdV8DzNEZ
         Bk2L3n3MwjHg6WwxMmwNjhAwOxlmx7pPf6KObVS08iT/mSnEwQdcFJ1s4zCQDit8JJGN
         e+W8y9Xh/RbV11aI9550ywUTpBt0iAEawQksFGtkWp2YEeLYJRtmo5C3hWhLwfRJFXs7
         Be7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3IEJJUdCdGG8U1WrhDSRoS/ptvIHsxOFNuOE68d/I0=;
        b=Dqnuxm5wOb2zL/oKWcwhDPZvjwshyfk4/dRXCfzsc7PubRtMAGNK4Wip0kzF3blLwY
         8joVPUrnIOV/cXr9ajNb/mwq3tdvFplvuekY92oOOlXvBoOclCCe6CpImkAq9PPB8LSJ
         8F/BEdrCPiBu4LuLGyHXD96CZmgffS40M9MgIPlNMjjZzX+aJEPNyXs+MM9OV25bKfVg
         liNXUPtzaKgmlb12zPFCfKbsqavYce+I2vN39IgkuvhOQiYM/ZZZ8wtDjOsaBvFPGIFS
         iKfAyIJv30T4YqdAEkAWXcgO+VP3M4DOQdFbXyuYgebPrlCOhTXueCB2kHMwxjfq/1ol
         4UiA==
X-Gm-Message-State: ANoB5pkcgSuGxbTXYM+63mTk5fwSY4R35kHWBZko73I94ga5Eg6ndcYh
        4BlGkzUt5xTo2m6quCE302rqmyTlGTKNmt2AWRM=
X-Google-Smtp-Source: AA0mqf5zltDU33DVT2ReMBUccg4qtzilym5j7/G+wHcvegLvavRcRsRjBnvW+BJWA/7y6crSrtPYvambJKRmYHUaEcw=
X-Received: by 2002:a5d:55c9:0:b0:242:1057:40b8 with SMTP id
 i9-20020a5d55c9000000b00242105740b8mr16070380wrw.182.1669952147042; Thu, 01
 Dec 2022 19:35:47 -0800 (PST)
MIME-Version: 1.0
References: <1669797463-24887-1-git-send-email-u0084500@gmail.com> <Y4iTVmOA5P/aN2yb@sirena.org.uk>
In-Reply-To: <Y4iTVmOA5P/aN2yb@sirena.org.uk>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 2 Dec 2022 11:35:35 +0800
Message-ID: <CADiBU3-gr1OrH0_OtuWyAN8WwvZtPghC6zfB3NYuVTq4b+DZBw@mail.gmail.com>
Subject: Re: [PATCH 1/2] regulator: mt6370: Fix potential UAF issue
To:     Mark Brown <broonie@kernel.org>
Cc:     lgirdwood@gmail.com, lee@kernel.org, matthias.bgg@gmail.com,
        yangyingliang@huawei.com, chiaen_wu@richtek.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2022=E5=B9=B412=E6=9C=881=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E6=99=9A=E4=B8=8A7:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Nov 30, 2022 at 04:37:42PM +0800, cy_huang wrote:
>
> > The original code uses i2c dev as the parent in order to reuse
> > the 'regulator_of_get_init_data'. But this will cause regulation
> > constraint devres attached to i2c dev, not the mfd cell platform
> > device.
>
> This is a general issue which will affect a lot of MFDs, we would be
> better to fix this by changing the API to provide a device to be used
> for the devres allocations separately to the one used for looking up the
> DT.

Not to affect too much, the better way may change the 'regulator_register' =
API.
Append it as regulator_register(dev, .....
This could separate device object with devres allocation and DT lookup.
