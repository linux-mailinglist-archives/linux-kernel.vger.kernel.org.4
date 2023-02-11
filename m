Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A575069336E
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 21:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbjBKUAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 15:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKUAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 15:00:16 -0500
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7196016327;
        Sat, 11 Feb 2023 12:00:14 -0800 (PST)
Received: from fpc.. (unknown [46.242.14.200])
        by mail.ispras.ru (Postfix) with ESMTPSA id F329840737BC;
        Sat, 11 Feb 2023 20:00:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru F329840737BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
        s=default; t=1676145607;
        bh=9zZWgSw2dv+vNDtDe9Rvl8F7Fv/omJW33B6s3CwSepw=;
        h=From:To:Cc:Subject:Date:From;
        b=UV8cC8i/VJR6dOw5qrWQVjrvZobF4sAHOKO77Dx2Olqw71vl+31G7UsLhS1nkWpfW
         58CMu34LCak4dnoqrykA+37uVW1/2/CCWuw5liMg7ovorVKf7PD1Qt4rqtzhfgDTa+
         TthFD0JyphXqEbDSU4MvCRhHQmYy9m44AKjWDDzw=
From:   Fedor Pchelkin <pchelkin@ispras.ru>
To:     Ian Kent <raven@themaw.net>
Cc:     Fedor Pchelkin <pchelkin@ispras.ru>,
        Matthew Wilcox <willy@infradead.org>,
        Andrei Vagin <avagin@gmail.com>,
        Takeshi Misawa <jeliantsurux@gmail.com>,
        autofs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        lvc-project@linuxtesting.org
Subject: [PATCH 0/1] autofs: fix memory leak of waitqueues in autofs_catatonic_mode
Date:   Sat, 11 Feb 2023 22:59:49 +0300
Message-Id: <20230211195950.452364-1-pchelkin@ispras.ru>
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

Syzkaller reports the leak [1]. It is reproducible.

The following patch fixes the leak. It was proposed by Takeshi Misawa and
tested by Syzbot.

In other places of the code the waitqueue is freed when its wait_ctr
becomes zero (see autofs_wait_release). So I think it is not actually
supposed that inside autofs_catatonic_mode wait_ctr cannot be decreased to
zero. Please correct me if I'm wrong.

Also, looking at the discussion [2] of the '[PATCH] autofs4: use wake_up()
instead of wake_up_interruptible', shouldn't wake_up_interruptible()
inside autofs_catatonic_mode() be replaced with wake_up()?

[1] https://syzkaller.appspot.com/bug?id=a9412f636e2d733130f8def7975897d0b57f6e37
[2] https://www.spinics.net/lists/autofs/msg01875.html
