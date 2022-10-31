Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B3C612EED
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 03:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiJaCXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 22:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJaCXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 22:23:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228772678;
        Sun, 30 Oct 2022 19:23:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N0xln29whz4xFy;
        Mon, 31 Oct 2022 13:23:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667183013;
        bh=07tdsqNe++J8/yzBiFrLHlBuVLMuqBEfXZItok9j7iI=;
        h=Date:From:To:Cc:Subject:From;
        b=D/P7CIX6+ZBmqnDmPh9rleF5+z0Qxx5HN4btcPPyBMloNYCRygrU3awRF8L2poUtc
         L/z+Db6jcN5WviRGnhFjSbslzF0DqQafd2K4bRx0XdiZikLPAwLQLaz2WU4gTLvs/i
         PTMclogQXLKfmUKU0rVuCxZoHUvnQIfnePUGzOG5ursupqRbButH7/i8VjIBVxZIl7
         cwTLYo8JRJnbtd5LDqKA/Ci6BtzSIPwsEgR8JbyTyX6EQW2FnamrbWhr8EQyqOo5SE
         igG4xYZfU70WsZqQzLwJ4cB/r/s0v4rW50RXSHyQNvDsWSlpM8Jht+McFxGvnYmNnS
         dXwBdghT0u8bA==
Date:   Mon, 31 Oct 2022 13:23:31 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the cgroup tree
Message-ID: <20221031132331.76193df5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CeH/UmCLq/GeI9VzD=+erx/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CeH/UmCLq/GeI9VzD=+erx/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the cgroup tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "css_tryget" [arch/x86/kvm/kvm-amd.ko] undefined!
ERROR: modpost: "css_put" [arch/x86/kvm/kvm-amd.ko] undefined!
ERROR: modpost: "css_put" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "css_get" [fs/btrfs/btrfs.ko] undefined!
ERROR: modpost: "css_put" [drivers/block/loop.ko] undefined!
ERROR: modpost: "css_get" [drivers/block/loop.ko] undefined!
ERROR: modpost: "css_put" [net/netfilter/xt_cgroup.ko] undefined!

Caused by commit

  6ab428604f72 ("cgroup: Implement DEBUG_CGROUP_REF")

I have used the cgroup tree from next-20221028 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/CeH/UmCLq/GeI9VzD=+erx/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNfMaMACgkQAVBC80lX
0GzSpQf/U0vlRo5t291zlYzb7OVa70jYeHV5ea992lQv6HRckE8+RxF7/43SA0Ja
82i6KXYcNfWmTwkNi+vHccD1muPUVaIYHMr80VKxyhru6DVLPAe87n19Dvj/y1fd
SpFdBwkzAn/oyiQJCzBzYWFXJHvsU3XV7T1uQ/QKau2PT4p6jCz5IkyDHwf+5bWt
RSOtRGlnYuqbaCkGJzv56OtfZ0k+6cSugSnn1G5JXHDOZ2Grzlwi5JaYQ+eN8L50
LVdjnrr+llij9EgLA8NnVcJorEwE3KWTj3MenViCh2w3jDyus41SOBb54jQyHwb7
jRDJtVyBud33rxoSKy4j9xKPMAVSeQ==
=LFI0
-----END PGP SIGNATURE-----

--Sig_/CeH/UmCLq/GeI9VzD=+erx/--
