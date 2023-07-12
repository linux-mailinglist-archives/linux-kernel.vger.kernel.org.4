Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC9E7504F1
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:40:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjGLKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbjGLKj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:39:59 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4F8E74;
        Wed, 12 Jul 2023 03:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=4khwpG0dcNuMOFi/GJdwM3DNEHM/4TESMkw3EUchFP4=;
        t=1689158395; x=1690367995; b=WSysUK0jevQ88EShwtWuOlmKe/grS4oJKVrQQjCON9SIqn+
        37aD/aqF6XxIZGxgKk1CoZV4Sp95UzxbT1wVEYnVRdzMG4Iu2oyq8kY79m7DxOsSKbby8bl/GiMsb
        O8o3LsWqrmnGpRl3dj/+TCrgR0yi9Zy3ZDLofeNVzB7TJV+8qRG7hkf8RiVJXv5SSd1qL5+cVj5TC
        KdPrPA7E615T5a/Oe4O1xwjcGdf3sOdyfNK1YeE3dOjKMu/2iKIOpmMAvw+9kh5x9Qoqa1WHI92Rw
        xq/bjxGCPwkNVA8CHU90vYwzecG5efRxXJA3XUZK0a0bw3TLeowg0C/UDkl1ucTA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qJXGA-00GcDL-1P;
        Wed, 12 Jul 2023 12:39:50 +0200
Message-ID: <cb081b034d9283284c4754e62c083567b516d68b.camel@sipsolutions.net>
Subject: Re: [regression] iwlwifi driver broken on Intel 3165 network card
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Aloka Dixit <quic_alokad@quicinc.com>,
        John Crispin <john@phrozen.org>
Cc:     Aditya Kumar Singh <quic_adisi@quicinc.com>,
        linux-wireless@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jul 2023 12:39:49 +0200
In-Reply-To: <c71e376e-4e44-a1b3-6feb-2ed1ba7d325b@leemhuis.info>
References: <6f8715af-95c2-8333-2b32-206a143ebb52@leemhuis.info>
         <047c7bdc8057175f2bb78981a5f1a1aa6b493153.camel@sipsolutions.net>
         <c71e376e-4e44-a1b3-6feb-2ed1ba7d325b@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-07-12 at 11:59 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> On 10.07.23 17:02, Johannes Berg wrote:
> > On Mon, 2023-07-10 at 10:32 +0200, Linux regression tracking (Thorsten
> > Leemhuis) wrote:
> > > Hi, Thorsten here, the Linux kernel's regression tracker.
> > >=20
> > > I noticed a regression report in bugzilla.kernel.org. As many (most?)
> > > kernel developers don't keep an eye on it, I decided to forward it by=
 mail.
> > >=20
> > > Aloka Dixit, apparently it's cause by a change of yours: bd54f3c2907
> > > ("wifi: mac80211: generate EMA beacons in AP mode") [v6.4-rc1]
> > >=20
> >=20
> > That bisect result seems unlikely to be correct. Those changes are in
> > "how to get beacons" (in AP mode) which isn't even used in client mode
> > here.
>=20
> You where right, the second bisect resulted in a different outcome.
> Currently looks like 5fc3f6c90cc ("r8169: consolidate disabling ASPM
> before EPHY access") [v6.4-rc1] is the culprit; this is somewhat odd as
> well, but confirmed partially, as blacklisting r8169 apparently fixes
> the issue.

That indeed is odd as well, but from the log it looks like r8169 is
actually present on the machine, so perhaps this messes with some PCI
bugs configuration badly enough? It looks harmless enough, but who
knows.

Anyway, thanks for letting me know.

johannes
