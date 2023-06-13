Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6301572E7CA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbjFMQDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242848AbjFMQC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:02:58 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8981732
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:02:54 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-3f7378a75c0so44023945e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:02:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686672173; x=1689264173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/K400k1Km4EVKPC+GNQfbMfgmY0e33d2pHpxznXgZDE=;
        b=UuTSQ6rK5YSqjULOpI5EL/HfP/NfOPLsAYOGjHpzDmoQHyUcXa5jM0f2tkAb4Y3fTJ
         qt2oks0+qf31V6cljw/1ycUz5V1b0yFkQqwnZ6c4DF8jAFiB9cpjhFXZacgur6PYA2RO
         ACQLUUemRLOaTqgEtN2gYTh+fs6ciP75MsETN0I696z9/Uf4B+a9oIi2MC6EFNgYOPbB
         7qAKS/mzC6RrYsRj5VZ7SG+vbIf+/i6u1mVcKnsMZptnRjqYxiVPue5vqGtJDhIPUeQE
         06UFHs+h/uvw3jkx9R/Tbx9FW7yP4aQ7eZ4+MCWs2EgF4v9udLZmpcdUvTdTqHFadMNr
         0JAg==
X-Gm-Message-State: AC+VfDxjbQez2iUf9tFB9cr3i1fMmXzEYJgCV0IF1h0GtU9KMc3iUVWk
        DHBWqGRpO2+NARXUVA2kFaw=
X-Google-Smtp-Source: ACHHUZ5EPHRFNEdwIthmIRBmik9rcoc3GiIaqvIdOdDDleYsuSDlpInsHS6HdZF8UeECuKx/YH/R/Q==
X-Received: by 2002:a05:600c:2110:b0:3f4:2c21:b52c with SMTP id u16-20020a05600c211000b003f42c21b52cmr7995309wml.39.1686672172788;
        Tue, 13 Jun 2023 09:02:52 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id o17-20020adfe811000000b0030fafcbbd33sm10106737wrm.50.2023.06.13.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 09:02:52 -0700 (PDT)
Date:   Tue, 13 Jun 2023 09:02:50 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     pawan.kumar.gupta@linux.intel.com,
        Thomas Gleixner <tglx@linutronix.de>, paul@paul-moore.com,
        leit@meta.com, x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpu/bugs: Disable CPU mitigations at compilation time
Message-ID: <ZIiTKttkucqiE8wJ@gmail.com>
References: <20230203120615.1121272-1-leitao@debian.org>
 <87352z7xld.ffs@tglx>
 <ZIcVoIAQbRl1GTo5@gmail.com>
 <20230612133230.GJZIcebkHxd8QJs0Dv@fat_crate.local>
 <ZIchqLWousxkCqyB@gmail.com>
 <20230612135301.GKZIcjPY0xvbNsiVNd@fat_crate.local>
 <ZIcoss0r/898/CpH@gmail.com>
 <20230612160807.GNZIdC58KQ8IibZjrt@fat_crate.local>
 <ZIdJs0F8Ow4sV27r@gmail.com>
 <20230612170532.GOZIdQXLYZCGKZQFXv@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612170532.GOZIdQXLYZCGKZQFXv@fat_crate.local>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 07:05:32PM +0200, Borislav Petkov wrote:
> On Mon, Jun 12, 2023 at 09:37:07AM -0700, Breno Leitao wrote:
> > I am not sure if these bugs (MDS, TAA) are speculations related. Pawan
> > could help us here.
> 
> "Microarchitectural Data Sampling is a hardware vulnerability which allows
> unprivileged speculative access..."
> 
> "TAA is a hardware vulnerability that allows unprivileged speculative
> access to data which is available in various CPU..."

 Is it OK if I send a patch that would disable these mitigations if
CONFIG_SPECULATION_MITIGATIONS is set to "no"?

Thank you!
