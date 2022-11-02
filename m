Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10A6164A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbiKBOMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 10:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiKBOMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 10:12:12 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB46627FD1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 07:11:55 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id u7so12481756qvn.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Km8d07l+If3latZbcnno8TWKH4LLZv0VkyhOoXFA9PI=;
        b=3K17y2wDCpq6CGFi/JqscdFCZwJGvNNaM/UrrmYofJw1wR3fGyOhi0rlaMmUvngM6N
         1krgS08m59z2fr/guD+Fxxlexzk1wWL4DDBfFKhfYnmJzVrUGe1X4SPy/ewT8BQC0GfG
         cyN/fTXQ6bcPNPSW3tnZyUIjkUqa1IflSfWNU57n1QgVF2Pfb/1krse6RRVC5tWKohru
         eaMOhLitbn3Pvl2VfFWMFZMYpBalV/17Mrynnzxe6BuDm4NHgpy96rb9Ta41d8fsSuYQ
         4HSWJFbdNieK8n5myVnk2FIvFji3UCt22731b4pIAwKKstvvQJ57GK52yWp62ipKzz8Y
         WCxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Km8d07l+If3latZbcnno8TWKH4LLZv0VkyhOoXFA9PI=;
        b=0WDaHQfRLervyD5w9/u5keT42KydqbRrWqhW33qMBqxVKFXNQO7eqnYWIJDL3K7goO
         7cZyF2271QGXe8kuvX2UrS3iVxbZhQbUJf5R1yGjkDrhh5hHhXXevmU63wQUDM3BkNAx
         b0UhGAKxi0KNkmK86U/5Eq1gnwTEc+5JbG3SxKPsJaBIHstJ1S2eVXDRJWndBaGFaYpa
         uPFVGeelE0Cfmnbomq8P4b6XURGIYHyabYsh/AhB9OVqmts3lcMRlEJkbQiVqxmYXfqt
         3v2jHwGo9GLULQuYCPNxHwyTDT6vf5rkjojoTz8rrSXB2QY6fyLR+7XmF7IEV3DDhU4Z
         6qnQ==
X-Gm-Message-State: ACrzQf0dRFbjcpvBTd9eJqBk9oghaMGW+s6wAjoUMWnnH+eKc6GLFLlf
        vXANyusODz3+DffYrPzaZErYDmqrU/pLMg==
X-Google-Smtp-Source: AMsMyM4K1A4U/HfQlteUYmVSAP0jWa6eNflO23gy6GLcso3nCMkqhvxGSpQm+BcuP6EyzmHHwmrnYA==
X-Received: by 2002:ad4:5c47:0:b0:4bc:f84:da8f with SMTP id a7-20020ad45c47000000b004bc0f84da8fmr8748534qva.73.1667398314614;
        Wed, 02 Nov 2022 07:11:54 -0700 (PDT)
Received: from localhost (cpe-174-109-170-245.nc.res.rr.com. [174.109.170.245])
        by smtp.gmail.com with ESMTPSA id v26-20020ac8729a000000b00359961365f1sm6524563qto.68.2022.11.02.07.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 07:11:54 -0700 (PDT)
Date:   Wed, 2 Nov 2022 10:11:48 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Kemeng Shi <shikemeng@huawei.com>
Cc:     tj@kernel.org, axboe@kernel.dk, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] block: Correct comment for scale_cookie_change
Message-ID: <Y2J6pPj4/aVdoGPp@localhost.localdomain>
References: <20221018111240.22612-1-shikemeng@huawei.com>
 <20221018111240.22612-3-shikemeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018111240.22612-3-shikemeng@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 07:12:39PM +0800, Kemeng Shi wrote:
> Default queue depth of iolatency_grp is unlimited, so we scale down
> quickly(once by half) in scale_cookie_change. Remove the "subtract
> 1/16th" part which is not the truth and add the actual way we
> scale down.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huawei.com>

This is perfect, thanks Kemeng

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
