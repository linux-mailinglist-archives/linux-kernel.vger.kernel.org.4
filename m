Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EF569DDED
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 11:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbjBUKdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 05:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjBUKdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 05:33:21 -0500
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A9D7EE7
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 02:33:16 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VcC.gMp_1676975593;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VcC.gMp_1676975593)
          by smtp.aliyun-inc.com;
          Tue, 21 Feb 2023 18:33:14 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] fscache/cachefiles: some work for on-demand mode
Date:   Tue, 21 Feb 2023 18:33:11 +0800
Message-Id: <20230221103313.120834-1-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there's some work to make users of fscache on-demand mode support
PAGE_SIZE larger than 4KB (e.g. 16/64KB in aarch64) [1].  I think they
may be also useful for other users of fscache/cachefiles.


Strictly speacking, patch 1 is a bug fix though the issue doesn't cause
serious harm when erofs doesn't support large PAGE_SIZE (other than
4KB).

__cachefiles_prepare_write() will align the requested file range to
PAGE_SIZE boundary.  This is reasonable for libnetfs as libnetfs will
construct an iter with the aligned file range from the ground.

While for fscache on-demand mode, cachefiles_ondemand_fd_write_iter() is
called by the user daemon, and thus it is unexpected to align the file
range to PAGE_SIZE boundary, as the iov_iter/kiocb is given by the user
daemon.  If the given file range is not aligned with the block size of
the backing filesystem, let's fail the write directly.


Patch 2 adds a new helper, by which users of fscache on-demand mode
could wait for the wrangling of the cache object and then derive the
object size (set in cachefiles_ondemand_copen()).
fscache_begin_read_operation() is not feasible for this purpose as
in this case @want_state is FSCACHE_WANT_PARAMS and it will not wait
there for object wrangling when cookie is in
FSCACHE_COOKIE_STATE_CREATING state.  An example use case of this helper
is illustrated in [2].


Any comment is welcomed.


[1] https://lore.kernel.org/all/20230221091719.126127-1-jefflexu@linux.alibaba.com/
[2] https://lore.kernel.org/all/20230221091719.126127-2-jefflexu@linux.alibaba.com/

Jingbo Xu (2):
  cachefiles: don't align the write IO in ondemand mode
  fscache: introduce fscache_begin_wait_operation() helper

 fs/cachefiles/ondemand.c |  3 ++-
 fs/fscache/io.c          |  9 +++++++++
 include/linux/fscache.h  | 22 ++++++++++++++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

-- 
2.19.1.6.gb485710b

