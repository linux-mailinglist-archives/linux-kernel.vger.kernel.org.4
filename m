Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B16718ED6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 00:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjEaWzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 18:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjEaWzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 18:55:36 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 6FE3A107
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 15:55:33 -0700 (PDT)
Received: (qmail 454049 invoked by uid 1000); 31 May 2023 18:55:32 -0400
Date:   Wed, 31 May 2023 18:55:32 -0400
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
Message-ID: <0125d274-bac3-41e1-bd29-156a3bfcc995@rowland.harvard.edu>
References: <20230531040203.19295-1-badhri@google.com>
 <20230531040203.19295-2-badhri@google.com>
 <618e4f17-2799-4838-a21c-184c9303bef6@rowland.harvard.edu>
 <CAPTae5KrTBa-=JuBDD8iVCx1+Hqd14yWOiCRkAg0+a75Q9QcXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5KrTBa-=JuBDD8iVCx1+Hqd14yWOiCRkAg0+a75Q9QcXA@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 03:40:26PM -0700, Badhri Jagan Sridharan wrote:
> On Wed, May 31, 2023 at 10:55 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > On Wed, May 31, 2023 at 04:02:02AM +0000, Badhri Jagan Sridharan wrote:
> > > usb_udc_connect_control() does not check to see if the udc has already
> > > been started. This causes gadget->ops->pullup to be called through
> > > usb_gadget_connect() when invoked from usb_udc_vbus_handler() even
> > > before usb_gadget_udc_start() is called. Guard this by checking for
> > > udc->started in usb_udc_connect_control() before invoking
> > > usb_gadget_connect().
> >
> > After a merged version of patches 1/3 and 3/3 have been applied, it
> > seems like most of this will not be needed any more.  Maybe not any of
> > it.
> 
> Without the connect_lock introduced in this patch, wouldn't the
> usb_gadget_connect()/
> usb_gadget_disconnect() through soft_connect_store() race against
> usb_gadget_connect()/ usb_gadget_disconnect() through
> usb_udc_connect_control() ?

Okay, yes, that's a good point.  It needs to be mentioned in the patch 
description so that people will understand it is the real reason for 
this change.

Alan Stern
