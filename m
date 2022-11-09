Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18246222F7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 05:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiKIEQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 23:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiKIEQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 23:16:42 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A731D649;
        Tue,  8 Nov 2022 20:16:41 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N6Wr706Nmz4xYV;
        Wed,  9 Nov 2022 15:16:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667967399;
        bh=5xtBjmrCT2kYf4KzjyulzCTTzIQLKTfs5IqGG9ERQ5g=;
        h=Date:From:To:Cc:Subject:From;
        b=jg1NAfvXu3MMtKKH2LVfJm5sgMB8dSnZ5At2VUSnHu//tRX7rbsBsY3doLmDsd7Yq
         iZM693SowrVU08YiCQcsx3cGjs07vAPjXWZqQ28Xe+0KL0i6eil32mnb9QCG0Zll6C
         4ZI2o9jZbsgKR8YwLHIV4z5A5ouvmt7gvkOCdxk0LLKf/bewlMUwtjawUuDq2sqGH2
         R8IFAHzY4RhTWfSBQ2hr3s4jiOK1dcukqgxbU9CaDvkOik0StnLkXJsADXAB6TIgzj
         4Tx02l+NWYJUzgJ0lqOOKRUoXMymXzFD5iXManQ6YmhJo+bT4X59CO2GCWmPfrmaP+
         9A7mVJHHIqu6w==
Date:   Wed, 9 Nov 2022 15:16:37 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jeff Johnson <quic_jjohnson@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mhi tree
Message-ID: <20221109151637.67be60f8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nTZ_f80NJu+xT1s9iF_.1oj";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nTZ_f80NJu+xT1s9iF_.1oj
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/bus/mhi/host/pci_generic.c: In function 'mhi_pci_get_irqs':
drivers/bus/mhi/host/pci_generic.c:743:60: error: assignment of member 'irq=
' in read-only object
  743 |                         mhi_cntrl_config->event_cfg[i].irq =3D 0;
      |                                                            ^

Caused by commit

  c970e67d64a5 ("bus: mhi: host: make mhi_controller_config::event_cfg cons=
t")

I have used the mhi tree from next-20221108 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/nTZ_f80NJu+xT1s9iF_.1oj
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNrKaUACgkQAVBC80lX
0GxQGggAmP+oB8CmQ6J0/ruCjNrK5cKXxM6LyVItAIrz1m6e485xob3wLkjAxXWs
zUFwZohLv7Xu6AsuNp5GVHtMOVTqJgS2IeaVZG53Y4Rr6oJ8oJkf1bI4OoAmSPcn
qzEewp13wBsSYBh+yDlpBojAfCAqiwVZJaLk5ehl0f8xGOqPBOs297F5M2chGMtx
FaTMc5DqKpantw+gAcZ3gHHCeD+kLsz2kuBp5/crovQRkJ4j/UhxNpobOunXrk5M
EtdEJNQCJdoFSrq5T+5CVISPuCp18eQjXyAwiT+nFedHBTEujyUcWyPl5ySoEr1j
AVn7aoJcgnzNqcvcoblesaZUgDmCow==
=e1pk
-----END PGP SIGNATURE-----

--Sig_/nTZ_f80NJu+xT1s9iF_.1oj--
