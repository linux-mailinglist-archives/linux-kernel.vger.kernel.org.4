Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85FB167842B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjAWSIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjAWSH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:07:59 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59421190;
        Mon, 23 Jan 2023 10:07:47 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso11758965pjf.1;
        Mon, 23 Jan 2023 10:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h8mPwBYse7oSlnAiC3+k73jR5nxT7YOe6OEcVmnTNWc=;
        b=QBks0YTQXt3iXhQoRWYMvh6bWkyuN6pncJJOl/t1vsJFyTklOTGVaszPWQ1K22i6nA
         YQPbeDi5+633iHQWeo0Xra8NubXQTVIs8XmY5VgUPB7qmiTNfM4eWh0//IHiQIgfb2zi
         Wb+qAF5oGr2r+8csn9k62UwlsltF171vQ4556thtH+uKwInBbb+t0UBdDXHVO3zW3B68
         5jA1wlswSyOvvldIrQ6HS2Qm3eqIbyVgte2W8WU2u2Qp8j6TRc7NF71Cwx4L61BVfxFl
         zAftNcQ7UHBEF49ErShqj36Q4ykONYGHtuuJlFqYU+Z6QTizJDQh5RB+y2PAW7MDsek0
         awaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h8mPwBYse7oSlnAiC3+k73jR5nxT7YOe6OEcVmnTNWc=;
        b=z/xi/FMMSUqobMm8tRWmCUTXzovFho0l753TgcgU06nJUtV6AO6Y+FQXAwAIJK8PQD
         g6xJM0y9NjDGNGKGYER11Cu2AeLrs7V46T0gSs28sa6YFU7KO6hk8LQR0oW0GzWo25BV
         qsFtpQBtFkeGkROgDEit6b03jJArTnK+jQgNumJOpQ8kFx8a5c8t/Onm62FABECgJJ24
         ItyQwn7s1y7CrLNT+IIVo47CK9aHTyV/6vpxgC0YuAp9JANLnBkH6q5m8uFZHLhms/7h
         m+BlkpXvbK4Mm2ULO4Pa9JGVV0k48XkMPdfW26vl1RfKfP24H+alf2o4eEEcbVG3j71W
         WIxw==
X-Gm-Message-State: AFqh2koCYerccLo55pQhsQ5UP/TRbPL2xUA9M4//zdJzUQ6OPHGUwnD5
        5tz/hXAS6f3OtNMOq65yDkI=
X-Google-Smtp-Source: AMrXdXtH6b3HsMLqBzTO0lY0bxGbNr0U/oHpFMF/dGvN0FH79uB0G8xRiobPqHsGTkUMbrDqCI4E1g==
X-Received: by 2002:a17:902:7889:b0:192:b5a8:3eb6 with SMTP id q9-20020a170902788900b00192b5a83eb6mr21709883pll.44.1674497266356;
        Mon, 23 Jan 2023 10:07:46 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id y3-20020a1709029b8300b00192c4055e72sm1347307plp.173.2023.01.23.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 10:07:45 -0800 (PST)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] ARM: dts: broadcom: align UART node name with bindings
Date:   Mon, 23 Jan 2023 10:07:44 -0800
Message-Id: <20230123180744.283430-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230123151616.369963-2-krzysztof.kozlowski@linaro.org>
References: <20230123151616.369963-1-krzysztof.kozlowski@linaro.org> <20230123151616.369963-2-krzysztof.kozlowski@linaro.org>
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

On Mon, 23 Jan 2023 16:16:16 +0100, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> Bindings expect UART/serial node names to be "serial".
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, thanks!
--
Florian
