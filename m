Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DC6705423
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 18:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjEPQjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 12:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjEPQjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 12:39:35 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DDD1FD8
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:33 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-50bc040c7b8so21755739a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 09:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684255172; x=1686847172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6o3iO64wtAww0ZhusXTfft+qEjTOhpLN6/IvMCHt+EY=;
        b=jpqbO3ZeIrms/ZDeWT04T9nqYTCAFh9hSUmBKMokjgdH4wPmpt9KcC7xRJh8INyTOJ
         qhN9poKIHpkEkd24IXJO2xdk1MLFyZ/hE9Ks2IsvQvafvWAZFNZgD7EmeidzX03L2ryu
         0U/mxkXf8qNMMZ6Fgx+b/VGqTlDVQdQ1WoKaOUz3EPd9cVhDbLzwG7mSd4OieyDZbfD4
         kX4Mijq/2rdTtR2JX8HSlDp6KJkYnTEKWZoa7fH185h0yLC6Ctyt3Hn/IyOvl98u9yMT
         BEnZaCpjbTk0OoTH19RgQPGMrSZxUOHowYlJtI1V9R+tsWDzpdxflvpf4em+lC633oIx
         yZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684255172; x=1686847172;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6o3iO64wtAww0ZhusXTfft+qEjTOhpLN6/IvMCHt+EY=;
        b=GReZvdtuiABa3ejB/+BuHZKUKkWSxjhVxIjFqPMsWtMrPJ5+jWPiZXGwSrOfWe0jfZ
         I6K6qWi1Hm4hMX9x/jNnQM20I7UvI07f68QGVLRm7pzqyyDCIb+4y1ICeiGtkurAq1sE
         oiM1ucxlcnE2bhkyXaPRWAAAY/vP/uswn6rTPlryWm29rVffYtfiUvupuuZ6gsuhYVqh
         ShW3olr33rqT9Pa4O49uygSbg4GAVxiqVpdWqZhojCFyqHl7SKTJ92x6DVYdVEQ3CQoy
         qC1mzir7aIuA8rZMvhNvH1AyP97ApglMmKBvtk00C/bUppOhmtYeiZPrDKh4/ZycgldU
         ikMw==
X-Gm-Message-State: AC+VfDxwbbcQHoT+20enqzgfJ1FqOrU5T5TvPL3KEMvRvcgo88e201sf
        JG7iIoAeofZEKOlnsxp9pDYnIw==
X-Google-Smtp-Source: ACHHUZ5p4TWaiCYVpEvyKbky7CU1W0H+LzCfOenbVk3tFV9tgqNixy8iQMl9D2uxZxDZBqUGvZXZJg==
X-Received: by 2002:aa7:c60c:0:b0:50b:d755:8acc with SMTP id h12-20020aa7c60c000000b0050bd7558accmr28507283edq.34.1684255172074;
        Tue, 16 May 2023 09:39:32 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:77d1:16a1:abe1:84fc])
        by smtp.gmail.com with ESMTPSA id d4-20020aa7c1c4000000b00504a356b149sm8278191edp.25.2023.05.16.09.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 09:39:31 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Khuong Dinh <khuong@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] arm64: dts: apm: add missing cache properties
Date:   Tue, 16 May 2023 18:39:22 +0200
Message-Id: <168425511041.243008.11215407401273783748.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223139.115044-1-krzysztof.kozlowski@linaro.org>
References: <20230421223139.115044-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 22 Apr 2023 00:31:39 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   apm-mustang.dtb: l2-cache-0: 'cache-level' is a required property
>   apm-mustang.dtb: l2-cache-0: 'cache-unified' is a required property
> 
> 
> [...]

Applied, thanks!

Please let me know if this should go through any other tree.

[1/1] arm64: dts: apm: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/0022cec7edecd5ea6796dfe0d75330c55dd07a67

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
