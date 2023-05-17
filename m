Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E687067FB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjEQMXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEQMXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:23:46 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86AC193
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:23:45 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bcb229adaso1295079a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684326224; x=1686918224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aFKYY6Sdcg71xkJMBu7aohX7hPHPB8gJkVrNK09lQxs=;
        b=OfK49a06EYLTxhOMLokZuo++H1DUjT4J9XClgz9+M/LH9ntb8vHsMz1WBLjkEQysMV
         zMwAFmXA33CqV9VHFl19ECypw6OWyvlv54VTxBI3dplFU3R0J5Fyr2PuEGj7cT/fTc7n
         EoJEKm+3gsB+fO/VosFtFAHCbVXKg5nUC7RYOmRtYUAEWyjoM7QoEOo7U/qXE054Cqus
         2EqO9dRBITaGU6aFNRD5G/2AMwNglVFsiRrHSIpCuguEOS1tJarg579JV+Xs+h1dgklV
         Aw4d1wtpk5QfxgktQbDbr6Src2DlIEvuy/h4mEYVcpKcH+GCLSTf0bqcQEDLnkg2l/ri
         kiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684326224; x=1686918224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aFKYY6Sdcg71xkJMBu7aohX7hPHPB8gJkVrNK09lQxs=;
        b=Q4EucBDvYBo5cKrEsAxaUDBLT2ssAKDP7hPfAvA0cVwYRV1TmREnrSl4CjyyNpP3M+
         EPq+TfRlZgkLL2nCb706lf7fnUvV7+MOSh8yfsITdrrLwGRqbnQWUvu/Lq3phP5Gt0Ky
         kjfDU6p4qDUwPCRT3z+FY2lFewlM+2DZXg4wSZ7u8vX1eYAFAmHlLtKV0Ng9EqMbbd9k
         LooXj+AOsrSSjOLVQEU1M1emvjQ3SA1wz8JIhXaLQLf2OtJkeJm7n93u63cjujesfoiL
         z9hjwcYmQEeQmF85VyJPgY76XJxfxO7+NtNHa2fVtv0oH9TdTE03oVUjXFf2X6xEMMdT
         W7bg==
X-Gm-Message-State: AC+VfDz3EZRrAyP81e6Jg7q8NoXTtu1QtnSXlSFZsvTOrPKRHizNzY8n
        m/enWGXDcNIF747ibKhI8PQA2g==
X-Google-Smtp-Source: ACHHUZ5kJ6RkUgqzaG+rRy4MEO4LhPbI+eWD4r3v9vQbx8sLcqCFc+z8A/6QGB8vit681QNT4GdbjA==
X-Received: by 2002:a05:6402:1353:b0:50d:9b59:4336 with SMTP id y19-20020a056402135300b0050d9b594336mr1807242edw.37.1684326224204;
        Wed, 17 May 2023 05:23:44 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id p3-20020aa7d303000000b0050e01a965a3sm6495480edq.5.2023.05.17.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 05:23:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
Date:   Wed, 17 May 2023 14:23:38 +0200
Message-Id: <168432619059.440504.9237676532611038988.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
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


On Sat, 22 Apr 2023 00:31:55 +0200, Krzysztof Kozlowski wrote:
> As all level 2 and level 3 caches are unified, add required
> cache-unified and cache-level properties to fix warnings like:
> 
>   sparx5_pcb125.dtb: l2-cache0: 'cache-level' is a required property
> 
> 

Applied, thanks!

[1/1] arm64: dts: microchip: add missing cache properties
      https://git.kernel.org/krzk/linux-dt/c/f217d94fc632fece2a41030c2eebc4ed34a48b2a

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
