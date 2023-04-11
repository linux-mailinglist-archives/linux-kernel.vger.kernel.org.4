Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3C96DD8FB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjDKLKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjDKLKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:10:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DAF44BF;
        Tue, 11 Apr 2023 04:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4dLgDD+3t6//ujM7LIO0v5abyc8cvGvdK7uuYESrTfM=;
        t=1681211442; x=1682421042; b=cQc+lgnLjda7gCYmTS3pyznzzig+AT7EVJzcojFdxxQeGEv
        Qgs5pbr2lnPyhFOb/LqNqCZD2qK7OPzUH9SG6RbUMpkXJ0wNSWBoPb5t1ANxOh3HT+/w4uBYbzefp
        Ot1OC4otheydzHeWKmIqvD4vp9HGaz2I2et32VhCXf8ihQFuMVQK6YGIB12+z2xXeaiICuQ7eHJOQ
        ygK4uFZJg+zSDaiDZGNrZxv7DXiaif3SZa7H8Hz7eOjcCZHgXIcN/zZGgbDU/OgCo6hVV60uPshkS
        gBuQCA8k3IHD/IQ7osGA8+5Y93V1kA3c7g08Gq1kLu++aw6W409Q/3+o2rqDaFcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pmBtT-00ChI7-1V;
        Tue, 11 Apr 2023 13:10:35 +0200
Message-ID: <147d12620126c651c2487d731b82783b2c352452.camel@sipsolutions.net>
Subject: Re: [PATCH] iwlwifi: cfg: Add missing MODULE_FIRMWARE() for *.pnvm
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Takashi Iwai <tiwai@suse.de>,
        Gregory Greenman <gregory.greenman@intel.com>
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 11 Apr 2023 13:10:34 +0200
In-Reply-To: <20230405063546.12439-1-tiwai@suse.de>
References: <20230405063546.12439-1-tiwai@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[removing Luca, he no longer works on wifi]

Hi,

On Wed, 2023-04-05 at 08:35 +0200, Takashi Iwai wrote:
> A few models require *.pnvm files while we don't declare them via
> MODULE_FIRMWARE().  This resulted in the breakage of WiFi on the
> system that relies on the information from modinfo (e.g. openSUSE
> installer image).
>=20
> This patch adds those missing MODULE_FIRMWARE() entries for *.pnvm
> files.

Makes sense. They (may) also exist the previous generation of devices,
but weren't strictly required then.

> The fix is obviously ad hoc.

Yeah. Maybe we'll merge it anyway though? Do you think this should still
go to 6.3? Pretty close I guess.

> Here I added the lines with the explicit string since *_PRE definition
> contains the tailing dash and can't be used for *.pnvm file.

Yeah, we thought about changing that - but I have a larger set of rework
in this area just done a short while ago, which would make it a bit hard
to do. Hence maybe we should merge this for 6.3/6.4 and do the larger
rework plus getting rid of the dash in the *_PRE definitions in 6.5,
what do you think?

> Alternatively, we may put a single line
>  MODULE_FIRMWARE("iwlwifi-*.pnvm");
> to catch all, too.
>=20

Unrelated discussion, but ... I didn't even know that was possible.

Maybe this gives us a way out of something else I was thinking about
recently - the MODULE_FIRMWARE() here in iwlwifi usually only states the
latest version that the driver accepts, however:

 * the driver might be ahead of the firmware releases - in fact that's
   how it usually should be, just due to various issues we haven't been
   upstreaming as quickly as we'd like
 * sometimes we (have to) skip firmware releases due to other issues
 * etc.

So it could be that 6.4 kernel will state e.g. the max version is 78,
but we end up never even releasing 78 firmware. The MODULE_FIRMWARE()
would then state 78, but that file would never exist.

Have we just been very lucky with never running into any of these
issues, and the distro kernels being "old enough" that usually all the
max version firmware was already released by the time it was used? Or
did you work around this in some other way?

Anyway, if we can use wildcards, maybe instead of stating the max API
version number of the filename, we should have a wildcard there for the
number? OTOH, iwlwifi *already* comes with a *lot* of firmware files for
all the various families of devices and radios, and making the API
version a wildcard would make it much bigger again, to the point where
we might as well state something like

  MODULE_FIRMWARE("iwlwifi-*")

which is a lot of files ...

Did you see any issues with this versioning thing in the past? And what
would you think (from a distro POV) about making this a wildcard on the
version, i.e. having, in things like

#define IWL_QU_B_HR_B_MODULE_FIRMWARE(api) \
        IWL_QU_B_HR_B_FW_PRE __stringify(api) ".ucode"


"*" instead of __stringify(api).


Some input on this would be nice.

Thanks,
johannes
