Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38CF66C280E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbjCUCWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjCUCWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:22:34 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B674AA250;
        Mon, 20 Mar 2023 19:22:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Pgb3S3NlFz4x1f;
        Tue, 21 Mar 2023 13:22:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1679365348;
        bh=HHMSDh3jfm30zmJyik4VAbKQJ/xml02l6zv5V7+dNQM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MPuoJiaFfYGUobzkCxvKgHTVhQPv0r371qensWmvBEIQo/FpT7VhR0Ix9sWGE6fbi
         BOwH8EoEaBkOyHsmG80CK26xnCF1oe723a3wSHBSko9uJ+ExgDMubsN7RSDDE33dkQ
         jaWpJ55gf5b55pHb3Oh6gLBV1pv/atmxKlgXrVKbXNLPECsBflaZMJQDQIGJx8EGle
         kZp4LqHzEcWX73O9v0d5FgadUZwYKsxxIkqtcZnZAexAg3eNi5pqahLBOPKFGD0Va2
         dyozlwZV1RLUY5o257UGyLCdJVmLPT+/2l2dBGpajkW0tN9HRdqLz2CA/4vk68fWzy
         n8ch1go0jLtQw==
Date:   Tue, 21 Mar 2023 13:22:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the sysctl tree with Linus' tree
Message-ID: <20230321132227.5f63cd43@canb.auug.org.au>
In-Reply-To: <20230321132052.7d12fd7d@canb.auug.org.au>
References: <20230321132052.7d12fd7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XETI10kzN24SewWHw37.h+X";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XETI10kzN24SewWHw37.h+X
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 21 Mar 2023 13:20:52 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the sysctl tree got a conflict in:
>=20
>   mm/memory-failure.c
>=20
> between commit:
>=20
>   44b8f8bf2438 ("mm: memory-failure: add memory failure stats to sysfs")
>=20
> from Linus' tree and commit:
>=20
>   cfe7e6ea5ee2 ("mm: memory-failure: Move memory failure sysctls to its o=
wn file")
>=20
> from the sysctl tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Sorry, I forgot the resolution - see below.
--=20
Cheers,
Stephen Rothwell

diff --cc mm/memory-failure.c
index f761704d27d7,242b6cae0035..000000000000
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@@ -87,41 -88,36 +88,71 @@@ inline void num_poisoned_pages_sub(unsi
  		memblk_nr_poison_sub(pfn, i);
  }
 =20
 +/**
 + * MF_ATTR_RO - Create sysfs entry for each memory failure statistics.
 + * @_name: name of the file in the per NUMA sysfs directory.
 + */
 +#define MF_ATTR_RO(_name)					\
 +static ssize_t _name##_show(struct device *dev,			\
 +			    struct device_attribute *attr,	\
 +			    char *buf)				\
 +{								\
 +	struct memory_failure_stats *mf_stats =3D			\
 +		&NODE_DATA(dev->id)->mf_stats;			\
 +	return sprintf(buf, "%lu\n", mf_stats->_name);		\
 +}								\
 +static DEVICE_ATTR_RO(_name)
 +
 +MF_ATTR_RO(total);
 +MF_ATTR_RO(ignored);
 +MF_ATTR_RO(failed);
 +MF_ATTR_RO(delayed);
 +MF_ATTR_RO(recovered);
 +
 +static struct attribute *memory_failure_attr[] =3D {
 +	&dev_attr_total.attr,
 +	&dev_attr_ignored.attr,
 +	&dev_attr_failed.attr,
 +	&dev_attr_delayed.attr,
 +	&dev_attr_recovered.attr,
 +	NULL,
 +};
 +
 +const struct attribute_group memory_failure_attr_group =3D {
 +	.name =3D "memory_failure",
 +	.attrs =3D memory_failure_attr,
 +};
 +
+ #ifdef CONFIG_SYSCTL
+ static struct ctl_table memory_failure_table[] =3D {
+ 	{
+ 		.procname	=3D "memory_failure_early_kill",
+ 		.data		=3D &sysctl_memory_failure_early_kill,
+ 		.maxlen		=3D sizeof(sysctl_memory_failure_early_kill),
+ 		.mode		=3D 0644,
+ 		.proc_handler	=3D proc_dointvec_minmax,
+ 		.extra1		=3D SYSCTL_ZERO,
+ 		.extra2		=3D SYSCTL_ONE,
+ 	},
+ 	{
+ 		.procname	=3D "memory_failure_recovery",
+ 		.data		=3D &sysctl_memory_failure_recovery,
+ 		.maxlen		=3D sizeof(sysctl_memory_failure_recovery),
+ 		.mode		=3D 0644,
+ 		.proc_handler	=3D proc_dointvec_minmax,
+ 		.extra1		=3D SYSCTL_ZERO,
+ 		.extra2		=3D SYSCTL_ONE,
+ 	},
+ };
+=20
+ static int __init memory_failure_sysctl_init(void)
+ {
+ 	register_sysctl_init("vm", memory_failure_table);
+ 	return 0;
+ }
+ late_initcall(memory_failure_sysctl_init);
+ #endif /* CONFIG_SYSCTL */
+=20
  /*
   * Return values:
   *   1:   the page is dissolved (if needed) and taken off from buddy,

--Sig_/XETI10kzN24SewWHw37.h+X
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQZFOMACgkQAVBC80lX
0Gx9Igf/ai+s0Ur/OAy0oPOuN4bKzvVH1rAMrgmqNgjMr3HcjZt1JHKIeAemo5AV
HPiSVe1MNIY2X4efAMc+HWByJGL3mEuvFhag+jV2pIPCRO/XKRZu1E+IDuG7VYdQ
TQdD2Ojfw5/6kOW9mpUQO8Rwb/6Sgxqrt5GR3pJmP/ZOWwrICm9SAGPN+85dt0Lu
lNk0a0paArM2AI/QHlR+/ckS7ePpK110G7Y1/WCTwoxbckIU72vFRrnIfPmd70un
8+quT/bLXkvdbyWZzzPbO4Z8pJcujBEu0Kb0+qBxdAZXZlDlu9StQqB2kLoON14h
1DSpijJ96o5Qh9WdwHAxPhG9WXDs+Q==
=YAqv
-----END PGP SIGNATURE-----

--Sig_/XETI10kzN24SewWHw37.h+X--
