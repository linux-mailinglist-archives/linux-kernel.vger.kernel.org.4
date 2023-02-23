Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04636A043F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 09:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbjBWI4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 03:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233299AbjBWI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 03:56:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5831A46174
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 00:56:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PMn2G21kNz4x7j;
        Thu, 23 Feb 2023 19:56:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1677142599;
        bh=dVU6A67pHBa4R69qFtAyoB1kpoC8kE9avrpf4rmf5Ew=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=GicTjADwu19QiNQtSftsopmG71q+HnjregXjDHqBaRiWOwY7IpHAhLuNV/Sc+fUen
         FY2mL+7uT7zQZ6qfLprABzp2AIHQ/q81yCGh5wUR29HkTfSDhMbNfWzQhPxW6j15E5
         hhu8iqkEZ3OhTT6Z7QMGiScZd7IQaTcoWGWiJx5RZZ1Kv12hkm4gDxxl2q6ioJhgQ5
         PAKzImdO+qCNyyBYd8Ca1YZkqOboJPgbSsjmq3I6HOMTQElft40nNc0tJzI4lR1LUn
         fJujwmY90SX9GjWwpSATwt4uP+yu5tuu0rZEYofAh9C4UG3+Nv40jfpTuLiCxBlUqm
         +cTQcN+Np19Cw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Elimar Riesebieter <riesebie@lxtec.de>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] macintosh: via-pmu-led: *********************************
In-Reply-To: <20230223014151.19270-1-rdunlap@infradead.org>
References: <20230223014151.19270-1-rdunlap@infradead.org>
Date:   Thu, 23 Feb 2023 19:56:36 +1100
Message-ID: <877cw8bvzv.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> LEDS_TRIGGER_DISK depends on ATA, so selecting LEDS_TRIGGER_DISK
> when ATA is not set/enabled causes a Kconfig warning:
>
> WARNING: unmet direct dependencies detected for LEDS_TRIGGER_DISK
>   Depends on [n]: NEW_LEDS [=y] && LEDS_TRIGGERS [=y] && ATA [=n]
>   Selected by [y]:
>   - ADB_PMU_LED_DISK [=y] && MACINTOSH_DRIVERS [=y] && ADB_PMU_LED [=y] && LEDS_CLASS [=y]
>
> Fix this by making ADB_PMU_LED_DISK depend on ATA.

Should it just depend on LEDS_TRIGGER_DISK ?

cheers

> Seen on both PPC32 and PPC64.
>
> Fixes: 0e865a80c135 ("macintosh: Remove dependency on IDE_GD_ATA if ADB_PMU_LED_DISK is selected")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Elimar Riesebieter <riesebie@lxtec.de>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  drivers/macintosh/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
>
> diff -- a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
> --- a/drivers/macintosh/Kconfig
> +++ b/drivers/macintosh/Kconfig
> @@ -86,6 +86,7 @@ config ADB_PMU_LED
>  
>  config ADB_PMU_LED_DISK
>  	bool "Use front LED as DISK LED by default"
> +	depends on ATA
>  	depends on ADB_PMU_LED
>  	depends on LEDS_CLASS
>  	select LEDS_TRIGGERS
