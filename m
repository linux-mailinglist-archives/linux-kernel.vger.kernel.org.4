Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F00661168
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjAGTut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGTur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:50:47 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878E9482AF
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:50:46 -0800 (PST)
Received: from fedcomp.intra.ispras.ru (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id AAE39419E9CD;
        Sat,  7 Jan 2023 19:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru AAE39419E9CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1673121039;
        bh=zyDTpQsc+BA1w6l0ID0YaSJ5ZrE2jWSGJh7OYRgTWMY=;
        h=From:To:Cc:Subject:Date:From;
        b=D8BLxAjCNF9AtnFH/kxA2aqlhMSg3agzUOBdF3UeaUVGc43lkLhA33ZflQ0cZg1XK
         ZSwUrd0GQzY3j7yQ+GNBsbFbZ2Gs+/GcMZueqcDHHZ7pILFaVKZjEvRpGZlUZYNvu7
         B1VoTYByrQ/OIvArfSdNH80hjUCb3wWyOwsE71Mc=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Jan Kara <jack@suse.com>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 0/1] udf: Fix null-ptr-deref in udf_write_fi()
Date:   Sat,  7 Jan 2023 22:50:15 +0300
Message-Id: <20230107195016.290627-1-pchelkin@ispras.ru>
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

Hello Jan,

Syzkaller reports the following problems [1].

null-ptr-deref is fixed by the following patch.

About out-of-bounds write: I suppose it is due to the similar issue which
caused null-ptr-deref bug - udf_find_entry() return value is not checked
and we can end up with an incorrect ocfi and ofibh structs. Actually,
padlen in udf_write_fi() becomes less than zero because the values it is
consisted of are invalid, then padlen is passed to memcpy and here is the
bug. Should I also add this to the patch description text (I'm not sure
about it as that is just a consequence of null-ptr-deref bug)?

With the applied patch reproducers on my machine do not trigger
null-ptr-deref and out-of-bounds anymore.

The only thing is that: does udf_rename() need to immediately return with
an error if udf_find_entry() fails here? If ofi is an error pointer
(especially -ENOMEM), udf_rename should return an error. But if ofi is
NULL, the entry has probably already been deleted, and we should just skip
udf_delete_entry() call.

[1] https://syzkaller.appspot.com/bug?id=ddfcda66fe98b595b0fe11d9dd64eb532478f04b

Fedor
