Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155F16FBBAA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 01:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233821AbjEHXz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 19:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjEHXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 19:55:53 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC24A35A8
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 16:55:52 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so4725612a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 16:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590152; x=1686182152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=eDmEQkTIIHMRWU2ntPglrb0g3MKZDF4Lz5fmmHbtX87ohKxjyU6xPw0WkmwtQ5Dmot
         uGL20P5UfpNoi+/vrdkkAczY+r3cNJfPIkEqvbGHQ0HhU1SYD9fJRMPO5DnJa7fGCFxQ
         oPv6i/8RjMJPNQMo1Dm/gF/Q0fwa9VYP2suNlp8qLe0do4nPZpTiBZSd0RsBCF39SeKh
         S0g3hygvbANJn5pD5CVuiu3dl4TTdcV2J93xNyKC0vnWjbFIByCpR7bBr/VRW09a7bDe
         bfoN61mfw84Y3mWoiCCLmAppkvcrEAEVDrJ4OrvIlHxr9G+Gnbq7917NUNBiLpd2meIm
         Lhzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590152; x=1686182152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2YJeCVahMakSFFIeHkE0L5vaAYWzeS9qst+vBo++bi0=;
        b=DXVylHrSBE74dUFMLSNFe07I5nhno0BlGW8OB2FvGHiZ7hGehsP1eRdD+qCen/LJVo
         B5R/hJ3tI72pb1MDxmGjLywssMdZKf4VKdXy90M6AbW4Oj+DTNANo6Ab939ul4j53AtO
         Lu3JalUq/lvbRbo8UzeW4aufMc5d9PjQgsxVBQjis5q7uWZVhH/NIfuGICYl+ZO9ievZ
         iuLpBMvdwJm+EcImiiiO2Z9gk/cg1McaIaRE+KgZ5hyFYb1j1/Ln2i2XS6ahAJhRxxPJ
         f4jh+Td36nbxwGoFnJrMWqp8zmhPLDU8dMx6yJorQk9g/m/aJ71zTjKmVwKRGBFhx2g4
         a9vg==
X-Gm-Message-State: AC+VfDzs/14vcZth5UYO5PKYfHfejOtIjyNudQnmirr7YniEnuXHF3e+
        SPBXUphv0dQI2yelMzLR8P0=
X-Google-Smtp-Source: ACHHUZ7uPD3bqVE30fL2j9i8d5ZClVd6/6A8t67rGZjmf/al2IN17DxPUOk+QF1xgTZAd79abA8e4w==
X-Received: by 2002:a05:6a20:3d20:b0:100:377b:2753 with SMTP id y32-20020a056a203d2000b00100377b2753mr7867297pzi.14.1683590151987;
        Mon, 08 May 2023 16:55:51 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 17-20020aa79251000000b00637b0c719c5sm454513pfp.201.2023.05.08.16.55.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:55:51 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 8 May 2023 13:55:50 -1000
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 02/22] greybus: Use alloc_ordered_workqueue() to create
 ordered workqueues
Message-ID: <ZFmMBq6Gsc-pWrDS@slm.duckdns.org>
References: <20230421025046.4008499-1-tj@kernel.org>
 <20230421025046.4008499-3-tj@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230421025046.4008499-3-tj@kernel.org>
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
