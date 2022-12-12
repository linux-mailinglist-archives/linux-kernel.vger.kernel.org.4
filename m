Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676306497A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 02:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbiLLBPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Dec 2022 20:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiLLBPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Dec 2022 20:15:31 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 963F96573
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 17:15:28 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id p24so10505675plw.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Dec 2022 17:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1Q7NSdDI+cBRdy4U2cxwXIHknLHBniGJjnQ4NlM7GlA=;
        b=De9WLIphv5+3yWxA5tUU1WZgh3st56qrLPCXkw4JhpG+RGUVKdvLDKsAWRw7x3qGXb
         h6xKw7/6YFfa9teZUNgqVZ7uvtBIYd6X+/txleT6RyDSuePCiqDr5PlZ0yWlWCVQZvzB
         itirQSTfw6nMpSLevMu8s98RKR2qYzwUd92xg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Q7NSdDI+cBRdy4U2cxwXIHknLHBniGJjnQ4NlM7GlA=;
        b=icpZIgMUZ5CWeiHzzfbI47auG4YJL0HSSer5HqJPUH9BwGMlSd8T70FY5GWj8tuiE9
         95ODJ1sM4coV0SYzIPj1cTV15cPR6mT7KJu6EsSBvk6WHs1KU0Zx/qJpUVpORRdZSrE3
         qvLO5ZjXz1djuWSBUZku1k3m+AqXTm2acJMKmWxgY6CBUHMP92vFOvvX9UszyDFVuj4u
         s2U8IbKXTScu2iVO1mlzk4vqkCjePfz8aVc6KvIoEvW7BiOYFaqtu6MF2zkY8LR/cuV7
         7POPrrFMnTDT6EYxUKFpRfyyF5njzeeHlgbScs4GoFVIBu+yqfvr3fKBw3ptIcN6sL4V
         RO8A==
X-Gm-Message-State: ANoB5pkOYgy3OxuVtGXA7NfPPIWV+WNRCwvrMODhlYh5r4THPJld21Pg
        K8O5CW3S1/xrsR0oBcRt220CqRDycem2m7Au
X-Google-Smtp-Source: AA0mqf6PdYEmDNqQaaRQp40o28ze+5hq9qWZnsCRqCLB6ZUMLH3jEZASyPCOIICmh3K2JHQdz2em8A==
X-Received: by 2002:a17:903:4094:b0:189:7548:20a7 with SMTP id z20-20020a170903409400b00189754820a7mr12235364plc.56.1670807728100;
        Sun, 11 Dec 2022 17:15:28 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id i133-20020a639d8b000000b004792ff8ab61sm2544334pgd.80.2022.12.11.17.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Dec 2022 17:15:27 -0800 (PST)
Date:   Mon, 12 Dec 2022 10:15:22 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Tomasz Figa <tfiga@chromium.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, Max Staudt <mstaudt@chromium.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v5 1/2] media: uvcvideo: Refactor streamon/streamoff
Message-ID: <Y5aAqoNQeUuwSlQd@google.com>
References: <20220920-resend-powersave-v5-0-692e6df6c1e2@chromium.org>
 <20220920-resend-powersave-v5-1-692e6df6c1e2@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220920-resend-powersave-v5-1-692e6df6c1e2@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/12/06 15:06), Ricardo Ribalda wrote:
> 
> Add a new variable to handle the streaming state and handle the
> streamoff errors, that were not handled before.
> 
> Suggested-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Reviewed-by: Max Staudt <mstaudt@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
