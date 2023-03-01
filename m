Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689FF6A7521
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 21:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjCAURG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 15:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjCAUQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 15:16:21 -0500
Received: from mail.parknet.co.jp (mail.parknet.co.jp [210.171.160.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 702554FA93
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 12:16:01 -0800 (PST)
Received: from ibmpc.myhome.or.jp (server.parknet.ne.jp [210.171.168.39])
        by mail.parknet.co.jp (Postfix) with ESMTPSA id 9A0802055F9C;
        Thu,  2 Mar 2023 05:15:45 +0900 (JST)
Received: from devron.myhome.or.jp (foobar@devron.myhome.or.jp [192.168.0.3])
        by ibmpc.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 321KFi0n133318
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 05:15:45 +0900
Received: from devron.myhome.or.jp (foobar@localhost [127.0.0.1])
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Debian-2) with ESMTPS id 321KFiWh553350
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 2 Mar 2023 05:15:44 +0900
Received: (from hirofumi@localhost)
        by devron.myhome.or.jp (8.17.1.9/8.17.1.9/Submit) id 321KFgbu553342;
        Thu, 2 Mar 2023 05:15:42 +0900
From:   OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: Long mount time of ESP FAT partition
In-Reply-To: <af9723a2-a077-5fde-97d0-3c6ce216287a@molgen.mpg.de> (Paul
        Menzel's message of "Tue, 28 Feb 2023 14:00:06 +0100")
References: <af9723a2-a077-5fde-97d0-3c6ce216287a@molgen.mpg.de>
Date:   Thu, 02 Mar 2023 05:15:42 +0900
Message-ID: <87lekgxm6p.fsf@mail.parknet.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Menzel <pmenzel@molgen.mpg.de> writes:

> $ journalctl -b -u boot-efi.mount -o short-precise
> Feb 28 11:19:14.014469 morley systemd[1]: Mounting boot-efi.mount - 
> /boot/efi...
> Feb 28 11:19:15.550770 morley systemd[1]: Mounted boot-efi.mount - 
> /boot/efi.
> ```

This mount is always slow? For example, simply unmount and mount by
command is also slow after finished boot sequence?

Since that operation of log would include too many syscalls, we have to
find which syscall is slow. Then check the detail of it (e.g. I/O
request).

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
