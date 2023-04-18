Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDE66E6628
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbjDRNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbjDRNoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:44:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BE8B74D
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:44:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id ED0FA1FD64;
        Tue, 18 Apr 2023 13:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681825438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OxhMh+ITikctSBmgWsRrV7mG+WiCNYWFwb/p5BvlDmM=;
        b=Pd5Y/oIP8ZjU2/JJGpjWYKrvWnxtkbaaWIJ+QoCnjNdnjf5Jx91QLUEohiHNStL4U84cEL
        r1S5XFxXzYa16bDTudORsIuJMqWwGA2tZ164MUSUdypl26ryQSo9hKmBZ31+lrH1ELlu/K
        rD9j/tY9jxm1BKnLl/vX66tYnqAcUDU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B888A2C141;
        Tue, 18 Apr 2023 13:43:58 +0000 (UTC)
Date:   Tue, 18 Apr 2023 15:43:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Chris Down <chris@chrisdown.name>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 1/2] printk: console: Create console= parser that
 supports named options
Message-ID: <ZD6envPT9YHVEaAx@alley>
References: <cover.1658339046.git.chris@chrisdown.name>
 <732ee897b2bd49ada3f7dee396475c5a2195071b.1658339046.git.chris@chrisdown.name>
 <Yw80MmyBl4js09If@alley>
 <ZD1f-1JjpihR1djd@chrisdown.name>
 <ZD1g2zidSD80OyJO@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZD1g2zidSD80OyJO@chrisdown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-04-17 16:08:11, Chris Down wrote:
> Chris Down writes:
> > Any thoughts on something simple like this that takes advantage of
> > memmove()? This should overcome the mmio/io concerns, and it's fairly
> > simple.
> 
> (although coming to think of it, this can just use memcpy(), but the same
> idea applies)

I think that we have to use memmove() because the locations might be
overlaping. The to-be-moved options might be longer than the replaced
option.

Best Regards,
Petr
