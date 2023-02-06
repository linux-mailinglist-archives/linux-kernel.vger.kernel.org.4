Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8942568B8C0
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 10:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjBFJby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 04:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjBFJbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 04:31:53 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B9B314490
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 01:31:51 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id hx15so32267123ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 01:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tuFBZ5K9jW80wuBRi5+QxVgu8MDWTYBOoGsuaY/QYkY=;
        b=L7RUS/+uC8fLgbDOo32M+uDoCMuXvRxGzwT7HAjjYO5Gdj0eWzAq+dVD4NeMv84Kd+
         7/gjqwxT+Q7Ir+FDK2bG5er+STb+PDUPdR8PmllRAPGQhQQ5BxFdkGu7pAu5sZ4OY3z7
         YsQSHmUs8JZ93wxVUONhiNcEj8JQ3N2rt9HTHFBB+X98lD9Z1gpmKOivs3CSQV71Grg7
         OSJjF6fzWuJ4n+d8eWUIkZpoV/ny11Unnix8RaOae1bukuvppFcE8LzjR5/BnwkttGy2
         7EpzQVs5TztZdojojOJIRbsqgEP1bB8QScc6MIOuqYId2JSQr8O5cOUvcmOFMbq60plI
         wE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tuFBZ5K9jW80wuBRi5+QxVgu8MDWTYBOoGsuaY/QYkY=;
        b=29GyhcJ7QWkfIvLNHxL+50aWnM9j0iw6SGcF3dDM7tY3GD5p93e1EzWhRqkKNatTQd
         /2UbO98QMMO7fR/tYIjXbSUWqr3jYAEGSFjnPhCPYimxBDR3uZHzvNVOXPbSbT36orrh
         yxwEBNE2NQypUrrtuqCAKACuXHQZ6CE2o8pSn+nfUOZVz6gy+GPl1nDnA40jsvZz+n3P
         Bv/4Sp8nl1UuD6gAEcY9YYUw++TvjAT/G2pvRrnk3VDJ2Ygq7ue3fKquFnpEiWF0odmR
         Z6wX8HDctCMXJrO4wOONdtWLF1erz9kGnOg5z8YLm9SWdDbkb6wBIsjTD4j1sOvYLHC/
         4sZQ==
X-Gm-Message-State: AO0yUKX+913OfjVfBfYDltzbY7F1RPf5S5ip2upCXewfPAJcu8U7hSZP
        iNG86mc8aZDTblh9iktZmcFdtg==
X-Google-Smtp-Source: AK7set97TxXOw5dAZKhqT9qBmAtCQTBKvKjEogYjKg5z3XzIWWG08n4AL3cXiPtl1/Myo4fFi/K2Fg==
X-Received: by 2002:a17:906:5a68:b0:87f:1d80:cda8 with SMTP id my40-20020a1709065a6800b0087f1d80cda8mr21582720ejc.25.1675675909885;
        Mon, 06 Feb 2023 01:31:49 -0800 (PST)
Received: from hades (ppp079167090036.access.hol.gr. [79.167.90.36])
        by smtp.gmail.com with ESMTPSA id gy10-20020a170906f24a00b008a47ee398a9sm884612ejb.47.2023.02.06.01.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 01:31:49 -0800 (PST)
Date:   Mon, 6 Feb 2023 11:31:46 +0200
From:   Ilias Apalodimas <ilias.apalodimas@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahisa Kojima <masahisa.kojima@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [RFC PATCH 0/2] introduce op-tee based EFI Runtime Variable
 Service
Message-ID: <Y+DJAqiKGb/01wgV@hades>
References: <20230126132120.1661-1-masahisa.kojima@linaro.org>
 <CAFA6WYMdTxkcFkSux7F3fwxx2OqHP9UzqbWxdGnxuzjNU75PxA@mail.gmail.com>
 <Y9zFzW2yj7uMI0XR@jade>
 <CAFA6WYOp-NQxvqOmemiW2D5Au549f-u4LJA7XEK2aJgMiXRUYg@mail.gmail.com>
 <Y9zoMJcbrKIvbDdh@jade>
 <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFA6WYPLeN5tUY8JA=J9T3XVNfq5jAQ62i=qSk-6eesM-9_K=Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 12:14:12PM +0530, Sumit Garg wrote:
> On Fri, 3 Feb 2023 at 16:25, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > > > > with its corresponding secure storage TA.
> > > >
> > > > In the current setup we have the following layers in the kernel:
> > > > 1. efivar_operations
> > > > 2. MM
> > > > 3. PTA_STMM
> > > > 4. OP-TEE MSG
> > > >
> > > > and in the secure world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_STMM
> > > > S4. OP-TEE MSG
> > > >
> > > > If I understand you correctly you'd like to see this instead:
> > > > Kernel:
> > > > 1. efivar_operations
> > > > 2. PTA_EFIVAR
> > > > 4. OP-TEE MSG
> > > >
> > > > Since we still have the MM interface with StMM we'd have this in the secure
> > > > world:
> > > > S1. internal to StMM
> > > > S2. MM interface to StMM
> > > > S3. PTA_EFIVAR
> > > > S4. OP-TEE MSG
> > > >
> > > > At S3 we'd have to convert between EFIVAR and MM messages. The
> > > > difference is that we're moving the EFIVAR <-> MM conversion from the
> > > > non-secure world into the secure world. We're still using OP-TEE
> > > > specific communication at the fourth layer. So we're only moving problem
> > > > around, I'd rather avoid growing the OP-TEE part in the secure world.
> > > >
> > >
> > > If you look carefully, we are essentially defining an ABI towards the
> > > secure world. The approach in this patch-set adds the MM interface as
> > > a redundant ABI layer which makes it complex to maintain. Now think
> > > about if every TEE implementation would propose such a complex ABI. It
> > > looks like a maintenance nightmare to me.
> > >
> > > The concerns you are highlighting about OP-TEE size, I think those are
> > > implementation details which can be simplified later but once you have
> > > defined an ABI then you are stuck with its maintainability.
> >
> > You have a point, but keep in mind that it's StMM that matters here.
> > StMM uses the MM protocol. It was originially using raw SMCs as a
> > conduit, but with the need for OP-TEE accessing RPMB that's not usable.
> > So instead we use OP-TEE MSG as a conduit. Seen from that perspective
> > we're only resuing something established instead of inventing something
> > new.
> 
> Aren't we already adding PTA_STMM?

There's a sequence diagram that might help here [0].
The StMM PTA,  is responsible for wrapping the buffer it received from the
NS-world into an MM buffer.

> 
> Isn't the StMM specific to Arm as you already mentioned it was
> designed to specifically use raw SMCs? So if in future AMD TEE wants
> to implement EFI services, can we suggest they reuse the MM interface?

The MM interface is not exposed as an ABI to the non-secure world.  From
a Linux point of view, it's still a normal SMC invoke command towards OP-TEE.
What's 'special' and part of the ABI, is that the driver prepares the buffer
in a way StMM understands.  Then it gets handed over to OP-TEE, which
encapsulates it in an MM buffer and sends it to StMM.

As Jens already said, you asking to move the 'special stmm buffer' creation 
into OP-TEE instead of having the linux driver responsible for it.  That way we
can define an API for other TEEs, which will make the linux driver simpler.
We would ofc need to define some kind of versioning or service ID in that
API, so every TEE knows what it's supposed to call afterwards (iow an
internal TEE identifier in case we end up with multiple backends handling
EFI variables even in the same TEE). 

The proposal definitely makes sense,  but we are adding complexity and
knowledge of EFI to the secure world.  Someone still has to prepare a
buffer the way StMM understands it.

> 
> I am not sure why we need to redirect EFI variables via MM interface
> communication buffers rather than directly using the TEE shared memory
> approach.
> 
> Ard,
> 
> Since you have better insights into how EFI runtime services have to
> be implemented, can you share your opinion here? It may be something I
> am missing here.
> 
> -Sumit
> 

[0] https://apalos.github.io/Protected%20UEFI%20variables%20with%20U-Boot.html#Protected%20UEFI%20variables%20with%20U-Boot

Cheers
/Ilias
