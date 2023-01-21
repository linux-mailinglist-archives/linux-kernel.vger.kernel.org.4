Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33276762D6
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 03:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbjAUCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 21:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjAUCGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 21:06:45 -0500
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 268C359769
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 18:06:40 -0800 (PST)
Received: (qmail 55081 invoked by uid 1000); 20 Jan 2023 21:06:39 -0500
Date:   Fri, 20 Jan 2023 21:06:39 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Elson Serrao <quic_eserrao@quicinc.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_wcheng@quicinc.com" <quic_wcheng@quicinc.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/5] usb: gadget: Add remote wakeup capable flag
Message-ID: <Y8tIrx+F/4X9YyFT@rowland.harvard.edu>
References: <1673992507-7823-1-git-send-email-quic_eserrao@quicinc.com>
 <1673992507-7823-2-git-send-email-quic_eserrao@quicinc.com>
 <20230119014409.yiw6xlp5cwlmu25s@synopsys.com>
 <f49c54d9-b9fe-e629-3f94-809cd79a2211@quicinc.com>
 <20230120011513.ajwum224lfwwb6ws@synopsys.com>
 <045f9ac1-5d48-fad0-8e74-8d5144aa1431@quicinc.com>
 <20230121002059.mpiqavemelnntxd7@synopsys.com>
 <Y8tGAXbKDtzmW8+E@rowland.harvard.edu>
 <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121020223.l2tyvyqifc7umqpy@synopsys.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 02:02:36AM +0000, Thinh Nguyen wrote:
> On Fri, Jan 20, 2023, Alan Stern wrote:
> > A UDC design might have multiple versions, some supporting remote wakeup 
> > and others not.  But drivers generally use a single static 
> > usb_gadget_ops structure, and they don't modify it at runtime to account 
> > for hardware differences.  So if a single driver controls those multiple 
> > versions, you can't rely on the presence of gadget->ops->wakeup to 
> > indicate whether there actually is hardware remote wakeup support.
> > 
> > Ideally, the usb_gadget structure should have a wakeup_capable flag 
> > which the UDC driver would set appropriately (probably during its probe 
> > routine).
> > 
> 
> I was thinking that it can be handled by the
> usb_gadget_enable_remote_wakeup() so we can do away with the
> wakeup_capable flag.

usb_gadget_enable_remote_wakeup() gets called when the gadget or 
function is suspended, right?  But a gadget driver may want to know long 
before that whether the UDC supports remote wakeup, in order to set up 
its config descriptor correctly.

Alan Stern
