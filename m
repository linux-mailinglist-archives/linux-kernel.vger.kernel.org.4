Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099C3621AAD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbiKHRbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbiKHRbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:31:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A911E21827;
        Tue,  8 Nov 2022 09:31:34 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r18so13961501pgr.12;
        Tue, 08 Nov 2022 09:31:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t0H4adOijjNqijdNgVvvEHYfjJqDCB5srsjIOvFZOw0=;
        b=ZqTEJ90xelHKa0fL8oXwDT466llWgiuptNThuod1N2qyEisflmX8u8/pUTGhy3Q5a1
         FR70sscCsHno1LY6f/q05V9ooUBuIrULhSHzNkSlKkvgEWd2JsEmCfxo2wRL8hlWd3Cc
         ZborFQi0eXqqsnMvH/1nn4gL3rdukb3TcHK/uUFFqVFJqgmCUZ+O9a7UZgaP9EpZoRjD
         t4/PbBogqan5ehmBHBT9RWMINqUbPCtWC7AzUe9qX5Me/zGxCd2fo3PTMdKWAp1DN/mh
         VDqTy0PY1u1cnqEetIpEiUU0ZuArVgTNLOEeaIjvjAaob3JxRveUgluvwbH2y2S1WR3t
         Rwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t0H4adOijjNqijdNgVvvEHYfjJqDCB5srsjIOvFZOw0=;
        b=jq2XIjM3AhPeqKJEbOIIye+XF0UcIKvv+wXKQ+28msXMCk7m7WNcH+uGrIvvRv7C7o
         /STshA8xugvfnLSJk11ZVbdwqy6LqIiD3H0gDXc9iSGkRC3ftlp2ZA0s28swz4DfBAZB
         pRLE1UtZgJrKP9aqJwlMjeW/y/dGCo57kht1It51Y8Xd0u3bQWSbW6PIYFmX5KGnQ73x
         llGoHWKdLUPKRX+QUD/1Oob/2CxMmMNwFhImi34BoSsGgNtGb05SelVMh8L9gDCwh4Of
         QPVSontl9nNfhzWbHkI8R797EMvsW9hW8kH8PrJfpossdcL6wW8J03ZCBmDvztsKbU7I
         Reyw==
X-Gm-Message-State: ACrzQf3W9fMD1FW+WMObxUv0Q5cU9xVr9qiNRWj1DzigdC9PA8CI/74M
        etP/Xx6j/T4Z6uXbgnX64bg=
X-Google-Smtp-Source: AMsMyM75+JkMtPaXuOEkZdNu3ya8LG6mkj6PpvauFxRCX50MGK1eRYMW2kWqxAU3LRUVg21M9a1w5g==
X-Received: by 2002:a63:82c3:0:b0:470:9d9:c2a9 with SMTP id w186-20020a6382c3000000b0047009d9c2a9mr30084096pgd.255.1667928693898;
        Tue, 08 Nov 2022 09:31:33 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:fb10:b5b0:232e:4afb])
        by smtp.gmail.com with ESMTPSA id t17-20020a17090a5d9100b00209a12b3879sm6282247pji.37.2022.11.08.09.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 09:31:33 -0800 (PST)
Date:   Tue, 8 Nov 2022 09:31:30 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Input: i8042 - Apply probe defer to more ASUS
 ZenBook models
Message-ID: <Y2qScl9UeyBHteh3@google.com>
References: <20221108142027.28480-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108142027.28480-1-tiwai@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 03:20:27PM +0100, Takashi Iwai wrote:
> There are yet a few more ASUS ZenBook models that require the deferred
> probe.  At least, there are different ZenBook UX325x and UX425x
> models.  Let's extend the DMI matching table entries for adapting
> those missing models.
> 
> Link: https://bugzilla.suse.com/show_bug.cgi?id=1190256
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Applied, thank you.

-- 
Dmitry
