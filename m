Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9493E6287DA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbiKNSHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238231AbiKNSHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:07:08 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0B2CDC4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:07:07 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id b185so11727767pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 10:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DaCwKyv1hR+Wk2L2q+3g3Ree7E4LfE2Us+ubJXqFLOs=;
        b=UqAuZuGOuM9ZMC1lADtuVHnTHowGl2bAaozPnFJdQsFymffYzqXen7a78YU0l9B+Ow
         246uSH9iv1WdHw7jHpyeL70luxCl12nnicuj0g218luZDp7qsD9W8CC21h/aePYiYYVW
         iWpz8pmvSU2nFtZh7bt50KwBs3crqtmiana9WafvbsnFlxYsqgVK0gd35yuUwQcuNDtp
         7n/ORIUVrY+a9WKTxBS5bgMY1+xHkCoPHItpLc1sQXqyjwnyhJfgBHkTwNEorE/Urk5n
         /WRuiqm0d6PFLPpTZ2xglbtt48vyn3bR7nvaSeR1JSCaNGraKnhVWMpTBAmc/8372oWn
         dWsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DaCwKyv1hR+Wk2L2q+3g3Ree7E4LfE2Us+ubJXqFLOs=;
        b=kuGdRgIqyLDxm83aTPuI2hbhfYdSx4MxGN5Rbyb+5CT3H/vuftQ/T+7umWLUqZ9OiR
         aQ0RGuqZfJf96Vh0TiMUDvLhr8KefJDBW/PdSxIaK86SjthCZZ2pcpkz/mW/fU7ucKhX
         wINjhgoJm5yG/QccyZSDWEggnpR72Nz37L4a35eTuZkJnPQtW1HWYWTJPzBnnUKaL6lU
         InOKJ5yg99S6Dn+OTH8AVGPYkhR/lABaq5p2gPJ9q4/EC56obI1ADTj3cgJdVOxd6cOm
         knI0hBQlP2ozOEgwX+wSnuuC6m63RO8UdSCz27b+V933wukzjlyUKmVLp9oYm2CEdkAG
         pbcg==
X-Gm-Message-State: ANoB5pm4xAlIOPLZaJewNUwW5RxRoGIVQvNuKMEDHch7Y07CQy0kchvu
        TCNmXcovSoQkxVRhRx76GTkWQx2R8YI=
X-Google-Smtp-Source: AA0mqf6+MfnO0fIZqwEjQkEEkbu9Y8GOzl7IrMllPFcQBn6sIjs5QXOVK9UEXkXEpIcyglI2QDeZDg==
X-Received: by 2002:a62:1851:0:b0:563:54fd:3638 with SMTP id 78-20020a621851000000b0056354fd3638mr14669917pfy.44.1668449226804;
        Mon, 14 Nov 2022 10:07:06 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:5c17:fc5a:f127:5bb5])
        by smtp.gmail.com with ESMTPSA id 133-20020a62188b000000b005722f4dfbefsm2227434pfy.193.2022.11.14.10.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 10:07:05 -0800 (PST)
Date:   Mon, 14 Nov 2022 10:07:02 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Tejun Heo <tj@kernel.org>,
        Matthieu Castet <castet.matthieu@free.fr>,
        Stanislaw Gruszka <stf_xl@wp.pl>, ming.lei@redhat.com,
        Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6bc35f3913193fe7f0d3@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in
 kernfs_next_descendant_post (2)
Message-ID: <Y3KDxpuoY4PB22vt@google.com>
References: <000000000000c183f505eb721745@google.com>
 <20221021225228.1750-1-hdanton@sina.com>
 <Y2BRzPxroVylPLan@slm.duckdns.org>
 <Y3J8GKR905SZ84EE@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J8GKR905SZ84EE@bombadil.infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 09:34:16AM -0800, Luis Chamberlain wrote:
> On Mon, Oct 31, 2022 at 12:53:00PM -1000, Tejun Heo wrote:
> > (cc'ing Luis for firmware loader and quoting the whole body)
> > 
> > On Sat, Oct 22, 2022 at 06:52:28AM +0800, Hillf Danton wrote:
> > > On 20 Oct 2022 00:15:40 -0700
> > > > syzbot has found a reproducer for the following issue on:
> > > > 
> > > > HEAD commit:    55be6084c8e0 Merge tag 'timers-core-2022-10-05' of git://g..
> > > > git tree:       upstream
> > > > console+strace: https://syzkaller.appspot.com/x/log.txt?x=1449d53c880000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=df75278aabf0681a
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=6bc35f3913193fe7f0d3
> > > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14e01c72880000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1128908c880000
> > > 
> > > See if the change to ueagle driver alone can survive syzbot test.
> > > 
> > > #syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  aae703b02f92
> > > 
> > > --- a/include/linux/netdevice.h
> > > +++ b/include/linux/netdevice.h
> > > @@ -3663,8 +3663,9 @@ static inline bool netif_attr_test_online(unsigned long j,
> > >  static inline unsigned int netif_attrmask_next(int n, const unsigned long *srcp,
> > >  					       unsigned int nr_bits)
> > >  {
> > > -	/* n is a prior cpu */
> > > -	cpu_max_bits_warn(n + 1, nr_bits);
> > > +	/* -1 is a legal arg here. */
> > > +	if (n != -1)
> > > +		cpu_max_bits_warn(n, nr_bits);
> > >  
> > >  	if (srcp)
> > >  		return find_next_bit(srcp, nr_bits, n + 1);
> > > @@ -3685,8 +3686,9 @@ static inline int netif_attrmask_next_and(int n, const unsigned long *src1p,
> > >  					  const unsigned long *src2p,
> > >  					  unsigned int nr_bits)
> > >  {
> > > -	/* n is a prior cpu */
> > > -	cpu_max_bits_warn(n + 1, nr_bits);
> > > +	/* -1 is a legal arg here. */
> > > +	if (n != -1)
> > > +		cpu_max_bits_warn(n, nr_bits);
> > >  
> > >  	if (src1p && src2p)
> > >  		return find_next_and_bit(src1p, src2p, nr_bits, n + 1);
> > > --- a/drivers/usb/atm/ueagle-atm.c
> > > +++ b/drivers/usb/atm/ueagle-atm.c
> > > @@ -597,9 +597,8 @@ static int uea_send_modem_cmd(struct usb
> > >  }
> > >  
> > >  static void uea_upload_pre_firmware(const struct firmware *fw_entry,
> > > -								void *context)
> > > +					struct usb_device *usb)
> > >  {
> > > -	struct usb_device *usb = context;
> > >  	const u8 *pfw;
> > >  	u8 value;
> > >  	u32 crc = 0;
> > > @@ -679,6 +678,7 @@ static int uea_load_firmware(struct usb_
> > >  {
> > >  	int ret;
> > >  	char *fw_name = EAGLE_FIRMWARE;
> > > +	const struct firmware *fw;
> > >  
> > >  	uea_enters(usb);
> > >  	uea_info(usb, "pre-firmware device, uploading firmware\n");
> > > @@ -701,13 +701,13 @@ static int uea_load_firmware(struct usb_
> > >  		break;
> > >  	}
> > >  
> > > -	ret = request_firmware_nowait(THIS_MODULE, 1, fw_name, &usb->dev,
> > > -					GFP_KERNEL, usb,
> > > -					uea_upload_pre_firmware);
> > > +	ret = request_firmware(&fw, fw_name, &usb->dev);
> > >  	if (ret)
> > >  		uea_err(usb, "firmware %s is not available\n", fw_name);
> > > -	else
> > > +	else {
> > >  		uea_info(usb, "loading firmware %s\n", fw_name);
> > > +		uea_upload_pre_firmware(fw, usb);
> > > +	}
> > >  
> > >  	uea_leaves(usb);
> > >  	return ret;
> > 
> > So, the problem is that while request_firmware_nowait() inc's the ref on the
> > device, if the device gets removed later, having a ref isn't sufficient for
> > adding stuff to the device. A relatively easy solution would be putting
> > these firmware load work items into its own workqueue and flushing it on
> > device removal path. Luis, what do you think?
> 
> Since we *can* remove a device after we get a module reference and
> since fw_cache_is_setup() tries to use the device before get_device()
> (even though this is not the issue reported), I think perhaps the fix
> below may be generic and best.

I do not see how moving the point where we acquire device refcount
around fixes anything. Caller of request_firmware_nowait() is supposed
to have a valid reference to device object and it is supposed to stay
valid for the entire duration of request_firmware_nowait(). Grabbing
and extra reference only matters if the device (or other refcounted
structure) is being passed to another thread of execution.

I think what Tejun is saying is the only way to fix this. Similarly to
work struct, where users are supposed to call cancel_work_sync() during
teardown, users of request_firmware_nowait() need to wait for it to
complete before continuing with tearing down the instance. See for
example ims-pcu driver where it tries to request firmware asynchronously
when it finds the device in bootloader mode, and is waiting for it
completion when handling device disconnect:

https://elixir.bootlin.com/linux/v6.1-rc3/source/drivers/input/misc/ims-pcu.c#L1978

Thanks.

-- 
Dmitry
