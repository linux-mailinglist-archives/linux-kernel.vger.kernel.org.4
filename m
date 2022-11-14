Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D9A62764A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 08:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbiKNHQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 02:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235493AbiKNHQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 02:16:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940FEDE9E;
        Sun, 13 Nov 2022 23:16:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 252FA60DE4;
        Mon, 14 Nov 2022 07:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0292BC433C1;
        Mon, 14 Nov 2022 07:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668410161;
        bh=QZ2hDN7ENnP9xgo+76D84xuEYJANb+AhzKCDG45trzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mTLTwTou6gugHVLBfC5kKM/9XlWijH3RpGVEbYyOow99SXMMh9K3DeJa/JNLR/8T3
         cvvCuWUoRzz/ACbIYI1HsoNKcxa0DFHjk4almwRjVnbhJ0WtFtkE0+xrOuZtsEJo9w
         bG6yp73fWu/4Bx+XuQoYoUf+DbeW5xUzNC/S7EzQ=
Date:   Mon, 14 Nov 2022 08:15:58 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thiago Macieira <thiago.macieira@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Joseph, Jithu" <jithu.joseph@intel.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "Jimenez Gonzalez, Athenas" <athenas.jimenez.gonzalez@intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>
Subject: Re: [PATCH v2 12/14] platform/x86/intel/ifs: Add current_batch sysfs
 entry
Message-ID: <Y3HrLpTdxqUPWW3F@kroah.com>
References: <20221021203413.1220137-1-jithu.joseph@intel.com>
 <20221107225323.2733518-1-jithu.joseph@intel.com>
 <20221107225323.2733518-13-jithu.joseph@intel.com>
 <Y2/JNAmSoYlLKq3A@zn.tnic>
 <CC3629D6-B205-4150-80E5-FC7A7A76DD25@intel.com>
 <Y3CevK2zhAmiUyG9@kroah.com>
 <Y3DZmKYV+8HBtZ+Q@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3DZmKYV+8HBtZ+Q@zn.tnic>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 13, 2022 at 12:48:40PM +0100, Borislav Petkov wrote:
> Replying to both with one mail because it still feels like there's a
> misunderstanding.
> 
> On Sun, Nov 13, 2022 at 08:37:32AM +0100, gregkh@linuxfoundation.org wrote:
> > No, please do not force the driver to resolve a filename path in the
> > kernel.
> 
> No, I don't mean to do any filename path resolving - all I suggest is to
> echo into sysfs the full filename instead of the number. I.e., this:
> 
> for i in $(ls /lib/firmware/intel/ifs_0/*.scan);
> do
> 	echo $i /sys/devices/virtual/misc/intel_ifs_0/current_batch
> done

Sorry, yes, that is fine, I was objecting to the previous "write any
path/file to the sysfs entry and the kernel will parse it" that was
happening in the original series.  A filename, without a path, that
always loads from the existing in-kernel firmware path locations is
fine.

thanks,

greg k-h
