Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F247267DB06
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 02:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjA0BDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 20:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjA0BD2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 20:03:28 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928A33EFDD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 17:03:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2zph6lhcz4x1N;
        Fri, 27 Jan 2023 12:03:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ozlabs.org;
        s=201707; t=1674781405;
        bh=fBlQHQkjULYltn0di+B+qVEhWP+9aJbxpt/yBW0mAcs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TJt374NFwqAP8qEsmer9y468rtrxWEPz5CbEw+QJIJwpjjOvVPg8Xum7WC70qKRpi
         NoMx1sAxKJj4F5El44nesEFr+wcNX1enJUVE2fu67nm0f/ZnG7lz0Ly0S6z8mNOjPE
         7VgdOrC9gljOJ7uTerRyL6WRMeFNyxNic6wDgiTAW5SQOMaCwCe6yaKRmpt4jrseCa
         kBmolAtxEFfVBl4fObQN3XNwmAnfZS2BNfx2jN729xfZlAzrJoz9s8QnWmlwh7NIXY
         RfOG1cENkig2vMHy5drgLZu1FNiYk6nKRb1L1EyKjfDY/jtrttr9ZqOEhUXNwaKcYW
         rOFwlzcfscdQg==
Message-ID: <8fa108c9dedf884eab6dacaf3e9680b7c66c4202.camel@ozlabs.org>
Subject: Re: [PATCH] fsi: Add aliased device numbering
From:   Jeremy Kerr <jk@ozlabs.org>
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, alistair@popple.id.au, joel@jms.id.au
Date:   Fri, 27 Jan 2023 09:03:23 +0800
In-Reply-To: <20230126223850.901302-1-eajames@linux.ibm.com>
References: <20230126223850.901302-1-eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

> The I2C and SPI subsystems can use an aliased name to number the
> device. Add similar support to the FSI subsystem for any device type.

Sounds good!

However, the majority of this patch seems to be the change to a (const)
enum value, which you then convert to a string to generate the
non-number component of the device name.

Does:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_set_name(&scom->dev, "%s%d", =
fsi_get_dev_type_name(fsi_dev_scom), didx);

have much of a benefit over:

=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev_set_name(&scom->dev, "scom%d"=
, didx);

?

Cheers,


Jeremy
