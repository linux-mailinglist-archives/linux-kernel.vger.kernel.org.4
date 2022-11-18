Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD93F62F04C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 09:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241294AbiKRI7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 03:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241627AbiKRI7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 03:59:08 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D175803A
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:59:06 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id a15so5968322ljb.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 00:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ikLNajhgagvsy8YWu//dBofdaBK+urha+25nG1v92v4=;
        b=uWO9GE/K9yuumFxgicFZpL7JSyWo8W7Ej0i238IwYtZFHEETQwJtZgtxybnIXhrEdr
         xWLUoiOeBFDd8kez2EO1LGOA2UYyu11SKNJqfHxoVeGn+yV8rkzYgMNmhzXmRZx8I1O1
         /LcpYxYskjNhjigedeL2NM99uOJacrfT8tzzu7KKPyko0MX5Qt99Mt0ZK+H7eyqFWDGZ
         5oZddPqFOyQqP29zlB0TliQYkntCLlJqQ1zQPec6qPjmmtYI4LH9I1wPAYKbLhibTap9
         VNKMFxCEqT98iaPlQYUPyCFNM9ZV2WmZHi9RJy1Mo07ycwJysmIV3wJk2RJtP7+36n87
         NaKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ikLNajhgagvsy8YWu//dBofdaBK+urha+25nG1v92v4=;
        b=Bv7McYBXQeH+ZSyVYT7P0DYoVnRYNzAJ/xglLV4wQjvcPW90BVAxGP4ZjdlHG9d3Cx
         iexCiT3O2HYBAXBxFPMxny68yRI1hh73Dnm8+hcw/RKis7pTsRn8MX7rFH9b4K27810U
         XzTzL2QKJK4/CwUviepJx+7gRU55DpV5MRZMG/+FRMRxZjUfmJF3htIJxZu0Wc7xW6zc
         FCKdTwsI1Q9DcIVjyBgGVqYj7lk2/LjGzTJAZKkh9cviPNC0rSOBIScwkTGyC2I+yAHq
         S1g5tnn5gK3ZA7sOAW3BRXUIdMSLhFse8t5XfI54EJ2i7rrYz+rtLqbD6QSlUCRbpuFD
         DuCg==
X-Gm-Message-State: ANoB5pk/GzTAym/nQSJKr/EqChVYYOmziLBY6VVBjpuQ2YeM0NhMJKaU
        EekN+Ba+5udJFd5Jb/I3GNiWzQ==
X-Google-Smtp-Source: AA0mqf7cReHOzSDcSHf5S0iQhLRoD854GcTOICPse30M4ulzJJRejVX2zyyWwfYTVCg999LvptS2DQ==
X-Received: by 2002:a05:651c:124c:b0:277:8144:413f with SMTP id h12-20020a05651c124c00b002778144413fmr2359934ljh.390.1668761945118;
        Fri, 18 Nov 2022 00:59:05 -0800 (PST)
Received: from krzk-bin.NAT.warszawa.vectranet.pl (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o6-20020a05651205c600b0049478cc4eb9sm575398lfo.230.2022.11.18.00.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 00:59:04 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx: trim addresses to 8 digits
Date:   Fri, 18 Nov 2022 09:59:00 +0100
Message-Id: <166876193952.14422.5417474911500432659.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115105051.95345-1-krzysztof.kozlowski@linaro.org>
References: <20221115105051.95345-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2022 11:50:51 +0100, Krzysztof Kozlowski wrote:
> Hex numbers in addresses and sizes should be rather eight digits, not
> nine.  Drop leading zeros.  No functional change (same DTB).
> 
> 

Applied, thanks!

[1/1] ARM: dts: imx: trim addresses to 8 digits
      https://git.kernel.org/krzk/linux-dt/c/a4231f626e780e3186fe4561b8cadf57673e3cd0

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
