Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07D5674C70
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 06:34:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbjATFeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 00:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjATFd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 00:33:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA867DFA3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 21:29:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 62DB8B82541
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 15:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8BA7C433D2;
        Thu, 19 Jan 2023 15:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674141732;
        bh=fuaHiayN9/WGnI4UfXAsrYe5slppaGLjht5c//g5Dao=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i0Cwq+LOB2ZsI2hwk9upoYclocTwEPiJXd2t4U7E034fADlivKkFPR3aksHSRAI6e
         HR6fo+kAN5RWQOyuXXw6habE8janoQhrKiCphNxJQQG17F0jnHFEWFTeduqOVaiIJu
         WG5pS1WVRiTFES4AG3EiCCT7XiT/+MveLG6dM5Ns=
Date:   Thu, 19 Jan 2023 16:22:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elena.reshetova@intel.com,
        kirill.shutemov@linux.intel.com, Amit Shah <amit@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 4/6] virtio console: Harden control message handling
Message-ID: <Y8lgIS+jygB7SGrn@kroah.com>
References: <20230119135721.83345-1-alexander.shishkin@linux.intel.com>
 <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119135721.83345-5-alexander.shishkin@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 03:57:19PM +0200, Alexander Shishkin wrote:
> In handle_control_message(), we look at the ->event field twice, which
> gives a malicious VMM a window in which to switch it from PORT_ADD to
> PORT_REMOVE, triggering a null dereference further down the line:

How is the other VMM have full control over the full message here?
Shouldn't this all have been copied into our local memory if we are
going to be poking around in it?  Like I mentioned in my other review,
copy it all once and then parse it.  Don't try to mess with individual
fields one at a time otherwise that way lies madness...

thanks,

greg k-h
