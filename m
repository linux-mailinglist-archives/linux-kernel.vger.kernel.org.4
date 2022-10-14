Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA45FEAA9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 10:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiJNIkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 04:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiJNIkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 04:40:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70851AAE44;
        Fri, 14 Oct 2022 01:40:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 39C9721FD5;
        Fri, 14 Oct 2022 08:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1665736845; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IrBnTOTPEBduuCsMotacV/UUwqSME3+WK+RUNH/MN5o=;
        b=LAtAspSt3FAi35njfOXph2UayM285L5/pCmVZHnh7hly+Dwcd3AIo04voxQQqOB1nYhCl3
        s/72ftDXNQBjboPNqVrrr0lBchtPhLm7PiTuXWMeqhd19H0yQEJimr7DL5HZCcO8srnp3a
        uuvnYaIZaSeAuBFUs7vG1GrNE7k2Ve8=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 162DD2C141;
        Fri, 14 Oct 2022 08:40:45 +0000 (UTC)
Date:   Fri, 14 Oct 2022 10:40:41 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Petr Pavlu <petr.pavlu@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] module: Correct wake up of module_wq
Message-ID: <Y0kgiafwcH8RY2qc@alley>
References: <20220919123233.8538-1-petr.pavlu@suse.com>
 <20220919123233.8538-2-petr.pavlu@suse.com>
 <YzdQAWa5eRtfOwHl@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzdQAWa5eRtfOwHl@bombadil.infradead.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 13:22:25, Luis Chamberlain wrote:
> On Mon, Sep 19, 2022 at 02:32:32PM +0200, Petr Pavlu wrote:
> > The module_wq wait queue has only non-exclusive waiters and all waits
> > are interruptible, therefore for consistency use wake_up_interruptible()
> > to wake its waiters.
> > 
> > Suggested-by: Petr Mladek <pmladek@suse.com>
> > Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> 
> Does this fix a bug? It seems like it does. Please think of this should
> go to stable, for instance, does it fix a bug not yet reported?

It is rather a clean up. It should not change the existing behavior.

wake_up_all() is needed only in special situations when
exclusive waiters are used. Also wake_up_*() variant should match
the related wait_for_completion_*() variants.

The patch looks good:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
