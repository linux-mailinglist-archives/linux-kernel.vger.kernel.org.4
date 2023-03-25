Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B626C8FED
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 18:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjCYR5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 13:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbjCYR5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 13:57:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43512EB79;
        Sat, 25 Mar 2023 10:57:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8C05B807E4;
        Sat, 25 Mar 2023 17:57:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD00C433D2;
        Sat, 25 Mar 2023 17:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679767021;
        bh=LWrmG5ueHjn7bVj/XG+uFxSFGDNLST3hBfsR6HVFo50=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s/nE3z7/9u3tp8y2p1yUVINY4JewlEu9dOPtjIL5ydyXPGs+57gasqm/ntBbMlf5e
         vSsZbETRCjt4olA0CvDkqL26HuwJ1nhs2UZEeqFotXK1v7SfvDh2l7bbkMLwYfPPjN
         ArhGZC+tD+iSG9MnKIVUHPi9ghY9sXYo7F51kJsKhJql+XOCEk/XijuSRO0kl0HAXq
         9m92plrHWEiU/G2rcUco0A+Hyg/ju6KFadvjf8dV939lp09dr2L+Zb5wWhVwTglcD+
         jk41Wmu+UuVLLRoCDhPFONRwLXLZFK+rz2CjWD4hVf6XsLrV+t6a5rmrpgG0fQioAP
         zLGOvQXxSplRA==
Date:   Sat, 25 Mar 2023 18:12:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     mazziesaccount@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: accel: Add support for Kionix/ROHM KX132
 accelerometer
Message-ID: <20230325181203.1e93df7d@jic23-huawei>
In-Reply-To: <ZBnch1tSKyR4fA7H@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
        <6f31fe7dbd142c01315891f6868ff75f7d7cde32.1679009443.git.mehdi.djait.k@gmail.com>
        <20230319162207.77ef0686@jic23-huawei>
        <ZBnch1tSKyR4fA7H@carbian>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Mar 2023 17:34:15 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hello Jonathan,
> 
> On Sun, Mar 19, 2023 at 04:22:07PM +0000, Jonathan Cameron wrote:
> > On Fri, 17 Mar 2023 00:48:37 +0100
> > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> >   
> > > Add support for the basic accelerometer features such as getting the
> > > acceleration data via IIO. (raw reads, triggered buffer [data-ready] or
> > > using the WMI IRQ).
> > > 
> > > Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
> > > Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>  
> > 
> > Nothing much specific to this patch, most changes will be as a result
> > of bringing this inline with the changes suggested for patch 2.
> > 
> > thanks,
> > 
> > Jonathan  
> > >  
> > > diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
> > > index 3bb40e9f5613..7e43bdb37156 100644
> > > --- a/drivers/iio/accel/kionix-kx022a.h
> > > +++ b/drivers/iio/accel/kionix-kx022a.h
> > > @@ -90,8 +90,61 @@
> > >  #define KX022A_REG_SELF_TEST	0x60
> > >  #define KX022A_MAX_REGISTER	0x60
> > >  
> > > +  
> > 
> > Push these down into the c file.  
> 
> Do you mean all REG and MASK defines ? 
> Even kx022a defines them in the h file, or am I misunderstanding your
> comment ?

Hmm. Generally we only put reg defines in a header if they
are accessed from multiple c files. Otherwise it's both noise and more
code that has to be parsed when compiling (even if it's all unused / ignored).

I'm fine with this patch set just continuing with local style given they
are already there, but if you fancy moving the existing ones down to the C file
as a precursor patch, then even better!

> 
> >   
> > > +#define KX132_REG_WHO		0x13
> > > +#define KX132_ID		0x3d
> > > +
> > > +#define KX132_FIFO_LENGTH	86
> > > +
> > > +#define KX132_REG_CNTL2		0x1c
> > > +#define KX132_REG_CNTL		0x1b
> > > +#define KX132_MASK_RES		BIT(6)
> > > +#define KX132_GSEL_2		0x0
> > > +#define KX132_GSEL_4		BIT(3)
> > > +#define KX132_GSEL_8		BIT(4)
> > > +#define KX132_GSEL_16		GENMASK(4, 3)
> > > +
> > > +#define KX132_REG_INS2		0x17
> > > +#define KX132_MASK_INS2_WMI	BIT(5)
> > > +
> > > +#define KX132_REG_XADP_L	0x02
> > > +#define KX132_REG_XOUT_L	0x08
> > > +#define KX132_REG_YOUT_L	0x0a
> > > +#define KX132_REG_ZOUT_L	0x0c
> > > +#define KX132_REG_COTR		0x12
> > > +#define KX132_REG_TSCP		0x14
> > > +#define KX132_REG_INT_REL	0x1a
> > > +
> > > +#define KX132_REG_ODCNTL	0x21
> > > +
> > > +#define KX132_REG_BTS_WUF_TH	0x4a
> > > +#define KX132_REG_MAN_WAKE	0x4d
> > > +
> > > +#define KX132_REG_BUF_CNTL1	0x5e
> > > +#define KX132_REG_BUF_CNTL2	0x5f
> > > +#define KX132_REG_BUF_STATUS_1	0x60
> > > +#define KX132_REG_BUF_STATUS_2	0x61
> > > +#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
> > > +#define KX132_REG_BUF_CLEAR	0x62
> > > +#define KX132_REG_BUF_READ	0x63
> > > +#define KX132_ODR_SHIFT		3
> > > +#define KX132_FIFO_MAX_WMI_TH	86
> > > +
> > > +#define KX132_REG_INC1		0x22
> > > +#define KX132_REG_INC5		0x26
> > > +#define KX132_REG_INC6		0x27
> > > +#define KX132_IPOL_LOW		0
> > > +#define KX132_IPOL_HIGH		KX_MASK_IPOL
> > > +#define KX132_ITYP_PULSE	KX_MASK_ITYP
> > > +
> > > +#define KX132_REG_INC4		0x25
> > > +
> > > +#define KX132_REG_SELF_TEST	0x5d
> > > +#define KX132_MAX_REGISTER	0x76
> > > +
> > >  enum kx022a_device_type {
> > >  	KX022A,
> > > +	KX132,  
> > As mentioned in previous review, I think this would be neater
> > done by just exporting the chip_info structures directly rather than
> > putting them in an array.  
> 
> I gave the reason in a response to the previous review.

If you strongly prefer the enum indexing array that's fine, but
definitely don't use the enum for the data in the tables - that should
be the pointer to the particular element of the array.
> 
> --
> Kind Regards
> Mehdi Djait

