Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC75663B5FB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 00:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiK1Xfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 18:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234725AbiK1Xf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 18:35:29 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E19A32B91;
        Mon, 28 Nov 2022 15:35:28 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id d6so11734179pll.7;
        Mon, 28 Nov 2022 15:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XubyZOJKJsc07ID8LSYL6Rik5ZXYgyn4rSu46a4XKlo=;
        b=jSH8TgzPKPfvYVbnirLcHh3f3GaHQ+mOd0I4ezyx9ahm7cPmqE/tMaz2rwvnGuNOcs
         MrjD8xPQIea4aaqmxJd//HgbuMxq5ibh1P1ojzZCvDiDVvtEyywLDsgclEjz794kOCpC
         C6zJUylkhbAhJg37qR4GkTNAfrvLrvkGK2lzg70V0TTw+6smGglXhW5dtSi3kRyh8d82
         f/GQiSDp2EhRGP6alqvRKW4JVlHKWrz9NFeiHJD3p4aTPe+kuplu7loX3RwLzKww8BNb
         diZjkeJdB99b+UEyvMUWYQyDUtIs1twS/rPGmYDYOLBoOtqWQOPp7j3HR8wrNjkoMkIj
         M4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XubyZOJKJsc07ID8LSYL6Rik5ZXYgyn4rSu46a4XKlo=;
        b=twn3qsIEEPpA2HHa8bsbmJNvSMlB9G8H/Rwi/OFR7XCQdyd6HrBQFSH3zahizvt3+R
         FR2bf9BPX2LBe7C6RlfPF0zQKBTHJkJA/LM72Ge+isXww9VaaV55zZX49ByH0rhA1cNb
         +nbN96KWdwy7TcIYg18jHyZBzBPJfKDJm/vx8YV+ALdgLpN8Iu7vmWtZkJsU9kedPmgj
         2sek424QWTU+smXipwms7ECKktazsKI3WaEY/baq0KdDUhLYw6VN0Oq+xqIc1cD0Fbow
         OpQvJ6nYuAbl+rCNFb0fTRhLyVBAu/SWhEPU8W8Enr04kse5+FSw4e+OzHsLd2qEvS1Z
         L3zg==
X-Gm-Message-State: ANoB5plMCMX4MGBR8dUOJ96DpM0j7LBjSw2cUA88fHUi/0FYdWIC5gWY
        CgMsyWOuqt3rHxpB+McE6i/I++9iw0U=
X-Google-Smtp-Source: AA0mqf7LCNGxWZr/79+PvDkMLvZ+6+osxNf104N0jL5j9YQemDsjUkopa1g5jdqmKNLGx/bcGeMCYA==
X-Received: by 2002:a17:902:d547:b0:189:5c50:ce5 with SMTP id z7-20020a170902d54700b001895c500ce5mr23085017plf.14.1669678527688;
        Mon, 28 Nov 2022 15:35:27 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n1-20020a056a00212100b00528a097aeffsm8524275pfj.118.2022.11.28.15.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 15:35:27 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-2?q?Rafa=B3_Mi=B3ecki?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: broadcom: align LED node names with dtschema
Date:   Mon, 28 Nov 2022 15:35:25 -0800
Message-Id: <20221128233525.500777-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221125144128.477059-1-krzysztof.kozlowski@linaro.org>
References: <20221125144128.477059-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 25 Nov 2022 15:41:27 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> The node names should be generic and DT schema expects certain pattern:
> 
>   bcm4708-asus-rt-ac68u.dtb: leds: 'logo', 'power', 'usb2', 'usb3' do not match any of the regexes: '(^led-[0-9a-f]$|led)', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
