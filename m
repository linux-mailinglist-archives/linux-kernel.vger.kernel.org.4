Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3183572C377
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234301AbjFLLwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjFLLv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:51:57 -0400
X-Greylist: delayed 592 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 04:48:18 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF16197
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 04:48:18 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel-mail [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 85B66E8022C;
        Mon, 12 Jun 2023 13:37:56 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 24DAC16006B; Mon, 12 Jun 2023 13:37:55 +0200 (CEST)
Date:   Mon, 12 Jun 2023 13:37:55 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Jonathan McDowell <noodles@meta.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Kay Sievers <kay.sievers@vrfy.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] firmware: dmi: Don't restrict access to serial number /
 UUID
Message-ID: <ZIcDk2XIePJidxW5@gardel-login>
References: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZIbslWZev/Ayoug5@noodles-fedora.dhcp.thefacebook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mo, 12.06.23 09:59, Jonathan McDowell (noodles@meta.com) wrote:

> The /sys/devices/virtual/dmi/id/*_serial + product_uuid files are
> currently only readable by root. There's no clear rationale for this;
> Windows + OS X both allow regular users to access the information, so
> there appears to be no expectation on the manufacturer side that it
> should be kept secret.
>
> Having the information easily available helps with automated tools that
> collect system information for the purposes of fault diagnosis/tracking
> without requiring the tools have root access.
>
> (I've tried to look for context on the initial patch submission about
> why these were root-only but didn't find any; hopefully Lennart or Kay
> can provide details if I'm missing something.)

When I originally added this in 2007 the intel cpuid serial numbers
kerfuffle wasn't ancient history yet, i.e. see:

https://en.wikipedia.org/wiki/Pentium_III#Controversy_about_privacy_issues

So we wanted to ensure that potentially identifying hw information
would not leak to unprivileged code just like that so easily, hence
restricting this was the easy way out.

We subsequently came up with the /etc/machine-id concept, i.e. a
*user* controlled ID value people can use instead. And for VMs we then
added logic so that the VM supplied UUID can be propagated into that
(under the assumption that the VM supplied UUID is under user control
anyway).

To my knowledge on ChromeOS the /etc/machine-id concept isn't much
liked either, they'd rather have *no* identifiable info available to
unpriv code instead of just user controllable ids... (i remember some
conversations with chromeos people back in the day about this.) if you
open up the DMI serial numbers like this you might not make yourself
many friends in that camp...

One might argue that there's always some identifiable hw info available
for apps to use, or that apps should run in sandboxes that make this
impossible, but that's cheap of course…

Lennart

--
Lennart Poettering, Berlin
