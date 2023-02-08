Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9BC68F6CA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 19:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBHSTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 13:19:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjBHSTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 13:19:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2D1233E9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 10:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675880325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IIcq3P/5rIAbyviB1ugNp87Uox5xG5dLJSCsy7c3axc=;
        b=f5gj86nJl2pit31YDFEp+sDGdEUo9ZKNKbEz7xIKiJCVOw6lY6Mm1vEwf2cXWDqbE+ilFr
        NGOyemKea1mqGfKQ2TIYKbRNWiNRN920YtBTQWUri3lzf+yLykRmi53gPVcDn2mdk+vx99
        KMtc+fKLuCriHw8EZFNGOfHiL3ADKCk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-74-xP__IbDeNLGZn3x0B59k-w-1; Wed, 08 Feb 2023 13:18:43 -0500
X-MC-Unique: xP__IbDeNLGZn3x0B59k-w-1
Received: by mail-ej1-f72.google.com with SMTP id 21-20020a170906225500b0088b953a6df6so13861334ejr.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 10:18:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IIcq3P/5rIAbyviB1ugNp87Uox5xG5dLJSCsy7c3axc=;
        b=uiZF9V60/WZ+ybL8fRinSKF2Ly+6HJUCT6uAP9HC66XXEkZRXEPeYRSHvfDB8de+5d
         PpH3RNmvJPI8bbK6LiYAkgWihXFRmGsiPt/ITGEHa/LnKmFXlVCCzdYJZ/xn+2hJCx/f
         GpZ7dergc9yWkPtOQA7KtuHGqzm3pkK7s+x0Tc1ddy7b7F3lSfBm16IDoDme+Owctkz3
         +l7zw2SJbNO+kSg4Ea+7Q8lMjdWyt7SaF2Hx0qzu4AjrbWZLVUpw7g8oU7SiVVPmFIXd
         l4LhvplIBZfYIJURmZcCVH9W2zWoaIiP/xZ09qPH6EiB7Dr5A2VLhcTpFikgckCn4J2H
         eTzA==
X-Gm-Message-State: AO0yUKXQcq62ydcd39zYysmxyOjoed26WD4wTZg9xckqCiF7EfMg1biB
        7nlcDgsdXQHr7az/QforZXTxSNzEtu7PrF2UBNhwYCLQhbfNojkzIESqVbGy6CSi3MKBUSp5iXm
        8sYLlFBsKgECJE8DMoAKaW5Oc
X-Received: by 2002:a17:907:7da8:b0:8ad:531d:3606 with SMTP id oz40-20020a1709077da800b008ad531d3606mr3713530ejc.35.1675880322548;
        Wed, 08 Feb 2023 10:18:42 -0800 (PST)
X-Google-Smtp-Source: AK7set+aC6Hz7vImfOgHT67wkp5ZsNnOrtTvqW8pQvkv83CS7iCBnpRFpNlQtr1mCGEStx+0YVRzgA==
X-Received: by 2002:a17:907:7da8:b0:8ad:531d:3606 with SMTP id oz40-20020a1709077da800b008ad531d3606mr3713518ejc.35.1675880322396;
        Wed, 08 Feb 2023 10:18:42 -0800 (PST)
Received: from redhat.com ([2.52.132.212])
        by smtp.gmail.com with ESMTPSA id n12-20020a1709065e0c00b0086a4bb74cf7sm8590060eju.212.2023.02.08.10.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Feb 2023 10:18:41 -0800 (PST)
Date:   Wed, 8 Feb 2023 13:18:37 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     qemu-devel@nongnu.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] x86: temporarily remove all attempts to provide
 setup_data
Message-ID: <20230208131805-mutt-send-email-mst@kernel.org>
References: <20230208180835.234638-1-Jason@zx2c4.com>
 <20230208131125-mutt-send-email-mst@kernel.org>
 <CAHmME9rMnbGDZ+Rq8ao=gZd10kBp5ni=73HcPpFC58ChoKZObA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHmME9rMnbGDZ+Rq8ao=gZd10kBp5ni=73HcPpFC58ChoKZObA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 03:14:38PM -0300, Jason A. Donenfeld wrote:
> On Wed, Feb 8, 2023 at 3:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Feb 08, 2023 at 03:08:35PM -0300, Jason A. Donenfeld wrote:
> > > All attempts at providing setup_data have been made as an iteration on
> > > whatever was there before, stretching back to the original
> > > implementation used for DTBs that [mis]used the kernel image itself.
> > > We've now had a dozen rounds of bugs and hacks, and the result is
> > > turning into a pile of unmaintainable and increasingly brittle hacks.
> > >
> > > Let's just rip out all the madness and start over. We can re-architect
> > > this based on having a separate standalone setup_data file, which is how
> > > it should have been done in the first place. This is a larger project
> > > with a few things to coordinate, but we can't really begin thinking
> > > about that while trying to play whack-a-mole with the current buggy
> > > implementation.
> > >
> > > So this commit removes the setup_data setting from x86_load_linux(),
> > > while leaving intact the infrastructure we'll need in the future to try
> > > again.
> > >
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Cc: Dov Murik <dovmurik@linux.ibm.com>
> > > Cc: Tom Lendacky <thomas.lendacky@amd.com>
> > > Cc: Gerd Hoffmann <kraxel@redhat.com>
> > > Cc: Daniel P. Berrangé <berrange@redhat.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Richard Henderson <richard.henderson@linaro.org>
> > > Cc: H. Peter Anvin <hpa@zytor.com>
> > > Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> > > Cc: Nathan Chancellor <nathan@kernel.org>
> > > Cc: Borislav Petkov <bp@alien8.de>
> > > Cc: Eric Biggers <ebiggers@kernel.org>
> > > Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> >
> > I think I'll be happier if this is just a revert of
> > the relevant commits in reverse order to make life easier
> > for backporters.
> > Unless that's too much work as we made other changes around
> > this code?
> 
> I think that's going to be messy. And it won't handle the dtb stuff
> either straightforwardly.

List of Fixes tags so people can at least figure out whether they
have a version that needs this fix then?

-- 
MST

