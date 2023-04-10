Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D402E6DCAD7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjDJShN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjDJShL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:37:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F144511B;
        Mon, 10 Apr 2023 11:37:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7147C61E7C;
        Mon, 10 Apr 2023 18:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C206C433EF;
        Mon, 10 Apr 2023 18:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681151829;
        bh=623dasWmscGyY+Q6atpJKWeyuHlDLhJJ8TIjaQYzSrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p3OClRvqnLBy1hGAjb3FSqiTeoVDoPJGpup53Tn85z/FxfMpHxH6AuWQOiw5w2IiS
         FXQiw+gY+9HL3nuuN30LropRwfBWPOejmegpBKzvE+4jIc/CDxSHcDhl3y7AO2vrBp
         QbdUIKN/hnM9A1PiB6yS05gzQe2TtdQDVAyQLPOU=
Date:   Mon, 10 Apr 2023 20:37:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Topi Miettinen <toiwoton@gmail.com>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Per-process flag set via prctl() to deny module loading?
Message-ID: <2023041010-vacation-scribble-ba46@gregkh>
References: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 10, 2023 at 01:06:00PM +0300, Topi Miettinen wrote:
> I'd propose to add a per-process flag to irrevocably deny any loading of
> kernel modules for the process and its children. The flag could be set (but
> not unset) via prctl() and for unprivileged processes, only when
> NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, but
> unlike capabilities, there would be no issues with namespaces since the flag
> isn't namespaced.
> 
> The implementation should be very simple.

Patches are always welcome to be reviewed.

But note, please watch out for processes that cause devices to be found,
and then modules to be loaded that way, it's not going to be as simple
as you might have imagined...

thanks,

greg k-h
