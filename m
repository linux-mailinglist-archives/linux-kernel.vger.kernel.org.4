Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 348596FA1F5
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 10:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbjEHINi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 8 May 2023 04:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjEHINh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 04:13:37 -0400
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD1A3C34
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 01:13:35 -0700 (PDT)
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay01.hostedemail.com (Postfix) with ESMTP id 031071C7257;
        Mon,  8 May 2023 08:13:34 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 886FB20028;
        Mon,  8 May 2023 08:13:31 +0000 (UTC)
Message-ID: <1a559a83d3519a849eb93ade955d90c1c19af884.camel@perches.com>
Subject: Re: get_maintainer broken for a few entries in MAINTAINERS
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de
Date:   Mon, 08 May 2023 01:13:30 -0700
In-Reply-To: <20230508074731.jlzuvx6yr336xmvp@pengutronix.de>
References: <20230508074731.jlzuvx6yr336xmvp@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Stat-Signature: 5ojafbzdbzsbcgcrxrmcofpux9qirwa7
X-Rspamd-Server: rspamout08
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: 886FB20028
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/hhfXRo+FUNATrKAFBW2RpQlt9gzisi1g=
X-HE-Tag: 1683533611-674902
X-HE-Meta: U2FsdGVkX18qwovIpVRRvhNH3odj/eZFQf1b00m5cZ0CylGQwU6h0ZgiTV+iOxSpaJGi+frSYM/tNqjNCGBkIw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-05-08 at 09:47 +0200, Uwe Kleine-König wrote:
> Hello,
> 
> on v6.3 and v6.4-rc1 I experience:
> 
> 	$ scripts/get_maintainer.pl -f drivers/gpu/drm/arm/display/komeda
> 	"James (Qian) Wang" <james.qian.wang@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Liviu Dudau <liviu.dudau@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Mihail Atanassov <mihail.atanassov@arm.com> (supporter:ARM KOMEDA DRM-KMS DRIVER)
> 	Brian Starkey <brian.starkey@arm.com> (supporter:ARM MALI-DP DRM DRIVER)
> 	David Airlie <airlied@gmail.com> (maintainer:DRM DRIVERS)
> 	Daniel Vetter <daniel@ffwll.ch> (maintainer:DRM DRIVERS)
> 	 (open list:ARM KOMEDA DRM-KMS DRIVER)
> 	dri-devel@lists.freedesktop.org (open list:DRM DRIVERS)
> 	linux-kernel@vger.kernel.org (open list)
> 
> The 7th entry is broken. I didn't try to debug that in the script. Doing
> 
> -L:     Mali DP Maintainers <malidp@foss.arm.com>
> +L:     malidp@foss.arm.com
> 
> (twice) in MAINTAINTERS fixes the output.

More like the entries in MAINTAINERS are broken.
L: entries should not have "names".

I suggest sending a patch to MAINTAINERS to remove the "names"
or change the non-conforming entries to "M:"

$ git grep -h "^L:" MAINTAINERS | \
  grep -v -P "^L:\s+[\w\_\.-]+@[\w_-]+\.\w+"
L:	Mali DP Maintainers <malidp@foss.arm.com>
L:	Mali DP Maintainers <malidp@foss.arm.com>
L:	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>

