Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85B36B4083
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 14:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbjCJNfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 08:35:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCJNfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 08:35:21 -0500
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E65108C24
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 05:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678455320; x=1709991320;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WtDcpAU3dvNjMDzvQt5FvC6SdEGthwtSk4hT1E8bcNk=;
  b=gG8GICWDrxirYsfNxDUPDdc4g5Cbez35WI66YrOsWH+/nJ1hrxPJUkyP
   gyLld+QjoSnhBN2Bqt2oEQxbGYjCj5KwzPPJXZ1WLhNun+0JimLlTEWPW
   nqzN48xseWfB1oU2SzBfEIoF/kBYdJbdOC3McMeFbwM+r/pCYnpsNsTMP
   DmXkPMu9klnXw+qfUDWwASXCcNdLpn2PdLFQk9OCNg+EGzKQTt1en6CBm
   KKaAzP7RZyS1Wq053nkbVZ5TD3khpwFG5dCbIcIHUkdvXSBKkHtL+TMHC
   jUFMGFm13BHwOJyh2Q9qZnvUiBNJLag225t4Chamz65paKw3XK1f+cJl/
   g==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29610059"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 10 Mar 2023 14:35:18 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 10 Mar 2023 14:35:18 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 10 Mar 2023 14:35:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1678455318; x=1709991318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WtDcpAU3dvNjMDzvQt5FvC6SdEGthwtSk4hT1E8bcNk=;
  b=RiX/x76lLEwYy22EphCtKB1NnYwrVNwaxoLiGgWVrX7I6uX2SEftMDd9
   VIUoHoZkx5Jl5A5FRR0+wmNJ01STNNHqwP4eKXcZkizfqoXO223KpgNaN
   hffZr18Jf/5FGOZOsFuEUG0THw2pvtYMYzJNG83eHlwLBEb8nmHsvPxdV
   5W2DzBQaxfXTPnXlrwVqQSbzdQo2F/5Q9zxGSpZm78T7NQy7BSz0M9263
   +67vDAWzCW8pwW5mkh1RsCUYtwG7v4nXvJHHbjqnbRXkmWFDA/PcjMIaA
   Sl2EGoGTDrApf7zXcuhYM9NGJcFpxiH+HUQy1+rk0nlE3icnpya3Qg99P
   Q==;
X-IronPort-AV: E=Sophos;i="5.98,249,1673910000"; 
   d="scan'208";a="29610058"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 10 Mar 2023 14:35:18 +0100
Received: from steina-w.localnet (unknown [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id E7080280056;
        Fri, 10 Mar 2023 14:35:17 +0100 (CET)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] regmap: cache: Do not panic for REGCACHE_NONE regmap
Date:   Fri, 10 Mar 2023 14:35:13 +0100
Message-ID: <2399331.NgBsaNRSFp@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <ZAsqVf8/C3lHOF8W@sirena.org.uk>
References: <20230310073911.3470892-1-alexander.stein@ew.tq-group.com> <ZAsqVf8/C3lHOF8W@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Am Freitag, 10. M=E4rz 2023, 14:02:13 CET schrieb Mark Brown:
> * PGP Signed by an unknown key
>=20
> On Fri, Mar 10, 2023 at 08:39:10AM +0100, Alexander Stein wrote:
> > Most regcache operations do check for REGCACHE_NONE, before ensuring
> > doing BUG_ON(!map->cache_ops). The missing regcache_sync* functions
> > panic on REGCACHE_NONE regmaps instead. Add an early return for non-cac=
hed
> > ones.
>=20
> Why would we be trying to do a regcache_sync() on a device with
> no cache?

Indeed, that makes no sense. That's indicating a bug in a driver, but why d=
o=20
we need to panic the kernel in this case?
On the other hand the same question applies to other regcache related=20
functions currently checking for non-cached maps. There is no common=20
behaviour:

panic:
* regcache_sync
* regcache_sync_region

returning -EINVAL:
* regcache_drop_region

returning -ENOSYS:
* regcache_read

returning success (0):
* regcache_write

early return (void return value):
* regcache_exit

Given all these possibilities I have no idea what's the right thing to do.

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/


