Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB83760ADCD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiJXOer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:34:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237223AbiJXOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:34:07 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA0109C;
        Mon, 24 Oct 2022 06:09:30 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id f140so8932190pfa.1;
        Mon, 24 Oct 2022 06:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=aSpoXN2MutncQ4V4fSkz8rocQLQbOT8gk060tfwv6HA=;
        b=VM2TGjTfd+9M4I2mEG2+ugX0olw7fq2OtJFlXmjmJ0HzOFp220J+qB0zejrhdaF4Pb
         gCEBZqVjF4BeYFyXIkaryPMseczZTWPyf4E3skQlhv67F/KKEbIMTtkW7zLU7cwnvZh3
         Ps8enynyDxVDq274klUmbkSQ0V5geo7J3t9XjD4PTqpbeVuGCmEB2gp6hvUrYqPw1qat
         9ZM/PvWkZEAHNH5ohtZShp+bopXN36SDFa3D6IWMh2koKC9/jKK7eLn5KNPcT6blEH9N
         MgMznOG8jO6ztumaiHZRQkcki9Rafmm+EXr5vmFK/WB+ezpEmvrIbIf4eYS17OFbSoGn
         2y6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSpoXN2MutncQ4V4fSkz8rocQLQbOT8gk060tfwv6HA=;
        b=6Cy3sovahQzWfvbF4o+ofXl3X3MWP8gbP5fOk/nBnarIRYhUzZSheuNdhfIUj2Far6
         VKT0dXkWHSO1rYbW8/nwxW4xsst33CkUxR/Mh/ZSO4HlOi4Ex/QXOQdNljYX1g8mAqux
         YwJqVfvTP84pI0IhNU6gFbn01wc9Ueh7cLJPQWg37C5k6UjIZUer9MvfHdIk5pEakAnT
         c+wn/KfojV5VJuLEc/HbcWObgZECKdSuX2cIt6mhy1rAaisD+tffkklvdgx5plXEV5I1
         aIjCGZu3w2GpQam1S9R5fi1AuNkLXwy4F7QtHHYOnNBj/Rpe3FSJo2X2iD/9TZN/CMKA
         cVng==
X-Gm-Message-State: ACrzQf2X7LXNaqzuJOZZjec1GeceCKmT68KHDzP743LYa2UoCmdAVDUw
        DDnLcvEDAc+/GhMAVqLo3Vk8ZxNp3jvIWg==
X-Google-Smtp-Source: AMsMyM4Itf01KbOxiaNjiBUgyf+DpgIlzp3VGzHaSWpIcHHq161KV+eJ6EGMlbFzo7SnxI5ZcF332Q==
X-Received: by 2002:a63:5761:0:b0:46e:b96b:e76 with SMTP id h33-20020a635761000000b0046eb96b0e76mr14719715pgm.534.1666612658465;
        Mon, 24 Oct 2022 04:57:38 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:3698:60f8:9964:1fb4])
        by smtp.gmail.com with ESMTPSA id e28-20020a056a0000dc00b0056afd55722asm5560034pfj.153.2022.10.24.04.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 04:57:37 -0700 (PDT)
Date:   Mon, 24 Oct 2022 04:57:34 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 17/21] input: remove s3c24xx touchscreen driver
Message-ID: <Y1Z9rrO2rVRtF22f@google.com>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-17-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021203329.4143397-17-arnd@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 10:27:50PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx SoC support and its adc driver was removed, so this driver
> has no remaining users.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Thanks.

-- 
Dmitry
