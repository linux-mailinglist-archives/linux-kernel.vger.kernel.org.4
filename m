Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03AFA6694D4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 11:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241441AbjAMKyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 05:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjAMKxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 05:53:20 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35652777D0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:48 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id az20so32326593ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 02:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EDWhhww2liTPkzlw3Z6v9YOfZ6LPQ8B5DpH9HyGjiFY=;
        b=lN6UU4qsZdMXBqH7o2Z/duUCv8HzG7vMFayirjBnSsG6ZAdCBoUzHmzAxfU649KefY
         qRYjWIRWlCmBmmCHTDrCtEVDgG+HG0rMErwuhee/CsQHt0CG1ugerHiXrUmnQSFBnFWZ
         YHlRo3qBQpJjHm6eJ2A91CUb0Z+HJn4htAx2P4XysmtvYU1/Z4lzWdtHos212+dowtgC
         +lVj5HYuKFt96vXBaHnMqtGiHocIdC8aRMpaJdUKfTz2id5hdoVeH6ZhmZYJsfmXfah8
         Zesg5Ooza9s9yM7+dsgTAfigO6BGTUBr0fW07MMipOSGxn3k3v8EVeMjjuADo2r1Ugbb
         rd+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EDWhhww2liTPkzlw3Z6v9YOfZ6LPQ8B5DpH9HyGjiFY=;
        b=xF/sdzT7sPJOz1jJO18LDFDd67ABbbZ/ZXVJA1LwGnrLmR3oTQs8LWLsUfpwYqBjaz
         QvhRZDJblWM+Q4Uz/StbloM3LYzPj/qUJumzQZ0tjC0vBNkV/FTlrzjma2N6JfKUaTX0
         +dQW9bObqnnZJu+mpbT/dEEwyR2XoO7k4EOs2viXs12SkAhzgnf4dIvkTROvLY00EhJZ
         i07Drv9pJ5SJJYbxKNC/sL2XQ/Y5QW/u+RE2qtYyzMrY4UULWeMtYQvxwgmgdE6jnqh/
         vnoSGT53FTpGTTJOVG65Ydsdeh9G7t1rZGZTq4cqpAkMdNuyO5+/HD8D9bFSrr9NlRLX
         AJOg==
X-Gm-Message-State: AFqh2koBJU4j9b1SUo+32Lf2Zb3g9wtBmi/0ErCettUIwQ7prfdt8fZ+
        0vYlMHcI0356M9WRnd2bOLzQhA==
X-Google-Smtp-Source: AMrXdXszFWOLh+vBaaku2Ym5P6lMMzRpRBy1TO6sVOJBW82K268mmvgw6PBX/4MPiIYNpQTVqWr5VA==
X-Received: by 2002:a17:907:10d0:b0:85e:f910:71b6 with SMTP id rv16-20020a17090710d000b0085ef91071b6mr8802781ejb.51.1673607107050;
        Fri, 13 Jan 2023 02:51:47 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u1-20020a1709061da100b0086b7ffb3b92sm146352ejh.205.2023.01.13.02.51.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 02:51:46 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: microchip: drop 0x from unit address
Date:   Fri, 13 Jan 2023 11:51:37 +0100
Message-Id: <167360709872.32944.1802202247794037769.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221210113343.63864-1-krzysztof.kozlowski@linaro.org>
References: <20221210113343.63864-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 10 Dec 2022 12:33:43 +0100, Krzysztof Kozlowski wrote:
> By coding style, unit address should not start with 0x.
> 
> 

Applied, thanks!

[1/1] arm64: dts: microchip: drop 0x from unit address
      https://git.kernel.org/krzk/linux-dt/c/e76d8a16d12fc3fbcf212dd1a38974b99d751613

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
