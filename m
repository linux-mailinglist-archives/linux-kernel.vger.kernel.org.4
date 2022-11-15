Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9831062AD9D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 23:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238130AbiKOWEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 17:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238363AbiKOWET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 17:04:19 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1112496B;
        Tue, 15 Nov 2022 14:04:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4NBgDz563Wz4xDK;
        Wed, 16 Nov 2022 09:04:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1668549844;
        bh=9AEMdOzc8tdMtvvnfetC34mjCGufm6r2F9K70yef6Nk=;
        h=Date:From:To:Cc:Subject:From;
        b=fhQmShV1muPFZYmYDk5gZ5yleXnCblyIl+t4kVxHCZeCXnF8oj+kLYaTf6DFMJn+a
         AED8sXMaQb4XKmTMgYzyRj9NWSvYK8I4H9QbG/tU1Sao6kIFSCI6M7wprlYUIAmEdL
         HXkawqZobPD2YVWJI2Ihlkq2iVf2RzXQqkvWclWypOr165F7eo8hymK8KN85YHfx8f
         2Oz7fg7OLCkbqYv5GHTpeGSGMusbmwXZ20DjOPiX5DL1MqeuQQXphpCh0eExXXTwu0
         F+McdwgUAe93oC/CA2vr6BCLEPXbFeGpo7j7cLgI7S1VwaIqIr7XeFohzHASVZ+rYX
         oHdUeae6rwi+w==
Date:   Wed, 16 Nov 2022 09:04:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the arm64 tree
Message-ID: <20221116090401.0cd5ccc7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/36dHDFHuE3kPA_fGIIKtC0/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/36dHDFHuE3kPA_fGIIKtC0/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the arm64 tree, today's linux-next build (x86_64
allmodconfig) failed like this:

drivers/perf/arm_cspmu/arm_cspmu.c: In function 'arm_cspmu_get_cpus':
drivers/perf/arm_cspmu/arm_cspmu.c:1114:29: error: implicit declaration of =
function 'get_acpi_id_for_cpu' [-Werror=3Dimplicit-function-declaration]
 1114 |                             get_acpi_id_for_cpu(cpu)) {
      |                             ^~~~~~~~~~~~~~~~~~~

Caused by commit

  e37dfd65731d ("perf: arm_cspmu: Add support for ARM CoreSight PMU driver")

I have used the arm64 tree from next-20221115 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/36dHDFHuE3kPA_fGIIKtC0/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmN0DNEACgkQAVBC80lX
0Gynggf/Y4H4Pvz2464pQlLXSKGPNg+e6KqU9/QhAfAybxTlFvbJMNthH/RZ44Bp
rncnCTHfOcCAqSCsewFrMBEFc7KEX+Dp24G8YXapmULY4GirNFeB+Zc1EtxhFePE
8jYP+BGmD4jrj3hswo+0dB5xzr7fzP3AAOIheOCSMa1cOiZaZ7hk0avmLYAV0u4q
xVY7HuijVJVE+t/XqaNsPmGrgEL5oRQ6jghYcPj+Txg7utBnL+lq+KpCZB9cez8G
q8H5slmKwFtzDO9dBz8IQi9spTmtR9Hh4WCSMM/XYEwVvfOyVwKM/qinI9BwpYIH
rUuurNa/9VPp7hD+MsMycjA+Ss6yRA==
=2rjn
-----END PGP SIGNATURE-----

--Sig_/36dHDFHuE3kPA_fGIIKtC0/--
