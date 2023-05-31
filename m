Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644AA7188E4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjEaRzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjEaRzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:55:21 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 82E6E126
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 10:55:19 -0700 (PDT)
Received: (qmail 445528 invoked by uid 1000); 31 May 2023 13:55:18 -0400
Date:   Wed, 31 May 2023 13:55:18 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v5 2/3] usb: gadget: udc: core: Invoke usb_gadget_connect
 only when started
Message-ID: <618e4f17-2799-4838-a21c-184c9303bef6@rowland.harvard.edu>
References: <20230531040203.19295-1-badhri@google.com>
 <20230531040203.19295-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531040203.19295-2-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 04:02:02AM +0000, Badhri Jagan Sridharan wrote:
> usb_udc_connect_control() does not check to see if the udc has already
> been started. This causes gadget->ops->pullup to be called through
> usb_gadget_connect() when invoked from usb_udc_vbus_handler() even
> before usb_gadget_udc_start() is called. Guard this by checking for
> udc->started in usb_udc_connect_control() before invoking
> usb_gadget_connect().

After a merged version of patches 1/3 and 3/3 have been applied, it 
seems like most of this will not be needed any more.  Maybe not any of 
it.

usb_udc_connect_control() gets called from only two places.  One of them 
is in gadget_bind_driver(), where we know that the UDC has been started 
and connecting is allowed.  The other place is the vbus work routine 
queued by usb_udc_vbus_handler().  If that place checks the new 
allow_connect flag before calling usb_gadget_connect(), nothing more 
will be needed.  You just have to make sure that the allow_connect flag 
is set in gadget_bind_driver between the start and connect_control 
calls, and it is cleared in gadget_unbind_driver before the 
cancel_work_sync call.

It's possible that a new mutex will be needed to synchronize accesses to 
the allow_connect flag.  That's something you will have to study and 
decide on.  But if you can avoid adding one, that would be best.

> Guarding udc->vbus, udc->started, gadget->connect, gadget->deactivate
> related functions with connect_lock. usb_gadget_connect_locked(),
> usb_gadget_disconnect_locked(), usb_udc_connect_control_locked(),
> usb_gadget_udc_start_locked(), usb_gadget_udc_stop_locked() are called
> with this lock held as they can be simulataneously invoked from
> different code paths.

It's a general principle of kernel programming that locks protect data, 
not code.  So if this patch were to be accepted, you would have to 
change this description to say that connect_lock guards various flags, 
not various function calls.

Alan Stern
