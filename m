Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8687362E062
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234875AbiKQPyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiKQPyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:54:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB28DED8;
        Thu, 17 Nov 2022 07:54:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 391366209A;
        Thu, 17 Nov 2022 15:54:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85D37C433C1;
        Thu, 17 Nov 2022 15:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668700457;
        bh=EsSvC1Bd9cCDqcgDGICCIVHG9/jMhUY/m8+coxXZkIM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nKSqxuRw1M0PQaaRRBx71A6+DEbyathvdZpqW62OcEVQcqq66SN1DGGjENCcWh4cq
         MjmtHm2SdOvguZkN3E9gQDA7LLPO5qXfd31kuDc/kItR/WyOB4HAS0AOqT+YNhGncv
         Mfj3Klu1lYWj1WBRuDtqB4C7FqrVOSZ9AS5rvZ52DExkzlyQPcKar3aCZdIrBVU7gp
         IIuVdodU0xScbxBMl9gb3nS0Ahkc0D0222sEUaXwIKxfpB6zPLIw1ZQDDsNQ/F4xNg
         RKn6TPHASeH1+d4WzahD3dhaccxoheWpEDl/Mlp8j23CorWG4cXtEj6CaoEk/w3C7L
         r9gkfO3LWEZAw==
Date:   Thu, 17 Nov 2022 16:54:12 +0100
From:   Alexey Gladkov <legion@kernel.org>
To:     Allen Webb <allenwebb@google.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] modules: add modalias file to sysfs for modules.
Message-ID: <Y3ZZJGSsC4VruKg3@example.org>
References: <b2d1004d-4a76-ab0b-d369-a38c2d7c1624@csgroup.eu>
 <20221111152852.2837363-1-allenwebb@google.com>
 <Y26UcbviRaoK9a3C@bombadil.infradead.org>
 <CAJzde06b4d065y7KSoGO6qQBgvcVdkUai1WAy_TkrkTCDHS41A@mail.gmail.com>
 <20221114172214.ilnk5wj3eevpsqts@ldmartin-desk2.lan>
 <CAJzde04id1kWhnR5HfuFEZR+ej7xXAsmQ9HpwYT5rQEY4Jsntw@mail.gmail.com>
 <Y3PN0GZYvFyUF83g@bombadil.infradead.org>
 <CAJzde06cFefEFwRxYo1ia=27rUw6yPn9ejkNChEH8YnVK1LWYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJzde06cFefEFwRxYo1ia=27rUw6yPn9ejkNChEH8YnVK1LWYQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:40:57PM -0600, Allen Webb wrote:
> When i get the modinfo for usbhid, there are no aliases listed:
> ```
> localhost ~ # modinfo usbhid
> name:           usbhid
> filename:       (builtin)
> author:         Andreas Gal
> author:         Vojtech Pavlik
> author:         Jiri Kosina
> description:    USB HID core driver
> file:           drivers/hid/usbhid/usbhid
> license:        GPL
> parm:           quirks:Add/modify USB HID quirks by specifying
> quirks=vendorID:productID:quirks where vendorID, productID, and quirks
> are all in 0x-prefixed hex (array of charp)
> parm:           ignoreled:Autosuspend with active leds (uint)
> parm:           kbpoll:Polling interval of keyboards (uint)
> parm:           jspoll:Polling interval of joysticks (uint)
> parm:           mousepoll:Polling interval of mice (uint)
> ```

Hm. Interesting. Actually, alias gets into modules.builtin.modinfo:

$ tr '\0' '\n' <  /lib/modules/`uname -r`/modules.builtin.modinfo |grep ^crc32c_generic.alias=
crc32c_generic.alias=crypto-crc32c-generic
crc32c_generic.alias=crc32c-generic
crc32c_generic.alias=crypto-crc32c
crc32c_generic.alias=crc32c

> bluetooth however has an alias listed:
> ```
> localhost ~ # modinfo bluetooth
> filename:
> /lib/modules/5.10.154-20424-gea7532c123d8/kernel/net/bluetooth/bluetooth.ko.gz
> author:         Marcel Holtmann <marcel@holtmann.org>
> description:    Bluetooth Core ver 2.22
> version:        2.22
> license:        GPL
> alias:          net-pf-31
> vermagic:       5.10.154-20424-gea7532c123d8 SMP preempt mod_unload
> name:           bluetooth
> intree:         Y
> retpoline:      Y
> depends:        ecdh_generic
> srcversion:     F8E46CD048C50B0AA1CD471
> parm:           disable_esco:Disable eSCO connection creation (bool)
> parm:           enable_ecred:Enable enhanced credit flow control mode (bool)
> parm:           disable_ertm:Disable enhanced retransmission mode (bool)
> ```
> 
> I believe the reason for this is many modules use `#define
> MODULE_DEVICE_TABLE(type, name)` which is a noop for buildin modules.
> I have a local patch that resolves that issue here:
> See: https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/3840672/1/include/linux/module.h#b246
> 
> However, I probably ought to rework that patch to create the
> MODULE_ALIAS defines instead of the buildin.alias file.
> 
> On Tue, Nov 15, 2022 at 11:35 AM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > On Tue, Nov 15, 2022 at 10:05:35AM -0600, Allen Webb wrote:
> > > On Mon, Nov 14, 2022 at 11:22 AM Lucas De Marchi
> > > <lucas.demarchi@intel.com> wrote:
> > > >
> > > > On Mon, Nov 14, 2022 at 10:42:50AM -0600, Allen Webb wrote:
> > > > >On Fri, Nov 11, 2022 at 12:29 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> > > > >>
> > > > >> On Fri, Nov 11, 2022 at 09:28:52AM -0600, Allen Webb wrote:
> > > > >> > USB devices support the authorized attribute which can be used by
> > > > >> > user-space to implement trust-based systems for enabling USB devices. It
> > > > >> > would be helpful when building these systems to be able to know in
> > > > >> > advance which kernel drivers (or modules) are reachable from a
> > > > >> > particular USB device.
> > > > >> >
> > > > >> > This information is readily available for external modules in
> > > > >> > modules.alias. However, builtin kernel modules are not covered. This
> > > > >> > patch adds a sys-fs attribute to both builtin and loaded modules
> > > > >> > exposing the matching rules in the modalias format for integration
> > > > >> > with tools like USBGuard.
> > > > >> >
> > > > >> > Signed-off-by: Allen Webb <allenwebb@google.com>
> > > > >>
> > > > >> Thanks for the patch Allen!
> > > > >>
> > > > >> I'd rather have something generic though, and it would seem kmod [0] already
> > > > >> does this, have you seen the kmod support for builtin.alias.bin
> > > > >>
> > > > >> Can't that be used?
> > > > >
> > > > >Probably, but I don't see the builtin.alias.bin in my build. Is it experimental?
> > > >
> > > > no. That is generated by depmod since v27 using modules.builtin.modinfo
> > > > generated by the kernel build system. Highly recommend v30 though
> > > > as there were fixes in v28 and v29 and some changes to speed up its
> > > > generation/use in v30:  See entries mentioning
> > > > builtin.alias and bultin.modinfo in
> > > > https://git.kernel.org/pub/scm/utils/kernel/kmod/kmod.git/tree/NEWS
> > > >
> > > > libkmod/modprobe/modinfo also have the corresponding changes to lookup that
> > > > index when resolving aliases.
> > >
> > > I see the file but it is largely missing the aliases I am interested
> > > in, so it looks like I might need to modify my patch that creates
> > > buildin.alias to add the missing alias defines in the header along
> > > with the other module metadata for builtin modules. Does this sound
> > > right to you?
> >
> > Can you clarify what is missing and why? And an RFC is welcomed if it
> > helps demonstrates what you mean.
> >
> >   Luis
> 

-- 
Rgrds, legion

