Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8713871529C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 02:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjE3Amf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 20:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjE3Amd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 20:42:33 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 4EDEDDB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 17:42:32 -0700 (PDT)
Received: (qmail 389153 invoked by uid 1000); 29 May 2023 20:42:31 -0400
Date:   Mon, 29 May 2023 20:42:31 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        francesco@dolcini.it, alistair@alistair23.me, stephan@gerhold.net,
        bagasdotme@gmail.com, luca@z3ntu.xyz, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v2] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <56f54ab7-4c4a-45fc-9d43-c15c1ac07fd9@rowland.harvard.edu>
References: <20230519043041.1593578-1-badhri@google.com>
 <c181c8ef-f342-4a31-9b8c-e1fa14ad214e@rowland.harvard.edu>
 <a1d064e7-9847-4e2e-b74a-4ae4f39d3f04@rowland.harvard.edu>
 <CAPTae5JKUW6g8cvUbJ3owMGm+npJSBgjr-O_xEiRm_tzXVBV1Q@mail.gmail.com>
 <a2305ca6-d343-473d-b220-556a2c2e7833@rowland.harvard.edu>
 <CAPTae5Lke+DE3WzGuBxkMMZ=qbbux=avdDTgrxEc1A5SrCFevg@mail.gmail.com>
 <547ecbb2-921d-4714-82b7-066202ccf292@rowland.harvard.edu>
 <CAPTae5J=VGeHNio0XAj=trrwqXWgGCiwcSaKsxQ4H_9j2mCVXA@mail.gmail.com>
 <406371f0-db48-4195-b85d-b75ce83e738b@rowland.harvard.edu>
 <CAPTae5LSvs+4pKJRgShPzH_tt7F4ZgdvNOQJXE1aLXTgt5Y+0A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPTae5LSvs+4pKJRgShPzH_tt7F4ZgdvNOQJXE1aLXTgt5Y+0A@mail.gmail.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 04:32:29PM -0700, Badhri Jagan Sridharan wrote:
> On Sat, May 27, 2023 at 9:36 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> >
> > I think it would be better just to merge the new material into
> > usb_gadget_connect() and usb_gadget_disconnect().
> 
> I ended up merging them into usb_gadget_pullup_update_locked() so that
> each of the individual helper function can call
> usb_gadget_pullup_update_locked() while holding the connect_lock. I
> actually had usb_gadget_(dis)connect() set udc->vbus.

What?  No, that's not right.  They are two completely separate concepts.  
The host controls VBUS and the gadget controls the pullup.

>  It appears to me
> that both usb_gadget_(dis)connect() and usb_udc_vbus_handler() are
> meant to be called based on vbus presence and hence seem to be
> redundant.

They are not.  We need to support turning off the pullup while VBUS is 
on.

>  Wondering if we could get rid of usb_gadget_(dis)connect()
> given that drivers/power/supply/isp1704_charger.c is only call it and
> instead make it call usb_udc_vbus_handler() instead ?

In short, no.

Alan Stern
