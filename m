Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95E56ADA50
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 10:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCGJ16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 04:27:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjCGJ1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 04:27:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0310D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 01:27:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D88D61298
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:27:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43D12C433D2;
        Tue,  7 Mar 2023 09:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678181271;
        bh=ogpfbMXCyg4VTzEjl6wEpYVmD4Q4RlhdDr3aLrDIZng=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NC6q3lf9YEU+OVnKpLKLp9l/WD4HpgLjlDVr0tI48ejlBQJAmANXnb98HRmhWLSMo
         9ekMt46+iWwXPv3CK6m8M3o5m35JzDmxg6BYgOh+6/y+9kkeN27G/pQcveZcMxEVd8
         V8Gcy7nPDvcq71/74zxLGaHpBCSkfFCHrzeLshfU=
Date:   Tue, 7 Mar 2023 10:27:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Xia Fukun <xiafukun@huawei.com>
Cc:     prajnoha@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kobject: Fix global-out-of-bounds in
 kobject_action_type()
Message-ID: <ZAcDlAkujTLkbrqr@kroah.com>
References: <20230307063757.247430-1-xiafukun@huawei.com>
 <ZAby1q1kA71S2WCv@kroah.com>
 <396e6a21-5270-1624-1229-1e59701cce35@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396e6a21-5270-1624-1229-1e59701cce35@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A: http://en.wikipedia.org/wiki/Top_post
Q: Were do I find info about this thing called top-posting?
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

A: No.
Q: Should I include quotations after my reply?

http://daringfireball.net/2007/07/on_top

On Tue, Mar 07, 2023 at 05:08:02PM +0800, Xia Fukun wrote:
> Thanks for your reply.
> Your understanding is correct."offline\0\0\0\0\0\0\0\0\0\0" is indeed blocked
> from matching "offline" and returns a failed result.
> 
> I'm not sure whether to relax the restrictions to make it match successfully.
> After all, the incoming count is too large and not the actual length of
> "offline".

But that doesn't matter at all.  Sometimes you do not have control over
the buffer length when writing to a file like this, what matters is the
content of the buffer and we should stop at the first \0 as that's the
"end of a string" in this type of api.

So your change here might break existing userspace code, and we can't do
that, sorry.

thanks,

greg k-h
