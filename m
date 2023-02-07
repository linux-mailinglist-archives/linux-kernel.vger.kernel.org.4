Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C83768D61A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbjBGL7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbjBGL7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:59:47 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 381881C336;
        Tue,  7 Feb 2023 03:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=In-Reply-To:Content-Type:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description; bh=SwNfBQdytqcD5R0x5w6EaPtW4xgLiprOimA8MmIP7zQ=; b=Alw8R
        760YfE+zq25EJElMa0mhL/bf1uj118PAmzIqwjuwNNsnEfdTym1WTLlRGiIXrnu/edJHEY+vFPIVI
        1lz4WSHE76N9FzSVDtMg0ia1XcElqw/r+1oN+V1X/oFqVUWIO4VPdtJungDFzv5uPql0DzHnfMJmu
        kD1grnJjXPrUrSIzV5RnbEtCgfj1uwX36cvgfWflgbPba+BbWeIYZCPHeNmJ2gZuiVVZ8dI18sFvM
        k5LBsga0ZXgjuhIEGaKB/gzg1Qm2VbdiN/7unegDQVd3CXD4zzwQF6N0U3FQIkn9GuTWfb8FUJoEH
        ywMgSG/SGIjsrMrE7rA6V/CIpFoZA==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <john@metanate.com>)
        id 1pPMdC-0000ef-Jv;
        Tue, 07 Feb 2023 11:59:26 +0000
Date:   Tue, 7 Feb 2023 11:59:25 +0000
From:   John Keeping <john@metanate.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Xin Zhao <xnzhao@google.com>, gregkh@linuxfoundation.org,
        jakobkoschel@gmail.com, rdunlap@infradead.org, ira.weiny@intel.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: dummyhcd: Fix use-after-free in
 dummy_free_request
Message-ID: <Y+I9HcPvrm1TzUCw@donbot>
References: <20230206225258.2302954-1-xnzhao@google.com>
 <Y+GcoFKiAkrCoAsv@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+GcoFKiAkrCoAsv@rowland.harvard.edu>
X-Authenticated: YES
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:34:40PM -0500, Alan Stern wrote:
> On Mon, Feb 06, 2023 at 10:52:58PM +0000, Xin Zhao wrote:
> > DummyHCD assume when dummy_free_request is called, the request
> > is already detached from request queues. It is correct in most
> > cases.
> > But when DummyHCD is detached from gadget configfs with pending
> > requests and some requests are still in pending queue,
> > dummy_free_request would free them directly.
> > Later on, dummy_udc_stop would iterate pending queue to release
> > the requests again.
> > 
> > Stacktrace for dummy_free_reqeust
> > ```
> > kfree(const void * x) (slub.c:4200)
> > dummy_free_request(struct usb_ep * _ep, struct usb_request * _req) (dummy_hcd.c:691)
> > usb_ep_free_request(struct usb_ep * ep, struct usb_request * req) (core.c:201)
> > functionfs_unbind(struct ffs_data * ffs) (f_fs.c:1894)
> 
> That's the bug right there.  The kerneldoc for usb_ep_free_request() 
> says "Caller guarantees the request is not queued".  So it looks like 
> the real solution is to fix functionfs_unbind().

This is commit ce405d561b02 ("usb: gadget: f_fs: Ensure ep0req is
dequeued before free_request") IIUC.

Xin, are you able to test a version with that commit?
