Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AED36297AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 12:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiKOLmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 06:42:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiKOLmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 06:42:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C14220BF7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668512495;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=82+Kiwei6AcNPhpq2ed6tDfygMQDux9NKFRsOyFrZno=;
        b=F/QtwmBuFQ0/4pXkHyZl2tt8+3L98a11au9et/4kCWiH+Zk2MdSZU/Df604mVF3uD5822e
        by9so0ZengvapnKu+x75++/tPVX0icoC0ntfj6ckNOWJm5Zrrkl01S7OnLjLF3LEixy7RY
        wVaNzf7ZPYgnBUdx5SnAGbvYA4HQn3M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-hpkPnmmiM0-dlZ1J-LuWig-1; Tue, 15 Nov 2022 06:41:34 -0500
X-MC-Unique: hpkPnmmiM0-dlZ1J-LuWig-1
Received: by mail-qk1-f199.google.com with SMTP id u5-20020a05620a0c4500b006fb30780443so11234272qki.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 03:41:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82+Kiwei6AcNPhpq2ed6tDfygMQDux9NKFRsOyFrZno=;
        b=TKK4eUUYTlLYEV6FrGCpJTJ0ab5fZDQAAmXCN5YSD4nnfcf0ObdiqRSe6AED3DOsEW
         db6cHmIyPd+Us2F4/2Q8Q7DoLbVXl5+F1Wn2BNr6f8FlEXuo96/C7xcE4xdfIRa9w6Lc
         uUiSB36PsTN+hpETIz94qtmp/PFcwjPj42nPsctXkoVMKc0d7D2qiPcoQ3bea2x0QT73
         Y3UbsYzDbPeNe8RPVmvd9XT9pRywAwV/IDEmOyQTzigc5kSNshHrd+RUlgRmJsYSp13N
         dio+TY7W+N6/fqV+9jKrCLKKmwVba2tzZjjC3LCN7NOcDjSg/AOwSnIPUXLGbNwTrJJd
         DYAg==
X-Gm-Message-State: ANoB5plG0aya8ku7LUkmBltcME3rfmwiJDoh1OuhzobYX3wTzhyDnz5d
        n2hwajRyJ2srwqZp9D5Qff1zTvC9tYpZ1WswIHiHCkWN1IE1QN8+uirLznWJatMQTswZUJfFIuh
        Phn1W2vYkHdHHy9RDsZI2yd1/
X-Received: by 2002:a05:622a:315:b0:3a5:fa35:f42d with SMTP id q21-20020a05622a031500b003a5fa35f42dmr2103882qtw.286.1668512493870;
        Tue, 15 Nov 2022 03:41:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6Qszwx+2DWZN2OY2H/erVBB9AWIiUGMsoX2/JkOauVhdJAAq9QUl6eAI1Zvd5JAPXFYCpxvw==
X-Received: by 2002:a05:622a:315:b0:3a5:fa35:f42d with SMTP id q21-20020a05622a031500b003a5fa35f42dmr2103862qtw.286.1668512493585;
        Tue, 15 Nov 2022 03:41:33 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id d11-20020a05620a240b00b006e2d087fd63sm8294000qkn.63.2022.11.15.03.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 03:41:33 -0800 (PST)
Date:   Tue, 15 Nov 2022 06:41:31 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: Re: [PATCH] gpiolib: of: Use correct fwnode for DT-probed chips
Message-ID: <Y3N66y1jsnoZClwg@x1>
References: <20221111113732.461881-1-thierry.reding@gmail.com>
 <Y3Kv7XoBytwwy9pC@x1>
 <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115111800.t6i6fuszhuasvgka@SoMainline.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 12:18:00PM +0100, Marijn Suijten wrote:
> On 2022-11-14 16:15:25, Brian Masney wrote:
> > On Fri, Nov 11, 2022 at 12:37:32PM +0100, Thierry Reding wrote:
> > > From: Thierry Reding <treding@nvidia.com>
> > > 
> > > The OF node store in chip->fwnode is used to explicitly override the FW
> > > node for a GPIO chip. For chips that use the default FW node (i.e. that
> > > of their parent device), this will be NULL and cause the chip not to be
> > > fully registered.
> > > 
> > > Instead, use the GPIO device's FW node, which is set to either the node
> > > of the parent device or the explicit override in chip->fwnode.
> > > 
> > > Fixes: 8afe82550240 ("gpiolib: of: Prepare of_gpiochip_add() / of_gpiochip_remove() for fwnode")
> > > Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > 
> > Reviewed-by: Brian Masney <bmasney@redhat.com>
> > Tested-by: Brian Masney <bmasney@redhat.com>
> > 
> > I separately sent a similar type of patch to fix the same issue today:
> > https://lore.kernel.org/linux-arm-msm/20221114202943.2389489-1-bmasney@redhat.com/T/#u
> 
> For completeness, your linked patch fixes a synchronous external abort
> on multiple Qualcomm platforms pointed out in [1].  This patch however
> does not, are you sure they fix the exact same issue?
> 
> [1]: https://lore.kernel.org/linux-arm-msm/20221115110800.35gl3j43lmbxm3jb@SoMainline.org/

Thierry's patch fixes the issue that I encountered in
of_gpiochip_match_node_and_xlate() on the Qualcomm sa8540p automotive
board. I don't get the stack dump that you encountered. I am having
issues with probe deferrals on UFS when trying to acquire the
reset-gpio.

The patch I posted feels hacky (hence the RFC) but if the maintainers
agree with it then I can clean up the commit message and post a v2.

Brian

