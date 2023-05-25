Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED2711ABB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 01:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241125AbjEYXi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 19:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjEYXi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 19:38:28 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C250A3;
        Thu, 25 May 2023 16:38:25 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so58979e87.3;
        Thu, 25 May 2023 16:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685057903; x=1687649903;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CRzA4TSuNbRkvjf9wpxiaSWiXpR8KS7NFNcbPrnX1fM=;
        b=JB7LEsBbwGJoTtw+4gPJ0wdvGW3V0/naNYN3touihHC6spNUNJiPJ2qHzWOBLXum3O
         TqrQhjObO2mWpvsmh/rT27jUOhnKc4bPXEKVyRpypRcZ2K8G5iqOTIGRsDYum7xde4Mf
         e2D/aBbK/kzqEU5VmVFECi/3m4+ADpf+Dew10oSTkUJOOJrYKdOaC7c46BSqixIadjA6
         6cc7q5kABqBhSSqz+jvfZJdtqq21s7LfpPrx4hKObCwt4qwaSynVjlSPuuLE6Wulj/nr
         fg49Y4JTq4X1muuvn0oS41NdRwUgOQfQHxbs0MyTeYtCFeGsAcKRS8Dp9pAbrRm8/ZkC
         jncA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685057903; x=1687649903;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CRzA4TSuNbRkvjf9wpxiaSWiXpR8KS7NFNcbPrnX1fM=;
        b=AAjfnRZhGfXTHj9tPJZ/eb7Rs5BIU3YtjetHEETjoZc+7MyAO+oSkEQXGO97jhBitH
         irQcqvHdS9vMHl/bWnfZHhKwTnsdTZnel1ZXkoomcuKTG0ZWBxKL9TNz9wFdRp94CIWT
         IRKRQi8Dtn4k8pCmxDxvLO4phNfmSHhAncLTPGtKYXR1l+vFjD1YXl+QGKBM+yKyvc1B
         F4GTShpKPx1Zh0hFmuotEpkwfw21I9qSsO3EmWRj7T3g7CIEMy4KWDaBCfV9iQ3+yHjR
         39bL/YHjBjhC712vBwe0vexaPPSPGonjDqD6bEEuC4or1d/403SYBf8EQ9HlMK6TO0LP
         APVQ==
X-Gm-Message-State: AC+VfDypFUZVa80LkuFEq1MX5hKBQwQJc0q9mvVLNQYHDH6512woChe8
        AbEFQGNB1HCYovOsRwS86Sb/eSLiovIcsl9ZfLBQ2OvtW5wB1snA
X-Google-Smtp-Source: ACHHUZ5NMCdPUVjM5R5bbPJt5lHPlFhkOwBTYUBVbDDnIoj1Ja5KuF2jxBA6+ywTZmp7DqG4ZHKTgc3uLdA8fqrIpWA=
X-Received: by 2002:ac2:44ae:0:b0:4ed:c61d:c8e8 with SMTP id
 c14-20020ac244ae000000b004edc61dc8e8mr8272273lfm.29.1685057903022; Thu, 25
 May 2023 16:38:23 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 25 May 2023 18:38:11 -0500
Message-ID: <CAH2r5muUoXaeFdq=HUnEvjrppaD2e0_HUZOkgcHDSk_MmZOUag@mail.gmail.com>
Subject: [GIT PULL] SMB3 client fixes and move of cifs and ksmbd to under
 "smb" directory
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
44c026a73be8038f03dbdeef028b642880cf1511:

  Linux 6.4-rc3 (2023-05-21 14:05:48 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.4-rc3-smb3-client-fixes

for you to fetch changes up to ab6cacf833ba337b41700ee193d2c8936f1d049e:

  smb3: move Documentation/filesystems/cifs to
Documentation/filesystems/smb (2023-05-24 16:29:21 -0500)

----------------------------------------------------------------
Four smb3 client server fixes (3 also for stable) and three patches to
move of fs/cifs and fs/ksmbd to a new common "fs/smb" parent directory
- Move the client and server source directories to a common parent
directory: e.g. fs/cifs --> fs/smb/client and fs/ksmbd -->
fs/smb/server and fs/smbfs_common --> fs/smb/common
- important readahead fix
- important fix for SMB1 regression
- fix for missing mount option ("mapchars") in mount API conversion
- minor debugging improvement

----------------------------------------------------------------
David Howells (1):
      cifs: Fix cifs_limit_bvec_subset() to correctly check the maxmimum size

Paulo Alcantara (1):
      cifs: fix smb1 mount regression

Steve French (5):
      smb3: display debug information better for encryption
      cifs: mapchars mount option ignored
      smb: move client and server files to common directory fs/smb
      cifs: correct references in Documentation to old fs/cifs path
      smb3: move Documentation/filesystems/cifs to Documentation/filesystems/smb

 Documentation/admin-guide/cifs/changes.rst              |  4 ++--
 Documentation/admin-guide/cifs/usage.rst                |  8 ++++----
 Documentation/filesystems/index.rst                     |  2 +-
 Documentation/filesystems/{cifs => smb}/cifsroot.rst    |  2 +-
 Documentation/filesystems/{cifs => smb}/index.rst       |  0
 Documentation/filesystems/{cifs => smb}/ksmbd.rst       |  0
 Documentation/userspace-api/ioctl/ioctl-number.rst      |  2 +-
 MAINTAINERS                                             | 10 +++++-----
 fs/Kconfig                                              |  9 +--------
 fs/Makefile                                             |  4 +---
 fs/smb/Kconfig                                          | 11 +++++++++++
 fs/smb/Makefile                                         |  5 +++++
 fs/{cifs => smb/client}/Kconfig                         |  0
 fs/{cifs => smb/client}/Makefile                        |  0
 fs/{cifs => smb/client}/asn1.c                          |  0
 fs/{cifs => smb/client}/cached_dir.c                    |  0
 fs/{cifs => smb/client}/cached_dir.h                    |  0
 fs/{cifs => smb/client}/cifs_debug.c                    |  8 ++++++--
 fs/{cifs => smb/client}/cifs_debug.h                    |  0
 fs/{cifs => smb/client}/cifs_dfs_ref.c                  |  0
 fs/{cifs => smb/client}/cifs_fs_sb.h                    |  0
 fs/{cifs => smb/client}/cifs_ioctl.h                    |  0
 fs/{cifs => smb/client}/cifs_spnego.c                   |  0
 fs/{cifs => smb/client}/cifs_spnego.h                   |  0
 fs/{cifs => smb/client}/cifs_spnego_negtokeninit.asn1   |  0
 fs/{cifs => smb/client}/cifs_swn.c                      |  0
 fs/{cifs => smb/client}/cifs_swn.h                      |  0
 fs/{cifs => smb/client}/cifs_unicode.c                  |  0
 fs/{cifs => smb/client}/cifs_unicode.h                  |  0
 fs/{cifs => smb/client}/cifs_uniupr.h                   |  0
 fs/{cifs => smb/client}/cifsacl.c                       |  0
 fs/{cifs => smb/client}/cifsacl.h                       |  0
 fs/{cifs => smb/client}/cifsencrypt.c                   |  2 +-
 fs/{cifs => smb/client}/cifsfs.c                        |  0
 fs/{cifs => smb/client}/cifsfs.h                        |  0
 fs/{cifs => smb/client}/cifsglob.h                      |  2 +-
 fs/{cifs => smb/client}/cifspdu.h                       |  2 +-
 fs/{cifs => smb/client}/cifsproto.h                     |  0
 fs/{cifs => smb/client}/cifsroot.c                      |  0
 fs/{cifs => smb/client}/cifssmb.c                       |  0
 fs/{cifs => smb/client}/connect.c                       |  0
 fs/{cifs => smb/client}/dfs.c                           |  2 +-
 fs/{cifs => smb/client}/dfs.h                           |  0
 fs/{cifs => smb/client}/dfs_cache.c                     |  0
 fs/{cifs => smb/client}/dfs_cache.h                     |  0
 fs/{cifs => smb/client}/dir.c                           |  0
 fs/{cifs => smb/client}/dns_resolve.c                   |  0
 fs/{cifs => smb/client}/dns_resolve.h                   |  0
 fs/{cifs => smb/client}/export.c                        |  0
 fs/{cifs => smb/client}/file.c                          |  3 ++-
 fs/{cifs => smb/client}/fs_context.c                    |  8 ++++++++
 fs/{cifs => smb/client}/fs_context.h                    |  0
 fs/{cifs => smb/client}/fscache.c                       |  0
 fs/{cifs => smb/client}/fscache.h                       |  0
 fs/{cifs => smb/client}/inode.c                         |  0
 fs/{cifs => smb/client}/ioctl.c                         |  0
 fs/{cifs => smb/client}/link.c                          |  0
 fs/{cifs => smb/client}/misc.c                          |  0
 fs/{cifs => smb/client}/netlink.c                       |  0
 fs/{cifs => smb/client}/netlink.h                       |  0
 fs/{cifs => smb/client}/netmisc.c                       |  0
 fs/{cifs => smb/client}/nterr.c                         |  0
 fs/{cifs => smb/client}/nterr.h                         |  0
 fs/{cifs => smb/client}/ntlmssp.h                       |  0
 fs/{cifs => smb/client}/readdir.c                       |  0
 fs/{cifs => smb/client}/rfc1002pdu.h                    |  0
 fs/{cifs => smb/client}/sess.c                          |  0
 fs/{cifs => smb/client}/smb1ops.c                       |  0
 fs/{cifs => smb/client}/smb2file.c                      |  0
 fs/{cifs => smb/client}/smb2glob.h                      |  0
 fs/{cifs => smb/client}/smb2inode.c                     |  0
 fs/{cifs => smb/client}/smb2maperror.c                  |  0
 fs/{cifs => smb/client}/smb2misc.c                      |  0
 fs/{cifs => smb/client}/smb2ops.c                       |  0
 fs/{cifs => smb/client}/smb2pdu.c                       |  0
 fs/{cifs => smb/client}/smb2pdu.h                       |  0
 fs/{cifs => smb/client}/smb2proto.h                     |  0
 fs/{cifs => smb/client}/smb2status.h                    |  0
 fs/{cifs => smb/client}/smb2transport.c                 |  0
 fs/{cifs => smb/client}/smbdirect.c                     |  0
 fs/{cifs => smb/client}/smbdirect.h                     |  0
 fs/{cifs => smb/client}/smbencrypt.c                    |  2 +-
 fs/{cifs => smb/client}/smberr.h                        |  0
 fs/{cifs => smb/client}/trace.c                         |  0
 fs/{cifs => smb/client}/trace.h                         |  0
 fs/{cifs => smb/client}/transport.c                     |  0
 fs/{cifs => smb/client}/unc.c                           |  0
 fs/{cifs => smb/client}/winucase.c                      |  0
 fs/{cifs => smb/client}/xattr.c                         |  0
 fs/{smbfs_common => smb/common}/Makefile                |  4 ++--
 fs/{smbfs_common => smb/common}/arc4.h                  |  0
 fs/{smbfs_common => smb/common}/cifs_arc4.c             |  0
 fs/{smbfs_common => smb/common}/cifs_md4.c              |  0
 fs/{smbfs_common => smb/common}/md4.h                   |  0
 fs/{smbfs_common => smb/common}/smb2pdu.h               |  0
 fs/{smbfs_common => smb/common}/smbfsctl.h              |  0
 fs/{ksmbd => smb/server}/Kconfig                        |  0
 fs/{ksmbd => smb/server}/Makefile                       |  0
 fs/{ksmbd => smb/server}/asn1.c                         |  0
 fs/{ksmbd => smb/server}/asn1.h                         |  0
 fs/{ksmbd => smb/server}/auth.c                         |  2 +-
 fs/{ksmbd => smb/server}/auth.h                         |  0
 fs/{ksmbd => smb/server}/connection.c                   |  0
 fs/{ksmbd => smb/server}/connection.h                   |  0
 fs/{ksmbd => smb/server}/crypto_ctx.c                   |  0
 fs/{ksmbd => smb/server}/crypto_ctx.h                   |  0
 fs/{ksmbd => smb/server}/glob.h                         |  0
 fs/{ksmbd => smb/server}/ksmbd_netlink.h                |  0
 fs/{ksmbd => smb/server}/ksmbd_spnego_negtokeninit.asn1 |  0
 fs/{ksmbd => smb/server}/ksmbd_spnego_negtokentarg.asn1 |  0
 fs/{ksmbd => smb/server}/ksmbd_work.c                   |  0
 fs/{ksmbd => smb/server}/ksmbd_work.h                   |  0
 fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.c               |  0
 fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.h               |  0
 fs/{ksmbd => smb/server}/mgmt/share_config.c            |  0
 fs/{ksmbd => smb/server}/mgmt/share_config.h            |  0
 fs/{ksmbd => smb/server}/mgmt/tree_connect.c            |  0
 fs/{ksmbd => smb/server}/mgmt/tree_connect.h            |  0
 fs/{ksmbd => smb/server}/mgmt/user_config.c             |  0
 fs/{ksmbd => smb/server}/mgmt/user_config.h             |  0
 fs/{ksmbd => smb/server}/mgmt/user_session.c            |  0
 fs/{ksmbd => smb/server}/mgmt/user_session.h            |  0
 fs/{ksmbd => smb/server}/misc.c                         |  0
 fs/{ksmbd => smb/server}/misc.h                         |  0
 fs/{ksmbd => smb/server}/ndr.c                          |  0
 fs/{ksmbd => smb/server}/ndr.h                          |  0
 fs/{ksmbd => smb/server}/nterr.h                        |  0
 fs/{ksmbd => smb/server}/ntlmssp.h                      |  0
 fs/{ksmbd => smb/server}/oplock.c                       |  0
 fs/{ksmbd => smb/server}/oplock.h                       |  0
 fs/{ksmbd => smb/server}/server.c                       |  0
 fs/{ksmbd => smb/server}/server.h                       |  0
 fs/{ksmbd => smb/server}/smb2misc.c                     |  0
 fs/{ksmbd => smb/server}/smb2ops.c                      |  0
 fs/{ksmbd => smb/server}/smb2pdu.c                      |  0
 fs/{ksmbd => smb/server}/smb2pdu.h                      |  0
 fs/{ksmbd => smb/server}/smb_common.c                   |  0
 fs/{ksmbd => smb/server}/smb_common.h                   |  2 +-
 fs/{ksmbd => smb/server}/smbacl.c                       |  0
 fs/{ksmbd => smb/server}/smbacl.h                       |  0
 fs/{ksmbd => smb/server}/smbfsctl.h                     |  2 +-
 fs/{ksmbd => smb/server}/smbstatus.h                    |  2 +-
 fs/{ksmbd => smb/server}/transport_ipc.c                |  0
 fs/{ksmbd => smb/server}/transport_ipc.h                |  0
 fs/{ksmbd => smb/server}/transport_rdma.c               |  0
 fs/{ksmbd => smb/server}/transport_rdma.h               |  0
 fs/{ksmbd => smb/server}/transport_tcp.c                |  0
 fs/{ksmbd => smb/server}/transport_tcp.h                |  0
 fs/{ksmbd => smb/server}/unicode.c                      |  0
 fs/{ksmbd => smb/server}/unicode.h                      |  0
 fs/{ksmbd => smb/server}/uniupr.h                       |  0
 fs/{ksmbd => smb/server}/vfs.c                          |  0
 fs/{ksmbd => smb/server}/vfs.h                          |  0
 fs/{ksmbd => smb/server}/vfs_cache.c                    |  0
 fs/{ksmbd => smb/server}/vfs_cache.h                    |  0
 fs/{ksmbd => smb/server}/xattr.h                        |  0
 156 files changed, 59 insertions(+), 39 deletions(-)
 rename Documentation/filesystems/{cifs => smb}/cifsroot.rst (97%)
 rename Documentation/filesystems/{cifs => smb}/index.rst (100%)
 rename Documentation/filesystems/{cifs => smb}/ksmbd.rst (100%)
 create mode 100644 fs/smb/Kconfig
 create mode 100644 fs/smb/Makefile
 rename fs/{cifs => smb/client}/Kconfig (100%)
 rename fs/{cifs => smb/client}/Makefile (100%)
 rename fs/{cifs => smb/client}/asn1.c (100%)
 rename fs/{cifs => smb/client}/cached_dir.c (100%)
 rename fs/{cifs => smb/client}/cached_dir.h (100%)
 rename fs/{cifs => smb/client}/cifs_debug.c (99%)
 rename fs/{cifs => smb/client}/cifs_debug.h (100%)
 rename fs/{cifs => smb/client}/cifs_dfs_ref.c (100%)
 rename fs/{cifs => smb/client}/cifs_fs_sb.h (100%)
 rename fs/{cifs => smb/client}/cifs_ioctl.h (100%)
 rename fs/{cifs => smb/client}/cifs_spnego.c (100%)
 rename fs/{cifs => smb/client}/cifs_spnego.h (100%)
 rename fs/{cifs => smb/client}/cifs_spnego_negtokeninit.asn1 (100%)
 rename fs/{cifs => smb/client}/cifs_swn.c (100%)
 rename fs/{cifs => smb/client}/cifs_swn.h (100%)
 rename fs/{cifs => smb/client}/cifs_unicode.c (100%)
 rename fs/{cifs => smb/client}/cifs_unicode.h (100%)
 rename fs/{cifs => smb/client}/cifs_uniupr.h (100%)
 rename fs/{cifs => smb/client}/cifsacl.c (100%)
 rename fs/{cifs => smb/client}/cifsacl.h (100%)
 rename fs/{cifs => smb/client}/cifsencrypt.c (99%)
 rename fs/{cifs => smb/client}/cifsfs.c (100%)
 rename fs/{cifs => smb/client}/cifsfs.h (100%)
 rename fs/{cifs => smb/client}/cifsglob.h (99%)
 rename fs/{cifs => smb/client}/cifspdu.h (99%)
 rename fs/{cifs => smb/client}/cifsproto.h (100%)
 rename fs/{cifs => smb/client}/cifsroot.c (100%)
 rename fs/{cifs => smb/client}/cifssmb.c (100%)
 rename fs/{cifs => smb/client}/connect.c (100%)
 rename fs/{cifs => smb/client}/dfs.c (99%)
 rename fs/{cifs => smb/client}/dfs.h (100%)
 rename fs/{cifs => smb/client}/dfs_cache.c (100%)
 rename fs/{cifs => smb/client}/dfs_cache.h (100%)
 rename fs/{cifs => smb/client}/dir.c (100%)
 rename fs/{cifs => smb/client}/dns_resolve.c (100%)
 rename fs/{cifs => smb/client}/dns_resolve.h (100%)
 rename fs/{cifs => smb/client}/export.c (100%)
 rename fs/{cifs => smb/client}/file.c (99%)
 rename fs/{cifs => smb/client}/fs_context.c (99%)
 rename fs/{cifs => smb/client}/fs_context.h (100%)
 rename fs/{cifs => smb/client}/fscache.c (100%)
 rename fs/{cifs => smb/client}/fscache.h (100%)
 rename fs/{cifs => smb/client}/inode.c (100%)
 rename fs/{cifs => smb/client}/ioctl.c (100%)
 rename fs/{cifs => smb/client}/link.c (100%)
 rename fs/{cifs => smb/client}/misc.c (100%)
 rename fs/{cifs => smb/client}/netlink.c (100%)
 rename fs/{cifs => smb/client}/netlink.h (100%)
 rename fs/{cifs => smb/client}/netmisc.c (100%)
 rename fs/{cifs => smb/client}/nterr.c (100%)
 rename fs/{cifs => smb/client}/nterr.h (100%)
 rename fs/{cifs => smb/client}/ntlmssp.h (100%)
 rename fs/{cifs => smb/client}/readdir.c (100%)
 rename fs/{cifs => smb/client}/rfc1002pdu.h (100%)
 rename fs/{cifs => smb/client}/sess.c (100%)
 rename fs/{cifs => smb/client}/smb1ops.c (100%)
 rename fs/{cifs => smb/client}/smb2file.c (100%)
 rename fs/{cifs => smb/client}/smb2glob.h (100%)
 rename fs/{cifs => smb/client}/smb2inode.c (100%)
 rename fs/{cifs => smb/client}/smb2maperror.c (100%)
 rename fs/{cifs => smb/client}/smb2misc.c (100%)
 rename fs/{cifs => smb/client}/smb2ops.c (100%)
 rename fs/{cifs => smb/client}/smb2pdu.c (100%)
 rename fs/{cifs => smb/client}/smb2pdu.h (100%)
 rename fs/{cifs => smb/client}/smb2proto.h (100%)
 rename fs/{cifs => smb/client}/smb2status.h (100%)
 rename fs/{cifs => smb/client}/smb2transport.c (100%)
 rename fs/{cifs => smb/client}/smbdirect.c (100%)
 rename fs/{cifs => smb/client}/smbdirect.h (100%)
 rename fs/{cifs => smb/client}/smbencrypt.c (98%)
 rename fs/{cifs => smb/client}/smberr.h (100%)
 rename fs/{cifs => smb/client}/trace.c (100%)
 rename fs/{cifs => smb/client}/trace.h (100%)
 rename fs/{cifs => smb/client}/transport.c (100%)
 rename fs/{cifs => smb/client}/unc.c (100%)
 rename fs/{cifs => smb/client}/winucase.c (100%)
 rename fs/{cifs => smb/client}/xattr.c (100%)
 rename fs/{smbfs_common => smb/common}/Makefile (59%)
 rename fs/{smbfs_common => smb/common}/arc4.h (100%)
 rename fs/{smbfs_common => smb/common}/cifs_arc4.c (100%)
 rename fs/{smbfs_common => smb/common}/cifs_md4.c (100%)
 rename fs/{smbfs_common => smb/common}/md4.h (100%)
 rename fs/{smbfs_common => smb/common}/smb2pdu.h (100%)
 rename fs/{smbfs_common => smb/common}/smbfsctl.h (100%)
 rename fs/{ksmbd => smb/server}/Kconfig (100%)
 rename fs/{ksmbd => smb/server}/Makefile (100%)
 rename fs/{ksmbd => smb/server}/asn1.c (100%)
 rename fs/{ksmbd => smb/server}/asn1.h (100%)
 rename fs/{ksmbd => smb/server}/auth.c (99%)
 rename fs/{ksmbd => smb/server}/auth.h (100%)
 rename fs/{ksmbd => smb/server}/connection.c (100%)
 rename fs/{ksmbd => smb/server}/connection.h (100%)
 rename fs/{ksmbd => smb/server}/crypto_ctx.c (100%)
 rename fs/{ksmbd => smb/server}/crypto_ctx.h (100%)
 rename fs/{ksmbd => smb/server}/glob.h (100%)
 rename fs/{ksmbd => smb/server}/ksmbd_netlink.h (100%)
 rename fs/{ksmbd => smb/server}/ksmbd_spnego_negtokeninit.asn1 (100%)
 rename fs/{ksmbd => smb/server}/ksmbd_spnego_negtokentarg.asn1 (100%)
 rename fs/{ksmbd => smb/server}/ksmbd_work.c (100%)
 rename fs/{ksmbd => smb/server}/ksmbd_work.h (100%)
 rename fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.c (100%)
 rename fs/{ksmbd => smb/server}/mgmt/ksmbd_ida.h (100%)
 rename fs/{ksmbd => smb/server}/mgmt/share_config.c (100%)
 rename fs/{ksmbd => smb/server}/mgmt/share_config.h (100%)
 rename fs/{ksmbd => smb/server}/mgmt/tree_connect.c (100%)
 rename fs/{ksmbd => smb/server}/mgmt/tree_connect.h (100%)
 rename fs/{ksmbd => smb/server}/mgmt/user_config.c (100%)
 rename fs/{ksmbd => smb/server}/mgmt/user_config.h (100%)
 rename fs/{ksmbd => smb/server}/mgmt/user_session.c (100%)
 rename fs/{ksmbd => smb/server}/mgmt/user_session.h (100%)
 rename fs/{ksmbd => smb/server}/misc.c (100%)
 rename fs/{ksmbd => smb/server}/misc.h (100%)
 rename fs/{ksmbd => smb/server}/ndr.c (100%)
 rename fs/{ksmbd => smb/server}/ndr.h (100%)
 rename fs/{ksmbd => smb/server}/nterr.h (100%)
 rename fs/{ksmbd => smb/server}/ntlmssp.h (100%)
 rename fs/{ksmbd => smb/server}/oplock.c (100%)
 rename fs/{ksmbd => smb/server}/oplock.h (100%)
 rename fs/{ksmbd => smb/server}/server.c (100%)
 rename fs/{ksmbd => smb/server}/server.h (100%)
 rename fs/{ksmbd => smb/server}/smb2misc.c (100%)
 rename fs/{ksmbd => smb/server}/smb2ops.c (100%)
 rename fs/{ksmbd => smb/server}/smb2pdu.c (100%)
 rename fs/{ksmbd => smb/server}/smb2pdu.h (100%)
 rename fs/{ksmbd => smb/server}/smb_common.c (100%)
 rename fs/{ksmbd => smb/server}/smb_common.h (99%)
 rename fs/{ksmbd => smb/server}/smbacl.c (100%)
 rename fs/{ksmbd => smb/server}/smbacl.h (100%)
 rename fs/{ksmbd => smb/server}/smbfsctl.h (98%)
 rename fs/{ksmbd => smb/server}/smbstatus.h (99%)
 rename fs/{ksmbd => smb/server}/transport_ipc.c (100%)
 rename fs/{ksmbd => smb/server}/transport_ipc.h (100%)
 rename fs/{ksmbd => smb/server}/transport_rdma.c (100%)
 rename fs/{ksmbd => smb/server}/transport_rdma.h (100%)
 rename fs/{ksmbd => smb/server}/transport_tcp.c (100%)
 rename fs/{ksmbd => smb/server}/transport_tcp.h (100%)
 rename fs/{ksmbd => smb/server}/unicode.c (100%)
 rename fs/{ksmbd => smb/server}/unicode.h (100%)
 rename fs/{ksmbd => smb/server}/uniupr.h (100%)
 rename fs/{ksmbd => smb/server}/vfs.c (100%)
 rename fs/{ksmbd => smb/server}/vfs.h (100%)
 rename fs/{ksmbd => smb/server}/vfs_cache.c (100%)
 rename fs/{ksmbd => smb/server}/vfs_cache.h (100%)
 rename fs/{ksmbd => smb/server}/xattr.h (100%)


-- 
Thanks,

Steve
