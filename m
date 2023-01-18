Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E038B6718EA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 11:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjARK0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 05:26:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjARK0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 05:26:05 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EE5DC28;
        Wed, 18 Jan 2023 01:31:20 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 6C73E20C5D;
        Wed, 18 Jan 2023 09:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1674034279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bVp7KTcQDbxHoHXUlHU1XAYm2vJ+8Qy42f6yOSykfsw=;
        b=n495Qf5SXOkdloH73gDVq4FvILM4H5GRWv25FvN0hgfoJWOj7Dk8oP1z3pHYZRuGI6zitG
        eilW4gukzty5h+F7kdWDBvvJ0x0YlpSaeLJTljal56TtFfA6SxNOQtIHGe6sz+JnhpxVmq
        3HcQXJPVCUYlRi1LTHHAxSGiN2FnCZY=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D346C2C141;
        Wed, 18 Jan 2023 09:31:18 +0000 (UTC)
Date:   Wed, 18 Jan 2023 10:31:16 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        coverity-bot <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] printk: Use scnprintf() to print the message about the
 dropped messages on a console
Message-ID: <Y8e8ZCTdEWU0iUqJ@alley>
References: <20230117161031.15499-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230117161031.15499-1-pmladek@suse.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2023-01-17 17:10:31, Petr Mladek wrote:
> Use scnprintf() for printing the message about dropped messages on
> a console. It returns the really written length of the message.
> It prevents potential buffer overflow when the returned length is
> later used to copy the buffer content.
> 
> Note that the previous code was safe because the scratch buffer was
> big enough and the message always fit in. But scnprintf() makes
> it more safe, definitely.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1530570 ("Memory - corruptions")
> Fixes: c4fcc617e148 ("printk: introduce console_prepend_dropped() for dropped messages")
> Link: https://lore.kernel.org/r/202301131544.D9E804CCD@keescook
> Signed-off-by: Petr Mladek <pmladek@suse.com>

JFYI, the patch has been comitted into printk/linux.git,
branch rework/buffers-cleanup.

Best Regards,
Petr
