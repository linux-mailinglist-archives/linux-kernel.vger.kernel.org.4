Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C186E809B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 19:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233165AbjDSRro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjDSRrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 13:47:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D935B194;
        Wed, 19 Apr 2023 10:47:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 702BA64150;
        Wed, 19 Apr 2023 17:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC77C433EF;
        Wed, 19 Apr 2023 17:47:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681926448;
        bh=pWh482ug9z2sqnnRAVNa0CWvtOeNXthB5Oa4dpUf8qQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rMmN2j+aACy9B0E/Ue1a6PZkHU8A2yZS+0gPvkPupDu9QQDJyAGC88hSS/m648/R2
         GrC7k6Fb9IUzJaW5n9403JAe+m23Ys2HJrvmivPjpKIyPu4CAL9F85FH+QFULb4RXx
         /KS1owff7JcbEQQ4MC4D5vPbT6JTXCN4L9J0PdU1dXQW0CfYhjrBGRWCcvrtSABVW/
         His9baU6XFrvJe5lsiQpyNu4qfncE6Q0A87qRN1zrLDlSLgqG8t77yQWEj/LUuAzE2
         SXIy5boFrKgfCFXczjXPAwdTJFjbToB3lCC5mp1Nvmy+yZDYIU1j7wra8brKFT9GMJ
         D/BJpMbGnkCdQ==
Date:   Wed, 19 Apr 2023 18:47:24 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Changhuang Liang <changhuang.liang@starfivetech.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        Hal Feng <hal.feng@starfivetech.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [RESEND v2 4/6] soc: starfive: Extract JH7110 pmu private
 operations
Message-ID: <20230419-atypical-unbounded-99cbbff3091a@spud>
References: <20230419035646.43702-1-changhuang.liang@starfivetech.com>
 <20230419035646.43702-5-changhuang.liang@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7GNjDzVc5Xp9dcL9"
Content-Disposition: inline
In-Reply-To: <20230419035646.43702-5-changhuang.liang@starfivetech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7GNjDzVc5Xp9dcL9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 18, 2023 at 08:56:44PM -0700, Changhuang Liang wrote:
> Move JH7110 private operation into private data of compatible.
> Convenient to expand different compatible.

I prefer how the code looks in v2, thanks.
However, just as in the prior patch, "Convenient to expand different
compatible" isn't really a justification - specifically, supporting the
power domain controller serving the dphy is your motivation here. The
important difference being that it uses a regmap from a syscon and has
no interrupts nor the encourage features.

Although, given the only real similarity the code driving each of the
PMUs is the variable names, I guess you could argue that this driver
should be left alone and the "aon dphy" should be a different driver
altogether.

I don't have a strong opinion though & if it's fine with Walker and
noone else objects, it's fine with me...

--7GNjDzVc5Xp9dcL9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZEApKwAKCRB4tDGHoIJi
0tYVAPwISZbXM40tjQmXEGDayikBInHUpr/oPqkALLx8vo+MDwD9ELD9t2yG84GK
wfCi0TDnkKmKRjeXnQ8LaIq5theaXws=
=YkVs
-----END PGP SIGNATURE-----

--7GNjDzVc5Xp9dcL9--
