Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8481366DB8D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 11:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235460AbjAQKxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 05:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236589AbjAQKwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 05:52:42 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C8305E6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 02:52:40 -0800 (PST)
Received: from fedcomp.intra.ispras.ru (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id 930C244C101D;
        Tue, 17 Jan 2023 10:52:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 930C244C101D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1673952758;
        bh=W+6gRdef0k52Vjrjx/yONZ2ai8LdoBBFD8BbNXJ1V2c=;
        h=From:To:Cc:Subject:Date:From;
        b=JXjJ/Oh1TAsyFP1lGsmOot3Tk42JjCLmdAKckewn58wdNJsTLW5g04eIp/ygFKxhs
         6DMH1CK+kmRdcn9Rjry+bbthNsP2Bod7P6pHHLYQjKxU/F3QyFu9m5/k0/nzROy+0l
         LGLqj1T92uQvz/cXV5X+k9zq3/A77Tr72hueA9dM=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Phillip Lougher <phillip@squashfs.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 0/1] squashfs: harden sanity check in squashfs_read_xattr_id_table
Date:   Tue, 17 Jan 2023 13:52:25 +0300
Message-Id: <20230117105226.329303-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Syzkaller reports the following problem [1].

null-ptr-deref in cache_first_page() happens because 'data[i]' is not
properly initialized in squashfs_read_table(): this is due to its 'length'
argument being zero (thus causing 'pages' being zero, too).
squashfs_read_table() is called twice from squashfs_read_xattr_id_table().
After the first call, 'id_table->xattr_ids' signed value is processed: if
a filesystem is corrupted, I suppose, a negative value is written to it
(in copy_bio_to_actor(), as I understand). So then 'len' and 'indexes'
values become incorrect (in this case, equal to zero), and it causes the
bug. I've added the additional check for '*xattr_ids' not being negative.

But, actually, I don't quite understand why 'xattr_ids' field has
different types in 'struct squashfs_xattr_id_table' and
'struct squashfs_sb_info'. Probably that would be an issue. For example,
in squashfs_xattr_lookup() we compare unsigned 'index' with signed
'msblk->xattr_ids'. So maybe convert 'xattr_ids' field in
'struct squashfs_sb_info' to unsigned type? And that, I think, would fix
the problem described in the patch as well.

[1] https://syzkaller.appspot.com/bug?id=8cf937ba2cde11be769fe8a1330c8d9153e3d7fa

--
Regards,

Fedor
