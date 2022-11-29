Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A7B63C420
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:49:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231599AbiK2Ptl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:49:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiK2PtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:49:22 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9340312D1C
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:48:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id l11so20353598edb.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 07:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VIRe95Z6jcNjLS0kWdXMlZ6r3LFNPa2W1G5woacMJko=;
        b=meU+ykcNyiAq6Ope/bgI1B6cXVFFCv8w5gGeixY5B4f/VQ1ZuJkGoo66jb2d2xfIgh
         DXDg1OF1N5lOE7QH1BTuURIYVuG6EQkJ2nDZE2+AcvcM++OoJ0I9vi/ddhhFfeVoT+65
         8VUn4blseN0/qhD746KdFJq36mVXIET3ERHbcVcTNd/W3AwLYSN53x1EahSFZSohu9nY
         uhbOmyrUUbQe85kxJ8Poz7eLXRcijVLPmZxRRdbQY+ygoqLXnONTPzz65w5aroAqLtD3
         z33KeTPnVXYf+7pDR2BnSpTQu9Y4w/az6q3NOGvOzJWuVmuOt31Vn0x6zb5M+cECyxFU
         dcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VIRe95Z6jcNjLS0kWdXMlZ6r3LFNPa2W1G5woacMJko=;
        b=Pzp5GII7XTAvPSGez06yn+0i18ziHF2tHzffg8t3983JAfir8//8rUlvmKnSmU2NJ9
         urjEjA+Bcb3KUJz5LD0WqkuroEaKhMK3bnDyv4ewFpyhuPVHS27AEwDaL+JoLR+KmJZB
         NgGjtFa7lVdfarVTiMa8p+lsBmkRsDwxC5lgx+J+QSDOUN22HdRkyFNuDlqSmrylsW00
         ePffJiyAtvaXch3kbTKgcYsoxZ4ZvY0ZsnWqQGoT5oYgGZJ3E/WRSmdCRNZrimcReg37
         UEkdSUTtZ6BO3c76CbArxJA0Jl8buCQKdvtFdvF/DxDyez/qS9d0plczxecCpy9KLaQX
         gWdQ==
X-Gm-Message-State: ANoB5plqxUsKW3pwNdwXrMFvB5mogDi3QzOjpSsQCHKHP5ilLxiXq8dx
        kl2lVxYH7C3WCEnwAZUGsricEg==
X-Google-Smtp-Source: AA0mqf5s58TQL7Mgsv2sX2m9+Mz1iCbc1RBtYKkkrGp3bN34Zcsvk1cIPnxBuOBedDqeyZsDPTsW8Q==
X-Received: by 2002:a05:6402:5413:b0:458:211d:cbe4 with SMTP id ev19-20020a056402541300b00458211dcbe4mr3453537edb.11.1669736914018;
        Tue, 29 Nov 2022 07:48:34 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-748-2a9a-a2a6-1362.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:748:2a9a:a2a6:1362])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b007be4d8a50d8sm3918194eji.70.2022.11.29.07.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 07:48:33 -0800 (PST)
Date:   Tue, 29 Nov 2022 16:48:32 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
        conor@kernel.org, devicetree@vger.kernel.org, guoren@kernel.org,
        heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, robh+dt@kernel.org
Subject: Re: [RFC 0/2] Putting some basic order on isa extension stuff
Message-ID: <20221129154832.27or3ywsx7npuqzq@kamzik>
References: <Y4XvnHIPw8ZuBZEk@wendy>
 <20221129144742.2935581-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221129144742.2935581-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 02:47:41PM +0000, Conor Dooley wrote:
> RFC:
> - I have not even tested this, I just did an allmodconfig
> - I don't know if I re-ordered something that is sacrosanct
> - I don't know if I changed all of the instances
> - I didn't write a proper commit message for "patch" 2/2
> 
> With those caveats out of the way - all I did here was try to make
> things consistent so that it'd be easier to point patch submitters at a
> "do this order please".
> 
> I never know which of these can be moved without breaking stuff - but
> they all seem to be internal use stuff since they're not in uapi?
> 
> @drew, I didn't touch the KVM ones - are they re-sortable too? My base
> here is rc7 so if you did a reorder at any point there I'd not see it ;)

Right, we can't touch enum KVM_RISCV_ISA_EXT_ID as that's UAPI. All new
extensions must be added at the bottom. We originally also had to keep
kvm_isa_ext_arr[] in that order, but commit 1b5cbb8733f9 ("RISC-V: KVM:
Make ISA ext mappings explicit") allows us to list its elements in any
order, which means we could sort them in canonical order, if we wanted
to. I think I'd rather have them in alphabetical order, though (they
nearly are at the moment, except for the bottom two...) The only other
place we have ISA extensions listed in KVM is in a switch statement,
which of course doesn't matter, and it's currently in alphabetical order.

Thanks,
drew
