Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E86C4728CFA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 03:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237527AbjFIBSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 21:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjFIBSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 21:18:01 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 169E62D4F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 18:17:59 -0700 (PDT)
Received: (qmail 283453 invoked by uid 1000); 8 Jun 2023 21:17:59 -0400
Date:   Thu, 8 Jun 2023 21:17:59 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, francesco@dolcini.it,
        alistair@alistair23.me, stephan@gerhold.net, bagasdotme@gmail.com,
        luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v8 2/2] usb: gadget: udc: core: Prevent
 soft_connect_store() race
Message-ID: <7b1a8de9-3811-4b4b-b85f-9afded0e45d1@rowland.harvard.edu>
References: <20230609010227.978661-1-badhri@google.com>
 <20230609010227.978661-2-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609010227.978661-2-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 09, 2023 at 01:02:27AM +0000, Badhri Jagan Sridharan wrote:
> usb_udc_connect_control(), soft_connect_store() and
> usb_gadget_deactivate() can potentially race against each other to invoke
> usb_gadget_connect()/usb_gadget_disconnect(). To prevent this, guard
> udc->started, gadget->allow_connect, gadget->deactivate and
> gadget->connect with connect_lock so that ->pullup() is only invoked when
> the gadget is bound, started and not deactivated. The routines
> usb_gadget_connect_locked(), usb_gadget_disconnect_locked(),
> usb_udc_connect_control_locked(), usb_gadget_udc_start_locked(),
> usb_gadget_udc_stop_locked() are called with this lock held.
> 
> An earlier version of this commit was reverted due to the crash reported in
> https://lore.kernel.org/all/ZF4BvgsOyoKxdPFF@francesco-nb.int.toradex.com/.
> commit 16737e78d190 ("usb: gadget: udc: core: Offload usb_udc_vbus_handler processing")
> addresses the crash reported.
> 
> Cc: stable@vger.kernel.org
> Fixes: 628ef0d273a6 ("usb: udc: add usb_udc_vbus_handler")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> ---

Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
