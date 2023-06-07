Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C554725347
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 07:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjFGFUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 01:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbjFGFT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 01:19:57 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13321988
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 22:19:56 -0700 (PDT)
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com [209.85.128.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 2D3AF3F15D
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 05:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686115193;
        bh=Y3mm/I7x2vRn2j9GXKotLgetA+QT35DrsPpKt0Y+YPk=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=bqOLVVxsaPBshvIrGgD6FBrIxW/aRlPuT1CZ/X2ijgJZLG+5bIu8ZjTl0FdQoAvvH
         3xIMKeaxjxksLNs/hPh3dOA7O//r83ir0E8dgCVj29DMk42Idy2ef38scU2wKCr4VB
         pP3NRz+hljEVOpS8GCX1fij+CElw1FuwtLv4QPuE6nE+GU3r7Nl2YfafrWkIjwyda1
         uqz2J8fC4iB+BY3S3BdM7aKObnoFZmrfvoZ23pbgBGLZ56hRyHOWQU8bkyUR09RrT0
         NI7GNO8ap7HJOjxKAG/8OvpdQOl24Ag3EpuIRMQyhmLj473cVhypPKb3nzgGWB+8Iv
         dE+So8XaKUUtw==
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-561ceb5b584so116861387b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jun 2023 22:19:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686115193; x=1688707193;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3mm/I7x2vRn2j9GXKotLgetA+QT35DrsPpKt0Y+YPk=;
        b=jBSJhM0OdHMliBYhr1o4Y90TN3uKip6bT3yGqaV7asEqzUoqdHsIhmxxWlkOO/FMLf
         AqS66C5yyKrueYAWDSZZ+WzfR9naGTICtK2E3UImHfQdz4P7JXwZlT6IZld2Kdoyz5w3
         s99ow4X6z16eI7GawXEySZznIYwr5RnLy2oOwbPmcla8utTObLp+A8V+2ry/VvO3tfWd
         BVe6dgKDdJITY03x96OGW28IuakALHtt98Kf+Ipm686JgMVlpmct6Y0lghurct6iQ788
         2nIuQ3Om/onn9HfwVrWBCRzCMhSaRCaQ5zUlYBRPZ6na7mVpazLi3mDFtX2LtdFHOSsM
         +kkw==
X-Gm-Message-State: AC+VfDxU6fESTvbXV01vsGt3rrHxPcgEJ3IokIu7NKNAAQ3oYHAWccqL
        aTdFjCt7NxPG/yr29357TkLDdXbgCGPnIqbJqZvyopX9Wuo7DpgqWafAftsnG4M1m92mn5Qqjnc
        nueQfmUsm72ZOeeGeqcNBwtcHg7tesSqbZ+5JQmNQ/Nq3zd1YfEeLYL2WPQ==
X-Received: by 2002:a81:494f:0:b0:565:df97:4439 with SMTP id w76-20020a81494f000000b00565df974439mr4470003ywa.37.1686115192730;
        Tue, 06 Jun 2023 22:19:52 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ40trCB1v0nQlIOadZnNVxmP8YW7DLNgQOAV86JMGej2W+a155jagc5TYTLR7MONXgf3+r3A2uU6DsBFyxrKhI=
X-Received: by 2002:a81:494f:0:b0:565:df97:4439 with SMTP id
 w76-20020a81494f000000b00565df974439mr4469990ywa.37.1686115192461; Tue, 06
 Jun 2023 22:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230607034331.576623-1-acelan.kao@canonical.com> <20230607042032.GA28835@srcf.ucam.org>
In-Reply-To: <20230607042032.GA28835@srcf.ucam.org>
From:   AceLan Kao <acelan.kao@canonical.com>
Date:   Wed, 7 Jun 2023 13:19:40 +0800
Message-ID: <CAFv23QmDNUFcPwvSQt5aUxtmHasfr8wrF72ObvcO-X19gfn=LA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: dell-laptop: Add drm module soft dependency
To:     Matthew Garrett <mjg59@srcf.ucam.org>
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gfx drivers(i915/amdgpu/nvidia) depend on the drm driver, so delaying
the loading of dell_laptop after drm can ease the issue the most.
Right, it's still possible to encounter the issue, unfortunately, we
do not have a better solution for it at the moment.


Matthew Garrett <mjg59@srcf.ucam.org> =E6=96=BC 2023=E5=B9=B46=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:20=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On Wed, Jun 07, 2023 at 11:43:31AM +0800, AceLan Kao wrote:
> > From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
> >
> > dell_laptop is somethines loaded before nvidia driver, causing it to
> > create its own backlight interface before native backlight is set.
> > This results in the presence of 2 backlight interfaces in sysfs and
> > leads to the backlight can't be adjusted.
>
> It seems like this approach would still be broken if the nvidia module
> isn't available at the time the dell module is loaded?
