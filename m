Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1CF7283E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237124AbjFHPnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237114AbjFHPnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:43:19 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52A432718
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:43:18 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E8E5E3F466
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686238995;
        bh=syV5HaxadzVX4WovEx170zRO/U/ZlS3A/61NcNcDyQ0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=SvDszGtLnhkHNaIKHifRgzaTuDRAbEwjcgXd6A8neypAHSlB5C1k6AhlSiFbbnnh1
         qfZgpHQkTQgr5WuguTf9cyUGvaPsot592v26/eLreP7uWZaIcCsRU8StkUmcBMLdw5
         B/YtRoNAhjQB4RPnM46reqqWFQdhXyQK7TjQkL+dA/J67SShMmMbl0QJ1Krpwf9/+2
         3EgGXKr2jM5eJcZqYWUTZ6lx5ieJPmVQkcpusA9UCgiBN/+gdYICKdaD/4t3E2qRqo
         jX23luJc/rlIKHPToi9LAYOOKJ6FF9wsIRB0ZdavjogO/OJ1e398ktQ+ATBPsLv96K
         VSsSEIrPYbDFw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-51566dc6066so757255a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 08:43:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686238993; x=1688830993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=syV5HaxadzVX4WovEx170zRO/U/ZlS3A/61NcNcDyQ0=;
        b=l59ijhPNf/eKrem0Gn3fUnZHOImXUfIFHhJ577K43hKDlf+YfmUrRyfFqdDJI1+0zD
         qc1BwKGBhnvwlJ1LDv7Hy1FbV7qiQrL9KtXy/J6si5+wRQl2jIy2ikzK+6NJwrI2wClz
         fWh1BNi+1/dkszp92Lsu+Qb8e5brlwiEbZBHNriWeqqPqPbhEKOyhVvK1U4sYuie8Q4B
         pPoEyKlZu+i9sj7sJ9j8iUgbPCoDbErVwir2IWwJcc7fG+P4OBDr0AnGSLS2Mwg70Gw0
         wA3n4ePVuTRAhQfE9ZJD5tiHqRZlMJsyFsDLXma9JR7AiMzbb/6h90FPGgudqBzRUFDZ
         6Vjg==
X-Gm-Message-State: AC+VfDyYDDFBbfm+q6sC+f9QR0UacO0HIJC2TeRdVrmBnZ5J+DF00RMH
        Oqrd44X3pJa1+/N5iM6baXF+YWWpNUdma+wD9A9TI34Eq5dOg9MrNHOd5hhJvIWKuUXLzZuanBA
        GbGtpJ8gQzAiOv7ISX1wNN6mP9JrbZC9A1QQrASi3JRznkbf4jg==
X-Received: by 2002:aa7:cfc8:0:b0:514:b1d6:d37f with SMTP id r8-20020aa7cfc8000000b00514b1d6d37fmr7721994edy.19.1686238993342;
        Thu, 08 Jun 2023 08:43:13 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lGm9L8z4YDDL2kvecwJoQh9lLjIraoOWEV4/1L2E1amdrCtmpK/U5m366rjL5caORy4NspA==
X-Received: by 2002:aa7:cfc8:0:b0:514:b1d6:d37f with SMTP id r8-20020aa7cfc8000000b00514b1d6d37fmr7721982edy.19.1686238993055;
        Thu, 08 Jun 2023 08:43:13 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id y8-20020aa7c248000000b005164ae1c482sm678387edo.11.2023.06.08.08.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 08:43:12 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 00/14] ceph: support idmapped mounts
Date:   Thu,  8 Jun 2023 17:42:41 +0200
Message-Id: <20230608154256.562906-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear friends,

This patchset was originally developed by Christian Brauner but I'll continue
to push it forward. Christian allowed me to do that :)

This feature is already actively used/tested with LXD/LXC project.

Git tree (based on https://github.com/ceph/ceph-client.git master):
v5: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v5
current: https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph

In the version 3 I've changed only two commits:
- fs: export mnt_idmap_get/mnt_idmap_put
- ceph: allow idmapped setattr inode op
and added a new one:
- ceph: pass idmap to __ceph_setattr

In the version 4 I've reworked the ("ceph: stash idmapping in mdsc request")
commit. Now we take idmap refcounter just in place where req->r_mnt_idmap
is filled. It's more safer approach and prevents possible refcounter underflow
on error paths where __register_request wasn't called but ceph_mdsc_release_request is
called.

Changelog for version 5:
- a few commits were squashed into one (as suggested by Xiubo Li)
- started passing an idmapping everywhere (if possible), so a caller
UID/GID-s will be mapped almost everywhere (as suggested by Xiubo Li)

I can confirm that this version passes xfstests.

Links to previous versions:
v1: https://lore.kernel.org/all/20220104140414.155198-1-brauner@kernel.org/
v2: https://lore.kernel.org/lkml/20230524153316.476973-1-aleksandr.mikhalitsyn@canonical.com/
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v2
v3: https://lore.kernel.org/lkml/20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com/#t
v4: https://lore.kernel.org/lkml/20230607180958.645115-1-aleksandr.mikhalitsyn@canonical.com/#t
tree: https://github.com/mihalicyn/linux/commits/fs.idmapped.ceph.v4

Kind regards,
Alex

Original description from Christian:
========================================================================
This patch series enables cephfs to support idmapped mounts, i.e. the
ability to alter ownership information on a per-mount basis.

Container managers such as LXD support sharaing data via cephfs between
the host and unprivileged containers and between unprivileged containers.
They may all use different idmappings. Idmapped mounts can be used to
create mounts with the idmapping used for the container (or a different
one specific to the use-case).

There are in fact more use-cases such as remapping ownership for
mountpoints on the host itself to grant or restrict access to different
users or to make it possible to enforce that programs running as root
will write with a non-zero {g,u}id to disk.

The patch series is simple overall and few changes are needed to cephfs.
There is one cephfs specific issue that I would like to discuss and
solve which I explain in detail in:

[PATCH 02/12] ceph: handle idmapped mounts in create_request_message()

It has to do with how to handle mds serves which have id-based access
restrictions configured. I would ask you to please take a look at the
explanation in the aforementioned patch.

The patch series passes the vfs and idmapped mount testsuite as part of
xfstests. To run it you will need a config like:

[ceph]
export FSTYP=ceph
export TEST_DIR=/mnt/test
export TEST_DEV=10.103.182.10:6789:/
export TEST_FS_MOUNT_OPTS="-o name=admin,secret=$password

and then simply call

sudo ./check -g idmapped

========================================================================

Alexander Mikhalitsyn (5):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: pass idmap to __ceph_setattr
  ceph: pass idmap to ceph_do_getattr
  ceph: pass idmap to __ceph_setxattr
  ceph: pass idmap to ceph_open/ioctl_set_layout

Christian Brauner (9):
  ceph: stash idmapping in mdsc request
  ceph: handle idmapped mounts in create_request_message()
  ceph: pass an idmapping to mknod/symlink/mkdir/rename
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  8 ++++----
 fs/ceph/addr.c                |  3 ++-
 fs/ceph/caps.c                |  3 ++-
 fs/ceph/dir.c                 |  4 ++++
 fs/ceph/export.c              |  2 +-
 fs/ceph/file.c                | 21 ++++++++++++++-----
 fs/ceph/inode.c               | 38 +++++++++++++++++++++--------------
 fs/ceph/ioctl.c               |  9 +++++++--
 fs/ceph/mds_client.c          | 27 +++++++++++++++++++++----
 fs/ceph/mds_client.h          |  1 +
 fs/ceph/quota.c               |  2 +-
 fs/ceph/super.c               |  6 +++---
 fs/ceph/super.h               | 14 ++++++++-----
 fs/ceph/xattr.c               | 18 +++++++++--------
 fs/mnt_idmapping.c            |  2 ++
 include/linux/mnt_idmapping.h |  3 +++
 16 files changed, 111 insertions(+), 50 deletions(-)

-- 
2.34.1

