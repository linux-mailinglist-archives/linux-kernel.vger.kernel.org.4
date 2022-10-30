Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 663AD612B9A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 17:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiJ3QXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 12:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3QXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 12:23:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 57F8018B
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 09:23:20 -0700 (PDT)
Received: (qmail 162170 invoked by uid 1000); 30 Oct 2022 12:23:19 -0400
Date:   Sun, 30 Oct 2022 12:23:19 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imv4bel@gmail.com
Subject: Re: [PATCH v2] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <Y16k90Lk2fehKqRC@rowland.harvard.edu>
References: <20221030094209.65916-1-eli.billauer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221030094209.65916-1-eli.billauer@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 11:42:09AM +0200, Eli Billauer wrote:
> The driver for XillyUSB devices maintains a kref reference count on each
> xillyusb_dev structure, which represents a physical device. This reference
> count reaches zero when the device has been disconnected and there are no
> open file descriptors that are related to the device. When this occurs,
> kref_put() calls cleanup_dev(), which clears up the device's data,
> including the structure itself.
> 
> However, when xillyusb_open() is called, this reference count becomes
> tricky: This function needs to obtain the xillyusb_dev structure that
> relates to the inode's major and minor (as there can be several such).
> xillybus_find_inode() (which is defined in xillybus_class.c) is called
> for this purpose. xillybus_find_inode() holds a mutex that is global in
> xillybus_class.c to protect the list of devices, and releases this
> mutex before returning. As a result, nothing protects the xillyusb_dev's
> reference counter from being decremented to zero before xillyusb_open()
> increments it on its own behalf. Hence the structure can be freed
> due to a rare race condition.
> 
> To solve this, a mutex is added. It is locked by xillyusb_open() before
> the call to xillybus_find_inode() and is released only after the kref
> counter has been incremented on behalf of the newly opened inode. This
> protects the kref reference counters of all xillyusb_dev structs from
> being decremented by xillyusb_disconnect() during this time segment, as
> the call to kref_put() in this function is done with the same lock held.
> 
> There is no need to hold the lock on other calls to kref_put(), because
> if xillybus_find_inode() finds a struct, xillyusb_disconnect() has not
> made the call to remove it, and hence not made its call to kref_put(),
> which takes place afterwards. Hence preventing xillyusb_disconnect's
> call to kref_put() is enough to ensure that the reference doesn't reach
> zero before it's incremented by xillyusb_open().
> 
> It would have been more natural to increment the reference count in
> xillybus_find_inode() of course, however this function is also called by
> Xillybus' driver for PCIe / OF, which registers a completely different
> structure. Therefore, xillybus_find_inode() treats these structures as
> void pointers, and accordingly can't make any changes.
> 
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Eli Billauer <eli.billauer@gmail.com>

It looks like the xillybus driver already has a private mutex that would 
have been very well suited for this task: unit_mutex defined in 
xillybus_class.c.  Of course, there's nothing wrong with using a new 
mutex instead -- just make sure there aren't any ABBA locking order 
problems.

Alan Stern
