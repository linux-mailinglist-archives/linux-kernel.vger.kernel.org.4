Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3641E645BFC
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 15:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbiLGOFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 09:05:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230106AbiLGOFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 09:05:31 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6BA5FB90
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 06:04:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so14251999ejc.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 06:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yLEQ1iziXxnm8tB1YfDZj59/p6SSPcwuVFJkFGvSq1g=;
        b=dzpKqLY84Dr7Ud955bgc9eOFeA7FKkqyevWEX9bPYQYNfiQPXWBeFs7jmaIfYkncte
         ap72TfM03WBZ22MFWrf9U6C2OFZWIKTZ5Z98jMrmvHyA336Cpu5KyLOs9zu3liPYJAhJ
         +bwye+1znCiXHtxai+tl0/agLChGg3DrkXlTYx+OdiVtz1eI/JUtyQDD9VFYinsEOMR0
         Ch7gGXu/BjX69v9MzRRg7Sv7CtHNWS9Fn/XjGmJfLXZAHO6nSGDjfuyaX5xw0FPb1p7L
         XSS1zUb8Ab/fv6aNXj9nR60g2HjlvzXMvMbmd9+TYqrt+Pk0poQVjYmjnXBUsasAetpO
         ArHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yLEQ1iziXxnm8tB1YfDZj59/p6SSPcwuVFJkFGvSq1g=;
        b=HXuhB6srouWwwAm1wIZnw6xCoPTaDsEIaXk2S/NRZDD/iIauGrmWJQHAz8A6fAzHGY
         UIseGuR9eZqUN/WtkljrWENMKvKGrNVqYMK2FOXRAVNP3m8mBgko/zTzdn9Xng0NBEXi
         uYgJN/UCzjs2/dFSXxwaLXC7EtLrYvjvox7p79AwhbQ29LsqXn0OSF0lLaGX++d7b4BD
         5hI7g3cm+u98R22Fh02HfZ3FXzB503BrGCK4WEeCbwAOKS7l60l2AC6Ygj/Z7IBJImD9
         Yawrb7JqKwujzxRk3E/QMt+VRXZhwl1XxxKUHM+/td3C88yhP3BY20Ew9phVurrPQ1Pm
         3ANg==
X-Gm-Message-State: ANoB5pkWKySGFM7vdcnpXKb9aYnDG47pqYaYAYO28H6jySMS1U5Vkge0
        lay+PHUlmRAt4i7teszfnxZWQw==
X-Google-Smtp-Source: AA0mqf6u3BZDsigCe1eE4YZ5zUn3KvdPVP/j/ewkyVT3pq/rT1ZFfyAPgBDFioYpogO/OwrHjvQROg==
X-Received: by 2002:a17:906:50a:b0:7c0:b995:8f8b with SMTP id j10-20020a170906050a00b007c0b9958f8bmr21986259eja.55.1670421855380;
        Wed, 07 Dec 2022 06:04:15 -0800 (PST)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090609ca00b007ad94422cf6sm8448157eje.198.2022.12.07.06.04.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 06:04:14 -0800 (PST)
Date:   Wed, 7 Dec 2022 15:04:13 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     ehakim@nvidia.com
Cc:     linux-kernel@vger.kernel.org, raeds@nvidia.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, sd@queasysnail.net,
        atenart@kernel.org
Subject: Re: [PATCH net] macsec: add missing attribute validation for offload
Message-ID: <Y5CdXd9KkKDq+uIo@nanopsycho>
References: <20221207101618.989-1-ehakim@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221207101618.989-1-ehakim@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Dec 07, 2022 at 11:16:18AM CET, ehakim@nvidia.com wrote:
>From: Emeel Hakim <ehakim@nvidia.com>
>
>Add missing attribute validation for IFLA_MACSEC_OFFLOAD
>to the netlink policy.
>
>Fixes: 791bb3fcafce ("net: macsec: add support for specifying offload upon link creation")
>Signed-off-by: Emeel Hakim <ehakim@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
