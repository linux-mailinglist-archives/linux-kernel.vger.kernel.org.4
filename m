Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646C2641B8D
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbiLDI1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 03:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLDI1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 03:27:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9B01706B;
        Sun,  4 Dec 2022 00:27:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C00D9B807ED;
        Sun,  4 Dec 2022 08:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7EBC433C1;
        Sun,  4 Dec 2022 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670142429;
        bh=WGPm3BBXhM8bn+JkVqZXZn5l4iJRrsbSCgZfTL0qFB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jhcdo1YdM309RfN1G73PM2G2+aVUH1BN0HawQ1fFOkHkhY279rX4UUrx1g5kd8jIz
         IUJHqF0OD6WaQglftZUmP8EG8W4PzPDPCSqZEETpFD4zY7OrQOw8hPpEycb1P9XgVd
         3iBrUrGN4yEvDAcZ759F9q9t18XwL9tV0apB1HpA=
Date:   Sun, 4 Dec 2022 09:27:04 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Allen Webb <allenwebb@google.com>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 5/5] drivers: Implement module modaliases for USB
Message-ID: <Y4xZ2C4OtfAvcMqs@kroah.com>
References: <20221202224540.1446952-1-allenwebb@google.com>
 <20221202224744.1447448-1-allenwebb@google.com>
 <20221202224744.1447448-5-allenwebb@google.com>
 <1e8322f1-590c-7826-955e-51d83ab333e7@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8322f1-590c-7826-955e-51d83ab333e7@csgroup.eu>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 06:25:46PM +0000, Christophe Leroy wrote:
> > +
> > +#ifdef CONFIG_USB
> > +/* USB related modaliases can be split because of device number matching, so
> > + * this function handles individual modaliases for one segment of the range.
> > + */
> > +static ssize_t usb_id_to_modalias(const struct usb_device_id *id,
> > +				  unsigned int bcdDevice_initial,
> 
> No camelCase please.
> 
> See https://docs.kernel.org/process/coding-style.html#naming

This is a name that comes directly from the USB specification, and as
such, those usages of CamelCase are allowed as they refer to well-known
fields.

But, the field is called bcdDevice, not bcdDevice_initial, so this could
get a better name overall as it doesn't directly match up, so it should
be changed to something a bit nicer.

thanks,

greg k-h
