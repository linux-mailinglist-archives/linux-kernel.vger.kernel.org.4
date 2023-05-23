Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C853670E9EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbjEXABt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237460AbjEXABr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:01:47 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 23 May 2023 17:01:23 PDT
Received: from sunphoto.ro (sunphoto.ro [193.203.204.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6E208E49
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 17:01:23 -0700 (PDT)
Received: from sunphoto.ro (localhost [127.0.0.1])
        by sunphoto.ro (Postfix) with ESMTP id 646CE914CD46
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:54:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=sunphoto.ro; h=from:to
        :subject:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=postfix2; bh=Yialrhjs9YIUGR2oBr36J
        9txyrQ=; b=PtOzfpd8b46YnFn8g2HSGCXWNyTUWZxNgQ4GoTE/g9mHIcZ13Qfva
        TDp3BMuLctr7F1VtzSYh3WHeZHBUv662WoE8ygaC5Csgj5C7tAbsmCLCWTcwtRVN
        HV8l1V4Rw7bNAaHe6BxDWBOn4FUqeHhoQt7+20O4MVRN83C/nAmevI=
Received: from S (unknown [79.113.95.106])
        by sunphoto.ro (Postfix) with ESMTPSA id 502B1914CD40
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 02:54:44 +0300 (EEST)
From:   "Claudiu" <jazzman@misalpina.net>
To:     <linux-kernel@vger.kernel.org>
Subject: OverlayFS performance with a slow CIFS lowerdir
Date:   Wed, 24 May 2023 02:54:45 +0300
Message-ID: <0dc801d98dd1$f38dfb70$daa9f250$@misalpina.net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdmNzwbwUfgnwqHYQuqy07Q61Ws5qQ==
Content-Language: en-gb
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

If there is a better list to post this to, please point me to it.

I have a readonly OverlayFS setup with a few lowerdirs in which the last of
the lowerdirs is a CIFS mount. This is a share from a remote homeserver with
drives that may go to sleep or may get disconnected. I experience
performance issues from time to time when accessing data via the overlay
even if that data is available in the first lowerdir and I suspect that this
is happening because of a slow CIFS access (sleeping drives may need to spin
up?).
Also, when the CIFS mount is dead (server unreachable), accessing the
overlay in any way seems to hang.

Is this behaviour as expected?
Are there any module/mount options that can improve this behaviour?

Notes:
- All lowerdirs are quite big file systems with tens of millions of files
- Running Debian stable with 5.10.0-21-amd64.

Thanks.

