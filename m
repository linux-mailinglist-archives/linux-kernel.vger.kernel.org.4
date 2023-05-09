Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F0A6FCA5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 17:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbjEIPiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 11:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjEIPiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 11:38:01 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272B646B2
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 08:37:59 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aad5245571so41549125ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 08:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683646678; x=1686238678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=znDwmoweGIbazinqZk+RMiWAEky714GctekUC5TPRSI=;
        b=KKOZZnf9GqB+bW2sq2bGj2OI4Eksv6MexBLK85NQVZrQbRXviqwAWY5u3yzTIeTtW6
         YtVYXZiCtfv1Ymn8pVeuL9rZZYJFYH8ay+4vC1dPp7IJNo5eWO31dxpkxT62JzvWBgMh
         I/T+6AmVV4FoUE04NVug7mYJmZb0vUH6TciApC35IgdiGsCSqrRkYP1PnQTutASx/0NG
         lsOq3BnDP6SBV4BZ19RYWCVYPNaCAW6+PtB7nTeU6nCcfx7rCmbomBZkuhhLLBkpSmP3
         uTBJufpBY0KQijq+q5j3XyfvziuhLI2WRViYJwl0lP1FecYYL3b8Hw7PkofkfkjYcpZf
         JDqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683646678; x=1686238678;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=znDwmoweGIbazinqZk+RMiWAEky714GctekUC5TPRSI=;
        b=aqLvEVN5Qlbma03dJ1qx+kmHDzK6EXC8bJjEjDXCZhQI+MOh/ILTpegFgxdoHm8mHs
         FnxZ5LEPBce2NxZeo6mifmgX2xESmY+pPVGWm7o/XBnSYEcWc8/S6WoxFU/XhYB4tbu4
         OLqn2a671INAgtpFqULkQVahKLju3heXtbH/cNO6p2Hn5ywGwbbnW20ACEte6CsSFey9
         egiPeSwFaVt1QBo2sVCq/0T7Op8EHIZncQglOZmalcMxqRE1F2J3paKQIkf0n2sert+9
         3Mc05GRUKQAZSnAkKrFa6OQXCse4sjbDP+p5VjNbAhGaCHIea/gZEsTlIOEBklAqBUjf
         ShHg==
X-Gm-Message-State: AC+VfDzKsv3JxO0K2xkxTBALq6ymLQQO8aikIdfg39Rk39ldZye0rnKi
        wWhGs66Vc5P5PgZQvle8jH8exskN8NM=
X-Google-Smtp-Source: ACHHUZ5V3bE4bDm1bOJVAoybprrK78mLfVXMFJins9Cj4n2R6LdEU6vQr+B5gQDJsvJaxb54BBdLOQ==
X-Received: by 2002:a17:902:d2cb:b0:1ac:7ea7:6ccd with SMTP id n11-20020a170902d2cb00b001ac7ea76ccdmr8190149plc.34.1683646678123;
        Tue, 09 May 2023 08:37:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id i1-20020a1709026ac100b001a64011899asm1753977plt.25.2023.05.09.08.37.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 08:37:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 9 May 2023 05:37:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH workqueues] Further upgrade queue_work_on() comment
Message-ID: <ZFpo1OA7hnRaVrgx@slm.duckdns.org>
References: <ae548f82-fd4e-490e-889a-3307b9a2c531@paulmck-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae548f82-fd4e-490e-889a-3307b9a2c531@paulmck-laptop>
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

On Fri, Apr 28, 2023 at 04:47:07PM -0700, Paul E. McKenney wrote:
> The current queue_work_on() docbook comment says that the caller must
> ensure that the specified CPU can't go away, and further says that the
> penalty for failing to nail down the specified CPU is that the workqueue
> handler might find itself executing on some other CPU.  This is true
> as far as it goes, but fails to note what happens if the specified CPU
> never was online.  Therefore, further expand this comment to say that
> specifying a CPU that was never online will result in a splat.
> 
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Lai Jiangshan <jiangshanlai@gmail.com>
> Cc: Tejun Heo <tj@kernel.org>

Applied to wq/for-6.5.

Thanks.

-- 
tejun
