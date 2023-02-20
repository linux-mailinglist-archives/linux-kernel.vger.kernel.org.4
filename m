Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CF369CA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:55:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjBTLz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:55:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjBTLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:55:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE2C4691
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676894073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TH4heAkd9VMklcYtFtHsbJ7cFvEpofoQQlBNmQcmA7U=;
        b=ckrrYhSxv7UgikTzZ2cWn41FkoUeJmRF8oYTojH5DKm4UwI7/M08DP7UxJSFPoVphhoGY1
        X1AURJdaf2LVPjc2QM5tRkn6aQW5l/m7bU5SeDPQFEr280xRgTsBylGw1siJ+KhymOAiuP
        d36+WVsygZ+T+KC432WqlbZIUXhCP3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-421-VxAbPUEENs29s1SyJrrMqQ-1; Mon, 20 Feb 2023 06:54:32 -0500
X-MC-Unique: VxAbPUEENs29s1SyJrrMqQ-1
Received: by mail-wm1-f69.google.com with SMTP id k26-20020a05600c0b5a00b003dfe4bae099so505088wmr.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 03:54:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH4heAkd9VMklcYtFtHsbJ7cFvEpofoQQlBNmQcmA7U=;
        b=S4YIqqhmv8Ab43iLPc21qWOgq2WsBUKSI9HbYGpH8iXhpxMlXJAAcXomZheJSvfUq7
         zuUPwraT3LyK+9YrqgC1N+k6Q5y396qP5Nh1Gh06TFWFIOTAkZUApptRezkdMloYZtC1
         glxCL0uXBr8ZyJzk0lsBZ2xQDoSi7Wqy1KPYHtCBL/GaigRTPMCshCUqDxG23eFTnTBz
         UpzoTWuhHtBpLHZRiiIReqz1BBnp0OFKxBP61Rnu+nYCiAHUwoVfIvdmG0a+Na3y9geI
         j/FQASfvVdsuoClMbLvxn6qUcCPlW5ryzP5O74qGTQqxHy2apYwKoRwTxWJmtdjcLBEe
         w6Ug==
X-Gm-Message-State: AO0yUKWemsGeSLmxzwPTOCxgF2Jhs24FcZ2166F31BwmmH0j0YkNq7zI
        /QvRl+0lUxC3Fw0D3AhD5A7+8qwGzB/0FnPhGWGiBTzxj2uIbhTIAfG+ZHCa+mw9CqD4txY24F0
        KAbjF89UN8FYHp3qfLZ+ICORM
X-Received: by 2002:a05:600c:a698:b0:3e2:1e31:36bc with SMTP id ip24-20020a05600ca69800b003e21e3136bcmr110354wmb.12.1676894071593;
        Mon, 20 Feb 2023 03:54:31 -0800 (PST)
X-Google-Smtp-Source: AK7set/cmHCer5I++eQzXfxaAsD+TKAnuLkw6cXg2aGfsbXV/ILAK/XbJNFn/oWrn3mcd7fYW9rmvA==
X-Received: by 2002:a05:600c:a698:b0:3e2:1e31:36bc with SMTP id ip24-20020a05600ca69800b003e21e3136bcmr110346wmb.12.1676894071316;
        Mon, 20 Feb 2023 03:54:31 -0800 (PST)
Received: from redhat.com ([2.52.5.34])
        by smtp.gmail.com with ESMTPSA id ja13-20020a05600c556d00b003e4326a6d53sm2783361wmb.35.2023.02.20.03.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Feb 2023 03:54:30 -0800 (PST)
Date:   Mon, 20 Feb 2023 06:54:27 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc:     qemu-devel@nongnu.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Dov Murik <dovmurik@linux.ibm.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH RFC 0/7] revert RNG seed mess
Message-ID: <20230220065418-mutt-send-email-mst@kernel.org>
References: <20230208211212.41951-1-mst@redhat.com>
 <Y+YratFIX/WHWbFy@redhat.com>
 <Y/NQGfiH322iZuhX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y/NQGfiH322iZuhX@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 10:48:57AM +0000, Daniel P. Berrangé wrote:
> On Fri, Feb 10, 2023 at 11:32:58AM +0000, Daniel P. Berrangé wrote:
> > On Wed, Feb 08, 2023 at 04:12:23PM -0500, Michael S. Tsirkin wrote:
> > > All attempts to fix up passing RNG seed via setup_data entry failed.
> > > Let's just rip out all of it.  We'll start over.
> > > 
> > > 
> > > Warning: all I did was git revert the relevant patches and resolve the
> > > (trivial) conflicts. Not even compiled - it's almost midnight here.
> > > 
> > > Jason this is the kind of approach I'd like to see, not yet another
> > > pointer math rich patch I need to spend time reviewing. Just get us back
> > > to where we started. We can redo "x86: use typedef for SetupData struct"
> > > later if we want, it's benign.
> > 
> > This approach looks suitable for applying to the 7.2 tree too,
> > which will be good for fixing the regressions in stable.
> 
> Since no further alternative has been proposed, can you consider sending
> a pull request for this series. This has been broken for too long and
> many users & vendors are looking for an official fix to be applied to
> master before they backport to 7.2
> 
> With regards,
> Daniel
> -- 
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

Will do. Thanks!

