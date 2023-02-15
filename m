Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB426698173
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 17:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBOQ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 11:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjBOQ6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 11:58:37 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDCD241DF;
        Wed, 15 Feb 2023 08:58:35 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id t5so16332126oiw.1;
        Wed, 15 Feb 2023 08:58:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnilHvHIWz6XJQyZmC9tlkle3V8Kd4Gf6vv7YdqxR7g=;
        b=W2Kij7HwOZ69SlA21yE20Tvu58qvFXHvnVOaM5wMJxICzaCiRi7MAhSTc5uXFU6AyL
         GXuGmGCM692bZQGW049nuPxarTmbm+jKeK6AxhQzA9pWj/HGYu6c5YEKx5x2iJZVRi+K
         LmiR6NrgBlhaAfQ9URxjdLD5+K1UayLoRCUsXx991qJbASL3xv8j1TYoBfGKC/fpR//U
         6EbIon43DdWfXoGXHabvxaBFZhFVgpta5dHAAVBvcsRtPfX3lpz+QD463vQgnegwDpnX
         2XV6HVe0D11wzQh79qMcsrth1C/tzDxIxggOArTMved0vFVyl7QDVR9h7UdrCaQUQgu8
         le+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnilHvHIWz6XJQyZmC9tlkle3V8Kd4Gf6vv7YdqxR7g=;
        b=fPA2p7oqwecfEU+4laagNzQZygTY5TIL3LkspWq8QFUOsK0b4e7nbk3pNXyZFLGta7
         BLX1UmIME0fIOgCUWOapU4WEzNaMfPZ8jDIfhoAbsXrgffPnsD+sN2PokQPpQO3DT2se
         qdxSxc/PcIeQP9ZWM1OmXE3rtD1wMG3bx/IFk6LA89JzdFNnnI8QdcK6zEURKoYKzyKT
         K15YoClDjoUpcqNBos92nINzlVJGAF9giE+iSnPRfSYqEDC0vYDJpIaQ0Q4fET045WP0
         hiIrJDkQZpZJIFUL8anqXJMUbv9JPh23w/cc85dGNdCaOp8EgwqLiHROiZzUXZviJbt0
         0brQ==
X-Gm-Message-State: AO0yUKVfpA59KG3cy9+xZ7+CGA536/49TF0DsH8WJlKprwTr4jy3fTpu
        t5dvi/cGYQdYUG2DCybaULY=
X-Google-Smtp-Source: AK7set/ZAvHpPaDMFMS7iXmCyOEZzy+JIZG9sfJMibCGco6yS7QrYlad8pI3tRcHIcvrjBqJLdJi8Q==
X-Received: by 2002:a05:6808:351:b0:364:8e7d:6afc with SMTP id j17-20020a056808035100b003648e7d6afcmr1098363oie.41.1676480314329;
        Wed, 15 Feb 2023 08:58:34 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s12-20020a9d758c000000b0068bc48c61a5sm7648978otk.19.2023.02.15.08.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 08:58:33 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 15 Feb 2023 08:58:32 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, Tony Luck <tony.luck@intel.com>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-ia64@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] arch: Remove Itanium (IA-64) architecture
Message-ID: <20230215165832.GB3786546@roeck-us.net>
References: <20230215100008.2565237-1-ardb@kernel.org>
 <20230215100008.2565237-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230215100008.2565237-2-ardb@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 15, 2023 at 11:00:04AM +0100, Ard Biesheuvel wrote:
> Itanium is the original architecture for which EFI was developed, and
> the way Linux supports it deviates significantly from other
> architectures.
> 
> So it is anyone's guess whether the ongoing maintenance and developement
> of the EFI subsystem has regressed Itanium or not - QEMU no longer
> implements support for it, and so there is zero test coverage using
> actual hardware.
> 
> Note that the Intel firmware team themselves already removed all IA-64
> support from the Tianocore/EDK2 reference implementation of EFI in 2018,
> so let's follow suit, and drop IA-64 from Linux as well.
> 
> Acked-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Trying again since the previous message bounced with "message too long".

Acked-by: Guenter Roeck <linux@roeck-us.net>

Sorry for the noise for anyone receiving this twice.

Guenter
