Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C126BA4F7
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 03:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbjCOCAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 22:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCOCA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 22:00:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2172B2887B
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 19:00:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pbtrk2zHtz4xDp;
        Wed, 15 Mar 2023 13:00:22 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1678845623;
        bh=zUCpIP8eMjrN8etQOwCOEXDVZhq5NHF0PZNHwLjUDmU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=D0rK86NmKbcJ+X9Ku6Qdk07mr2ceuEl3hAvcGnMcECSO6GxPRP3ecOPMCzlsq0mQY
         WdN0CgkfEyVb58TsHWzE/UPY6HlmpCBIDlInImAEKREsP9QpnSQUdjipzGlZ8SA7b0
         MWuGx1T/dgc3UUr2XgZWDByJ13OJm0n6afDOyyfv9dddJfGxwKB3iyubb3xMCU0GdD
         giZ9ccXRwEzJptULR60dRmDVlFV7jrldUlRcLX1rhA9aHJDmNqGzuItVGHVXjL6gvN
         fEHONjOfqwMaHRqoT8eOJ17MgOCAb4e90HqU/qvLxku9/GU27DAv4jtoDwIL26NMQy
         LP3HRf+O19XZw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     rafael@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 14/36] powerpc/pseries: move to use bus_get_dev_root()
In-Reply-To: <20230313182918.1312597-14-gregkh@linuxfoundation.org>
References: <20230313182918.1312597-1-gregkh@linuxfoundation.org>
 <20230313182918.1312597-14-gregkh@linuxfoundation.org>
Date:   Wed, 15 Mar 2023 13:00:21 +1100
Message-ID: <87bkkuojt6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> Direct access to the struct bus_type dev_root pointer is going away soon
> so replace that with a call to bus_get_dev_root() instead, which is what
> it is there for.
>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
> Note, this is a patch that is a prepatory cleanup as part of a larger
> series of patches that is working on resolving some old driver core
> design mistakes.  It will build and apply cleanly on top of 6.3-rc2 on
> its own, but I'd prefer if I could take it through my driver-core tree
> so that the driver core changes can be taken through there for 6.4-rc1.
>
>  .../platforms/pseries/pseries_energy.c        | 28 +++++++++++--------
>  arch/powerpc/platforms/pseries/suspend.c      | 10 +++++--
>  2 files changed, 25 insertions(+), 13 deletions(-)

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

The other powerpc changes look OK too.

cheers
