Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F36F7ABF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 03:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjEEBnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 21:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjEEBng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 21:43:36 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B4F93FF
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 18:43:35 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24decf5cc03so906200a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 18:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=SRSJR08bxAHAMdoZW4MZSe7iK6mrvIUWXj+xImkjInDeC+BKT5rulIeJRpprEA2A/P
         2wR4vDTEY/NcegpyBO388QGVn2G8aPEfOqdRijuytR9ctglQYCNn0SxDqGCGopDqqSXo
         hfW1BrVWN7aLwmkQjg9Vv+Tp0SFiGAK5EPSCjILMU2AHJqn8YB3qQm+FD1ZoLeQxImCB
         5V+YFmLL1Zs79Wm3ey664ZAd32AgVN8nXQQnXHNM889C0okh23bmeP5qaqOwv5wr/Vo9
         zDPRyCTYFG0G6WXU5KpHLb3XUMOXw4NjQHDNmXaZB0BALFk/ywV9inewGSuuLCDq2tQH
         erqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683251015; x=1685843015;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7hypnUIygICP+cjWknZimHYa1WmNJLmE2RPntTriZE=;
        b=fKJ0rdO6Az01XYFHraVMOFIhyfU5kxAl9Rs8BJyuf9RI/MJJs1+pSUzoD7OFyYARz5
         L21CzzVtmOgEn7a1cbfM0H1yAvIH3BtsOd8Bvw0GHUXHeH9lDxY/5OPXh2KGPIlAuY4k
         /Ez5dkKkVqSEQxdYOZlLK8WrRf/eOn7gY2ljfjb6oehHNcnQ+i4XD8BuqaZkaS64iAuj
         wiZHj+Fez3FXIpTCFi6vxIomgPUVnXMHr7ijCWVtIZCK1uIHQA8AEvUgm1dhC/LxNUjy
         Yx6GV6DZjrZ/yLWSLU7Fl64UPhOPNT9zCxUnyWBXZh8FB6d4b7RoqeD73NeiVm6xuZvM
         7cZQ==
X-Gm-Message-State: AC+VfDwnyfYj0kgmZgfTtFped+RpAJJbwohTf15Xt+JVhzgv7of7v0d5
        Xg+WJJLWmS9b8nKYh4QJ7Ifa2Z2A0D+LYKtMP2MhpA==
X-Google-Smtp-Source: ACHHUZ4nn6CR7WvpwK2l3gX182OnFajAMv+Tvqu7NWUIZsz4N5QzlPEFmq4YJyzU6CckTRIsxWKcgbDLhrRwAXYlJiI=
X-Received: by 2002:a17:90b:380e:b0:249:748b:a232 with SMTP id
 mq14-20020a17090b380e00b00249748ba232mr3836196pjb.25.1683251014942; Thu, 04
 May 2023 18:43:34 -0700 (PDT)
MIME-Version: 1.0
From:   Jon Pan-Doh <pandoh@google.com>
Date:   Thu, 4 May 2023 18:43:24 -0700
Message-ID: <CAMC_AXUHD=-zRxL-AogoDQTSz31SfmQ7u_eX3J5PVbXy4P86GA@mail.gmail.com>
Subject: Re: [PATCH] iommu/amd: Fix domain flush size when syncing iotlb
To:     Jon Pan-Doh <pandoh@google.com>
Cc:     Sudheer Dantuluri <dantuluris@google.com>,
        Gary Zibrat <gzibrat@google.com>, iommu@lists.linux.dev,
        joro@8bytes.org, linux-kernel@vger.kernel.org, namit@vmware.com,
        robin.murphy@arm.com,
        "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>,
        will@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cc'ing stable@vger.kernel.org per Nadav's suggestion.
