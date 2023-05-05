Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2E116F7D0E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 08:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjEEGkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 02:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjEEGkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 02:40:35 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6215EC7;
        Thu,  4 May 2023 23:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=X0c1PBLFOhai+mqhEBi/tW1OeYtirBEECbmlevNdTtM=;
        t=1683268834; x=1684478434; b=tYED6gMyFU8FHCp/t2Z6rOgjV0iHJl6LS3GH/R3WbiO4vZV
        Qj4cn5YUTsx/4o08IYEzd90oy6527pEyfaXDS5UlujiTe6R5rcWSzwW4Z/IYozCcNL1b0uKkwdomr
        FBN19mi5RqNndBQ0QHPZ2GRrQcvPlHe0/lxQj2UIutnub+3CPlgLCI9txyKjwI0ak7wGsstlH9MKU
        u4uegyw6u2uyhkBd5HhyBGG7VWVKD3DMb8O6J0Kk/UENTPLzsX/Z8KboshxtZzHozZ9RLRuS1uGJv
        QlpTxgPNdBhIx77QQLZQAzlxjerzjVuoOQ2tIugubMKOr+Qc1713nLkV4C2OFKAA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1pup74-000CRq-0E;
        Fri, 05 May 2023 08:40:18 +0200
Message-ID: <f02a94a6cad2e87e0cfe9c8ca8eedc89753313ab.camel@sipsolutions.net>
Subject: Re: [PATCH] wifi: iwlwifi: Fix spurious packet drops with RSS
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Sultan Alsawaf <sultan@kerneltoast.com>
Cc:     "Greenman, Gregory" <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Goodstein, Mordechay" <mordechay.goodstein@intel.com>,
        "Coelho, Luciano" <luciano.coelho@intel.com>,
        "Sisodiya, Mukesh" <mukesh.sisodiya@intel.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Fri, 05 May 2023 08:40:16 +0200
In-Reply-To: <ZFPxkRKep27H74Su@sultan-box.localdomain>
References: <20230430001348.3552-1-sultan@kerneltoast.com>
         <8d2b0aec270b8cd0111654dc4b361987a112d3ce.camel@sipsolutions.net>
         <ZFPxkRKep27H74Su@sultan-box.localdomain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
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

On Thu, 2023-05-04 at 10:55 -0700, Sultan Alsawaf wrote:
> >=20
> > So I assume you tested it now, and it works? Somehow I had been under
> > the impression we never got it to work back when...
>=20
> Yep, I've been using this for about a year and have let it run through th=
e
> original iperf3 reproducer I mentioned on bugzilla for hours with no stal=
ls. My
> big git clones don't freeze anymore either. :)

Oh! OK, great.

> What I wasn't able to get working was the big reorder buffer cleanup that=
's made
> possible by using these firmware bits. The explicit queue sync can be rem=
oved
> easily, but there were further potential cleanups you had mentioned that =
I
> wasn't able to get working.

Fair enough.

> I hadn't submitted this patch until now because I was hoping to get the b=
ig
> cleanup done simultaneously but I got too busy until now. Since this smal=
l patch
> does fix the issue, my thought is that this could be merged and sent to s=
table,
> and with subsequent patches I can chip away at cleaning up the reorder bu=
ffer.

Sure, that makes sense.

> > > Johannes mentions that the 9000 series' firmware doesn't support thes=
e
> > > bits, so disable RSS on the 9000 series chipsets since they lack a
> > > mechanism to properly detect old and duplicated frames.
> >=20
> > Indeed, I checked this again, I also somehow thought it was backported
> > to some versions but doesn't look like. We can either leave those old
> > ones broken (they only shipped with fewer cores anyway), or just disabl=
e
> > it as you did here, not sure. RSS is probably not as relevant with thos=
e
> > slower speeds anyway.
>=20
> Agreed, I think it's worth disabling RSS on 9000 series to fix it there. =
If the
> RX queues are heavily backed up and incoming packets are not released fas=
t
> enough due to a slow CPU, then I think the spurious drops could happen so=
mewhat
> regularly on slow devices using 9000 series.
>=20
> It's probably also difficult to judge the impact/frequency of these spuri=
ous
> drops in the wild due to TCP retries potentially masking them. The issue =
can be
> very noticeable when a lot of packets are spuriously dropped at once thou=
gh, so
> I think it's certainly worth the tradeoff to disable RSS on the older chi=
psets.

:)

> Indeed, and removing the queue sync + timer are easy. Would you prefer I =
send
> additional patches for at least those cleanups before the fix itself can =
be
> considered for merging?
>=20

No, you know, maybe this is easier since it's the smallest possible
change that fixes issues. Just have to see what Emmanuel says, he had
said he sees issues with this change.

johannes
