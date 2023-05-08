Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795D56FB5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 19:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234431AbjEHREv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 13:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjEHREi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:04:38 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E58E729C
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 10:04:27 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-50bc5197d33so9105933a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 10:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683565465; x=1686157465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAw+LmjENYP6n0JgiGSrlogWGfxzFdRErjaIx7RmFsY=;
        b=LTMddz/OjQ+Gm/xmlL+u9f//UGe2LOfuR2QNqJzmMZnvIZiQKDF67T0AybETmaDR4p
         ysi/En4tB8DzHIHnbioW4giP82BrA6hWqqLk96cwcOq4wcEiEBskOVhmg4RPrUuM+8yX
         BWHTqgQpir3cJFpFRlaHqTXrmcJT1mq+UhRZlWey/SVUmn4ZXBxLbzV0PlXDdFh3M80Y
         v4iZ2scc9q/Ri47zqfdG54NtONkYz2Zqfm4sPppc7549GT2GzVjl2k4OSUSqsuhqr2G4
         FM54FqM66QsUY9d94TGQSEO/gSftn9Q0GWhJhY527GaAxE1i7IKkiVVK3bamnBZYLnyg
         eHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683565465; x=1686157465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAw+LmjENYP6n0JgiGSrlogWGfxzFdRErjaIx7RmFsY=;
        b=GkjthxMjB5Q4CMnKiTomB5sfj0rHeUhfklr1eRt4agVV4k3NqiVb2NfBhO/Wq6t2CV
         e7be/aHngxoaug4Su0/AXyeiWaCjgDO/Czw/pAUlc7GeKxK/NgSVQp8R5Q0SklhhrX/P
         QNq8uXX/LaGRs/x2Wp9+coLS2SaxfSZv8yyIoHEshoa4fCLa/5ph60MOTapOdEtLABae
         4sq8lpad08HXN2rDnT650Vas6/tRHyNIAoddUz2jOr4f0z0umYZlF53NmYMsNEziMqqm
         zCYaadH3DwslaPSejEDjdCoEz3fGixvst9BDwm5dDIyzwJxSSYQH1uD9j80qLohweEg2
         UisQ==
X-Gm-Message-State: AC+VfDz05PRUDine65bwjhSNreVmagnIrAhgXYi3LMaG8yIDktBwcbPA
        P0XD7vpfRdlNzhnW4Hzc4Mh0VQ==
X-Google-Smtp-Source: ACHHUZ4VYMYjYzSc1Acapa5ANUYEhCSkSLGGQ/iMjiXSFlOVs1VhRjgzciwj/nWArtp91698u0L/Yg==
X-Received: by 2002:a17:907:360c:b0:966:23e5:c8f7 with SMTP id bk12-20020a170907360c00b0096623e5c8f7mr5754200ejc.62.1683565465540;
        Mon, 08 May 2023 10:04:25 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:50e0:ebdf:b755:b300])
        by smtp.gmail.com with ESMTPSA id lh2-20020a170906f8c200b00965b7bf6aa5sm206862ejb.52.2023.05.08.10.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 10:04:25 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ARM: dts: s5pv210: remove empty camera pinctrl configuration
Date:   Mon,  8 May 2023 19:04:17 +0200
Message-Id: <168356544397.281925.652895138808564025.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230421190202.15471-1-krzysztof.kozlowski@linaro.org>
References: <20230421190202.15471-1-krzysztof.kozlowski@linaro.org>
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


On Fri, 21 Apr 2023 21:02:02 +0200, Krzysztof Kozlowski wrote:
> The camera's pinctrl configuration is simply empty and not effective.
> Remove it to fix dtbs_check warnings like:
> 
>   s5pv210-torbreck.dtb: camera@fa600000: pinctrl-0: True is not of type 'array'
> 
> 

Applied, thanks!

[1/1] ARM: dts: s5pv210: remove empty camera pinctrl configuration
      https://git.kernel.org/krzk/linux/c/b8039b4e40094e81351221275ed61ee7643cdb91

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
