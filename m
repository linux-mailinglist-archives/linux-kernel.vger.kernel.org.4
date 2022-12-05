Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5F64210C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 02:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbiLEBYL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 20:24:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbiLEBYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 20:24:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE812D30
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 17:24:07 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so2028850pjj.4
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 17:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=igorinstitute-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=udJjLFsIsuNM+D3lyGnLy0JwlIO+NVedMCgCplH0XXs=;
        b=2sodOIYqDSiSgt9c4aOcnZzMycrCLMB+S0oc/UblasgK8rW84vy4R/wwVZEnNlVY93
         dVOmV12xvGZ4Oujmwz1r3dUvMOPMVaD0UHuC7nxTuYX1ZsR1ZxnqJL9/U86lKZ3CsYC0
         wRRuLNZhYVg+RkW7uXJjyINUWtDmDvcslOU+/WpBe+vPm2tI/jkIT7jDr84wBsQW6PZ/
         577d1OB826wBRXpLZlfIqClwq+/M5pT9pYUA/GGVIdbpLxheD6C67ZXr2wucXtLnWNXx
         mESa5q578cQ3zESImbIxA0wk1glfr0h4sQZ8FbmVYghHbA94d3IbJjd5o2j6gfbDSPfB
         NMBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udJjLFsIsuNM+D3lyGnLy0JwlIO+NVedMCgCplH0XXs=;
        b=TBlCS37s71WOH4XOFtTCZMQ5Qed6GdBt7l4P0mHZ8ILEQNt2IIkjhraDM1QASDQNFJ
         I1yrCy2DzrsvmWpBd/hftd1mAycdKHlWpLEkfA5FCcGL4sJfuE+QUrVhNzksjz+M5Z/f
         jImkKX1OE0yoLNgHinzfJMTcfVYUSMnmV4YOMYKUZMafV+Phv0Ig8HsQX9mxPN5X+mLy
         KS2x9hEPx+kKcY3RsdpLH6IIKsV7WEsce+1LDkuRX4xwQXBGYlRAGP6W5PALsx4M4f81
         gh8RU5lFT6ovoqQIaOWTtyoIAOb9D5K6t8udzwch30HEZ3NzkexZnSRRG87oNiS2Nfe8
         b9OA==
X-Gm-Message-State: ANoB5pmoZ8+SjJbmt5P7/bCGBkjLGW6qczbj32tvMmD7lq3JQEJ8sk10
        cgsHbNCYQMRvc1/FuGYeQKGtFw==
X-Google-Smtp-Source: AA0mqf5qIK01sWvLtVrvTGJppmqa9AVW7iYDN5qPvMB9YJRe16Mwf2rVSwykwYB2y8WjCGkUQH5HtQ==
X-Received: by 2002:a17:902:8604:b0:186:fe2d:f3cb with SMTP id f4-20020a170902860400b00186fe2df3cbmr66231522plo.132.1670203446986;
        Sun, 04 Dec 2022 17:24:06 -0800 (PST)
Received: from localhost ([121.99.145.49])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7962d000000b00576d4d69909sm1481840pfg.8.2022.12.04.17.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Dec 2022 17:24:06 -0800 (PST)
Date:   Mon, 5 Dec 2022 14:24:03 +1300
From:   Daniel Beer <daniel.beer@igorinstitute.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Michael Zaidman <michael.zaidman@gmail.com>,
        Christina Quast <contact@christina-quast.de>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH] hid-ft260: add UART support.
Message-ID: <20221205012403.GA14904@nyquist.nev>
References: <638c51a2.170a0220.3af16.18f8@mx.google.com>
 <Y4xX7ILXMFHZtJkv@kroah.com>
 <20221204091247.GA11195@nyquist.nev>
 <Y4xqyRERBdr8fT7F@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y4xqyRERBdr8fT7F@kroah.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 04, 2022 at 10:39:21AM +0100, Greg Kroah-Hartman wrote:
> > Thanks for reviewing. This device is quite strange -- it presents itself
> > as a USB HID, but it provides both an I2C master and a UART. The
> > existing driver supports only the I2C functionality currently.
> 
> Lots of devices are a "fake HID" device as other operating systems make
> it easy to write userspace drivers that way.  Linux included.  What
> userspace programs are going to want to interact with this device and
> what api are they going to use?

Hi Greg,

The application I'm looking at uses it as a debug console, so personally
I'd like to be able to use it with picocom and other terminal programs.

> > > > --- a/include/uapi/linux/major.h
> > > > +++ b/include/uapi/linux/major.h
> > > > @@ -175,4 +175,6 @@
> > > >  #define BLOCK_EXT_MAJOR		259
> > > >  #define SCSI_OSD_MAJOR		260	/* open-osd's OSD scsi device */
> > > >  
> > > > +#define FT260_MAJOR		261
> > > 
> > > A whole new major for just a single tty port?  Please no, use dynamic
> > > majors if you have to, or better yet, tie into the usb-serial
> > > implementation (this is a USB device, right?) and then you don't have to
> > > mess with this at all.
> > 
> > As far as I understand it, I don't think usb-serial is usable, due to
> > the fact that this is already an HID driver.
> 
> That should not be a restriction at all.  You are adding a tty device to
> this driver, no reason you can't interact with usb-serial instead.  That
> way you share the correct userspace tty name and major/minor numbers and
> all userspace tools should "just work" as they know that name and how to
> interact with it already.
> 
> Try doing that instead of your own "raw" tty device please.

Maybe I've misunderstood something. The reason I thought usb-serial was
unusable in this instance was that I couldn't see a way to create a port
except via usb-serial's own probe function (otherwise, the API looked
fine).

I don't know whether I'm looking at a serial or an I2C interface until
after it's already been probed by HID core, I have a struct hid_device
and I've asked what type of interface it is via an HID feature report.
This can't be determined otherwise, because strapping pins affect the
presentation of interfaces.

At that point, I (currently) call uart_add_one_port. I might have missed
it, but I didn't see anything analogous in the usb-serial API. Am I
going about this the wrong way?

Cheers,
Daniel

-- 
Daniel Beer
Firmware Engineer at Igor Institute
daniel.beer@igorinstitute.com or +64-27-420-8101
Offices in Seattle, San Francisco, and Vancouver BC or (206) 494-3312
