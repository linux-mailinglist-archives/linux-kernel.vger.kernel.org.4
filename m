Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E745E6FDCD2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 13:36:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbjEJLgG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 07:36:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbjEJLgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 07:36:00 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15F7C2D77
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 04:35:59 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5C6511EC067E;
        Wed, 10 May 2023 13:35:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683718557;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=PkOGxR0M+FAPkq52+rH7zXIhdbVNcWipgwSVZpJf70E=;
        b=TPM3gYl37YJLIK/XtmqUOJzS/ZpXdHIBRxfQ1+mDeUyBpZ6jBdiJaAj7aAN0YhQFS8n0IS
        de/IUb0zIXCU74S+IvKw+cgKTXRWHlqbtzjVHPRCI+mFjciO/fUQuQ5PqE91tJvG68TtQl
        qCbrBq1I7LqzUsmnj5jWlUunepuk04E=
Date:   Wed, 10 May 2023 13:35:53 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Yazen Ghannam <yazen.ghannam@amd.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/amd_nb: Check for invalid SMN reads
Message-ID: <20230510113553.GAZFuBmZbhAFkbqm1a@fat_crate.local>
References: <20230403164244.471141-1-yazen.ghannam@amd.com>
 <20230403193245.GCZCsp3RjNZFSE5f9s@fat_crate.local>
 <abc57738-6ab9-50e6-6c05-5059299d19d1@amd.com>
 <20230403203623.GDZCs4x5yVReaPVOaS@fat_crate.local>
 <a8826972-376a-5af6-8e61-d74520e355df@amd.com>
 <20230405180648.GEZC24uJ+GSMZxczaW@fat_crate.local>
 <05c682d7-bddc-d990-37fb-cd1779f7e604@amd.com>
 <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <83d4ad40-4812-0583-ba4a-da3e79732e51@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 05, 2023 at 03:10:09PM -0400, Yazen Ghannam wrote:
> What do you think?

Yes, please put that as a comment over __amd_smn_rw() as to why callers
should check the retval *and* make both the read and the write
__must_check and get rid of

        if (err)
                pr_warn("Error %s SMN address 0x%x.\n",
                        (write ? "writing to" : "reading from"), address);

which won't be seen in all cases. The __must_check will force the
callers to do the proper checking which is the only sane thing to do
with such a variety of bit behaviors.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
