Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE5F706B7E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjEQOo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbjEQOo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:44:56 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id 115978F
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 07:44:53 -0700 (PDT)
Received: (qmail 876293 invoked by uid 1000); 17 May 2023 10:44:53 -0400
Date:   Wed, 17 May 2023 10:44:53 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     gregkh@linuxfoundation.org, colin.i.king@gmail.com,
        xuetao09@huawei.com, quic_eserrao@quicinc.com,
        water.zhangjiantao@huawei.com, peter.chen@freescale.com,
        balbi@ti.com, francesco@dolcini.it, alistair@alistair23.me,
        stephan@gerhold.net, bagasdotme@gmail.com, luca@z3ntu.xyz,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Subject: Re: [PATCH v1] usb: gadget: udc: core: Offload usb_udc_vbus_handler
 processing
Message-ID: <c7f19b4e-469c-4e40-bd2e-e864ca5f7872@rowland.harvard.edu>
References: <20230517115955.1078339-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517115955.1078339-1-badhri@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 11:59:55AM +0000, Badhri Jagan Sridharan wrote:
> chipidea udc calls usb_udc_vbus_handler from udc_start gadget
> ops causing a deadlock. Avoid this by offloading usb_udc_vbus_handler
> processing.

Surely that is the wrong approach.

The real problem here is that usb_udc_vbus_handler() gets called from 
within a udc_start routine.  But this is totally unnecessary, because 
the UDC core will call usb_udc_connect_control_locked() itself, later on 
during gadget_bind_driver().

So a proper solution would be simply to remove the unnecessary
usb_udc_vbus_handler() call from the chipidea driver (and similarly for 
the max3420_udc driver).

Similar changes may be needed in these drivers' udc_stop routines.

Alan Stern
