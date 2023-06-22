Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAE673A39F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 16:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjFVOwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 10:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFVOv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 10:51:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BD1212A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A7DE961888
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 14:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5AF0C433C0;
        Thu, 22 Jun 2023 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687445481;
        bh=b+2YQt/L3f18cPrjrpPVNB62Jp6PLhPadnkvondgfqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FizK5F5LJERjZ8EtqyjdqGZvydLRYrIzRHMTTFw8Fn8P9/oPylegaFeNt+QqmrbM0
         28uRyY59h8Oo8qBLgGBXtARH8GKKhSdz844UJj9SAaGIogWMxsaCMslJ5WeAbnK3Z4
         fM+wws01ii+g+GF4jXelZQKZUhRodhQ1w0vwURGs=
Date:   Thu, 22 Jun 2023 16:51:18 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Marcel Holtmann <marcel@holtmann.org>, linux-cachefs@redhat.com,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] cachefiles: allocate static minor for /dev/cachefiles
Message-ID: <2023062245-synopses-scared-9d96@gregkh>
References: <20230615160806.94000-1-marcel@holtmann.org>
 <1886146.1687441374@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1886146.1687441374@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 02:42:54PM +0100, David Howells wrote:
> Marcel Holtmann <marcel@holtmann.org> wrote:
> 
> > The cachefiles misc character device uses MISC_DYNAMIC_MINOR and thus
> > doesn't support module auto-loading. Assign a static minor number for it
> > and provide appropriate module aliases for it. This is enough for kmod to
> > create the /dev/cachefiles device node on startup and facility module
> > auto-loading.
> 
> Why?  The systemd unit file for it just modprobe's the module first.  It's a
> specialist device file only for use by the appropriate daemon.

And you really don't want to have auto-module-loading when trying to
open a /dev/foo file, that way lies madness in the past, please let's
learn from our mistakes :)

thanks,

greg k-h
