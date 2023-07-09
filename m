Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE11C74C6F0
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 20:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbjGISIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 14:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjGISIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 14:08:04 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61599BC;
        Sun,  9 Jul 2023 11:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=QXMFC6gz8KNAOpyGfeaSWSTcXiuxDivyP/I51DPhIWo=;
        t=1688926079; x=1690135679; b=ZhU2IhvoFdCPkjX1slEqgeXFUb8ezDWivC4ABTC93yuk7At
        n4K9g+CND3bNTe+kTwqkXk7PkVzNNgRbuoN/MKbeYEDq0xxhCjg7vv7BzJb+V+8j73v3797o2MZVi
        jx+O6WEd1wB9GwbPbmv1mD6gG7nbhqHQiWT/GJJ5DhKNWp6GTcjnQWyD2V8pvqbZ2OOy5sBdDz3vK
        r7tvtXLk9V3XxN3C8mZv0oDnAA0ik8TGzm/OrfdLcyNCfciXcQGq9eAh3xPr3U5MMw0Gu6y1LwqQu
        jOjCqbIHjjIJyHiUQ6jBZADtGS5zwRkW1uAeDp/bH/uhABOAaf0uP54anJS+57CQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qIYov-00Dn5B-1O;
        Sun, 09 Jul 2023 20:07:41 +0200
Message-ID: <446c25888d9316d0f15e6bcc6ecb100dda99324e.camel@sipsolutions.net>
Subject: Re: [Regression][BISECTED] kernel boot hang after 19898ce9cf8a
 ("wifi: iwlwifi: split 22000.c into multiple files")
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Zhang, Rui" <rui.zhang@intel.com>,
        "Greenman, Gregory" <gregory.greenman@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Baruch, Yaara" <yaara.baruch@intel.com>,
        "Ben Ami, Golan" <golan.ben.ami@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Date:   Sun, 09 Jul 2023 20:07:40 +0200
In-Reply-To: <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
References: <b533071f38804247f06da9e52a04f15cce7a3836.camel@intel.com>
         <a4265090-d6b8-b185-a400-b09b27a347cc@leemhuis.info>
         <CAHk-=wg23SdKRcn2W+BWWEfJ2Efp0sreJx9=iw0AsUPjW3qznw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2023-07-09 at 09:31 -0700, Linus Torvalds wrote:
> On Fri, 7 Jul 2023 at 03:55, Linux regression tracking (Thorsten
> Leemhuis) <regressions@leemhuis.info> wrote:
> >=20
> > [CCing the regression list, netdev, the net maintainers, and Linus;
> > Johannes and Kalle as well, but just for the record, they afaik are
> > unavailable]
>=20
> So I will release rc1 with this issue, but remind me - if it hasn't
> had any traction next week and the radio silence continues, I'll just
> revert it all.

Sorry. I got back home a few hours ago (for few days anyway) and I think
I already know what the issue is. I'll send a fix to try in a few
minutes, was just trying to collect all the reported-by etc.

There's clearly a separate bug in the init failure path, but the reason
it fails in the first place is a mismatch between different changes.

johannes


