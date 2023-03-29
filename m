Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8056CF5AA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbjC2Vw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjC2VwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:52:17 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79CC526F;
        Wed, 29 Mar 2023 14:52:09 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id e65so21193463ybh.10;
        Wed, 29 Mar 2023 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680126729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Wh1B0599Qis1A5KRvW2arbaj6Q9+dYZeQ7c/+45Fju4=;
        b=mtkw9BQf6FvMVy9xBbTWd93wXY0IItrzV2y964p++mrHIFjo15Zv7JN5y8/1+D9gh8
         p9uGmphy+0pCwvrTL5J5p64f7DjUOXu/HAJcpaJvDirbgpq9JpUDJzuHP4TOTqVsAM7f
         vUfRIClDh3hmT3//D6WcGPrURMJVbzDQgbHEbPUDzlNQLm0e7HASKgnaUoTvqKU3AZgI
         zdC/25qFvMopr08kp/eorb1Tqb5Kp7s+pcSjQJFkCqDI5WmxXZRW7w+iRalol62Rx5O1
         BmLdZXyVfx3QjjAkngWamJDrKo0uXVukIdzraQ+cJJT7koDFIdXIFQPa2tKGyTEn+iFC
         Qdjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680126729;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wh1B0599Qis1A5KRvW2arbaj6Q9+dYZeQ7c/+45Fju4=;
        b=GVXB+NlZpYSMPyAonPra2/2w44xIj4zf0xYgRKGiQfgGZQaaoUnIWbu4lF1ovnJ0ZV
         8WOCjFyL1sdZTRvCyf4Zw+Kae+G/VhhbV8FFoszZPUose3gHMcxMkF9/AN38F3arBaZE
         Pb/5B0IXPsvSmW9gLFOZlYymDodLJp0b2xfe1a+UxBnzdtlNpdZqchN2+dBRCq3D5dxg
         t9c/P0OBOnlmybH+cxaE6rk7j7ijY7iXDkjOBs8agNGvh4upajd9Nbp456Lkj43k4+s4
         Ah4WDv8CXo0krxEOsN1zlR8iaWsE73ygCEThYqEXyM6HLVoULnfIKpbP2Wiu8p8ryXfM
         sPYw==
X-Gm-Message-State: AAQBX9fydOPpgnvwJcPBfYdbkJb3mQ6BsZOVJHfNj5dYUXAvVKGelFRJ
        s7YJUGNllh/88Y6mMIzBjf0=
X-Google-Smtp-Source: AKy350bi4OXB1GzOB9yXEI/9SI7hN/blDYvOoj9AynOzMz7+0VnDJGXWeYDXayBQznPtopkd6xXdQg==
X-Received: by 2002:a25:f826:0:b0:b6d:5e86:7ed2 with SMTP id u38-20020a25f826000000b00b6d5e867ed2mr18841698ybd.36.1680126729127;
        Wed, 29 Mar 2023 14:52:09 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v130-20020a252f88000000b00b7767ca7490sm3721007ybv.45.2023.03.29.14.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 14:52:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 29 Mar 2023 14:52:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Shreeya Patel <shreeya.patel@collabora.com>,
        wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jamie@jamieiles.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 2/2] dt-bindings: watchdog: rockchip: Add
 rockchip,rk3588-wdt string
Message-ID: <b3bfec84-b8b4-437c-82e8-37c6812deeeb@roeck-us.net>
References: <20230328210048.195124-1-shreeya.patel@collabora.com>
 <20230328210048.195124-3-shreeya.patel@collabora.com>
 <157937fd-0af7-4ff5-8430-2f956c7aafba@roeck-us.net>
 <4256207.ejJDZkT8p0@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4256207.ejJDZkT8p0@diego>
X-Spam-Status: No, score=0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 03:04:52PM +0200, Heiko Stübner wrote:
> Hi Guenter,
> 
> Am Mittwoch, 29. März 2023, 14:47:34 CEST schrieb Guenter Roeck:
> > On Wed, Mar 29, 2023 at 02:30:48AM +0530, Shreeya Patel wrote:
> > > Add rockchip,rk3588-wdt compatible string.
> > > 
> > > Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> just the usual question who is expected to pick up the binding patch?
> Should I just take it together with the dts-patch or do we wait for
> a watchdog-maintainer to pick up the binding alone?


I am ok with you taking both patches.

FTR:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Guenter
