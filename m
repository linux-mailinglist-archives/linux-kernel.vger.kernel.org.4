Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D236FBBB3
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjEHX5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjEHX5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:57:39 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793B183F3;
        Mon,  8 May 2023 16:57:33 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5144a9c11c7so4862177a12.2;
        Mon, 08 May 2023 16:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590253; x=1686182253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=MJyMoA+DGCV9gjU/7Lz+GCw9zjHFPUFEECOilNzBsYlKHMMldLvhOzSfMZHf0xKYQL
         a9sN0Yu3k8J9X1LpWEw851NpPv4ya9z7KqHOCuRGfwjyBV8gieS0X5X1fUrrb6ZtTwiB
         58bzkhkgBQDfrBsLFr/Gvw5UatuApiD8GE5OFQBClSbAdmR2tOOkVyWQYHVmffrVoKC2
         bJbgNSXu33UbAuXC0GB5bmjqC/Zuo0ngTLIocOCVkiRXG4F+meqJtFls3Yz8EP94ecNB
         xsVYS9CF+xVgyAiYdNBK8Sv/9pLTKYMqXZ5qbCMXl86tH9HtOiHQudvjWSyQsgwNe3B6
         eO+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590253; x=1686182253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=QyfJRMe/QDQuEfF/6YTZwf3IUKJ/Mk4E3296/6q6CgYvsC79gA8CXEAjKkrQE18GAL
         fGxJ1fLyPda1Ole2KpOyDFAi/aGIsmEKUxJ+YXNJS+QgBDuP/7KI7APjZMGV6A5oh4Hv
         /GDGTuWA6NeCztf2pTUsUr0CmExXCLiZz3aef+KBKjpiCUp5gR0Yo852qcZkAK3OhKSD
         sTajKLBsvwMFnQ/nYwroOIG1sFqBGjFxB9UG6W9/Jzscff5O7jNeYsSWuz35NKtiBvvz
         EOvIZXOfwEVcpEXNVO457OQlLj0NMora6rq857tUmQOguCKoCuTGqGh97tiQr24+6Z4n
         TCkg==
X-Gm-Message-State: AC+VfDxI0812KPp8piiPedjTahobjtXXqq3DbDHOlChO/8eLZtoO9Ik3
        RWvPar2FWczn/3Jhr3ee66c=
X-Google-Smtp-Source: ACHHUZ63tGldDsJwLr9gP3VsyVE0cl5sz1IS+uyUFXYiraLlx0leK89+0WBf1E38ocQEKIweSwQ33w==
X-Received: by 2002:a05:6a20:440c:b0:ff:7ebe:279a with SMTP id ce12-20020a056a20440c00b000ff7ebe279amr12177959pzb.41.1683590252601;
        Mon, 08 May 2023 16:57:32 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id y16-20020aa78550000000b0063b898b3502sm480844pfn.153.2023.05.08.16.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:57:32 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:57:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 12/22] scsi: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmMaraKKz8D_YGY@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-13-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-13-tj@kernel.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to wq/for-6.5-cleanup-ordered.

Thanks.

-- 
tejun
