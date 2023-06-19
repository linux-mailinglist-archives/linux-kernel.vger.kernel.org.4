Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3E273517A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjFSKGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjFSKGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:06:21 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3705DCA
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:06:17 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id E4984240106
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 11:59:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1687168784; bh=rv8/fB8ERkqg5LdBhWihNWSXDtklcfVW8V0G2uDSZXM=;
        h=MIME-Version:Content-Transfer-Encoding:Date:From:To:Cc:Subject:
         Message-ID:From;
        b=WbFYvv/IRaKo2POREV7GfmxLozUE956aIYgA2va8sOp99W4lY+uOhqAceR6LnNVre
         cloDvIZqOTdu/gDFTXGAvE0wI9MlOj6Hi99P1d8nXWvU+yAvEDoiPlMxgea4SCw8st
         zPKj79SOh1ztbJg+jFIdbD4NIKVRKGJE9tqeUMRC8krSFt1GAta5lB/g9ywXJNAO8j
         qMX+ChKaAX1m9ZuT8tvBNASr6uQitijGINCz0CkPlHrVBU0DYph8fKI5cDC/OC/+0j
         Qj0sslhLb9RC8bLMy90NVrD5XmCtARHCyroyjxEMN7EmCamyxC/fhfSKsxD6lClPbb
         7CnC//YiMgQMQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Ql4xX0Wrzz6tw9;
        Mon, 19 Jun 2023 11:59:44 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 19 Jun 2023 09:59:44 +0000
From:   retpolanne@posteo.net
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Vinod Koul <vkoul@kernel.org>,
        Christian Lamparter <chunkeey@googlemail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: host: xhci: parameterize Renesas delay/retry
In-Reply-To: <2023061951-taekwondo-unsoiled-faf2@gregkh>
References: <20230618224656.2476-2-retpolanne@posteo.net>
 <2023061951-taekwondo-unsoiled-faf2@gregkh>
Message-ID: <0627e991f2c446cd7e265188523607da@posteo.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.06.2023 07:46, Greg Kroah-Hartman wrote:
> On Sun, Jun 18, 2023 at 10:46:57PM +0000, Anne Macedo wrote:
>> Cards based on Renesas uPD720202 have their firmware downloaded during
>> boot by xhci-pci. At this step, the status of the firmware is read and
>> it takes a while for this read to happen (up to a few seconds). The
>> macros RENESAS_RETRY and RENESAS_DELAY are used to retry reading this
>> status byte from PCI a few times. If it can't read the status byte in
>> RENESAS_RETRY tries, it times out.
>> 
>> However, since this may vary from card to card, these retry and delay
>> values need to be tweaked. In order to avoid having to patch the code 
>> to
>> change these values, CONFIG_USB_XHCI_PCI_RENESAS_RETRY and
>> CONFIG_USB_XHCI_PCI_RENESAS_DELAY are introduced.
> 
> No, a build-time option that affects all devices controlled by this
> driver is not how you handle this, sorry.

Sorry, I completely forgot that other environments might have multiple 
cards.
Mine only has one and I was focused on making it work.
> 
> Make this a dynamic value, either determined automatically by the 
> device
> itself (as you know what device is being controlled), or worst case, a
> sysfs attribute that you can modify if things are not working properly.
> 

I'll follow Christian's tip and check the uPD720202 user manual and see
if there's something I can look for in order to make this value dynamic.

> But a build-time option will never work, as it will never be changed,
> and it would not allow for multiple devices in the system that are
> different.
> 
> thanks,
> 
> greg k-h

