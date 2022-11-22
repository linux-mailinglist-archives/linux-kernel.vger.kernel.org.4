Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E423463491D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 22:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234876AbiKVVWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 16:22:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234581AbiKVVWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 16:22:10 -0500
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6928FB09;
        Tue, 22 Nov 2022 13:22:08 -0800 (PST)
Received: by mail-io1-f47.google.com with SMTP id 11so11945567iou.0;
        Tue, 22 Nov 2022 13:22:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=61D4QX3fnERtNT3uDo8U48CODKORmNXYk2VXpv6fxMw=;
        b=pQwzKaUiVeLB7ximJf7CsxX/gmA9/iUFI+PJOKsCi3AmQxuTPq5PwYq7ZxbLF+LsCL
         vvFpDJj6Xp0N9SJATIHXnJyY4shNSw2fRGjNWT1RiRB+8oeQx7tLpFmncp+EcZx67sRH
         T122AYMYzG+1mq8qDvluybI00tsuBUJNk92MpBophz/iGo06I+xnunpz4nDXuBTNE+GC
         9Zz9lG9BRtHGOIR8ewsQOrQN2UdWjcu0sJQfznFiWS6WmSZDKkkFkVh/B92FV5oZoQ/D
         s1V3uKPa481EhCXpZmlEC2tAwi+4py0lPC95A1TshWsXJc/WVSg3mcx+nVCsf50lKlfm
         UoAQ==
X-Gm-Message-State: ANoB5pkOMMBda72SFPKFMisemRSlqg5nykmLJCtAGN8FWtT3DMMlobdO
        CIcA2awCXJGexIUnNrB7mg==
X-Google-Smtp-Source: AA0mqf4v2DouMGNBCh4G7qwa+WVcDYj6HDZnTd0nEL3jjFPQr73sjhri5ATcCl/bPpKRqRMOKNPfsQ==
X-Received: by 2002:a05:6638:1916:b0:363:95e3:c813 with SMTP id p22-20020a056638191600b0036395e3c813mr11847700jal.263.1669152128096;
        Tue, 22 Nov 2022 13:22:08 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id o11-20020a0566022e0b00b006c5247c8f81sm5693719iow.48.2022.11.22.13.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 13:22:07 -0800 (PST)
Received: (nullmailer pid 597043 invoked by uid 1000);
        Tue, 22 Nov 2022 21:22:09 -0000
Date:   Tue, 22 Nov 2022 15:22:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 5/5] driver core: pass a const * into of_device_uevent()
Message-ID: <20221122212209.GA583854-robh@kernel.org>
References: <20221121094649.1556002-1-gregkh@linuxfoundation.org>
 <20221121094649.1556002-5-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121094649.1556002-5-gregkh@linuxfoundation.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 10:46:49AM +0100, Greg Kroah-Hartman wrote:
> of_device_uevent() does not modify the struct device * passed into it,
> so make it a const * to enforce this.  Also the documentation for the
> function was really wrong so fix that up at the same time.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/of/device.c       | 6 +++---
>  include/linux/of_device.h | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)

Looks like I can take this one?

The same could be done for several other functions in of/device.c.
