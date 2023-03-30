Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45D56CFA2E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 06:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjC3E15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 00:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjC3E1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 00:27:55 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2199C49D8;
        Wed, 29 Mar 2023 21:27:53 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id kc4so16940162plb.10;
        Wed, 29 Mar 2023 21:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680150472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1U9hRJb89Ko+9M6v6pJAp28XNpi16VYv1bAP4awuv0g=;
        b=LIgQ14kRBiNS1bRbv5v25/KuQ/PArb3SXrTw6ysSwLa9pyG1xvTYw8rhkQt0tW+q+Z
         9YBaZAZCopHQg0DB7qPA2tM96IW7mmvTKEa1jRzz6+KDh4CQhfFn7QNIRZSGNzXzjFjp
         IIQe8RthM0YhPT/SMqM2uVZQG3Mf5LR+PtvDZsaZdFi1DdSrzgeem4xYc2Pjj7btWRiy
         JHLm5lJPpUEH1Z3iVYyWufnuRaJOD4zd/vojI8FYOGyo5JkMXkGCtq9jNFmPiDA2v5Re
         N7vu0ho1MKdOtye2g7G7XoNdVOi4bPGJe69dLeBoK7jHNGz923ry5kwni3H8xOOfTRQA
         z7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680150472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1U9hRJb89Ko+9M6v6pJAp28XNpi16VYv1bAP4awuv0g=;
        b=xZO6zLAEbrlzy/CGSCLGInBP3ATEunVuCZkWbiWGyrKqxe2xnTnsSeYPpPJYSahRsX
         NzRPcjmXRjjHOFBT8p1WVUKqcM4hhvwQ4NgkUH59RLTu9t3Qbp9vIrQa9GNTmXv1dTEV
         DNNbN8Kl3XM4Av3/TdSlTlJcMI0obx9Ffkc1cv05qEflYv86YHIHYSrTXWj15+uM6s/z
         IM1TDlTEME7ckM1r1OKMeH5/ccdg8o2I7S+2k9IEY9Lp7XPFdWW6X0cDNQBhzstXSpEy
         6iUfED+RWmw49HhaybHeCu3iJP5n7cg0N6p1HIlsWHpfN2yhy8BSTz1oZTy5FkcEBXqq
         fD8A==
X-Gm-Message-State: AAQBX9ehdzt3XjmMXlY6GN620q6BpwjbyPb+VIagazYelNGGl0wKS3gd
        N1uf802Cg+XAVEJthiP6MVg=
X-Google-Smtp-Source: AKy350bUMcUm7OdolOcWYu5kDPquWvi2jXfjzFNmcp9lbP9AVHR+B2cSCowNhA5w6gvFCIeYfCmr/Q==
X-Received: by 2002:a17:902:e88e:b0:19d:ee88:b4d7 with SMTP id w14-20020a170902e88e00b0019dee88b4d7mr26613416plg.25.1680150472557;
        Wed, 29 Mar 2023 21:27:52 -0700 (PDT)
Received: from debian.me (subs02-180-214-232-71.three.co.id. [180.214.232.71])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902c1cd00b0019f2328bef8sm23800979plc.34.2023.03.29.21.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 21:27:51 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 7D71F10672E; Thu, 30 Mar 2023 11:27:48 +0700 (WIB)
Date:   Thu, 30 Mar 2023 11:27:48 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Feng Tang <feng.tang@intel.com>, Jonathan Corbet <corbet@lwn.net>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnaldo Carvalho de Melo <acme@redhat.com>,
        Joe Mario <jmario@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Shakeel Butt <shakeelb@google.com>, dave.hansen@intel.com,
        ying.huang@intel.com, tim.c.chen@intel.com, andi.kleen@intel.com
Subject: Re: [PATCH v2] Documentation: Add document for false sharing
Message-ID: <ZCUPxMQPJ8ETvUbM@debian.me>
References: <20230329073322.323177-1-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+bc6jzHwCokGdRls"
Content-Disposition: inline
In-Reply-To: <20230329073322.323177-1-feng.tang@intel.com>
X-Spam-Status: No, score=1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+bc6jzHwCokGdRls
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 29, 2023 at 03:33:22PM +0800, Feng Tang wrote:
> +False sharing hurting performance cases are seen more frequently with
> +core count increasing.  Because of these detrimental effects, many
> +patches have been proposed across variety of subsystems (like
> +networking and memory management) and merged.  Some common mitigations
> +(with examples) are:
> +
> +* Separate hot global data in its own dedicated cache line, even if it
> +  is just a 'short' type. The downside is more consumption of memory,
> +  cache line and TLB entries.
> +
> +  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_soc=
kets_allocated")
> +
> +* Reorganize the data structure, separate the interfering members to
> +  different cache lines.  One downside is it may introduce new false
> +  sharing of other members.
> +
> +  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduc=
e false sharing")
> +
> +* Replace 'write' with 'read' when possible, especially in loops.
> +  Like for some global variable, use compare(read)-then-write instead
> +  of unconditional write. For example, use::
> +
> +	if (!test_bit(XXX))
> +		set_bit(XXX);
> +
> +  instead of directly "set_bit(XXX);", similarly for atomic_t data.
"... The similar technique is also applicable to atomic_t data".

But how?

> +
> +  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() m=
ultithreaded CPU false sharing")
> +  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
> +
> +* Turn hot global data to 'per-cpu data + global data' when possible,
> +  or reasonably increase the threshold for syncing per-cpu data to
> +  global data, to reduce or postpone the 'write' to that global data.
> +
> +  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status ca=
che hits/misses")
> +  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to =
vm overcommit policy")
> +

Here's what I mean by bridging conjunctions to example commits as I reviewed
in v1 [1]:

---- >8 ----
diff --git a/Documentation/kernel-hacking/false-sharing.rst b/Documentation=
/kernel-hacking/false-sharing.rst
index ceeaf20290eabd..3b08f6f16d442e 100644
--- a/Documentation/kernel-hacking/false-sharing.rst
+++ b/Documentation/kernel-hacking/false-sharing.rst
@@ -141,19 +141,18 @@ False sharing hurting performance cases are seen more=
 frequently with
 core count increasing.  Because of these detrimental effects, many
 patches have been proposed across variety of subsystems (like
 networking and memory management) and merged.  Some common mitigations
-(with examples) are:
+are:
=20
 * Separate hot global data in its own dedicated cache line, even if it
   is just a 'short' type. The downside is more consumption of memory,
-  cache line and TLB entries.
-
-  - Commit 91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_socke=
ts_allocated")
+  cache line and TLB entries. The example implentation is in commit
+  91b6d3256356 ("net: cache align tcp_memory_allocated, tcp_sockets_alloca=
ted").
=20
 * Reorganize the data structure, separate the interfering members to
   different cache lines.  One downside is it may introduce new false
-  sharing of other members.
-
-  - Commit 802f1d522d5f ("mm: page_counter: re-layout structure to reduce =
false sharing")
+  sharing of other members. How it is done is illustrated by commit
+  802f1d522d5f ("mm: page_counter: re-layout structure to reduce false
+  sharing").
=20
 * Replace 'write' with 'read' when possible, especially in loops.
   Like for some global variable, use compare(read)-then-write instead
@@ -163,16 +162,21 @@ networking and memory management) and merged.  Some c=
ommon mitigations
 		set_bit(XXX);
=20
   instead of directly "set_bit(XXX);", similarly for atomic_t data.
+  Example commits are:
=20
-  - Commit 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() mul=
tithreaded CPU false sharing")
-  - Commit 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
+  - 7b1002f7cfe5 ("bcache: fixup bcache_dev_sectors_dirty_add() multithrea=
ded
+    CPU false sharing")
+  - 292648ac5cf1 ("mm: gup: allow FOLL_PIN to scale in SMP")
=20
 * Turn hot global data to 'per-cpu data + global data' when possible,
   or reasonably increase the threshold for syncing per-cpu data to
   global data, to reduce or postpone the 'write' to that global data.
+  Examples are in commits:
=20
-  - Commit 520f897a3554 ("ext4: use percpu_counters for extent_status cach=
e hits/misses")
-  - Commit 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm=
 overcommit policy")
+  - 520f897a3554 ("ext4: use percpu_counters for extent_status cache
+    hits/misses")
+  - 56f3547bfa4d ("mm: adjust vm_committed_as_batch according to vm overco=
mmit
+    policy")
=20
 Surely, all mitigations should be carefully verified to not cause side
 effects.  And to avoid false sharing in advance during coding, it's

Thanks.

[1]: https://lore.kernel.org/linux-doc/ZB2baIDIPhxj5Vdl@debian.me/

--=20
An old man doll... just what I always wanted! - Clara

--+bc6jzHwCokGdRls
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZCUPvwAKCRD2uYlJVVFO
o6ngAQCe45mznyyZlyy4uLSGqihng7Df4U/iJd9SjCZBs5/2+gD9Ei5+SL30Pf4H
NOpggsvX5sBAmHridg0qrx79tLN/pQE=
=WQq6
-----END PGP SIGNATURE-----

--+bc6jzHwCokGdRls--
