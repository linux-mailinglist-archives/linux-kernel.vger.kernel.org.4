Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70426E1C32
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 08:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjDNGGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 02:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjDNGGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 02:06:15 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405B340FB;
        Thu, 13 Apr 2023 23:06:15 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id p17so6237080pla.3;
        Thu, 13 Apr 2023 23:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681452375; x=1684044375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nt3V2+mv4t801ZlOZsHsJ+sMq7Uehw8dmEUN92ABS60=;
        b=HoGqEkjeNtcP2rPL1p0y+FJIxoFVGTA5z6A2hPsrtax4RiKwU5poiwvth7vyrTIBJn
         3YZn3AGtuXrm8TB5J9gKjgfMiiJLaCU8jPiH/FQTcwfZ4N0ujU/K6sqWtA80eEuY2qKJ
         +TsoFY50tz40tx87JjDxeXkjpgA1HLocoZ4ksPqgxKXyQIoILFfF9NsjjEtTKeWMqPY1
         g5L8oaVzNqQZK0iEHIAc46ZCvXxujf6R91IjWajUMcm/twuvW+bUaAmXi0LpM8jEzE+W
         HjX3oCEBBxWDGW0XMB9fLlyl8hALQoMwf5+m1cWOXoA8knVn0cxE95ST/FrgpQAWagBt
         cnUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681452375; x=1684044375;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt3V2+mv4t801ZlOZsHsJ+sMq7Uehw8dmEUN92ABS60=;
        b=T9dfKDt/e+AqDfzdyzlXQQ1Saju/lODEQ669BGMp07++X5RI+jRacg7n0xmHJS3RRt
         MzIBkhK8tn5d47g6a9d/S6mc08/0EkzUrDK6AOdLBcLsXuMpa74mhX6H30s/ZrZvaXWc
         jxdr4utnsTZYDgaVG+VZsstnb1XEf9n98UIOf4i111Hfg/QmcjL25y621BY9lEw/zrhg
         inTtTg8j3i40YLDcn5NDmdrfqp4/AzP6A1assxrODNxwvleDg5r6Fzmn8QSlwzhupiOU
         1OnaX6z6zoZAsiBQcOr3JRxg6UHZNzLw9usFYz/TiW6b7JtHixN2B8B1nXJ0oTWC11R9
         QTNQ==
X-Gm-Message-State: AAQBX9c0mBDBkuI6XaceNUWTYbU4nXxEVEdJfBXHD9aR9Jwg8xkjKcX1
        fHBoT8gDySXJjA2/pF+OrLJR1k3uXm7+tA==
X-Google-Smtp-Source: AKy350am8vILPKKjsKr52mYLRSslvwQR+wsgesWZfuKdo0gQ2RhDaTJUcXxdcEs77Xu3IytxIKvRgA==
X-Received: by 2002:a17:90b:17c7:b0:246:f9f1:ad17 with SMTP id me7-20020a17090b17c700b00246f9f1ad17mr4145791pjb.40.1681452374443;
        Thu, 13 Apr 2023 23:06:14 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:5142:7eb2:ace5:60c1])
        by smtp.gmail.com with ESMTPSA id z4-20020a17090a540400b002407c8f89aasm2195283pjh.24.2023.04.13.23.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 23:06:13 -0700 (PDT)
Date:   Thu, 13 Apr 2023 23:06:10 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh@kernel.org>, Eric Anholt <eric@anholt.net>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        linux-input@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] input: raspberrypi-ts: Fix refcount leak in
 rpi_ts_probe
Message-ID: <ZDjtUjTTTXPrmr8N@google.com>
References: <20221223074657.810346-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223074657.810346-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 11:46:53AM +0400, Miaoqian Lin wrote:
> rpi_firmware_get() take reference, we need to release it in error paths
> as well. Use devm_rpi_firmware_get() helper to handling the resources.
> Also remove the existing rpi_firmware_put().
> 
> Fixes: 0b9f28fed3f7 ("Input: add official Raspberry Pi's touchscreen driver")
> Fixes: 3b8ddff780b7 ("input: raspberrypi-ts: Release firmware handle when not needed")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Applied, thank you.

-- 
Dmitry
