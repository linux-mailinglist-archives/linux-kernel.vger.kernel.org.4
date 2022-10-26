Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAAC60E402
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 17:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiJZPCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 11:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234115AbiJZPCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 11:02:20 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id AED12A50DA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 08:02:18 -0700 (PDT)
Received: (qmail 1489809 invoked by uid 1000); 26 Oct 2022 11:02:17 -0400
Date:   Wed, 26 Oct 2022 11:02:17 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Eli Billauer <eli.billauer@gmail.com>
Cc:     gregkh@linuxfoundation.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        imv4bel@gmail.com
Subject: Re: [PATCH] char: xillybus: Prevent use-after-free due to race
 condition
Message-ID: <Y1lL+dVsJo2zu3Gy@rowland.harvard.edu>
References: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e5cbdfe-f6cd-d24f-9785-55176af6c975@gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 11:52:40AM +0300, Eli Billauer wrote:
> xillybus_find_inode() is called by xillybus_open() and xillyusb_open()
> to translate the inode's major and minor into a pointer to a relevant
> data structure and an index.
> 
> But with xillyusb_open(), the data structure can be freed by
> xillyusb_disconnect() during an unintentional time gap between the
> release of the mutex that is taken by xillybus_find_inode() and the
> mutex that is subsequently taken by xillyusb_open().
> 
> To fix this, xillybus_find_inode() supplies the pointer to the mutex that
> it has locked (when returning success), so xillyusb_open() releases this
> mutex only after obtaining the mutex that is specific to a device file.
> This ensures that xillyusb_disconnect() won't release anything that is in
> use.

The standard way of handling this problem is different from this.  The 
driver defines a private mutex, and it ensures that any routine calling 
*_find_inode() holds the mutex.  It also ensures that the mutex is held 
while a new device is being registered and while a device is being 
removed.

Even that won't fix all the synchronization problems.  A process can 
open a device, and then after the device has been removed the process 
can still try to access the device.  The driver needs to ensure that 
such accesses are not allowed.

Alan Stern
