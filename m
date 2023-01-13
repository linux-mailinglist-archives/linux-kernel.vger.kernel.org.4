Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D03C668E3D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 07:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjAMGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 01:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239638AbjAMGsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:48:10 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D143B7A390
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:33:00 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id f8so4358093ilj.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 22:33:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FbcvrpXLiOj2aVPZhpgGMF7fN4pxhgDC+epYNwB8PvM=;
        b=WJS7nPzUoIP8rbTag8GicEfltsmTxWO17BlAWGW0ciuWXa7IfF57AiTEvOoSxjW14F
         Dv1fAdWj11fSddcILv2UUb9JFamNwmbhM8RjPAZI8z+GQ3t+F9BGyT2yMdjxJX97Zaoj
         ayOITR/nx/0apCzJQvedDmzQ0WKwZv4GSdueo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbcvrpXLiOj2aVPZhpgGMF7fN4pxhgDC+epYNwB8PvM=;
        b=6lskGZ473nJBJBrWNLlQf4uaEm8V8jCyXXwbhoDndTZKeIF4lEeF6P1JKjJOiZM3cY
         +8Tdl1pbi+m773O0zGLYvSzBQj9K9Vbn81eQftKWd2PzHmsgyfktvqjQcPKxJyFagO9y
         BC3pmzxVdN1/hCE2vwbw0KlMAQDWE9S7DsCUECW82koAytgsYE/ADHFevKX70ZSszkWa
         eLkU7De2sZxpwgjO29FqSWz0EKKdIpb1OtY6/kWmcfQU/iA+eXbfW4na0o25pv8zqE3F
         D+Illiov+CZrY4FrLTYS54hDOXj6i9ve+m44cntrr9Bw7x/+EG4DPjvTacI+jl8PHunD
         y+yQ==
X-Gm-Message-State: AFqh2ko9Co1t/3rMOvt/p7fSBvadxBQw1u3Jd2ekJGv2pdiZeQlMYb0W
        +h2TsKVKFTvewZrrj4qYBhVsKQ==
X-Google-Smtp-Source: AMrXdXuGaPBMtjduUpnSDSdiMpo7mxlCGHV+p3tlc6mEZ+7wnMH9hCy9Jnt6RWpsBUXuMUPhOhaD1A==
X-Received: by 2002:a92:c04b:0:b0:304:4481:2aad with SMTP id o11-20020a92c04b000000b0030444812aadmr52820937ilf.9.1673591510050;
        Thu, 12 Jan 2023 22:31:50 -0800 (PST)
Received: from chromium.org ([2601:285:8300:c23:d502:b79f:c908:7743])
        by smtp.gmail.com with ESMTPSA id b10-20020a92670a000000b00304ae88ebebsm2435002ilc.88.2023.01.12.22.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 22:31:49 -0800 (PST)
Date:   Thu, 12 Jan 2023 23:31:47 -0700
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] firmware: coreboot: Check size of table entry and
 split memcpy
Message-ID: <Y8D608sr+jhBQCXG@chromium.org>
References: <20230112230312.give.446-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112230312.give.446-kees@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-12 at 15:03 -0800, Kees Cook wrote:
> The memcpy() of the data following a coreboot_table_entry couldn't
> be evaluated by the compiler under CONFIG_FORTIFY_SOURCE. To make it
> easier to reason about, add an explicit flexible array member to struct
> coreboot_device so the entire entry can be copied at once. Additionally,
> validate the sizes before copying. Avoids this run-time false positive
> warning:
> 
>   memcpy: detected field-spanning write (size 168) of single field "&device->entry" at drivers/firmware/google/coreboot_table.c:103 (size 8)
> 
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Link: https://lore.kernel.org/all/03ae2704-8c30-f9f0-215b-7cdf4ad35a9a@molgen.mpg.de/
> Cc: Jack Rosenthal <jrosenth@chromium.org>
> Cc: Guenter Roeck <groeck@chromium.org>
> Cc: Julius Werner <jwerner@chromium.org>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Stephen Boyd <swboyd@chromium.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Julius Werner <jwerner@chromium.org>
> Reviewed-by: Guenter Roeck <groeck@chromium.org>
> Link: https://lore.kernel.org/r/20230107031406.gonna.761-kees@kernel.org
> ---

Reviewed-by: Jack Rosenthal <jrosenth@chromium.org>
