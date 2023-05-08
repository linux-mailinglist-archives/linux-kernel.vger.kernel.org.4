Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECB6FA2CA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 11:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbjEHJAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 05:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233506AbjEHJAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 05:00:36 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351222F58
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 02:00:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso6443536a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 02:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683536407; x=1686128407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iALQJ4TleVOi463PGcNADtR4jMjReITCcEFEBaYKd9Q=;
        b=aXya+bZWAIdwD4ugTZRuzB/+UE4ZsSjgGnkCe2DTKELLASkkeet162rFVkbNC1D8dt
         0ZIh/Tuoio2/s67jexOScdqUpw7mMiH0VJSWwWq9oR3dbWrn7pibPAQZjYqZQ0PqTp6D
         yfGkK+mRvCgsVw0cgeULJaXWqas8BI8OkRnjy/Fm3XMfFHW2w1lx87RgQj7UqxTeK7wJ
         uv6cZwUKOzuj1/xxHtbTk0DDXyhmcMZ4jrhbwJ7FDHj2k3J2Sli3g2khkZvy9WsCcubw
         hDtVWhFo3FDWWEKYg8bF4jqPIQSZuRdU31zLYf+/P9R/XYfIAmRkxv0w1iI+miuULAks
         COKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683536407; x=1686128407;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iALQJ4TleVOi463PGcNADtR4jMjReITCcEFEBaYKd9Q=;
        b=V99UvNDf/gOXq/xgBK2zgtr6s4eMtz3i81MTURp9hS1fcmIliWPHiB3+6siNZ/ovxs
         xOma1eJnz1bALEawRTMG6lTDwQ73iQdBfq8DH1CWhH/Aauo3YOFbKZKU/mhnAEq3XmXU
         yY7vlvgk4zzAbrn5nW+AHMLoXQQPsHFSYdMkvBkbd9F3PTOOnYtdJKQM++FnNSwfJeTu
         5a+vZudTUzaXDHmVoITEnKvjJALnfpG4zb02GuzR0nNKBhjAQxlUYKzbWY596H1F1Z6y
         oUCLU9okG/mlA+fHEDdI1TQ74VycU++Zbn5IML6NtC9ifwltrZ/NubYqAcXvr6vnX15L
         GZcg==
X-Gm-Message-State: AC+VfDw3paEDNPtAo5+25y+BdSpTaQxLWS+reRsFKUjDAZq2P8O6aodg
        RPpueA53QsekH7FlnlBF29cL1Q==
X-Google-Smtp-Source: ACHHUZ7PFt6i7K3b6K7iJKWEHoA2/r/pfQhVheH2GEzhXVWbEoMhkoE1E86CjEW+wM1QLVlaOa5HYg==
X-Received: by 2002:a17:907:808:b0:960:ddba:e5c6 with SMTP id wv8-20020a170907080800b00960ddbae5c6mr7165162ejb.22.1683536407353;
        Mon, 08 May 2023 02:00:07 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id jz4-20020a170906bb0400b0094bb4c75695sm4718953ejb.194.2023.05.08.02.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 02:00:06 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Evgeniy Polyakov <zbr@ioremap.net>,
        Colin Ian King <colin.i.king@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] w1: remove redundant initialization to variable result
Date:   Mon,  8 May 2023 10:59:40 +0200
Message-Id: <168353638585.78189.845440168403301888.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20210721103451.43026-1-colin.king@canonical.com>
References: <20210721103451.43026-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 21 Jul 2021 11:34:51 +0100, Colin King wrote:
> The variable result is being initialized with a value that is never
> read, it is being updated later on. The assignment is redundant and
> can be removed.
> 
> 

Applied, thanks!

[1/1] w1: remove redundant initialization to variable result
      https://git.kernel.org/krzk/linux-w1/c/9033ff4c0fc65f3f168ee029b7e302a999c152ca

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
