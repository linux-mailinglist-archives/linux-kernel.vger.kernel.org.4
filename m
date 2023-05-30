Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D337716FDA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 23:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjE3VjM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 17:39:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230399AbjE3VjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 17:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BF5BC7;
        Tue, 30 May 2023 14:39:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ECDD633DB;
        Tue, 30 May 2023 21:39:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504F1C4339B;
        Tue, 30 May 2023 21:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685482745;
        bh=K8tnh3E6cz2urAtYiHrxzL4PLY6sjrXzK1nJAzkm1l8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iIfcx+aLwdykV7AH9GpWQV3R0vRhMc95o68dX/6k/c+0KdjCVsjZyH01qTdmABgzU
         CmfvK/Of1GJVPgdKi+JX667/jEJ919uBVvwZIuLiCFT8jIDlw2gjNnpiC7SUasAuyw
         JaN0rsll7ad3dKGrvjRQQXv+xjfFNpmIEcM1Ih3+8hVEt6Dfu7WHkzTunfbYEpakC8
         40T3uMyekZvqL4gwh+xgRuo3Ou0FNUDmwBXkownXDZqWzyVO7JqJTPEY8iBgcWaH9Q
         51+S/QLLuw1n7AS3CbewwpLaMk0TOc6G+JdRAO5fasbIKk39G5J/8S4no25/aC9n8/
         5u/2ImEVWfLoA==
Date:   Tue, 30 May 2023 22:39:00 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo
 error message if -ENOENT
Message-ID: <20230530-basically-wildly-84415a94171d@spud>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230530201955.848176-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yo Florian,

On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
> From: Pierre Gondois <pierre.gondois@arm.com>
>=20
> commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream
>=20
> fetch_cache_info() tries to get the number of cache leaves/levels
> for each CPU in order to pre-allocate memory for cacheinfo struct.
> Allocating this memory later triggers a:
>   'BUG: sleeping function called from invalid context'
> in PREEMPT_RT kernels.
>=20
> If there is no cache related information available in DT or ACPI,
> fetch_cache_info() fails and an error message is printed:
>   'Early cacheinfo failed, ret =3D ...'
>=20
> Not having cache information should be a valid configuration.
> Remove the error message if fetch_cache_info() fails with -ENOENT.
>=20
> Suggested-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/all/20230404-hatred-swimmer-6fecdf33b57a@sp=
ud/
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20230414081453.244787-4-pierre.gondois@ar=
m.com
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

How come this now needs a backport? Did the rest of the series get
backported, but not this one since it has no fixes tag?

Cheers,
Conor.
