Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4709701893
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 19:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjEMRmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 13:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjEMRmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 13:42:14 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C09D26AE
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:42:13 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-96aadfb19d7so343931066b.2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 10:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683999731; x=1686591731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EPLQBB2GBeM0JhJNupUXh7QXE7qM2moBT4BpqtzLKg=;
        b=oODy6h5jG9SUBf+aIIvWE97lvjJakoMZ+QZqPXqefm5+lvTscoIdfzXZW+IWkJ0ek/
         /l/bRdbtu/PN5lDTB6VZaHZdry0DM6vdmagDg0hSk3Kilcxg8m2HxIdo5vjNYlYOdKkY
         j6LMeS1t6+vlUyJYkxiDaiq9ZqtHYP8MscQWXhMWyC5zN8+L1rhZaxxSufvyM8kT+pZu
         f+m3Kdqd3RK06IBI1mo529GxyBhcrWPmX9eqrXMK60tkOrJMb8YwjlFhCFrhyBmX/fZk
         Gw6ykEa4bXdpmtvAtpvHNh+zwJ10DnKN0QVnGgjKU/IIOkZ6VmICvufj9scuBcP5vO1w
         ox4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683999731; x=1686591731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EPLQBB2GBeM0JhJNupUXh7QXE7qM2moBT4BpqtzLKg=;
        b=lsCjSWR8XgddX8IhPh0+Y5hAoiZye/Av6+b19RaghBe0zpFTUQYHqp8pdCbOm7XNmv
         eukFd5JBFMmdaa/WHfv04nTRR3XrZa/XHou0bWjOH1ds5VfGoJgRTDdQTU8t75I6Hvco
         n8sYrUG8DM5Ue0u8d8NhxMjb72QzLskaehY35emlssuq0YQXqGnhFhJuS8n4Pc4pHcr4
         r3G8h/AZOvhMw7QcmrCjo4wpw6wa3Ms3963cfwVYSrJ+/Kq8iw7TUUEjxxe7OZEZNtBy
         cEPrJomsnUI6t+NOnoE3g9Vc1xxnJrAQ8UqLlMXm12LNTjB/BBlN5ZNGAc6RXtgta+rj
         gQpw==
X-Gm-Message-State: AC+VfDzyE/Zo7lPJem9mR4zehfQPDd2GLufkH6V05679QsvFrFJcEXtE
        0pj2WIV92uEn7qAemJxQdgwozQ==
X-Google-Smtp-Source: ACHHUZ4KckdzIN9YVVpYV11NF6S3LYjc2DL/mCzjw1npS3Buhdnr5DUezOv6AibXv0XhTS/+UcSrTA==
X-Received: by 2002:a17:906:974b:b0:957:943e:7416 with SMTP id o11-20020a170906974b00b00957943e7416mr29305305ejy.15.1683999731473;
        Sat, 13 May 2023 10:42:11 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:bc2d:23f8:43c2:2aed])
        by smtp.gmail.com with ESMTPSA id hy25-20020a1709068a7900b0096607baaf19sm7032021ejc.101.2023.05.13.10.42.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 May 2023 10:42:10 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Aakarsh Jain <aakarsh.jain@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        m.szyprowski@samsung.com, andrzej.hajda@intel.com,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        ezequiel@vanguardiasur.com.ar, jernej.skrabec@gmail.com,
        benjamin.gaignard@collabora.com, krzysztof.kozlowski+dt@linaro.org,
        stanimir.varbanov@linaro.org, dillon.minfei@gmail.com,
        david.plowman@raspberrypi.com, mark.rutland@arm.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, andi@etezian.org,
        alim.akhtar@samsung.com, aswani.reddy@samsung.com,
        pankaj.dubey@samsung.com
Subject: Re: [Patch v7] dt-bindings: media: s5p-mfc: convert bindings to json-schema
Date:   Sat, 13 May 2023 19:42:06 +0200
Message-Id: <168399972073.5154.5669328924762682011.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230328114729.61436-1-aakarsh.jain@samsung.com>
References: <CGME20230328114738epcas5p475b8fa1d1e86bbb86d004afe365e0259@epcas5p4.samsung.com> <20230328114729.61436-1-aakarsh.jain@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Mar 2023 17:17:29 +0530, Aakarsh Jain wrote:
> Convert s5p-mfc bindings to DT schema format using json-schema.
> 
> 

Applied, thanks!

[1/1] dt-bindings: media: s5p-mfc: convert bindings to json-schema
      https://git.kernel.org/krzk/linux/c/538af6e5856b1aa971975c747a2974a74db48928

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
