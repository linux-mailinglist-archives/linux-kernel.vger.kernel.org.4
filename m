Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB47606AF9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 00:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiJTWHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 18:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiJTWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 18:07:05 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DDB1D463F;
        Thu, 20 Oct 2022 15:07:04 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-12c8312131fso1306050fac.4;
        Thu, 20 Oct 2022 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8y8/n+CIlPDe676Sc/xoar5vSLVQg7pNUfs29f+wZg=;
        b=AVGIdyv2AqPbzPgbkhXWjliy9TWo1+CaB25NF1DMU8UgHFhsSOCdIliiN40jtR1AaH
         oFbv3VvIlbGTlz/fi5OZx03S8BVXFT04/1m/9e72/ccdmV3DxRZeAW0CAsBDSvJBzfIX
         hEzitq+qjBHsE2QrCza9Q6o9LErMxhl5sCSZ7M449QH04ScgA7hcKv2JGc9Y4Ti2UfLN
         0WXZQ0XFh00yMObNcFimWX2GGhjk2aIO/xrspGYYBk6U8zQmiF/zZGgdIRsbLEzWLni7
         xIQQHW2GNPShPUOeDL/2qyKmKf182hwd9KoGP4Nt8qvbKMe3u626svjHkvOZEZx3EDTt
         zaqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c8y8/n+CIlPDe676Sc/xoar5vSLVQg7pNUfs29f+wZg=;
        b=EqFD+BLX/wmeS84qhqx/iDTo36mh2FT3EycB+gBaIc/XqK9kVFMgkI3vQn96ohByOp
         RSPrwc5zzKfnyHoHpUtO+r6ggClr0SdiUh/Xst1c/ZopQlC9Annj443kDN5s+JuxIRGp
         oeN2G6iKm7O0owgHdSo2iFznc2uw+twIYGXZqhqVl70l2VKHVpk9sjs2s4GC5AGgVEUB
         vS6rVXLFCb1Il6olKyFsj5+m4s8XvghxRGPivrlTFSFDqnKwX2VS5onEJyoVekQkf28+
         PN49wuUhOFd4PjF9opv3ETZzGRZZixdjohur2UI+oBTR8LfHFyYsGPm+N3lAWVdRGgm0
         vj8w==
X-Gm-Message-State: ACrzQf2iidYTCkwcaybgkWf5o33lFSSm+awqZR2FPT2BxfU0U+8LiqPd
        P/zqzWtDZXp/0pTlhHrNj60EbgOMbrM=
X-Google-Smtp-Source: AMsMyM4iN2P9yFLWr8RwwZtwLC10ZNOh8C2fpXHGvPRW42Is6KaU7mmW3HR9KihukguBHm5kX4bCag==
X-Received: by 2002:a05:6871:88a:b0:132:40e6:280 with SMTP id r10-20020a056871088a00b0013240e60280mr26667291oaq.202.1666303623655;
        Thu, 20 Oct 2022 15:07:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870418300b0011f400edb17sm9520754oac.4.2022.10.20.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 15:07:02 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 20 Oct 2022 15:07:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] hwmon: (jc42) Convert register access to use
 an I2C regmap
Message-ID: <20221020220701.GF4035307@roeck-us.net>
References: <20221020210320.1624617-1-martin.blumenstingl@googlemail.com>
 <20221020210320.1624617-2-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020210320.1624617-2-martin.blumenstingl@googlemail.com>
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

On Thu, Oct 20, 2022 at 11:03:17PM +0200, Martin Blumenstingl wrote:
> Switch the jc42 driver to use an I2C regmap to access the registers.
> This is done in preparation for improving the caching of registers and
> to restore the cached limits during system resume.
> 

I would suggest to combine patch 1 and 2 and drop local caching entirely
in a single patch.

Thanks,
Guenter
