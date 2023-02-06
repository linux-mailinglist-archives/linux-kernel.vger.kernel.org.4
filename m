Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DBC68C12E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbjBFPSG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:18:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjBFPR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:17:56 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 938594C09
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 07:17:54 -0800 (PST)
Received: (qmail 657159 invoked by uid 1000); 6 Feb 2023 10:17:53 -0500
Date:   Mon, 6 Feb 2023 10:17:53 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     =?utf-8?B?5pyx5b+g5p2w?= <zhongjiezhu1@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: core: hub: fix usb_hub worker blocking
 drain_all_pages() worker issue
Message-ID: <Y+EaIRHZfLs49w9L@rowland.harvard.edu>
References: <20230203072819.3408-1-zhongjiezhu1@gmail.com>
 <Y90egBL6HSoEdz2P@rowland.harvard.edu>
 <CAJnoMhNYDXjfttiio+P7k6W1fDU3N=jbjmZe+ZRVON=bqm0yvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnoMhNYDXjfttiio+P7k6W1fDU3N=jbjmZe+ZRVON=bqm0yvw@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 11:33:15AM +0800, 朱忠杰 wrote:
> Yes, this is a very special case.
> 
> It will happen only when disconnecting the mass storage if there are
> too many files in the storage, and the scanning operation is running,
> and the file system is not unmounted.
> It looks like this issue should be fixed in the usb mass storage
> driver, but I don't find an appropriate place.

That's not surprising, because usb-storage doesn't know anything about 
what's happening on the mass-storage device it connects to.  All it does 
is send the commands that it gets from the SCSI subsystem to the device 
and receive the results back.  It has no idea whether there is a mounted 
filesystem on the device, if the filesystem contains any files, or 
whether a scanning operation is running,

A better place to look for fixing this might be the filesystem code.  
That's where the information about mounting, files, and scanning can be 
found.

Alan Stern
