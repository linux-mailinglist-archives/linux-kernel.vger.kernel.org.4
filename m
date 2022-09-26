Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AC5EA8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbiIZOlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234914AbiIZOko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:40:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2BDF186E;
        Mon, 26 Sep 2022 06:01:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 817D56068C;
        Mon, 26 Sep 2022 13:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F00C433D6;
        Mon, 26 Sep 2022 13:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664197301;
        bh=Cn6NBU74rUDa6kJ/DEloWl+kpXHAM3ZSRRMJ12LdkuU=;
        h=From:To:Cc:Subject:Date:From;
        b=DUYNg1rjx00K7VTRnD+WrtW9FXv8xIZOIP+aswOECf7q4iShxvwTQxeG/WqDPHf2/
         XBX4fXsRywKxcKAqWaV099YI886FI0Y0mhX+jv9Y9JozkTFlaJMAR5rVebPbgujCgc
         BuOVaPHdwIbefGa8lmwtLHNoJAtz7bNgiX+TYpcBg7PJ8Dq0qy+g4wMpPctma3i9Yp
         G2oxyfHbfIy3JYEsYHUklvZBhfLCqtCqVmtchmfDgn9vJlOTvHh0iQ/LpB9s0YbCbv
         QLd9k7ZvHm9cnC6afroqPX2an6wlNwH3sxUcj4pYxGgCNT4ismKHY+RvuLkpOG0Pbr
         Tl1+fe7yBSnXg==
From:   broonie@kernel.org
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     Gaosheng Cui <cuigaosheng1@huawei.com>, Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the ext3 tree
Date:   Mon, 26 Sep 2022 14:01:37 +0100
Message-Id: <20220926130137.105900-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/notify/fanotify/fanotify.h

between commit:

  7a80bf902d2bc ("fanotify: Remove obsoleted fanotify_event_has_path()")

from the ext3 tree and commit:

  d5bf88895f246 ("fs/notify: constify path")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/notify/fanotify/fanotify.h
index b34246c6ec87e,bf6d4d38afa04..0000000000000
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@@ -452,7 -452,13 +452,7 @@@ static inline bool fanotify_is_error_ev
  	return mask & FAN_FS_ERROR;
  }
  
- static inline struct path *fanotify_event_path(struct fanotify_event *event)
 -static inline bool fanotify_event_has_path(struct fanotify_event *event)
 -{
 -	return event->type == FANOTIFY_EVENT_TYPE_PATH ||
 -		event->type == FANOTIFY_EVENT_TYPE_PATH_PERM;
 -}
 -
+ static inline const struct path *fanotify_event_path(struct fanotify_event *event)
  {
  	if (event->type == FANOTIFY_EVENT_TYPE_PATH)
  		return &FANOTIFY_PE(event)->path;
