Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2D633C9A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 13:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbiKVMfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 07:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiKVMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 07:35:35 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100005B84D;
        Tue, 22 Nov 2022 04:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:Reply-To:Content-ID:Content-Description:
        In-Reply-To:References; bh=WNYH3Wf/F/BKreKTbCqzjC+1rMIGWdBr2obALWP6rRQ=; b=I3
        l1MCey4cfOQh+0NOa3qTF3QQOFG2nOJTicoX3Cv3gNypyyp+Y6gyj3q3t4bRpvGmpgdTJx2wEeKtb
        Xk0JRyrfAovyVyrXGF/gCe8q4FTqE1v17FarMyTJSKRkDC+wFvgKjxjkak3V6lSFd7L+YJRZjS67w
        CQXBlaM+a+u41s+5Dz74af2ZHoujuCgJXCdLCYre8doyidrj/3kTOou/r0j+KIk9a5dLu/xqWKYKJ
        j9uXC2S2e8lrwJnaCkHcD3fc1FMJhv/4Kn9aKC73qTAK9WgQ1XsiT+o6twaJeugyM1u2kGTyBilaP
        2sK6jXcWtM624XmFbtoe1e86y7CT3Y2A==;
Received: from [81.174.171.191] (helo=donbot.metanate.com)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1oxSUs-0003da-TD;
        Tue, 22 Nov 2022 12:35:31 +0000
From:   John Keeping <john@metanate.com>
To:     linux-usb@vger.kernel.org
Cc:     Fabien Chouteau <fabien.chouteau@barco.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Felipe Balbi <balbi@ti.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Keeping <john@metanate.com>, Lee Jones <lee@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 0/3] usb: gadget: f_hid: fix f_hidg lifetime vs cdev
Date:   Tue, 22 Nov 2022 12:35:20 +0000
Message-Id: <20221122123523.3068034-1-john@metanate.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series arises from the recent thread [1] on lifetime issues.

The main point is the first patch, with the second being an unrelated
fix for an issue spotted while working on this.  Both of these have
Fixes: tags for backporting to stable.

The final patch tidies up some error handling to hopefully avoid patch 2
issues in the future.

[1] https://lore.kernel.org/r/20221117120813.1257583-1-lee@kernel.org

John Keeping (3):
  usb: gadget: f_hid: fix f_hidg lifetime vs cdev
  usb: gadget: f_hid: fix refcount leak on error path
  usb: gadget: f_hid: tidy error handling in hidg_alloc

 drivers/usb/gadget/function/f_hid.c | 60 ++++++++++++++++-------------
 1 file changed, 33 insertions(+), 27 deletions(-)

-- 
2.38.1

