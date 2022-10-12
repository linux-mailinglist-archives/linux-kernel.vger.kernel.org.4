Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE6315FBF5F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 04:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbiJLC5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 22:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiJLC5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 22:57:45 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC68FA285D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:57:44 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bs14so6179377ljb.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 19:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JQI4vBs+lelQege7RBEn6DWHgmIXsDFHZwNA5ZgFKU=;
        b=Lyo4UNutfEAagGtWOhZr2eUmQ1+gSAHnSbjg07tOccfA/IjKp5mUvKUs+kUbNmGoyO
         cC6XOpn2HEwDduT2aiMkudUJhvWiPHTv6C9CSZrb7AHSfP/3csxNJ4WUCmGvjDOnbGCs
         mcCNo80bZGRbXQzNv+DDjOT/l2Mx40LWu9w5DNuONANC6IFlzED0pBy6AoiG1+CmenBP
         D/IuRGMVge0qIwES/jcq9QP7Mc8dvdQiU1b1WwyEis5gjVi/5Qqk4ci8rnsMyZlVS5PT
         6UTRBllaON5bauw6uI1OsyXPGCfBMPrvaQZZlcS/sPVUa5XMFCVAujs+rIkn1bNEq6iv
         IG5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JQI4vBs+lelQege7RBEn6DWHgmIXsDFHZwNA5ZgFKU=;
        b=rGCfVMria5g7H/Qu2l/x5Nxy8dOGiIWgC3c+DPg2xyCBXNT257Epo7WkC5xsIGwzYs
         yzQmrtbeAPwC8lHsZiGCVZhVb0xzuWISu+/JzECakYAKZXjIaOA+pOI69se+59kagtxl
         vnrVgw9SP+gpyGkFvVl7YKTj+A+4P/7yGv9KBOkL8nqgdwP4niilPrlob+sc103e7ew6
         o56GzVfQjVq5b5A9uVo2StF2x8+q7gV/d+vpMh3vzs5izKgSk+8wDbu00YcVopR4RQVx
         WwQzLWEbmMUAtcrD87oKsz/Pl1ZnFDzQiTyLOHb+k5Urx6yTo9/SULsqEbSPXdKj7gvT
         5B6g==
X-Gm-Message-State: ACrzQf3qApZvP4WdcKiGeLBil0UQ566u8y5uE+SZq7qU26aL14y+g40h
        JYJnWJkZPVDpjO4RslXqyCAoXpenBoc05zF1oEHX
X-Google-Smtp-Source: AMsMyM75oXrhPO9vWAe9sZAYTcz7EaqyLgYfh9oxskTd528INwQQSWMA9lUAahaX55B4s7CdTOVKidG0X/cTSQhQzOQ=
X-Received: by 2002:a2e:a273:0:b0:26f:b795:8b30 with SMTP id
 k19-20020a2ea273000000b0026fb7958b30mr2469197ljm.209.1665543463217; Tue, 11
 Oct 2022 19:57:43 -0700 (PDT)
MIME-Version: 1.0
References: <20221012012629.334966-1-ye.xingchen@zte.com.cn>
In-Reply-To: <20221012012629.334966-1-ye.xingchen@zte.com.cn>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 11 Oct 2022 19:57:32 -0700
Message-ID: <CANDhNCo4OnN62oVo+B4tQoOK6SYaxbwK==GOt=e3yYD5NMJR6w@mail.gmail.com>
Subject: Re: [PATCH linux-next v2] timers: replace in_irq() with
To:     yexingchen116@gmail.com
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ye xingchen <ye.xingchen@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 6:26 PM <yexingchen116@gmail.com> wrote:
>
> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Replace the obsolete and ambiguos macro in_irq() with new

ambiguous ?

> macro in_hardirq().
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Acked-by: John Stultz <jstultz@google.com>
