Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABA36F3D7A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 08:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjEBGcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 02:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231610AbjEBGcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 02:32:20 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AE6B1BFF
        for <linux-kernel@vger.kernel.org>; Mon,  1 May 2023 23:32:19 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 3426WF1o027706;
        Tue, 2 May 2023 08:32:15 +0200
Date:   Tue, 2 May 2023 08:32:15 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools/nolibc: remove LINUX_REBOOT_ constants
Message-ID: <ZFCubzgPxBSDiTwq@1wt.eu>
References: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230428-nolibc-reboot-v1-1-0bca02d20ba6@weissschuh.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Apr 28, 2023 at 05:52:11PM +0200, Thomas Weißschuh wrote:
> The same constants and some more have been exposed to userspace via
> linux/reboot.h for a long time.
> 
> To avoid conflicts and trim down nolibc a bit drop the custom
> definitions.

For me it breaks the build when including nolibc directly, so most
likely we need to include certain files:

  In file included from /g/public/linux/master/tools/include/nolibc/nolibc.h:99,
                   from <command-line>:
  /g/public/linux/master/tools/include/nolibc/sys.h: In function 'reboot':
  /g/public/linux/master/tools/include/nolibc/sys.h:972:30: error: 'LINUX_REBOOT_MAGIC1' undeclared (first use in this function)
    972 |         int ret = sys_reboot(LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, cmd, 0);
        |                              ^~~~~~~~~~~~~~~~~~~
  /g/public/linux/master/tools/include/nolibc/sys.h:972:30: note: each undeclared identifier is reported only once for each function it appears in

I suspect it might be like the S_* macros for stat() that we had to
guard against. What build conflict did you meet ? I would like as well
to redefine the least possible and if we can make sure to fix the
conflict efficiently without breaking code, that would be better.

Thanks,
Willy
