Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE10741098
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjF1L63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjF1L61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:58:27 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C2C42D58
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 04:58:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 400551F8BE;
        Wed, 28 Jun 2023 11:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687953505; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=4PSVKdu4YuaaVmLrTx0BPSZzxS2JnYjY0dV5S923kiM=;
        b=aIM01k+yK19D1teR8x8GIyL5TFqv1lJ/XoNhaPPGWK7SKM+kstIO7nMM4Dk20RxDNzXjI6
        W7ypUMoQmKB7PJNOpk1Y49qgPv+b/oEy0jtruo8SUJ0WbbEBe6jCM+PWba+Z0SH0vaqMAL
        1CfoOmwisMw5zqjsysndGjeqHPCjGVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687953505;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type;
        bh=4PSVKdu4YuaaVmLrTx0BPSZzxS2JnYjY0dV5S923kiM=;
        b=ZrMfCCgMLF17te0E21j61dnQADqRuqXWxlDM+a/pkz7ZJ/91u7OCKZXWQ3D6jfVYQ3VwTn
        1Qg3VdEAqASvvbDw==
Received: from lion.mk-sys.cz (unknown [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2FF0A2C308;
        Wed, 28 Jun 2023 11:58:25 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 0A69A608BE; Wed, 28 Jun 2023 13:58:25 +0200 (CEST)
Date:   Wed, 28 Jun 2023 13:58:25 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: build failure after commit eb0481bbc4ce ("objtool: Fix reloc_hash
 size")
Message-ID: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3snxz4aqmzhc3ifr"
Content-Disposition: inline
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3snxz4aqmzhc3ifr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

this morning, mainline kernel builds started to fail on my desktop like
this:

  mike@lion:~/work/git/kernel-upstream> mkdir /srv/ram/kobj
  mike@lion:~/work/git/kernel-upstream> make -j24 CC=gcc-13 O=/srv/ram/kobj defconfig >/dev/null
  mike@lion:~/work/git/kernel-upstream> make -j24 CC=gcc-13 O=/srv/ram/kobj all >/dev/null
  net/ipv4/netfilter/iptable_nat.o: warning: objtool: mmap fail reloc
  net/netfilter/xt_mark.o: warning: objtool: mmap fail reloc
  net/netfilter/xt_nat.o: warning: objtool: mmap fail reloc
  net/netfilter/xt_LOG.o: warning: objtool: mmap fail reloc
  net/netfilter/xt_MASQUERADE.o: warning: objtool: mmap fail reloc
  net/netfilter/nf_log_syslog.o: warning: objtool: mmap fail reloc
  net/netfilter/xt_addrtype.o: warning: objtool: mmap fail reloc
  fs/efivarfs/efivarfs.o: warning: objtool: mmap fail reloc
  drivers/thermal/intel/x86_pkg_temp_thermal.o: warning: objtool: mmap fail reloc
  vmlinux.o: warning: objtool: mmap fail reloc
  incomplete ORC unwind tables in file: vmlinux
  Failed to sort kernel tables
  make[2]: *** [/home/mike/work/git/kernel-upstream/scripts/Makefile.vmlinux:35: vmlinux] Error 1
  make[2]: *** Deleting file 'vmlinux'
  make[1]: *** [/home/mike/work/git/kernel-upstream/Makefile:1256: vmlinux] Error 2
  make: *** [Makefile:226: __sub-make] Error 2

I bisected the failure to commit

  eb0481bbc4ce ("objtool: Fix reloc_hash size")

I also tried gcc11 and building on a normal filesystem (rather than
tmpfs) but the result is still the same. Different configurations (e.g.
allmodconfig) only show more modules with "mmap fail reloc". The machine
has 64 GB of RAM and both ulimit -m and ulimit -v show "unlimited".
Anything idea what else I should try?

Michal Kubecek

--3snxz4aqmzhc3ifr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmScIFsACgkQ538sG/LR
dpWQuQf+PBePIZXxMKsWjYF/i2iLyU6pZ7ikh/MOofFyEnXhIQgJqpzSQrazizrV
b+O9iOk1BhCkP4ifRhCtDr34oTzumNSsn0auFpmaZkKSmsiyTTIAk7h9Zduyf8Z0
zslVfZr3r7aT0BewZNuqe5Z8f+Lg/q25zUEeWyEQqyI99k65aOUfrR2AcrZVviZZ
c1gKCSsqlfeYeQ6m0uG+/jy81JE5Hq3bw0/bxH9jsZ3qpJMWsk7XLK3V6j1IwSzQ
nQyrnkEBX/0aiQwS46PxITak+vU9spVcuBZSH3mjHS9caEPbfXZFtbw49qXGjEqz
D/aVD62o18cs9Xf2cQ2zojAtxPdEuQ==
=cuf2
-----END PGP SIGNATURE-----

--3snxz4aqmzhc3ifr--
