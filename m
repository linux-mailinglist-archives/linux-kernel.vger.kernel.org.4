Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB936D6D7C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 21:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236275AbjDDTxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 15:53:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236245AbjDDTx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:53:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7775B421A;
        Tue,  4 Apr 2023 12:53:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so135435753eda.0;
        Tue, 04 Apr 2023 12:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680638006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCyr7MBPtK/Bu7eE4+1NwdPPqfOycNURZYPDWp9fUT4=;
        b=Op3jIBgiM7MQM4kKugT8I7cpcDJMTTQ0tmflfhFFUnVdq1SucA13bVRXmiglor5/GA
         AaBezNFYXn/VsdCHkT68xOFifTGnIJFHkyvtsx+tXGcG1AxyxJX8O8FyvwQzqhIkSnUb
         kaMNRc36cqZ303F433YY19tU+4V+JCINhCRhFWf7qnylFQvMpYI6Hs+leozvFykGfEKb
         lBKNI00dPj5Vz89JysxhR/ujA+2nzsi1vZVeG+fSBqptLKVELAC/yWCICwaTIFxxHaDW
         7uk3kCtRSl6V2Xqs3ZGm0BCH7jnqvtIJYf61gsq06yBKGrBLHyvqIS0yUdxKiE372dB0
         DoEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680638006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RCyr7MBPtK/Bu7eE4+1NwdPPqfOycNURZYPDWp9fUT4=;
        b=NVLDUVhHgFZ2ClkTIq6y+cuvVF2Z2T4zZ1ij0f/ejuqYaBMzXsGN8+URFqRATsM+Q/
         BqcG26diSLR+Dp0+YvEPp6KsRdQ9WtdUASlZwEPsa2GSFGK3jDPgR9EWI424+VySowdl
         pK+NDJlHGVtRvoH5QtilubkW1hfXUdisGrWyaxBvzNMEeAMgLInOU3KHrKUI06HjZ25r
         breCFDqcDTLiOasM1y+qCs8YDSs8N6ee/qfwUQOlUZ5pkndN/QVpf3o1F1b5GQ43JeKD
         /OxVDMYeI5uqVG+wJr9kgeLYR1TTN7qpt+PIiaViQ7r3V4kyV1p7FGwngYCPjFMtp4Gx
         LK9g==
X-Gm-Message-State: AAQBX9dZ67uY2aBAFYJPj+atN2E1v8YsAROaVrztNennRCgjDefHdgtG
        q2pzUnoza8L7TlQ3fA0Qoxc=
X-Google-Smtp-Source: AKy350YsvnE8U3Qhq6zoeIUKLpfciqe8Km8qBE1voq/ELBxpy1Vh9nMHdKRQ8mm2I+TR+hTTzZH4nw==
X-Received: by 2002:aa7:ccc9:0:b0:4fb:9372:f837 with SMTP id y9-20020aa7ccc9000000b004fb9372f837mr253558edt.4.1680638005803;
        Tue, 04 Apr 2023 12:53:25 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f24-20020a50a6d8000000b004acbda55f6bsm6346090edc.27.2023.04.04.12.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 12:53:25 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: Use of_property_present() for testing DT property presence
Date:   Tue,  4 Apr 2023 21:53:25 +0200
Message-Id: <168063798453.4019835.233964862275533619.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230310144704.1542045-1-robh@kernel.org>
References: <20230310144704.1542045-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Fri, 10 Mar 2023 08:47:04 -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> [...]

Applied, thanks!

[1/1] firmware: Use of_property_present() for testing DT property presence
      commit: 8c47b8253f4cfd8b4dbda8c9adc1d0b1d7f3009d

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
