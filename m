Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664965C05E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 14:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjACNAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 08:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjACNAc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 08:00:32 -0500
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D0C1BA;
        Tue,  3 Jan 2023 05:00:31 -0800 (PST)
Received: from localhost (127.0.0.1) (HELO v370.home.net.pl)
 by /usr/run/smtp (/usr/run/postfix/private/idea_relay_lmtp) via UNIX with SMTP (IdeaSmtpServer 5.1.0)
 id c5c15f71b261e711; Tue, 3 Jan 2023 14:00:30 +0100
Received: from kreacher.localnet (unknown [213.134.163.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by v370.home.net.pl (Postfix) with ESMTPSA id A6ED2781239;
        Tue,  3 Jan 2023 14:00:29 +0100 (CET)
Authentication-Results: v370.home.net.pl; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: v370.home.net.pl; spf=fail smtp.mailfrom=rjwysocki.net
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>
Cc:     "zh.nvgt@gmail.com" <zh.nvgt@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ACPI: Drop the custom_method debugfs interface
Date:   Tue, 03 Jan 2023 14:00:29 +0100
Message-ID: <5639784.DvuYhMxLoT@kreacher>
In-Reply-To: <c26f6cbc705a939c31c6da96a8100c7e6a02d30c.camel@intel.com>
References: <7499491.EvYhyI6sBW@kreacher> <c26f6cbc705a939c31c6da96a8100c7e6a02d30c.camel@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 213.134.163.200
X-CLIENT-HOSTNAME: 213.134.163.200
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvhedrjeeggdegiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfjqffogffrnfdpggftiffpkfenuceurghilhhouhhtmecuudehtdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddtjeenucfhrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqeenucggtffrrghtthgvrhhnpeefudduuedtuefgleffudeigeeitdeufeelvdejgefftdethffhhfethfeljefgteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvudefrddufeegrdduieefrddvtddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvddufedrudefgedrudeifedrvddttddphhgvlhhopehkrhgvrggthhgvrhdrlhhotggrlhhnvghtpdhmrghilhhfrhhomhepfdftrghfrggvlhculfdrucghhihsohgtkhhifdcuoehrjhifsehrjhifhihsohgtkhhirdhnvghtqedpnhgspghrtghpthhtohepgedprhgtphhtthhopehlihhnuhigqdgrtghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhirdiihhgrnhhgsehinhhtvghlrdgtohhmpdhrtghpthhtohepiihhrdhnvhhgthesghhmrghilhdrtghomhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
 lhdrohhrgh
X-DCC--Metrics: v370.home.net.pl 1024; Body=4 Fuz1=4 Fuz2=4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, January 3, 2023 3:17:43 AM CET Zhang, Rui wrote:
> On Mon, 2023-01-02 at 18:05 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The ACPI custom_method debugfs interface is security-sensitive and
> > concurrent access to it is broken [1].
> > 
> > Moreover, the recipe for preparing a customized version of a given
> > control method has changed at one point due to ACPICA changes, which
> > has not been reflected in its documentation, so whoever used it
> > before
> > has had to adapt an no problems with it have been reported.
> > 
> > The latter likely means that the number of its users is limited at
> > best
> > and attempting to fix the issues mentioned above is likely not worth
> > the
> > effort.  Moreover, if it gets broken in the process, the breakage may
> > not
> > be readily discovered, so deleting it altogheher appeares to be a
> > better
> > option.
> > 
> > Accordingly, drop custom_method along with its (outdated anyway)
> > documentation.
> > 
> > Link: 
> > https://lore.kernel.org/linux-acpi/20221227063335.61474-1-zh.nvgt@gmail.com/
> > # [1]
> > Reported-by: Hang Zhang <zh.nvgt@gmail.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > ---
> >  Documentation/firmware-guide/acpi/method-customizing.rst |   89 ----
> > --------
> 
> Documentation/firmware-guide/acpi/index.rst
> needs to be updated as well.

Right, thanks!

I've just sent a v2 of the patch with that fixed.



