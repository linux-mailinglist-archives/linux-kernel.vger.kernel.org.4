Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282AD624D65
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 23:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiKJWCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 17:02:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiKJWCT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 17:02:19 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7805450B2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:02:18 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id 4so2734989pli.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 14:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pWnWQpgCfyLL75UcCxaWOvo2eGDLJFTWzPdbidxkk6s=;
        b=Ltn4DQYpxD8XRKnD+VE6SLO/x9sbFrvqKDGRNohcbAqRd3n+H06MRZOjVftUKeR/Th
         YERJkafcKVparUQev2meHFZEw2s+2eS2yZshuVO4r1WBXX4GVE1ykgmueOlBZVWuX6OF
         7QIYmCJMDoVsJTSph19rT+K2RP1uTIKG/TGwQFIuMAbN66yCEgNrwawbsCBn6JI3uRRn
         3SJI9EqjqG/5XjL/o6BYZUjvOEi5YJH9IGP0ZC7SfuO1alCvDaoIVHl0tQv8NgA+8X7W
         03xkVR4yZ8fWj68bun6lqkiq9D7DEqclcYK6WKXQIJCUW+e1S9ihr1Zx1Wl1S6Rwx7lF
         TxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pWnWQpgCfyLL75UcCxaWOvo2eGDLJFTWzPdbidxkk6s=;
        b=4jexPlXgPIpq6fdkAUkP7znKACx/phtt9iRfl0uwpmLQm5dL4AKKg+ZFXstwQlOOvy
         Za/7qn9QhFrY5OmGiubF3k8uEUCseJkjJafFoYjB40pbrVchZgYP7yZkk62K8uB1ATiY
         76CKp6V+BVvZ9zBCkxyl29MqAqQPEbkdzlSUZjeh3qk9n5gytyXbVsVIl3UoF61I2Z27
         UcBZQNnYfd5rnncDElnC6ujXcLuxeD6IAOjgpqVPs15D1fNcAcyC1XkNIVSPMOapRqnM
         1OGVbmljLrrYk35gT1pHcWP7y2gZ03EbTR2VzotxIf96t6e4Fww/8NdMz7mcsVxAYZGH
         cDcA==
X-Gm-Message-State: ACrzQf3PePtKC9/2GUWCFaQf8XWLtGpsIkmkrVIIcPrbinnOYN/6tgCe
        5SqKnntfSBh+EYkg27O5S/M=
X-Google-Smtp-Source: AMsMyM4LP44QyfsfYLQTEa/p9FC0OdTz8BrdTjRdknNjVMw/wnsHrOTXeYTzyzWd4hj3xUCWW3z01g==
X-Received: by 2002:a17:90a:de0f:b0:216:92a9:fca4 with SMTP id m15-20020a17090ade0f00b0021692a9fca4mr1983176pjv.245.1668117738387;
        Thu, 10 Nov 2022 14:02:18 -0800 (PST)
Received: from google.com ([2620:15c:211:201:8c0b:3260:c81c:119d])
        by smtp.gmail.com with ESMTPSA id i188-20020a6254c5000000b0056e0ff577edsm143183pfb.43.2022.11.10.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 14:02:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 10 Nov 2022 14:02:16 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 3/9] zsmalloc: move away from page order defines
Message-ID: <Y2106OzBXOtAzQ3c@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-4-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221031054108.541190-4-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 02:41:02PM +0900, Sergey Senozhatsky wrote:
> There is no reason for us to require pages per-zspage to be a
> power of two. Rename macros and use plain limit numbers there
> instead of 2 ^ N values. This will let us to have more tunable
> limits.
> 
> Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Looks good to me.
