Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC0468013A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 20:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbjA2TrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 14:47:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjA2TrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 14:47:05 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5070F1ABE0;
        Sun, 29 Jan 2023 11:47:04 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1442977d77dso12733481fac.6;
        Sun, 29 Jan 2023 11:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v8O/cRRsAjvRSUFWhqOftJSo8NlvCf8iVIgYQungJRY=;
        b=FZw1I3XDHAlGQgXRR04Bf+xHf3qPGKQ6jSh9pCrGteruu452yZ2u5jAMpaU/FeLyE9
         z77rgJ/H3zFIX6n2K8bGiYWOFvGGnFo4YV0B0PcOAZIoeeicE2pauwyXA1/ueJOWMYu/
         1kphCeWB1YTY15aLLhBSY03JRA5TNiJa8B2YVD1sn7xoY2lpjBGcbCwTrysnyHZ95kbs
         +AedOtgjaVn+93998WpNtRHZlUT7XZMNq3XGgx/Arap3z1KhzaWa3FzMBNa6H4vRYp9r
         AqetUF3houBxQIBRVH2No+XrCzuBMN5O3HCX8wUpGhZN8uLRI/VNNU67r/scyNGTIrsn
         /O7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v8O/cRRsAjvRSUFWhqOftJSo8NlvCf8iVIgYQungJRY=;
        b=G0hkiAMofeUP9tsPpRnV4VjjxAUeZMFESwh3Q6PvUfHZMdJ7/AwoGavWMwcWXbRDUd
         ZQj5Z7x+OFmd9DbmjSYObfZKKgiA4iZEYmHkfCdm8Kca7tYiI48/Ubn4HFt/14Vr8rnl
         Aj33GrQVaAuc2ED8XaneUpJu5xU0lWyAFKQlpZdjQwtQGZx9aJMrvLumuHkMiQO41xCQ
         L85nFq9YIaVjmkPaFn+ZNvtndyIINt2oH+XxSSoHIidmPIHhwqVw5FDev3ZlKlviAru0
         mSh20jEyAO1IzgucPlfpUdAs7vGjnHkE/ZtLawtt3K4WtkSwq9ZBGvD9FPdIPf3QrsUA
         R0vA==
X-Gm-Message-State: AFqh2kqxNzWGblUChC9OfoA1bWJAdM806BqaIN+/4ZzJipNKzcUyNrFj
        38ea0OILzTwraB4Y+ybmJAY=
X-Google-Smtp-Source: AMrXdXuQIGGNUv0m9e9hWsi93lvGw9ADu/LxpBXvX2xcuoK+DdOJdZ+TkSxrRqDgmOr6LPiRnPBI5w==
X-Received: by 2002:a05:6870:cd0f:b0:144:c95f:a305 with SMTP id qk15-20020a056870cd0f00b00144c95fa305mr26615075oab.29.1675021623636;
        Sun, 29 Jan 2023 11:47:03 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x2-20020a4a2a42000000b0050dc3c2f77asm1253760oox.8.2023.01.29.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jan 2023 11:47:02 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Jan 2023 11:47:01 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-hwmon@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: trivial-devices: Add Infineon
 TDA38640 Voltage Regulator
Message-ID: <20230129194701.GA1418791@roeck-us.net>
References: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124202317.3704963-1-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 09:23:16PM +0100, Naresh Solanki wrote:
> Infineon TDA38640 is PMBUS compliant voltage regulator.
> 
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied to hwmon-next.

Thanks,
Guenter
