Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D2F6058E7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 09:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbiJTHo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 03:44:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbiJTHoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 03:44:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA73212
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 00:44:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA3C661A2A
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 07:44:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6E5C433D6;
        Thu, 20 Oct 2022 07:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666251841;
        bh=O8VY0wI9/3En4GC1jrJRx7Muph8YeCnAP79nOYeaWUA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HNd/B7E0DBewDV9k8larAM6Ioigw1KuZAHJABwM7nokYbfHv7jdBv3aunclOHQF5y
         D9d6XCBuuw+R/8F/aL4CNPiDu5r952WsMHvVyv5oMmbcybRTR5RtPj3T2i/ahxPY2R
         6RO/sM7xygBW0yGBVcGerFXaDOqJFOliQ+gT/ObY=
Date:   Thu, 20 Oct 2022 09:43:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH printk v2 35/38] tty: tty_io: use console_list_lock for
 list synchronization
Message-ID: <Y1D8Pg9PS17BDg6R@kroah.com>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-36-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019145600.1282823-36-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 05:01:57PM +0206, John Ogness wrote:
> show_cons_active() uses the console_lock to gather information
> on registered consoles. It requires that no consoles are unregistered
> until it is finished. The console_list_lock should be used because
> list synchronization repsponsibility will be removed from the
> console_lock in a later change.
> 
> Note, the console_lock is still needed to stop console printing.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
