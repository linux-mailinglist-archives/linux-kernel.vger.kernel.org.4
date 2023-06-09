Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0217C72A4E3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 22:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjFIUoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 16:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjFIUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 16:44:09 -0400
Received: from mail-40140.protonmail.ch (mail-40140.protonmail.ch [185.70.40.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D922E30F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 13:44:07 -0700 (PDT)
Date:   Fri, 09 Jun 2023 20:44:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1686343445; x=1686602645;
        bh=pZVmlS0Dh4UwZm7Cf3ZnTS5MkKxcVS93i6YC2fAbp8s=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=OnePWlvYrdB3+LdTIJLj/ZvkKGb1GMsMBEwQVCo3UfKxMa7XhtUc9+2q6P3AZcv6b
         N5yz9UYQvpEUIGdWWdsDA0Znin54iCHXYRbZQsxD3fpf+Xd3pl1fJ12rVoPyGnV8VO
         YnB35ZNc0ldkrDHF+vkPTwq7FxkqNifQYvCSvEL4iqTt07/XCnhK1YMxJCt/fDMdlO
         pP4205NPShQ+MKN1nOgwJcaye1qpTFzgfOauLqorGO5wKVYrRPfGbxBhxZns6Ae7ev
         aVKBOYBw5GHoEuFvSV1uYF7zM796NEzHf5u1llfrnDDn8xOWke/QLLY63QpmmQvcx9
         l497dnPOcNtTg==
To:     krzysztof.kozlowski@linaro.org
From:   Raymond Hackley <raymondhackley@protonmail.com>
Cc:     broonie@kernel.org, davem@davemloft.net,
        devicetree@vger.kernel.org, edumazet@google.com,
        jk@codeconstruct.com.au, kuba@kernel.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, michael@walle.cc,
        netdev@vger.kernel.org, pabeni@redhat.com,
        raymondhackley@protonmail.com, robh+dt@kernel.org,
        u.kleine-koenig@pengutronix.de
Subject: Re: [PATCH v2 2/2] NFC: nxp-nci: Add pad supply voltage pvdd-supply
Message-ID: <20230609204329.105189-1-raymondhackley@protonmail.com>
In-Reply-To: <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org>
References: <20230609154033.3511-1-raymondhackley@protonmail.com> <20230609154200.3620-1-raymondhackley@protonmail.com> <e2bb439c-9b72-991b-00f6-0b5e7602efd9@linaro.org> <20230609173935.84424-1-raymondhackley@protonmail.com> <7ad5d027-9b15-f59e-aa76-17e498cb7aba@linaro.org>
Feedback-ID: 49437091:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Friday, June 9th, 2023 at 7:29 PM, Krzysztof Kozlowski <krzysztof.kozlow=
ski@linaro.org> wrote:

> > > Why do you need these checks? This should be called in correct contex=
t,
> > > so when regulator is valid and enabled. If you have such checks it
> > > suggests that code is buggy and this is being called in wrong context=
s.
> >=20
> > First condition !IS_ERR(pvdd) is to check if pvdd exists.
> > Some devices, msm8916-samsung-serranove for example, doesn't need pvdd =
or
> > have it bound in the device tree:
>=20
>=20
> If regulator is missing you should get a dummy.
>=20
> But anyway the code will not be executed if you don't get proper regulato=
r.
>=20

The current patch set is using devm_regulator_get_optional() instead of
devm_regulator_get(), which doesn't get a dummy regulator.

> > https://github.com/torvalds/linux/commit/ab0f0987e035f908d670fed7d86efa=
6fac66c0bb
> >=20
> > Without !IS_ERR(pvdd), checking it with regulator_is_enabled(pvdd):
> >=20
> > [ 50.161882] 8<--- cut here ---
> > [ 50.161906] Unable to handle kernel paging request at virtual address =
fffffff9 when read
> > [ 50.161916] [fffffff9] *pgd=3Daffff841, *pte=3D00000000, *ppte=3D00000=
000
> > [ 50.161938] Internal error: Oops: 27 [#1] PREEMPT SMP ARM
> >=20
> > Or disabling it directly with regulator_disable(pvdd):
> >=20
> > [ 69.439827] 8<--- cut here ---
> > [ 69.439841] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000045 when read
> > [ 69.439852] [00000045] *pgd=3D00000000
> > [ 69.439864] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> >=20
> > Second condition regulator_is_enabled(pvdd) is to make sure that pvdd i=
s
> > disabled with balance.
>=20
>=20
> So you have buggy code and to hide the bug you add checks? No, make the
> code correct so the check is not needed.
>=20

Do you mean that I should use devm_regulator_get() instead in order to get
a dummy regulator, so that it can disable pvdd without unnecessary checks?
Actually there is v4 with those buggy codes and checks dropped.
Please do let me know if I am understanding and doing it correctly. I would
send it after proper period of cooldown.

Regards,
Raymond

