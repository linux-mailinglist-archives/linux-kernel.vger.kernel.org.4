Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C528673088
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjASErM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbjASEqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 23:46:09 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B06237497F;
        Wed, 18 Jan 2023 20:42:06 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-4c24993965eso10673077b3.12;
        Wed, 18 Jan 2023 20:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tEL5q0gdvRQcXcMbCv9i2khmy9sVAvwANWZ5CU7Ktw8=;
        b=DdG+KDKzzl/Q10f5IwLdjJKtkg54MM38BjvhsBf4QA470iha1Z9YdIb7y+x5NJN+1z
         ER9Y/GetiKL0MhMUHpc5Z9FwVu8NU3vLs2OcEbLPnXXs3zlA3xCNx+P6a9D4ub1S4q5q
         T1OWL2zrXkyFrY4D4E3K0qcuZVwLk75OzrElTTvWyR9wBWZ5pblp21Cn+/jjmBKZAB0H
         IS/X91U5reo/5s8DRUaRxPD/ahxWJX2LA8bGZ35RQ46Bp62CKw0hrq0oKIPI3wM8PedS
         Z2boh2QjbYv7xh1TCpWyfiFCngGGWNbQbJ27HS9EP3jsWkzUh7B0Zij8bSmOUCnDDFk0
         V4FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEL5q0gdvRQcXcMbCv9i2khmy9sVAvwANWZ5CU7Ktw8=;
        b=rUpfy8QAD9AqoXZ2AK8zC+f/sxhVkgmjO/ns3vcI3cUUg8LSOAA8r/wZc+kYzaXYYZ
         6kdHZ1PiT+Io3vflwBUEmrfFgsmnN0XkYZt6+t92GqSXzAl7yeHqEKSA9C4SVHdw5Wuo
         jAa45F/TIMnwBkbiMTGXPoyOTYQ0xBUPOSfmeeJ69vk+49t/yKvfTtaypf32vLkNqtaE
         GqrhD93Ehsm260Ai8eJ1Cd0qH96HaEyQdSNt+zmkeFSPuTeSeF0J7oRgEWZhx8UYMNTc
         rqPkCijMdIUE+1yyaSdkWnBdQNO7xWSgLUcl0pwGADp4g1NKeBUQYEQTa1p/9XJveW/5
         SLLg==
X-Gm-Message-State: AFqh2kryovJzGFYS5GxqQna7r5tPWh64bQwTLSFcH/NTwk+Nqgh1rLDp
        TzjObhUhAX37JsspAf3oQgg=
X-Google-Smtp-Source: AMrXdXs3n9dYoZdp5en3XPTTghFRNT/V6cDPyp3Ke/b/VTPp7u+7tHub9LILE8A3rWVMFFHjd3c0HQ==
X-Received: by 2002:a17:902:7404:b0:194:97c8:84c3 with SMTP id g4-20020a170902740400b0019497c884c3mr9939488pll.66.1674101687091;
        Wed, 18 Jan 2023 20:14:47 -0800 (PST)
Received: from debian.me (subs03-180-214-233-1.three.co.id. [180.214.233.1])
        by smtp.gmail.com with ESMTPSA id j3-20020a170903028300b001886ff822ffsm444399plr.186.2023.01.18.20.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 20:14:46 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
        id 9C126104FA9; Thu, 19 Jan 2023 11:14:42 +0700 (WIB)
Date:   Thu, 19 Jan 2023 11:14:42 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        airlied@redhat.com, christian.koenig@amd.com, bskeggs@redhat.com,
        jason@jlekstrand.net, tzimmermann@suse.de, mripard@kernel.org,
        corbet@lwn.net
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH drm-next 03/14] drm: manager to keep track of GPUs VA
 mappings
Message-ID: <Y8jDsqGc5gXoIBAO@debian.me>
References: <20230118061256.2689-1-dakr@redhat.com>
 <20230118061256.2689-4-dakr@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="st4xfXKFTYFcRLrQ"
Content-Disposition: inline
In-Reply-To: <20230118061256.2689-4-dakr@redhat.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--st4xfXKFTYFcRLrQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 18, 2023 at 07:12:45AM +0100, Danilo Krummrich wrote:
> This adds the infrastructure for a manager implementation to keep track
> of GPU virtual address (VA) mappings.

"Add infrastructure for ..."

> + * Analogue to drm_gpuva_sm_map_ops_create() drm_gpuva_sm_unmap_ops_crea=
te()
> + * provides drivers a the list of operations to be executed in order to =
unmap
> + * a range of GPU VA space. The logic behind this functions is way simpl=
er
> + * though: For all existent mappings enclosed by the given range unmap
> + * operations are created. For mappings which are only partically locate=
d within
> + * the given range, remap operations are created such that those mapping=
s are
> + * split up and re-mapped partically.

"Analogous to ..."

> + *
> + * The following paragraph depicts the basic constellations of existent =
GPU VA
> + * mappings, a newly requested mapping and the resulting mappings as imp=
lemented
> + * by drm_gpuva_sm_map_ops_create()  - it doesn't cover arbitrary combin=
ations
> + * of those constellations.
> + *
> + * ::
> + *
> + *	1) Existent mapping is kept.
> + *	----------------------------
> + *
> + *	     0     a     1
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     a     1
> + *	req: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     a     1
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *
> + *	2) Existent mapping is replaced.
> + *	--------------------------------
> + *
> + *	     0     a     1
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     a     1
> + *	req: |-----------| (bo_offset=3Dm)
> + *
> + *	     0     a     1
> + *	new: |-----------| (bo_offset=3Dm)
> + *
> + *
> + *	3) Existent mapping is replaced.
> + *	--------------------------------
> + *
> + *	     0     a     1
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     b     1
> + *	req: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     b     1
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *
> + *	4) Existent mapping is replaced.
> + *	--------------------------------
> + *
> + *	     0  a  1
> + *	old: |-----|       (bo_offset=3Dn)
> + *
> + *	     0     a     2
> + *	req: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     a     2
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *	Note: We expect to see the same result for a request with a different=
 bo
> + *	      and/or bo_offset.
> + *
> + *
> + *	5) Existent mapping is split.
> + *	-----------------------------
> + *
> + *	     0     a     2
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	     0  b  1
> + *	req: |-----|       (bo_offset=3Dn)
> + *
> + *	     0  b  1  a' 2
> + *	new: |-----|-----| (b.bo_offset=3Dn, a.bo_offset=3Dn+1)
> + *
> + *	Note: We expect to see the same result for a request with a different=
 bo
> + *	      and/or non-contiguous bo_offset.
> + *
> + *
> + *	6) Existent mapping is kept.
> + *	----------------------------
> + *
> + *	     0     a     2
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	     0  a  1
> + *	req: |-----|       (bo_offset=3Dn)
> + *
> + *	     0     a     2
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *
> + *	7) Existent mapping is split.
> + *	-----------------------------
> + *
> + *	     0     a     2
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	           1  b  2
> + *	req:       |-----| (bo_offset=3Dm)
> + *
> + *	     0  a  1  b  2
> + *	new: |-----|-----| (a.bo_offset=3Dn,b.bo_offset=3Dm)
> + *
> + *
> + *	8) Existent mapping is kept.
> + *	----------------------------
> + *
> + *	      0     a     2
> + *	old: |-----------| (bo_offset=3Dn)
> + *
> + *	           1  a  2
> + *	req:       |-----| (bo_offset=3Dn+1)
> + *
> + *	     0     a     2
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *
> + *	9) Existent mapping is split.
> + *	-----------------------------
> + *
> + *	     0     a     2
> + *	old: |-----------|       (bo_offset=3Dn)
> + *
> + *	           1     b     3
> + *	req:       |-----------| (bo_offset=3Dm)
> + *
> + *	     0  a  1     b     3
> + *	new: |-----|-----------| (a.bo_offset=3Dn,b.bo_offset=3Dm)
> + *
> + *
> + *	10) Existent mapping is merged.
> + *	-------------------------------
> + *
> + *	     0     a     2
> + *	old: |-----------|       (bo_offset=3Dn)
> + *
> + *	           1     a     3
> + *	req:       |-----------| (bo_offset=3Dn+1)
> + *
> + *	     0        a        3
> + *	new: |-----------------| (bo_offset=3Dn)
> + *
> + *
> + *	11) Existent mapping is split.
> + *	------------------------------
> + *
> + *	     0        a        3
> + *	old: |-----------------| (bo_offset=3Dn)
> + *
> + *	           1  b  2
> + *	req:       |-----|       (bo_offset=3Dm)
> + *
> + *	     0  a  1  b  2  a' 3
> + *	new: |-----|-----|-----| (a.bo_offset=3Dn,b.bo_offset=3Dm,a'.bo_offse=
t=3Dn+2)
> + *
> + *
> + *	12) Existent mapping is kept.
> + *	-----------------------------
> + *
> + *	     0        a        3
> + *	old: |-----------------| (bo_offset=3Dn)
> + *
> + *	           1  a  2
> + *	req:       |-----|       (bo_offset=3Dn+1)
> + *
> + *	     0        a        3
> + *	old: |-----------------| (bo_offset=3Dn)
> + *
> + *
> + *	13) Existent mapping is replaced.
> + *	---------------------------------
> + *
> + *	           1  a  2
> + *	old:       |-----| (bo_offset=3Dn)
> + *
> + *	     0     a     2
> + *	req: |-----------| (bo_offset=3Dn)
> + *
> + *	     0     a     2
> + *	new: |-----------| (bo_offset=3Dn)
> + *
> + *	Note: We expect to see the same result for a request with a different=
 bo
> + *	      and/or non-contiguous bo_offset.
> + *
> + *
> + *	14) Existent mapping is replaced.
> + *	---------------------------------
> + *
> + *	           1  a  2
> + *	old:       |-----| (bo_offset=3Dn)
> + *
> + *	     0        a       3
> + *	req: |----------------| (bo_offset=3Dn)
> + *
> + *	     0        a       3
> + *	new: |----------------| (bo_offset=3Dn)
> + *
> + *	Note: We expect to see the same result for a request with a different=
 bo
> + *	      and/or non-contiguous bo_offset.
> + *
> + *
> + *	15) Existent mapping is split.
> + *	------------------------------
> + *
> + *	           1     a     3
> + *	old:       |-----------| (bo_offset=3Dn)
> + *
> + *	     0     b     2
> + *	req: |-----------|       (bo_offset=3Dm)
> + *
> + *	     0     b     2  a' 3
> + *	new: |-----------|-----| (b.bo_offset=3Dm,a.bo_offset=3Dn+2)
> + *
> + *
> + *	16) Existent mappings are merged.
> + *	---------------------------------
> + *
> + *	     0     a     1
> + *	old: |-----------|                        (bo_offset=3Dn)
> + *
> + *	                            2     a     3
> + *	old':                       |-----------| (bo_offset=3Dn+2)
> + *
> + *	                1     a     2
> + *	req:            |-----------|             (bo_offset=3Dn+1)
> + *
> + *	                      a
> + *	new: |----------------------------------| (bo_offset=3Dn)
> + */

Factor out lists from the big code block above:

---- >8 ----

diff --git a/drivers/gpu/drm/drm_gpuva_mgr.c b/drivers/gpu/drm/drm_gpuva_mg=
r.c
index e665f642689d03..411c0aa80bfa1f 100644
--- a/drivers/gpu/drm/drm_gpuva_mgr.c
+++ b/drivers/gpu/drm/drm_gpuva_mgr.c
@@ -129,15 +129,14 @@
  * the given range, remap operations are created such that those mappings =
are
  * split up and re-mapped partically.
  *
- * The following paragraph depicts the basic constellations of existent GP=
U VA
+ * The following diagram depicts the basic relationships of existent GPU VA
  * mappings, a newly requested mapping and the resulting mappings as imple=
mented
- * by drm_gpuva_sm_map_ops_create()  - it doesn't cover arbitrary combinat=
ions
- * of those constellations.
+ * by drm_gpuva_sm_map_ops_create()  - it doesn't cover any arbitrary
+ * combinations of these.
  *
- * ::
- *
- *	1) Existent mapping is kept.
- *	----------------------------
+ * 1) Existent mapping is kept.
+ *=20
+ *    ::
  *
  *	     0     a     1
  *	old: |-----------| (bo_offset=3Dn)
@@ -149,8 +148,9 @@
  *	new: |-----------| (bo_offset=3Dn)
  *
  *
- *	2) Existent mapping is replaced.
- *	--------------------------------
+ * 2) Existent mapping is replaced.
+ *
+ *    ::
  *
  *	     0     a     1
  *	old: |-----------| (bo_offset=3Dn)
@@ -162,8 +162,9 @@
  *	new: |-----------| (bo_offset=3Dm)
  *
  *
- *	3) Existent mapping is replaced.
- *	--------------------------------
+ * 3) Existent mapping is replaced.
+ *
+ *    ::
  *
  *	     0     a     1
  *	old: |-----------| (bo_offset=3Dn)
@@ -175,8 +176,9 @@
  *	new: |-----------| (bo_offset=3Dn)
  *
  *
- *	4) Existent mapping is replaced.
- *	--------------------------------
+ * 4) Existent mapping is replaced.
+ *
+ *    ::
  *
  *	     0  a  1
  *	old: |-----|       (bo_offset=3Dn)
@@ -187,12 +189,14 @@
  *	     0     a     2
  *	new: |-----------| (bo_offset=3Dn)
  *
- *	Note: We expect to see the same result for a request with a different bo
- *	      and/or bo_offset.
+ *    .. note::
+ *       We expect to see the same result for a request with a different bo
+ *       and/or bo_offset.
  *
  *
- *	5) Existent mapping is split.
- *	-----------------------------
+ * 5) Existent mapping is split.
+ *
+ *    ::
  *
  *	     0     a     2
  *	old: |-----------| (bo_offset=3Dn)
@@ -203,12 +207,14 @@
  *	     0  b  1  a' 2
  *	new: |-----|-----| (b.bo_offset=3Dn, a.bo_offset=3Dn+1)
  *
- *	Note: We expect to see the same result for a request with a different bo
- *	      and/or non-contiguous bo_offset.
+ *    .. note::
+ *       We expect to see the same result for a request with a different bo
+ *       and/or non-contiguous bo_offset.
  *
  *
- *	6) Existent mapping is kept.
- *	----------------------------
+ * 6) Existent mapping is kept.
+ *
+ *    ::
  *
  *	     0     a     2
  *	old: |-----------| (bo_offset=3Dn)
@@ -220,8 +226,9 @@
  *	new: |-----------| (bo_offset=3Dn)
  *
  *
- *	7) Existent mapping is split.
- *	-----------------------------
+ * 7) Existent mapping is split.
+ *
+ *    ::
  *
  *	     0     a     2
  *	old: |-----------| (bo_offset=3Dn)
@@ -233,8 +240,9 @@
  *	new: |-----|-----| (a.bo_offset=3Dn,b.bo_offset=3Dm)
  *
  *
- *	8) Existent mapping is kept.
- *	----------------------------
+ * 8) Existent mapping is kept.
+ *
+ *    ::
  *
  *	      0     a     2
  *	old: |-----------| (bo_offset=3Dn)
@@ -246,8 +254,9 @@
  *	new: |-----------| (bo_offset=3Dn)
  *
  *
- *	9) Existent mapping is split.
- *	-----------------------------
+ * 9) Existent mapping is split.
+ *
+ *    ::
  *
  *	     0     a     2
  *	old: |-----------|       (bo_offset=3Dn)
@@ -259,104 +268,113 @@
  *	new: |-----|-----------| (a.bo_offset=3Dn,b.bo_offset=3Dm)
  *
  *
- *	10) Existent mapping is merged.
- *	-------------------------------
+ * 10) Existent mapping is merged.
  *
- *	     0     a     2
- *	old: |-----------|       (bo_offset=3Dn)
+ *     ::
  *
- *	           1     a     3
- *	req:       |-----------| (bo_offset=3Dn+1)
+ *	      0     a     2
+ *	 old: |-----------|       (bo_offset=3Dn)
  *
- *	     0        a        3
- *	new: |-----------------| (bo_offset=3Dn)
+ *	            1     a     3
+ *	 req:       |-----------| (bo_offset=3Dn+1)
+ *
+ *	      0        a        3
+ *	 new: |-----------------| (bo_offset=3Dn)
  *
  *
- *	11) Existent mapping is split.
- *	------------------------------
+ * 11) Existent mapping is split.
  *
- *	     0        a        3
- *	old: |-----------------| (bo_offset=3Dn)
+ *     ::
  *
- *	           1  b  2
- *	req:       |-----|       (bo_offset=3Dm)
+ *	      0        a        3
+ *	 old: |-----------------| (bo_offset=3Dn)
  *
- *	     0  a  1  b  2  a' 3
- *	new: |-----|-----|-----| (a.bo_offset=3Dn,b.bo_offset=3Dm,a'.bo_offset=
=3Dn+2)
+ *	            1  b  2
+ *	 req:       |-----|       (bo_offset=3Dm)
+ *
+ *	      0  a  1  b  2  a' 3
+ *	 new: |-----|-----|-----| (a.bo_offset=3Dn,b.bo_offset=3Dm,a'.bo_offset=
=3Dn+2)
  *
  *
- *	12) Existent mapping is kept.
- *	-----------------------------
+ * 12) Existent mapping is kept.
  *
- *	     0        a        3
- *	old: |-----------------| (bo_offset=3Dn)
+ *     ::
  *
- *	           1  a  2
- *	req:       |-----|       (bo_offset=3Dn+1)
+ *	      0        a        3
+ *	 old: |-----------------| (bo_offset=3Dn)
  *
- *	     0        a        3
- *	old: |-----------------| (bo_offset=3Dn)
+ *	            1  a  2
+ *	 req:       |-----|       (bo_offset=3Dn+1)
+ *
+ *	      0        a        3
+ *	 old: |-----------------| (bo_offset=3Dn)
  *
  *
- *	13) Existent mapping is replaced.
- *	---------------------------------
+ * 13) Existent mapping is replaced.
  *
- *	           1  a  2
- *	old:       |-----| (bo_offset=3Dn)
+ *     ::
  *
- *	     0     a     2
- *	req: |-----------| (bo_offset=3Dn)
+ *	            1  a  2
+ *	 old:       |-----| (bo_offset=3Dn)
  *
- *	     0     a     2
- *	new: |-----------| (bo_offset=3Dn)
+ *	      0     a     2
+ *	 req: |-----------| (bo_offset=3Dn)
  *
- *	Note: We expect to see the same result for a request with a different bo
- *	      and/or non-contiguous bo_offset.
+ *	      0     a     2
+ *	 new: |-----------| (bo_offset=3Dn)
+ *
+ *     .. note::
+ *        We expect to see the same result for a request with a different =
bo
+ *        and/or non-contiguous bo_offset.
  *
  *
- *	14) Existent mapping is replaced.
- *	---------------------------------
+ * 14) Existent mapping is replaced.
  *
- *	           1  a  2
- *	old:       |-----| (bo_offset=3Dn)
+ *     ::
  *
- *	     0        a       3
- *	req: |----------------| (bo_offset=3Dn)
+ *	            1  a  2
+ *	 old:       |-----| (bo_offset=3Dn)
  *
- *	     0        a       3
- *	new: |----------------| (bo_offset=3Dn)
+ *	      0        a       3
+ *	 req: |----------------| (bo_offset=3Dn)
  *
- *	Note: We expect to see the same result for a request with a different bo
- *	      and/or non-contiguous bo_offset.
+ *	      0        a       3
+ *	 new: |----------------| (bo_offset=3Dn)
+ *
+ *     .. note::
+ *        We expect to see the same result for a request with a different =
bo
+ *        and/or non-contiguous bo_offset.
  *
  *
- *	15) Existent mapping is split.
- *	------------------------------
+ * 15) Existent mapping is split.
  *
- *	           1     a     3
- *	old:       |-----------| (bo_offset=3Dn)
+ *     ::
  *
- *	     0     b     2
- *	req: |-----------|       (bo_offset=3Dm)
+ *	            1     a     3
+ *	 old:       |-----------| (bo_offset=3Dn)
  *
- *	     0     b     2  a' 3
- *	new: |-----------|-----| (b.bo_offset=3Dm,a.bo_offset=3Dn+2)
+ *	      0     b     2
+ *	 req: |-----------|       (bo_offset=3Dm)
+ *
+ *	      0     b     2  a' 3
+ *	 new: |-----------|-----| (b.bo_offset=3Dm,a.bo_offset=3Dn+2)
  *
  *
- *	16) Existent mappings are merged.
- *	---------------------------------
+ * 16) Existent mappings are merged.
  *
- *	     0     a     1
- *	old: |-----------|                        (bo_offset=3Dn)
+ *     ::
  *
- *	                            2     a     3
- *	old':                       |-----------| (bo_offset=3Dn+2)
+ *	      0     a     1
+ *	 old: |-----------|                        (bo_offset=3Dn)
  *
- *	                1     a     2
- *	req:            |-----------|             (bo_offset=3Dn+1)
+ *	                             2     a     3
+ *	 old':                       |-----------| (bo_offset=3Dn+2)
  *
- *	                      a
- *	new: |----------------------------------| (bo_offset=3Dn)
+ *	                 1     a     2
+ *	 req:            |-----------|             (bo_offset=3Dn+1)
+ *
+ *	                       a
+ *	 new: |----------------------------------| (bo_offset=3Dn)
  */
=20
 /**

However, the relationship scenario descriptions are too generic (different
diagrams are described by the same text). Please rewrite them, taking into
account bo_offset values in each scenario.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--st4xfXKFTYFcRLrQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCY8jDrQAKCRD2uYlJVVFO
oyc5AQDzS32MPEoI8XEnJ+yGcruwTqG4VgFpXjQO6ybbNI0oaAD/cDphbOXxvq0A
nY3OKSukKaxO8u18WTRGbGOfkLvASA0=
=bBlm
-----END PGP SIGNATURE-----

--st4xfXKFTYFcRLrQ--
