Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6423726419
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235642AbjFGPVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 11:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240983AbjFGPVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 11:21:10 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF37A1720
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 08:21:08 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6F8A73F15A
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 15:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686151266;
        bh=8aY1VEWoPNEUlLBN7rmQq3eOh6/TfDDzDz8dWVmei8E=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=DmDAUP1TNFZPG+1XBqt6gwBW/5iv9ZWJv3vupEce3lzScE8DLpj1vyx6CbBKNAY8g
         8mF+XJ/NKv2YhnDLwxMPpH5vOYy/cPYw2zyu8kuD4SmnmbMXWvaT7/EbMlwfMbHSaG
         o2nOYv/q0kD4f9NFBiFtupApkqzbSt4JrFw54yqZ1jXOCQntFZpyu0RAxh8kl7CiBI
         MpzbpnZfmxyd9SGGGMOBJTxZWXM9+wqGFsVce7r2+WjoW4v4GJ8iFiKvUYH61YRC70
         XyTff0fwS664eeaG7N4jCdcWpyY7u1J6USNt2FL4Zx8PraVWlm0ebl6YgUjgIfETnB
         xUwbc8zdANhxQ==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-514a1501b0eso833952a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 08:21:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686151266; x=1688743266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8aY1VEWoPNEUlLBN7rmQq3eOh6/TfDDzDz8dWVmei8E=;
        b=DWQUXtw16hc/locBHwqceahmcoFzIr8sKrIvSNqR59JwY3VJsTKVzl1z2UCrnOo3jo
         lljjtxkeBzFGaG8bzHpD6Vb+nEaUO0T51HbChIxjsKZlE7bouCdoNNCCFczE7HeRDe2M
         pbB/vYXeV7ukl1GnK5jnpBH1yxzNrUSpdza7oRqeRZESmM69rT4TmxcQN+w8azy9rtDi
         2H4J6e90yjFxLJIe9WOlYow//kgL13qtoGGo+92Gg0ZUHrliFdl0GHjXY1//6jtj4hFI
         QMugWGeXIpYNKxWcsYRP5wntqZUArjaQoHlfkBXOFF+lcCi5impj3mbbr5hgPUe17NBm
         6yaA==
X-Gm-Message-State: AC+VfDyaaIVAOk4UkU2WYVF5E76QKc03jvCJ5paIdAxAfqs1SWfAKYtK
        Xrc2vbwDNE9ZJIOlUsHynfAnNzqSHSrd+pFs0XTjgVWX9eHhTJRU0EltCaYmlaMmRND8rr74Dmu
        F7FsSN7JGMEKMf7uXk+nZa7nu9d67LyRGvBUMqRz22Q==
X-Received: by 2002:aa7:cd7c:0:b0:514:98c8:9d7c with SMTP id ca28-20020aa7cd7c000000b0051498c89d7cmr4306405edb.4.1686151266032;
        Wed, 07 Jun 2023 08:21:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jGoY1/cSqCCKJEhcMIh7TGVGPrCBczoHCXvlo5e6XW3XxFcEYbVqs7fQhicmHa1Zuso1ZOg==
X-Received: by 2002:aa7:cd7c:0:b0:514:98c8:9d7c with SMTP id ca28-20020aa7cd7c000000b0051498c89d7cmr4306389edb.4.1686151265750;
        Wed, 07 Jun 2023 08:21:05 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-002-205-064-187.002.205.pools.vodafone-ip.de. [2.205.64.187])
        by smtp.gmail.com with ESMTPSA id w17-20020a056402129100b005147503a238sm6263441edv.17.2023.06.07.08.21.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 08:21:05 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/14] ceph: support idmapped mounts
Date:   Wed,  7 Jun 2023 17:20:24 +0200
Message-Id: <20230607152038.469739-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
https://github.com/mihalicyn/linux/tree/fs.idmapped.ceph

In the version 3 I've changed only two commits:
- fs: export mnt_idmap_get/mnt_idmap_put
- ceph: allow idmapped setattr inode op
and added a new one:
- ceph: pass idmap to __ceph_setattr

I can confirm that version 3 passes xfstests.

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

Alexander Mikhalitsyn (2):
  fs: export mnt_idmap_get/mnt_idmap_put
  ceph: pass idmap to __ceph_setattr

Christian Brauner (12):
  ceph: stash idmapping in mdsc request
  ceph: handle idmapped mounts in create_request_message()
  ceph: allow idmapped mknod inode op
  ceph: allow idmapped symlink inode op
  ceph: allow idmapped mkdir inode op
  ceph: allow idmapped rename inode op
  ceph: allow idmapped getattr inode op
  ceph: allow idmapped permission inode op
  ceph: allow idmapped setattr inode op
  ceph/acl: allow idmapped set_acl inode op
  ceph/file: allow idmapped atomic_open inode op
  ceph: allow idmapped mounts

 fs/ceph/acl.c                 |  6 +++---
 fs/ceph/dir.c                 |  4 ++++
 fs/ceph/file.c                | 10 +++++++--
 fs/ceph/inode.c               | 38 ++++++++++++++++++++++++-----------
 fs/ceph/mds_client.c          | 29 ++++++++++++++++++++++----
 fs/ceph/mds_client.h          |  1 +
 fs/ceph/super.c               |  2 +-
 fs/ceph/super.h               |  3 ++-
 fs/mnt_idmapping.c            |  2 ++
 include/linux/mnt_idmapping.h |  3 +++
 10 files changed, 75 insertions(+), 23 deletions(-)

-- 
2.34.1

