Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD54729847
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 13:38:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbjFILi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 07:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFILi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 07:38:27 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146F530E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Jun 2023 04:38:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f735bfcbbbso11961475e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Jun 2023 04:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686310703; x=1688902703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6e5QbRUnU+agFZANreqZIgq4SD5UQhoPe6DRJUY6y9k=;
        b=YMwWwqAnsDoN4SkvomdU10HDl54IFKKlrEjetiCPwmKf2brL04M3tC2/hSLmW31nPB
         HE4IJnCcnnApNMje3Akdyb7kZAMQRFTao7i/N2oXp+vhpJBz4AlksxYQVeEgWDs5pVFk
         WhlQrAjm3HGufIfHlnIfnhJhhvW24ZH9sUFq3EftfbMwaSHkMFzMKpOE/sr2UTyfuhGs
         yHyL0RlZpXRy8G6jSsWOv7yq/rxTTd2tLMYpcIWVtvuPmw0zj8yceWAV5mcPYozfl1W3
         tZ5YKbtv8WmiSkdwqDEPla45xeAmRU4oIu8eUGvwFnbHTzAG8a4BqC1FPhP3cxaIS/A/
         lKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686310703; x=1688902703;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6e5QbRUnU+agFZANreqZIgq4SD5UQhoPe6DRJUY6y9k=;
        b=FFOWDkKIVzrm7Z+d/H5t0lb4fujWjYu4ID22ZZWXKAzrmc5SO9L2QHinGqE0OUHhGD
         FA9gvrYcKK9jAWk4zQPGYNDKuIQXW1CnKTc5cJLkUuvgK2gxSfSsM4LvyP9o4f+GBSOO
         MBC1A0TXCxVi1eKhKcABNikdBV4p0l/IAzHpYAUaGsNtCk3i1dhxnSg2XW9JP6kFIUb2
         tmrO0HgPwYRvAEY58kYGzMioufsgNkrb3hWWekfcDpnqhtXKc/52jaePngPz3mmx+zVJ
         KHRHmz1uukhHxK6qM2hEGw+2B5daNjOiSh9XhGVsucDQES8rb78s31JBZZPWryPu4aFP
         2AiQ==
X-Gm-Message-State: AC+VfDy7MhUrw4tRZY2z6D3Fx7QeHVH03xOfBr1U6be7kzYqjJGNr6q/
        aDwTsk3y+F80OpweH6wsG1Omuoy+qcIHFIZF2AcDew==
X-Google-Smtp-Source: ACHHUZ5tXNBQnN0YokqinPTWBRgL5yCO5urh+1uT1H6tsM9CPm+SC1MbYVNW80JpCuQ2kovJMT8d2g==
X-Received: by 2002:a05:600c:cd:b0:3f7:e7a0:967c with SMTP id u13-20020a05600c00cd00b003f7e7a0967cmr748405wmm.19.1686310703366;
        Fri, 09 Jun 2023 04:38:23 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id n6-20020a7bcbc6000000b003f6f6a6e769sm2422024wmi.17.2023.06.09.04.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jun 2023 04:38:22 -0700 (PDT)
Date:   Fri, 9 Jun 2023 13:38:21 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     simon.horman@corigine.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH net-next 3/3] tools: ynl: Remove duplicated include in
 devlink-user.c
Message-ID: <ZIMPLYi/xRih+DlC@nanopsycho>
References: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609085249.131071-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 09, 2023 at 10:52:47AM CEST, yang.lee@linux.alibaba.com wrote:
>./tools/net/ynl/generated/devlink-user.c: stdlib.h is included more than once.
>
>Reported-by: Abaci Robot <abaci@linux.alibaba.com>
>Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5464
>Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
>---
> tools/net/ynl/generated/devlink-user.c | 1 -
> 1 file changed, 1 deletion(-)
>
>diff --git a/tools/net/ynl/generated/devlink-user.c b/tools/net/ynl/generated/devlink-user.c
>index c3204e20b971..18157afd7c73 100644
>--- a/tools/net/ynl/generated/devlink-user.c
>+++ b/tools/net/ynl/generated/devlink-user.c

You are patching generated file, as the path suggests.
See what the file header says:
/* Do not edit directly, auto-generated from: */
/*      Documentation/netlink/specs/devlink.yaml */


>@@ -8,7 +8,6 @@
> #include "ynl.h"
> #include <linux/devlink.h>
> 
>-#include <stdlib.h>
> #include <stdio.h>
> #include <string.h>
> #include <libmnl/libmnl.h>
>-- 
>2.20.1.7.g153144c
>
>
