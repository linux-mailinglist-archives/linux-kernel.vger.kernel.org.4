Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D269474B506
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 18:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjGGQRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 12:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjGGQRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 12:17:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F3D1BEE;
        Fri,  7 Jul 2023 09:17:08 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-51d9128494cso2554486a12.0;
        Fri, 07 Jul 2023 09:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688746627; x=1691338627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xbawlpEGPtvxnI27h7HhTsmExC7ngca6g7HWBIPoTAA=;
        b=YnSkLhAUqf5opB7MYZjgBmxWDNsITO//np1Yd4Gt4ILR/tAD+m2j8J8haxiNoeVkQh
         mdZYD4xmY4P+HZrCfWelkIR8pbEYyz+rzb3mvZR1BWyjoZtfSyPQKFfexgXoKePfzzi9
         2yDj/cMmWibWnDjmUB3OShqZcorq5FzloS4URXPyI9AV0uJTrwgyvfRhdCJXxKDLywPS
         hV1bJhw8XAW9iFdt1NnjVZ/SVYReUeDkNRKMIwcfGCZaKFPeZGTTo/q/621DCBLTPSS9
         M3UmOB2d4ZVBDfCZfjLOX8vyBZBR+XU6Inkpm1n9HNmPb6dKCKpNEkpMz8us+Dp0uxi0
         UnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688746627; x=1691338627;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xbawlpEGPtvxnI27h7HhTsmExC7ngca6g7HWBIPoTAA=;
        b=BEVPb1YyqzRZgiI/lEg/uXb6QuEAOlhz+gsfQg0DTYEaDb0KtQ3f88LxyMSnHNWWGO
         VEEitpq5JC9/sFZPgSkL6/XpCoY4lFebg3Zq5UcEVOpuV+PLS+9M28xLASeWA5jWxATh
         os+xh1ZS1egTf1BoNq57DB74iuftVrhuHlgTm/6caNJuHGiNUCpioKbEVDu27+bhq/zT
         b1QqjeE0GjenvzFoVs/0vrl+xGJt9hsr2/KdWuKqBOKv4huv0yKwXFrO6ciT8A1KxfLo
         f041soEMnyPrgZSs8YRNikDQgEB0eOHpfJRGKqirBSJFGWl8EYviQAJMHxDAcoINOhGX
         2TQg==
X-Gm-Message-State: ABy/qLYCKgM9gr5W89D9ggOPJXwZ9kurKh4drJi64SRYlHhpchmXw1or
        B7EfOrYoFp4KykBsQQfd5Gu9FLen+Zw=
X-Google-Smtp-Source: APBJJlGHm29g6eAZ1w+y7RoFR9EhJwGiZh7HsNelxOXycBsWs3LcXyDVZvTPZTl+d6S7we55XS967Q==
X-Received: by 2002:aa7:df95:0:b0:51e:2cdb:ed1f with SMTP id b21-20020aa7df95000000b0051e2cdbed1fmr4810310edy.9.1688746626826;
        Fri, 07 Jul 2023 09:17:06 -0700 (PDT)
Received: from zambezi.local (ip-94-112-104-28.bb.vodafone.cz. [94.112.104.28])
        by smtp.gmail.com with ESMTPSA id m11-20020aa7c2cb000000b0051e2a4edfd5sm2210110edp.21.2023.07.07.09.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 09:17:06 -0700 (PDT)
From:   Ilya Dryomov <idryomov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.5-rc1
Date:   Fri,  7 Jul 2023 18:16:58 +0200
Message-Id: <20230707161658.372600-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 6995e2de6891c724bfeb2db33d7b87775f913ad1:

  Linux 6.4 (2023-06-25 16:29:58 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.5-rc1

for you to fetch changes up to 257e6172ab36ebbe295a6c9ee9a9dd0fe54c1dc2:

  ceph: don't let check_caps skip sending responses for revoke msgs (2023-06-30 12:08:55 +0200)

----------------------------------------------------------------
A bunch of CephFS fixups from Xiubo, mostly around dropping caps, along
with a fix for a regression in the readahead handling code which sneaked
in with the switch to netfs helpers.

----------------------------------------------------------------
Xiubo Li (8):
      ceph: only send metrics when the MDS rank is ready
      ceph: try to dump the msgs when decoding fails
      ceph: voluntarily drop Xx caps for requests those touch parent mtime
      ceph: add a dedicated private data for netfs rreq
      ceph: fix blindly expanding the readahead windows
      ceph: trigger to flush the buffer when making snapshot
      ceph: issue a cap release immediately if no cap exists
      ceph: don't let check_caps skip sending responses for revoke msgs

 fs/ceph/addr.c       | 85 +++++++++++++++++++++++++++++++++++++++++-----------
 fs/ceph/caps.c       | 55 +++++++++++++++++++++++++++-------
 fs/ceph/dir.c        | 17 ++++++-----
 fs/ceph/file.c       |  3 +-
 fs/ceph/mds_client.c |  4 +++
 fs/ceph/metric.c     |  8 +++++
 fs/ceph/snap.c       |  9 ++++--
 fs/ceph/super.h      | 13 ++++++++
 8 files changed, 154 insertions(+), 40 deletions(-)
