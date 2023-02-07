Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C470D68D9A3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:48:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjBGNsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:48:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbjBGNs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:48:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A54C3A9E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 05:47:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675777660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=FISClwm9n2lK3nXC1EJXUFPtyGgEYcjLqBDtj/ZfPDxoAT3GJXU4bIqo59efpvohntqtSq
        wt1zmCfFG4hBABcgPqadv97DTpBcq4Bcq/tF2X50u2Z2u9m8ZOjApoWXDtZ1O21HzRBV0j
        Q6NDaeBk2jRkpGBpF5wD4k3YIo7tBAo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-222-VEd_Z1piPHuYosL-4KbFuQ-1; Tue, 07 Feb 2023 08:47:39 -0500
X-MC-Unique: VEd_Z1piPHuYosL-4KbFuQ-1
Received: by mail-qk1-f200.google.com with SMTP id q21-20020a05620a0d9500b0070572ccdbf9so9839413qkl.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 05:47:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA/I3fzzNYZ//8/vwERAn+P62R3VluePPy0fivL+Wr8=;
        b=NaRZc/pmsma9VbTAg/m999yPrFHV+kCN8X4PD5i2odV0owXUY/rcCOqOEXrJCKHLoL
         8SghlITINTqRXrZqiC+mi+Atfgxte0DXmYOVr85+TDpE3/cYhet2ZC7Q06ex/4Y4UpeD
         Q3rP5IAJQlbcrcttIqR6g67AtAfww4etb2lxfeaJij2N5zeBDg40EKZyb5NLkHfAH1V+
         /JebS2zR+79wDB24PT2PnfOp/T27CKqyp6FZz6rhsbI0+LjCBdo76gzPqiILQKac0uFz
         Ll1deOgU/ObtRihMAqj9T1O8AiTK/ZpY/m8eIg/oqbjsVmpYBM8cagPq+XrVBfvc2OKj
         NIiw==
X-Gm-Message-State: AO0yUKVBXXuRB7IAJwPJrTvt58TsisfXxE1hhUgJbfZTrlOsr0U8UJY6
        XYpmk7fDNRRrpCCSwdrsLPkxTks+Y/PUtOTlkdtk17/ryX1kaa1DMFiFHFgEMO4wddRHzC0czdH
        29YcvQSRspBfvV5oY3yuXDXKC
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879064qtx.56.1675777658672;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/ejwgCvHaxLr87VY1OqTrLmCn+q6U4BxbYz736hZ4+blH4zqNep1u4j55SpjNPGPQlVa5mTQ==
X-Received: by 2002:a05:622a:508:b0:3b8:6075:5d16 with SMTP id l8-20020a05622a050800b003b860755d16mr5879035qtx.56.1675777658395;
        Tue, 07 Feb 2023 05:47:38 -0800 (PST)
Received: from fedora (modemcable181.5-202-24.mc.videotron.ca. [24.202.5.181])
        by smtp.gmail.com with ESMTPSA id pe4-20020a05620a850400b0071ada51ab48sm9503353qkn.37.2023.02.07.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 05:47:37 -0800 (PST)
Date:   Tue, 7 Feb 2023 08:47:35 -0500
From:   Adrien Thierry <athierry@redhat.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
Subject: Re: [PATCH v4] cpuidle: psci: Do not suspend topology CPUs on
 PREEMPT_RT
Message-ID: <Y+JWd6NfhH0sAlim@fedora>
References: <20230125113418.455089-1-krzysztof.kozlowski@linaro.org>
 <Y9L5VFPdDnsiCluu@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9L5VFPdDnsiCluu@fedora>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is there still something preventing this patch from being picked up?

Best,

Adrien

