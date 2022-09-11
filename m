Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02F75B4D68
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 12:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiIKKaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 06:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbiIKKad (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 06:30:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53037F9D;
        Sun, 11 Sep 2022 03:30:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A95F4B802BD;
        Sun, 11 Sep 2022 10:30:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038BCC433C1;
        Sun, 11 Sep 2022 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662892229;
        bh=rNnbtRFKYREYyqEB7cI/f2rBcfDDV7x9aQ18P6n205U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=N7+so8nMUS8AntI37LqQR6aolHFhmwsq60lvM/jMkeiTpXQFl68I22dUsOd8WwsGD
         6EPkPkpxMqb8qSSzQxuD+ggBeil1U8iAPZJXFfK2VfkSRaK2R9CAoKIMEe6vDJORzY
         S7BahXqRiDLkAYhT3T62SHhCLs7X5d26ZGOIK3q8yI6vVWDZbMEP/8e2+p1KNnNAad
         y+ydJKlisNDGP9uByVGa92KVdo5O/3QNjdH2VzYdFZAH7q67QVh7nHMgRHVWKwge1p
         kde/pwUpH1pGbdKTQW8ZEXcx4J1HjQ8cxm2QQn1aWukNMU2wHQyLYyz2H2MIpnb8ZE
         JE8j9S0/RFfMA==
Date:   Sun, 11 Sep 2022 10:56:25 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup
 procedure
Message-ID: <20220911105625.348e3861@jic23-huawei>
In-Reply-To: <85280d48-4251-2811-b66d-092f4153fbb5@linux.ibm.com>
References: <20220809211246.251006-1-eajames@linux.ibm.com>
        <20220809211246.251006-2-eajames@linux.ibm.com>
        <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
        <e35b595f-572e-a539-c550-831cdd02dbd3@linux.ibm.com>
        <CAHp75VfU26QZ7Z1ApzRcFPudgsQc7zWF5g0kwn7Jzk1htXaWng@mail.gmail.com>
        <20220820124915.5dd5b745@jic23-huawei>
        <85280d48-4251-2811-b66d-092f4153fbb5@linux.ibm.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 14:48:20 -0500
Eddie James <eajames@linux.ibm.com> wrote:

> On 8/20/22 06:49, Jonathan Cameron wrote:
> > On Fri, 19 Aug 2022 12:42:00 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >  
> >> On Mon, Aug 15, 2022 at 4:42 PM Eddie James <eajames@linux.ibm.com> wrote:  
> >>> On 8/12/22 17:03, Andy Shevchenko wrote:  
> >>>> On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:  
> >> ...
> >>  
> >>>>> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
> >>>>> +       if (rc)
> >>>>> +               return rc;
> >>>>> +
> >>>>> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
> >>>>> +       if (rc)
> >>>>> +               return rc;  
> >>>> This code already exists, but still want to ask, is it really
> >>>> byte-registers here and not be16/le16 one? In such a case perhaps bulk
> >>>> write can be used to reflect it better?  
> >>> The temperature and pressure regs are 24 bits big endian, and all the
> >>> rest are 8 bits. I think the existing approach is best.  
> >> It doesn't look like you got what I was meaning... Or I misunderstood
> >> what you said.
> >>
> >> The code above writes two byte values to two sequential registers
> >> which make me think that they are 16-bit registers at offset 0x0e.  
> > Given they are undocumented, this is guessing territory.
> > Probably best to just leave them as is.
> > You could do a bulk write on an array though as that implies
> > nothing about what's in the registers -just that they happen
> > to be next to each other.  
> 
> 
> Indeed. Is it worth it to switch to bulk write for two 2-byte writes? 
> I'm inclined to say no and will leave this as-is for v6, but if you 
> think it is, I can switch it.
> 

As far as I'm concerned, fine either way.

Jonathan

> 
> Thanks,
> 
> Eddie
> 
> 
> >  
> >> ...
> >>  
> >>>>> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
> >>>>> +       if (rc)
> >>>>> +               return rc;
> >>>>> +
> >>>>> +       return regmap_write(data->regmap, 0x0f, 0x00);  
> >> Ditto.
> >>  

