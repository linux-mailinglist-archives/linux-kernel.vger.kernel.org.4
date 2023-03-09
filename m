Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2221B6B320D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 00:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjCIX06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 18:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjCIX0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 18:26:55 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B221033A2;
        Thu,  9 Mar 2023 15:26:54 -0800 (PST)
Date:   Thu, 9 Mar 2023 23:26:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678404413;
        bh=ux9NVh/SJtqN4uPNVCVjQcIF51NeF7WtFGZPYrwhnms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tNHAlZ4tTynjTBhZNO16V0LxrPNdrSz+TnjI0442bxnlHLzVeWJKEly1Ew/X7CqQg
         jUgVchU6pEx/ruVYvtNyaLTeSuGfG9WteuSjQOqB8Lsj+0je3DU2AFyNMOJnRMgEwh
         8MuQaG3RPQRbkWcxXvM77Vo2Fh0gbc/rR+PLJJJA=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] block: don't embed integrity_kobj into gendisk
Message-ID: <7f977a5d-8302-4a32-9dce-f6d7637b2555@t-8ch.de>
References: <20230309-kobj_release-gendisk_integrity-v1-1-a240f54eac60@weissschuh.net>
 <d85ba503-d93c-3483-25e1-6043d4af444f@alu.unizg.hr>
 <0ac9777c-7586-494f-bbc5-87f14f645b12@t-8ch.de>
 <d10f18b4-56cf-8a55-b12f-79b1163d8841@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d10f18b4-56cf-8a55-b12f-79b1163d8841@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 10:46:50PM +0100, Mirsad Goran Todorovac wrote:
> On 09. 03. 2023. 22:23, Thomas Weißschuh wrote:
> 
> Very well, but who then destroys the cache crated here:
> 
> security/integrity/iint.c:177-179
> > 177         iint_cache =
> > 178             kmem_cache_create("iint_cache", sizeof(struct integrity_iint_cache),
> > 179                               0, SLAB_PANIC, init_once);
> 
> I assumed that it must have been done from iint.c because iint_cache is
> static?

It doesn't seem like anything destroys this cache.

I'm not sure this is a problem though as iint.c can not be built as module.

At least it's not a problem with kobjects as those are not used here.

> BTW, moving check for !ktype->release to kobject_init() is great for it
> might make such problems noticed in dmesg, rather than taking screenshots.
> 
> Regards,
