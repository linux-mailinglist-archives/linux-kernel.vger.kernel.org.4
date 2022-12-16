Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D97564EA2C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbiLPLVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiLPLUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:20:54 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28446399
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:20:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id h7so2163474wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 03:20:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c8zJd904+IXjpPodDBXcpzzovSChRn9dgEg89jVdTTc=;
        b=rwC753FZsDUgTG4iIcy926S69sXY8sUHPwYod7qj6vcU/Aab3GdkOxs2e0mkNILo40
         EuzGZWQSs+t9TFGViBP0HMSn2f5NA0pEON7drTGWJabe53fS/hClSpNaQd2IHD68Ljri
         XQ/yG4C+pacM8BubKRno+Iln+lJnd55/H7dKp2pflYml8XZ6pfUDA3JQyAy6+Pml3p/7
         uEfIi7EiShHzKM5HwFWYeDR7ipOt1A3fcUuDkVoUp6vj6GKvo3I+3nNSrapQ++X7Sj4l
         A750lg4s57z9KiCUEsre4OyU1xmWg45pt/SAMR5e2IEFGSrA6pE2EsZrcueaM+CZeXSP
         7Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c8zJd904+IXjpPodDBXcpzzovSChRn9dgEg89jVdTTc=;
        b=Bv6AU9ciMgHibqTlY5FZnry9IAyrquSYfJ8NOWbd0r+A4YWV0HNQPp/UHly97ILQ6s
         iv8DZA1CSffYN0T+kwMSXY/+H75q8L81PadCJaVzY+xy6I8W99aubqcBC20FfKhZPFIQ
         5CDhbFdxD66z9m6hyZj6ZEOLbPAjEs0gqsIKOSzytGTJW4PE3UoZhUzZRgoOGNdnEYPp
         K6HJIufyuCPBhHKHPhOmoqf0zNMbxEhA0zhh+E1iD+0Q333C7yC3i9WjbUUSkg81AB7s
         Zbu/GurFx1Q2xYmp5+gcx++yTSd2BnwiEm+6PE1bZaaKzuu8iuhs9dVLZlLdHnwEADzH
         OSfA==
X-Gm-Message-State: ANoB5plAYM3zj+FfgvsInfaeB7E9locTrNvIrwxrk4EPWHEIIHi+akoO
        UYR3FBWswRfNZf/cjqHXkjoNBw==
X-Google-Smtp-Source: AA0mqf5FTRHlnyovbIiVic0ZLreeNyr+YqX6ewUwMmrnndfqEH8iic7W9jiQeCVaZIQ65MZg/fR77Q==
X-Received: by 2002:a05:6000:1d9c:b0:242:7eb8:37bf with SMTP id bk28-20020a0560001d9c00b002427eb837bfmr21996245wrb.32.1671189649772;
        Fri, 16 Dec 2022 03:20:49 -0800 (PST)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c228100b003d23928b654sm9042343wmf.11.2022.12.16.03.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 03:20:48 -0800 (PST)
Date:   Fri, 16 Dec 2022 12:20:48 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] iavfs/iavf_main: actually log ->src mask when talking
 about it
Message-ID: <Y5xUkA1WlFX4UhzR@nanopsycho>
References: <20221216091326.1457454-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221216091326.1457454-1-d-tatianin@yandex-team.ru>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Dec 16, 2022 at 10:13:26AM CET, d-tatianin@yandex-team.ru wrote:
>This fixes a copy-paste issue where dev_err would log the dst mask even
>though it is clearly talking about src.
>
>Found by Linux Verification Center (linuxtesting.org) with the SVACE
>static analysis tool.
>
>Fixes: 0075fa0fadd0a ("i40evf: Add support to apply cloud filters")
>Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
