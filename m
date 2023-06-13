Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C9F72D805
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 05:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbjFMDMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 23:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbjFMDLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 23:11:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC661730;
        Mon, 12 Jun 2023 20:10:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A0E6D61D5A;
        Tue, 13 Jun 2023 03:10:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FAEFC433D2;
        Tue, 13 Jun 2023 03:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686625809;
        bh=hzoTsWIe+W0MkQt7OpjaB2OEQVikCx9KmTVgfu6i3Wo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pnafMXnHRAo1NxIlBZFL9ihkEP1KfM1H8Yp3cuF+8urOjaDUVOt9wwl4/Ks0gz36Z
         dag2AQTYEAJxdFoQ0N2XI3voddu79ZtYbl/y3iQZbWmz2evoACnJL5o2gvewFbylRi
         LadR44/l78Z3hSZGpyaywKyt0gqT/+rSPpODXFQgJv5N1Gvfj5jcsEkGaDQFSNfhg0
         3IcFHaIlKte10s/oLbmQnBKPl91rPEFt/O9TzoFKJgLp6JheYL1C66ufWbtDL+A6nB
         inGBOis0buSEcDFI91tYICDjnIfQs1M7U8gqQS2oueT2kP3ODVVn9bypunTffGNnTy
         cWUd0azpxZSbQ==
Date:   Mon, 12 Jun 2023 20:10:06 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     palmer@dabbelt.com, paul.walmsley@sifive.com,
        aou@eecs.berkeley.edu, herbert@gondor.apana.org.au,
        davem@davemloft.net, conor.dooley@microchip.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, christoph.muellner@vrull.eu,
        Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v5 4/4] RISC-V: crypto: add accelerated GCM GHASH
 implementation
Message-ID: <20230613031006.GD883@sol.localdomain>
References: <20230612210442.1805962-1-heiko.stuebner@vrull.eu>
 <20230612210442.1805962-5-heiko.stuebner@vrull.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230612210442.1805962-5-heiko.stuebner@vrull.eu>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Mon, Jun 12, 2023 at 11:04:42PM +0200, Heiko Stuebner wrote:
> diff --git a/arch/riscv/crypto/ghash-riscv64-zbc.pl b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> new file mode 100644
> index 000000000000..677c438a44bf
> --- /dev/null
> +++ b/arch/riscv/crypto/ghash-riscv64-zbc.pl
> @@ -0,0 +1,427 @@
> +#! /usr/bin/env perl
> +# Copyright 2022 The OpenSSL Project Authors. All Rights Reserved.
> +#
> +# Licensed under the Apache License 2.0 (the "License").  You may not use
> +# this file except in compliance with the License.  You can obtain a copy
> +# in the file LICENSE in the source distribution or at
> +# https://www.openssl.org/source/license.html
> +
> +# This file is dual-licensed and is also available under the following
> +# terms:
> +#
> +# Copyright (c) 2023, Christoph Müllner <christoph.muellner@vrull.eu>
> +# All rights reserved.
> +#
> +# Redistribution and use in source and binary forms, with or without
> +# modification, are permitted provided that the following conditions
> +# are met:
> +# 1. Redistributions of source code must retain the above copyright
> +#    notice, this list of conditions and the following disclaimer.
> +# 2. Redistributions in binary form must reproduce the above copyright
> +#    notice, this list of conditions and the following disclaimer in the
> +#    documentation and/or other materials provided with the distribution.

Is this worded properly for a dual license?  The paragraph about the Apache
License makes it sound like the Apache License must always be complied with:
"You may not use this file except in compliance with the License."

So I worry that this could be interpreted as:

    Apache-2.0 AND BSD-2-Clause

instead of

    Apache-2.0 OR BSD-2-Clause

It needs to be the latter.

So I think the file header needs to be clarified w.r.t. the dual license.

Side note: can you please also include a SPDX-License-Identifier?

- Eric
