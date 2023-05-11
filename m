Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6F86FF683
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 17:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbjEKPzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 11:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238125AbjEKPy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 11:54:57 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C966E86
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:54:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-24df161f84bso6185915a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 08:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1683820496; x=1686412496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OMLaXG3kn9J1t0D8UdL377w+Iu6C1rddJ1+6LY7WuQ=;
        b=o2j86sMAjKRwrNcSOUc1D2lNvbnwpfLDIMXnDPW/JL+p7m3o1BMVPk5w0mFww7/Qnp
         t0j1eCrx3jC6C/HsBWL3WTyYP9h6ZyHiIWMCG+CwGxIk6DeppKW+MYoxXAvWvNAIP9/u
         KUBGEoxs+faJMKgi80frPDFLTQO69XZ/S5I1idVq++dOEMYTSZDFA2VUtPszNFbDFI4/
         KcDnnTj3poNx5SdD4tH4thehMfq+60G6CxqQoKT2Ci7YnE5sVfYUcRyWuEDXFjI1WGgT
         uc+aHnQyxfK7lAZ6IcTAuMD8665b5lx1CbpZRD2z/IEqDjdnvz4JHzucWgZMLPXGH+0c
         gv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683820496; x=1686412496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OMLaXG3kn9J1t0D8UdL377w+Iu6C1rddJ1+6LY7WuQ=;
        b=M5ar2puXr7OIYyuE/QHnwg/q3XG5YXWlRyTjukVZB0UcYv8pq/pClmN8cg+2cqMg6N
         VaL4dscyENzLn8JycCfGhZwOIz/RolcVIuS74k+KflgY6G43I4WI5G3/+5Kba8SQJowW
         ck7PoJBmDFZnkkbJnPUopmM1wTjFvsj7ykJzMEErcZx5+dwD7aMTC/X/o5mkCWN/r9IN
         kU1CAyHHSKNJfnEFe1MwuPxN1JJHO+E7fRLyLMX5e1VHxWjMibzow0I8oUBoZMZ0w+M9
         d6k5lcPLai9wX03ZsocI5UjknCFYWAWvQHw5Dqb1X9Sm8OjJmK9ENuBCyizMR2M54ERO
         BKgA==
X-Gm-Message-State: AC+VfDw2Rvlbw7n0ABNIEIQ6zO/QjCGKaObizOBKBCWij3GBRRogjjsW
        nE911OTPHL34/kv3dHoj+58Ssg==
X-Google-Smtp-Source: ACHHUZ5+A5WzzInU+dmYhGcas2Vq9d1UU5sle82Hegffgt41Kmc5mwhNEST0CGFCNe1n3HBQEl8M7A==
X-Received: by 2002:a17:90b:85:b0:24e:4350:cb50 with SMTP id bb5-20020a17090b008500b0024e4350cb50mr21416343pjb.29.1683820495804;
        Thu, 11 May 2023 08:54:55 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id m21-20020a17090a859500b0024e33c69ee5sm16810157pjn.5.2023.05.11.08.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 08:54:55 -0700 (PDT)
Date:   Thu, 11 May 2023 08:54:53 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] ipvlan: Remove NULL check before dev_{put, hold}
Message-ID: <20230511085453.25ef33fc@hermes.local>
In-Reply-To: <20230511072119.72536-1-yang.lee@linux.alibaba.com>
References: <20230511072119.72536-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 May 2023 15:21:19 +0800
Yang Li <yang.lee@linux.alibaba.com> wrote:

> The call netdev_{put, hold} of dev_{put, hold} will check NULL,
> so there is no need to check before using dev_{put, hold},
> remove it to silence the warning:
> 
> ./drivers/net/ipvlan/ipvlan_core.c:559:3-11: WARNING: NULL check before dev_{put, hold} functions is not needed.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Link: https://bugzilla.openanolis.cn/show_bug.cgi?id=4930
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Maybe add new coccinelle script for this? scripts/free/dev_hold.cocci?
