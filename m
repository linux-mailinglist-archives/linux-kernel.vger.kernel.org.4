Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB06678437
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbjAWSKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233534AbjAWSKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:10:02 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88EF613B;
        Mon, 23 Jan 2023 10:10:01 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9so12229013pll.9;
        Mon, 23 Jan 2023 10:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfkNd1nzmeK8RpLMZuHHy+INyAN7KLANHjMjDXqSaxU=;
        b=aW8nnE6ZS3GDuCh+jMXzcJ56Nd0RWxXhCdpIMCGCcmGLVKPtZC/N50ckjJwX+BuD/R
         Qw8pMvNKRYcMHx6jylC/PwjKZMTx7oaFWCDnZFukupkCgfFQEp6Qi9Y4UdDXa6EuE4PO
         qEqYBBRuj3i/uSbHOamFaImFwYWq+yXjYe4fJAMni7FqGTX7gQkTmICZLnYPxk8bv2DU
         beVPUnJPaCQAzm4NwTnc7VoGKSLz+vS/rGZvPfnvCgSkHZg5EYBoW+MhdRxawGj4a0nT
         MUwlb8tUaOptWr6wAPdGDJj0XtPmUE7xRnpjd08xQDU8U97HHPY2C/kCJ1svND1LAY4W
         9QoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zfkNd1nzmeK8RpLMZuHHy+INyAN7KLANHjMjDXqSaxU=;
        b=bqc0nB0eEdXvP70E4k0B+Dh8vpkHdzEEi2hAT+D+IZk0ZYqaAh7WxTa1TUTQhn9LRo
         MOANlTgsKG4JFHqv6t4YHFZJExKtWMCrng/oNzaklvGIKaXbOWA61PjMPdBo5jobE0s6
         bXxIkRWhvWXAKkF36QRpJTPrpalZ8c6plufufgA9tG4m+IHITPUshnbhJhbGc9eLBq+d
         kIyXlHJEmCjDNAefJgiftb4sKBOft3ehvDnZq/GHqncGKQdDuLQ3ZlOW2iX4xUSoGGTK
         26E22U9DAFpL0w0vD8HIRd7RmXlQuSF6fTGrAKCex7lSi9Qns//0iQUdAe5mTOB46MsF
         kojA==
X-Gm-Message-State: AFqh2kqjTjdekW4XLUVyU8GEmNcy1LMhZTX9xACgRuobGN5uGcxX24jI
        TqJjzGgMFyKPocYsDNtYL6U=
X-Google-Smtp-Source: AMrXdXuEBDf+Y4dxEyI17JtnQX9rnFRA8vUhaCUX2HkE0H74xCdzfJ/JQOxrN5ZSPd2+A0Y6SGaDKA==
X-Received: by 2002:a17:902:ef91:b0:195:f0be:375c with SMTP id iz17-20020a170902ef9100b00195f0be375cmr10300011plb.19.1674497400975;
        Mon, 23 Jan 2023 10:10:00 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id l16-20020a170902f69000b001911e0af95dsm2183492plg.240.2023.01.23.10.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:10:00 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64: dts: broadcom: drop deprecated serial device_type
Date:   Mon, 23 Jan 2023 10:09:58 -0800
Message-Id: <20230123180958.283659-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151616.369963-1-krzysztof.kozlowski@linaro.org>
References: <20230123151616.369963-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Jan 2023 16:16:15 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> The device_type property is deprecated by Devicetree specification and
> bindings do not allow it.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree-arm64/next, thanks!
--
Florian
