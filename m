Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112BA697AE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 12:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232996AbjBOLhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 06:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjBOLhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 06:37:40 -0500
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A867436FC0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 03:37:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1676461059;
  x=1707997059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PEjpUWMbeln01XAviTHjoay8hTO1EQrZCx56ILrI2wE=;
  b=JqI5t1uni7/1NJ2aFQVWHBaV0qDruwEXGdu6ZHIF7NAyknxBdSgnntgJ
   uWwxKgDYXwLR/GMwspoOIUaCJtR8BLqUu1BNEtqACLhAq35LPl8P44dXm
   JkettPD/VUncnrihZ/XePX+1nR4EC/JAcCossu/xikPMZFmkyrQ2zkM6f
   GxbzkpiXTihloyPAxOgEspwmwmN95L8rzS/4IHFQA8gwH9MuDCONUHv0S
   Bqq49WSwENWl0FsF2aDlP634k6jtVeH911RiKVktDTDC2X/PwYmTWr2tP
   HcYqYE71hJoLCtYOjDWPxnNOm0YBHpJkHL6ILRCA5B5fksHvU48USRRCM
   A==;
Date:   Wed, 15 Feb 2023 12:37:36 +0100
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Michael Thalmeier <michael.thalmeier@hale.at>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <john.ogness@linutronix.de>, <pmladek@suse.com>
Subject: Re: [PATCH v2] tty: ttynull: implement console write
Message-ID: <Y+zEAA1hp+3guGxT@axis.com>
References: <20230214115921.399608-1-michael.thalmeier@hale.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230214115921.399608-1-michael.thalmeier@hale.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Cc: John, Petr

On Tue, Feb 14, 2023 at 12:59:21PM +0100, Michael Thalmeier wrote:
> Since commit a699449bb13b ("printk: refactor and rework printing logic"),
> con->write is called without checking if it is implemented in the console
> driver. This does make some sense, because for all "normal" consoles it
> is vital to have a write function.
> As the ttynull console driver does not need any console output the write
> function was not implemented. This caused a "unable to handle kernel NULL
> pointer dereference" when the write function is called now.
> 
> To fix this issue, implement an empty write function.
> 
> Fixes: a699449bb13b ("printk: refactor and rework printing logic")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>

Looking at the referenced commit, the only place I see it calling
con->write() is from call_console_driver(), which is in turn only called
from console_emit_next_record().  And console_flush_all(), the only
caller of console_emit_next_record(), checks that con->write is not NULL
using console_is_usable() before calling console_emit_next_record().

What am I missing?  Which code path in the referenced commit calls
con->write without checking for NULL?
