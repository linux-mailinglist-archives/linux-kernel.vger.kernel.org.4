Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0E8C5F567E
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 16:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiJEOem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 10:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiJEOej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 10:34:39 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6510D2ADA;
        Wed,  5 Oct 2022 07:34:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a2so15781062ejx.10;
        Wed, 05 Oct 2022 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=yqlnpXoBfzdLQcMI+98mIBgiL7Jr/JPJ+r1RO+48dlU=;
        b=XCiIl7jSUAQieHYsvn7rS75F06P/W8gJBjr8Yuu+a1xQqJtnKhaJryuoWTnDee/UcE
         PVnctBYNeHwRFZrR7OGJ26DQrbyC8kFIIkPPTSSwBAYxZhjJrPs0jC6LhmShy/yypQgQ
         HtT0Am0ea1XJ0HxIUdROk2yihBRxut72axLKSYRiKeYYCdvtOzXJbMY2PAM9GmthcrS2
         gK/k1v6Rvkm7pyvTv+90vMb5HkmK6CEzpbDrPsmqQGHzSuxtmLVF9BLnQLpTfkLGRkmk
         EXm6BxAPHcUG+jl1UyGTPBjyrMKNeOPxZ1XkytfFtXnrvPSmX4I/y+y+aB5E/O6M+BHj
         nt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=yqlnpXoBfzdLQcMI+98mIBgiL7Jr/JPJ+r1RO+48dlU=;
        b=091zmkaopgwEKQvVhYmBrJWKhPPK4Dr1nwzAsqHN5/SXEGDA6kY/HnrlrSJW2Y0LUk
         JuR90JggM9CzWPIvD2CYKCmqh9Xq55y7SPXOrTDYc2CENSnoweXZcpx0MEjPaX2+n+fw
         oLFIdXSRViqNNPAvL+8oKGuOLriXMm8pOF+iohYY9lDfqw1oE5obLWCTbEs6DeWuIRfr
         rv6PPy4cSdFITJYlsO6KrSVCvtn5LqG8qSiPl947VB/RbSSFTNDmFWX2u8LwsujG8nsb
         MUfws69MY8eb5PWVlk0umLN8Tno2a+XzgiIhAh7brsQOEOP8Qx2Phg6Ad8LHNjOGlgOH
         MXJQ==
X-Gm-Message-State: ACrzQf3NeRmnA6OywuB6ozXUmVAbcOZvN/iyUsrxPSDbO9FkKf48Dlov
        fFN2VugLPZlSjPXoErUYBCZ5Xi6vTp1lag==
X-Google-Smtp-Source: AMsMyM7YBFHZZmCcwehJMGVN5qXfioPudUzIHmm86SPx9hTVoPU+jJYPMNDgmKjCykE6A8QIJnZ7aQ==
X-Received: by 2002:a17:907:a40f:b0:78d:10fc:6ef5 with SMTP id sg15-20020a170907a40f00b0078d10fc6ef5mr7120161ejc.212.1664980476885;
        Wed, 05 Oct 2022 07:34:36 -0700 (PDT)
Received: from michael-VirtualBox (89-139-44-91.bb.netvision.net.il. [89.139.44.91])
        by smtp.gmail.com with ESMTPSA id n10-20020a170906378a00b0078175601630sm8672603ejc.79.2022.10.05.07.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 07:34:36 -0700 (PDT)
Date:   Wed, 5 Oct 2022 17:34:34 +0300
From:   Michael Zaidman <michael.zaidman@gmail.com>
To:     Enrik Berkhan <Enrik.Berkhan@inka.de>
Cc:     jikos@kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org,
        Guillaume Champagne <champagne.guillaume.c@gmail.com>
Subject: Re: [PATCH v2 5/7] HID: ft260: improve i2c large reads performance
Message-ID: <Yz2V+pT/2AmGvE7k@michael-VirtualBox>
References: <20220928144854.5580-1-michael.zaidman@gmail.com>
 <20220928144854.5580-6-michael.zaidman@gmail.com>
 <4ce2960686605f2290046b396a8edc4cc47beb9e.camel@inka.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ce2960686605f2290046b396a8edc4cc47beb9e.camel@inka.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 08:15:56PM +0200, Enrik Berkhan wrote:
> Hi Michael,
> 
> On Wed, 2022-09-28 at 17:48 +0300, Michael Zaidman wrote:
> > After:
> > 
> > $ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xff 13 0x51 -S
> > 
> >   Read block via i2ctransfer by chunks
> >   -------------------------------------------------------------------
> >   data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
> >   -------------------------------------------------------------------
> >   49316           85             256           2           128
> > 
> > Kernel log:
> > 
> > [  +1.447360] ft260_i2c_write_read: off 0x0 rlen 128 wlen 2
> > [  +0.000002] ft260_i2c_write: rep 0xd0 addr 0x51 off 0 len 2 wlen 2 flag 0x2 d[0] 0x0
> > [  +0.001633] ft260_xfer_status: bus_status 0x41, clock 100
> > [  +0.000190] ft260_xfer_status: bus_status 0x40, clock 100
> > [  +0.000001] ft260_i2c_read: rep 0xc2 addr 0x51 len 128 rlen 128 flag 0x7
> > [  +0.008617] ft260_raw_event: i2c resp: rep 0xde len 60
> > [  +0.008033] ft260_raw_event: i2c resp: rep 0xde len 60
> > [  +0.000954] ft260_raw_event: i2c resp: rep 0xd1 len 8
> 
> As the ft260 can pack up to 60 bytes into one report, would it make
> sense to use a multiple-of-60 size (120 or 180)? Might reduce overhead
> by another tiny bit ...
> 
> Cheers,
> Enrik
> 
The size of the Read IO to perform is given to the driver by the upper
layer. So it's up to him how to align the IO request size.

When we read from the EEPROM, we want to issue the read requests with
EEPROM page size granularity. The I2C EEPROMs page sizes are usually a
power of 2 aligned.

Please see the examples of reading 4K bytes from the 24C512 EEPROM
first by the read requests of EEPROM page size granularity of 128 bytes
and the second time of the 120 bytes (a multiple of 60 bytes granularity).
In the power of 2 aligned cases, we issued lesser Read IOs (I2C combined
transactions - write address read data) than when we did it with the 60
bytes alignment. Hence the performance gain.

$ sudo ./i2cperf -d 2 -o 2 -s 128 -r 0-0xfff 13 0x51 -S
  Read block via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  49581           85             4096          32          128

$ sudo ./i2cperf -d 2 -o 2 -s 120 -r 0-0xfff 13 0x51 -S
  Read block via i2ctransfer by chunks
  -------------------------------------------------------------------
  data rate(bps)  efficiency(%)  data size(B)  total IOs   IO size(B)
  -------------------------------------------------------------------
  48816           85             4096          35          120

Thanks,
Michael

> 
