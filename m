Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE86F3B6F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjEBAi6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbjEBAi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:38:56 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36B50173D;
        Mon,  1 May 2023 17:38:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-64115eef620so30859371b3a.1;
        Mon, 01 May 2023 17:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682987935; x=1685579935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgo80ghMQOp+mjhp2fGDQU7QdU+z5+Mm0uWXto6AZlU=;
        b=IJR3jyqlkwy2IHEDHlIvP74Ui1r26SKHxyUjGDHxFrZ+2JshRElACiOo/JYPBlq6Qp
         F21dqydo152mTAfrhwPNNrCKySPMmEkmICcWezztk/gl4hVdYB8vfbaXtQKJjkYzZKx/
         +ONhv2u776ZfH0IBtRpbl75x1rdeX+C2DcdYWzK95IjakYJHm5Pujpc7NpD9tEMwfYzq
         NCLfmXdixq0KYKmpvTKxfE7rkFegESR0y9vkFGHt2qfzySJHLJnXpRh7MYCUYG3fNuwV
         rEbIZoVONrvMGzDkGVpDY6gI/jvaKaKJteQxUS406dfFroQTqB76n3uGATYaMZ4yERsZ
         GQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682987935; x=1685579935;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgo80ghMQOp+mjhp2fGDQU7QdU+z5+Mm0uWXto6AZlU=;
        b=S1nLHpn2Wg7DUUysz5s3PzCvC3SU8OxCIUJlEcHPf4ZUiQSOLz+DPzQVA1qNKnth9M
         ehSi4Pvg/7jvIoVZAgUwjFr0F6h30xkEA285JtaMkjTyqHwSY9SukHGz9wkXrUzOey70
         7vOteD4kCD30qkhc8NhOTNWI3Q2oGiJJYnUwjEOHNM0wRzwmrAx4dAMsZqriK9BrtkW2
         d9edECaZktnHKdrMoSEAW5pYNzP57UnCUxPzzVakS6XL7GoqEjji4GEZibaTgKGcc6jL
         jvnPrM3Kq42pncKIieAci4GB5a4sEibI/Yyyb3smuqINDhOsY5jmKhov9AZ+WD3Rg4Ko
         Dvog==
X-Gm-Message-State: AC+VfDwENK/dh+AeXszwB3FcXIVke3h/NHymX6cnD0GdVr9F1CRjCT6p
        CRBb+5KPQzuDgThK5GHJtEI=
X-Google-Smtp-Source: ACHHUZ5PqMyht/4L+6ILf5eSVUnk6TN6JX/D2hkH0+Ws98y4ahr+b/jmV38AJ72219PiqsPbAu9Evg==
X-Received: by 2002:a05:6a00:1709:b0:63b:6d4d:4c9 with SMTP id h9-20020a056a00170900b0063b6d4d04c9mr26890898pfc.9.1682987934466;
        Mon, 01 May 2023 17:38:54 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id j12-20020aa78dcc000000b0063a04905379sm1645284pfr.137.2023.05.01.17.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:38:53 -0700 (PDT)
Date:   Mon, 1 May 2023 17:38:50 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Duoming Zhou <duoming@zju.edu.cn>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org
Subject: Re: [PATCH] Input: cyttsp4_core - change del_timer_sync() to
 timer_shutdown_sync()
Message-ID: <ZFBbmml9FjXICHUv@google.com>
References: <20230421082919.8471-1-duoming@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421082919.8471-1-duoming@zju.edu.cn>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 21, 2023 at 04:29:19PM +0800, Duoming Zhou wrote:
> The watchdog_timer can schedule tx_timeout_task and watchdog_work
> can also arm watchdog_timer. The process is shown below:
> 
> ----------- timer schedules work ------------
> cyttsp4_watchdog_timer() //timer handler
>   schedule_work(&cd->watchdog_work)
> 
> ----------- work arms timer ------------
> cyttsp4_watchdog_work() //workqueue callback function
>   cyttsp4_start_wd_timer()
>     mod_timer(&cd->watchdog_timer, ...)
> 
> Although del_timer_sync() and cancel_work_sync() are called in
> cyttsp4_remove(), the timer and workqueue could still be rearmed.
> As a result, the possible use after free bugs could happen. The
> process is shown below:
> 
>   (cleanup routine)           |  (timer and workqueue routine)
> cyttsp4_remove()              | cyttsp4_watchdog_timer() //timer
>   cyttsp4_stop_wd_timer()     |   schedule_work()
>     del_timer_sync()          |
>                               | cyttsp4_watchdog_work() //worker
>                               |   cyttsp4_start_wd_timer()
>                               |     mod_timer()
>     cancel_work_sync()        |
>                               | cyttsp4_watchdog_timer() //timer
>                               |   schedule_work()
>     del_timer_sync()          |
>   kfree(cd) //FREE            |
>                               | cyttsp4_watchdog_work() // reschedule!
>                               |   cd-> //USE
> 
> This patch changes del_timer_sync() to timer_shutdown_sync(),
> which could prevent rearming of the timer from the workqueue.
> 
> Fixes: 17fb1563d69b ("Input: cyttsp4 - add core driver for Cypress TMA4XX touchscreen devices")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>

Applied, thank you.

-- 
Dmitry
