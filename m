Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1066D6F6262
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 02:37:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjEDAhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 20:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjEDAhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 20:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E434138
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 17:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3431862824
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32931C433D2;
        Thu,  4 May 2023 00:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683160641;
        bh=o+DrfImxy5HZeqKr+NFuD5e3O4ohZgxyH+dr5yW6U2g=;
        h=Date:From:To:Cc:Subject:From;
        b=Tcc+EouqCxJAnk5hXotUS1JjMfHMtUazb+lvK5zdDKh25yTEDw6fvUjbKsUkqymO3
         PLuTUi6qgGvAaBkBTKMJJ0dFrXmxq/fGyHo3XSo71JKJMjkLNqsCRhzE/vHhEAqjCf
         mzQNXUtQskS+JwbuZNfNu/z36GYH8Up1rxZLsdOcVLh1aexqImI1s9DAe2q/nK6wU0
         1d9sVfDRowXgXbfvnX5hDLB98yD82vZ30ZQuuvLqJozYbPpSrY1VW4HHYeZdsJxEuT
         O0QyzdrmYF/kJ+NiHwDplkqey1Z/S3+5jNVBCMw/45HBK0RhOV8c/2KVHg2cAU2YXa
         DdvZY21h7+LPA==
Date:   Thu, 4 May 2023 00:37:18 +0000
From:   Eric Van Hensbergen <ericvh@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     v9fs@lists.linux.dev, v9fs-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p patches for 6.4 merge window
Message-ID: <ZFL+Pg3IGWeLsQOo@7e9e31583646>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rIx30bTc8oq0MPoy"
Content-Disposition: inline
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rIx30bTc8oq0MPoy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ericvh/v9fs.git tags/9p-6.4-for-linus

for you to fetch changes up to 21e26d5e54ab7cfe6b488fd27d4d70956d07e03b:

  fs/9p: Fix bit operation logic error (2023-04-28 16:59:26 +0000)

----------------------------------------------------------------
9p patches for 6.4 merge window

This pull request includes a number of patches that didn't quite make
the cut last merge window while we addressed some outstanding issues
and review comments.  It includes some new caching modes for those that
only want readahead caches and reworks how we do writeback caching so we
are not keeping extra references around which both causes performance problems
and uses lots of additional resources on the server.

It also includes a new flag to force disabling of xattrs which can also
cause major performance issues, particularly if the underlying filesystem
on the server doesn't support them.

Finally it adds a couple of additional mount options to better support
directio and enabling caches when the server doesn't support qid.version.

There was one late-breaking bug report that has also been included as its
own patch where I forgot to propagate an embarassing bit-logic fix to the
various variations of open.  Since that was only added to for-next a week
ago, if you would like to not include it, I can include it in the first
round of fixes for -rc2.

Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>

----------------------------------------------------------------
Eric Van Hensbergen (8):
      fs/9p: Consolidate file operations and add readahead and writeback
      fs/9p: Remove unnecessary superblock flags
      fs/9p: allow disable of xattr support on mount
      9p: Add additional debug flags and open modes
      fs/9p: Add new mount modes
      fs/9p: remove writeback fid and fix per-file modes
      fs/9p: Rework cache modes and add new options to Documentation
      fs/9p: Fix bit operation logic error

 Documentation/filesystems/9p.rst |  52 +++++++++++++++++++++++++++++++++++++++-------------
 fs/9p/cache.h                    |   3 +--
 fs/9p/fid.c                      |  48 +++++++++++++++++++-----------------------------
 fs/9p/fid.h                      |  31 ++++++++++++++++++++++++++++++-
 fs/9p/v9fs.c                     |  59 +++++++++++++++++++++++++++++++----------------------------
 fs/9p/v9fs.h                     |  62 +++++++++++++++++++++++++++++++++++++++++++-------------------
 fs/9p/v9fs_vfs.h                 |   4 ----
 fs/9p/vfs_addr.c                 |  50 ++++++++++++++++++++++++++++----------------------
 fs/9p/vfs_dir.c                  |  10 +++++++---
 fs/9p/vfs_file.c                 | 206 ++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------------------------------------------------------------------------------------------------------------------
 fs/9p/vfs_inode.c                | 111 +++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------------------------------------
 fs/9p/vfs_inode_dotl.c           |  90 +++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------------
 fs/9p/vfs_super.c                |  44 ++++++++++++--------------------------------
 include/net/9p/9p.h              |   6 ++++++
 net/9p/client.c                  |   8 ++++----
 15 files changed, 368 insertions(+), 416 deletions(-)


--rIx30bTc8oq0MPoy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEElpbw0ZalkJikytFRiP/V+0pf/5gFAmRS/j4ACgkQiP/V+0pf
/5gEcw//carKAhsy2/af+dEB1Sz2Za+kIABVtto7Sw0bb55FJ21jOw527T/5SNiO
qoPS+sWKY53Dj6DxJkiUbEJY/wjOxnBLl3LAjS26cpxQ/7Nu/7OjRPVRDPdl36L7
2bNcM+bMAzFqnbfT1o/OVX8jXN6nbgRarXt9HS/QlseMBGVPEoTRK6jxttQSz7WI
y807C+yts6uRvQQqlt9GjMliudPw3nNzv/56tbEJN783jxjmaoowgPd61FANAHhS
Rmn+LTfkYsiU9VHkB535SDb2ih8yk+6zRMmsZUjGjLQDH15/RK1ZuC+jElibV7in
5K4oh+hK/3BGzZfXWJ68Fx+C24dkiYG2om9h+9AxLSbhOs8hPGpT40ML70c8PtDv
zWFEJzocZN8nqj0AxEi29OH/boaU8Jp9lPaCl2d+EBrM5ft5pD2IlGh4jIDAKlV7
k4tM7Dogk8beqozz02OETQR3YeWLoaPIFcAwAxph5uzqrcGHernRYYOVZh4QgC8y
37anaHDxuHHmeVa4HI/VvfkUV/MmOha5lxA6lKvMjkspmL0ZmqmkmBnSvjgeV6yJ
e+GVRb0MK98H2UvdizJzd+EWuGB7+7FIshfXPY+DTZR8r6jSsW6LQrPQvCN5Hl69
awXnPJJGq9rP68aOwpoCpMwA7YnskKD1d6QEZ7hvNoF7BDAXYYw=
=5L3B
-----END PGP SIGNATURE-----

--rIx30bTc8oq0MPoy--
