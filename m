Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A61A717AD4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 10:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235243AbjEaI4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 04:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235208AbjEaI4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 04:56:47 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23348BE
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:56:46 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-30b023b0068so570811f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 01:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685523404; x=1688115404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=exzz6pAeE8UvoElYgU8je4n0hY+uXNzHEMLEFlVL23o=;
        b=fGhNTIeXBBRs2kumWzyzJepFEZ4JgIPKU7lkqJTxf4R5QFfcKfhMI/ujsekrCiPVWx
         D9Pc9aD/Coo3KK4G0R1OK8phLndB7GD0B0zajNlxQBoFarKb2MYyu7jA4I0X462DtXGu
         92Mg5Ig12pPOGY9u0NOF8l7A68EwfHxnxOra5j2/GRIAxXj15c2LzuGnQLqF9NAw9qaY
         Y2KYmMHjV/KM8jMjeIE5sztS6ZObz+xJ6e9qBd4Wun9Johcg3rxOeEcKQiClAUCDWBe2
         qzCTX/2on0n2AY/Pp8xyt5NKkLJ5na+ieaV2FJva8z/ygN6+s4WCn4e7vUL/CGJOuNT3
         cRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685523404; x=1688115404;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=exzz6pAeE8UvoElYgU8je4n0hY+uXNzHEMLEFlVL23o=;
        b=IGmeynN1JtX/gdDw+9G2EBQEt0KN8jN0oPBUiMlvh87pym7IzLPzKiWvzygzo1A+yG
         qwI1LBk6bEkyQvE3C+/4l5/wLJ68dSY0pvT7nJYQXgRl7WWNTcp710NP/dcnBmpp1vWy
         PFPmRKr5yo7Fuug6Vs1YX98TnOxFLlrBTh4aOB0/1JeTnddzD9GDOmEznJLkbufEPwaR
         R/X2zJW8rwO9Ar7F3P6o+4/4EzgHwgchBMoidSqakJN9vQ33lm8+vUNM4x8foi9y945j
         bgdZwoeFvzEmqW4n3LxNgmzljZSmKUck+Te0RzzHpdq6n/OrGJsISCt2Yzz42gk+iuan
         ke7A==
X-Gm-Message-State: AC+VfDzx15atXlIWyRCnqnAdCUhpwWPr3UwcGTqlfRQgBnAQkgTpI04U
        9PrliMB8NW1PXM/oAvcxB5R43w==
X-Google-Smtp-Source: ACHHUZ6UuXtxDIm/fOFuqamiq5/YRQFeSq1dyqtPf0kIc9s9Of0DFxwhdnZ+zYh3NZx626Dfyp1H/A==
X-Received: by 2002:a5d:6ac3:0:b0:30a:ebdb:908c with SMTP id u3-20020a5d6ac3000000b0030aebdb908cmr3755201wrw.16.1685523404537;
        Wed, 31 May 2023 01:56:44 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0030af20aaa3fsm6050551wro.71.2023.05.31.01.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 01:56:44 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     linux-amlogic@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hans-Frieder Vogt <hfdevel@gmx.net>
In-Reply-To: <20230516203029.1031174-1-martin.blumenstingl@googlemail.com>
References: <20230516203029.1031174-1-martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v3] ARM: dts: meson8: correct uart_B and uart_C clock
 references
Message-Id: <168552340376.1980576.16108743746787991413.b4-ty@linaro.org>
Date:   Wed, 31 May 2023 10:56:43 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 16 May 2023 22:30:29 +0200, Martin Blumenstingl wrote:
> On Meson8 uart_B and uart_C do not work, because they are relying on
> incorrect clocks. Change the references of pclk to the correct CLKID
> (UART1 for uart_B and UART2 for uart_C), to allow use of the two uarts.
> 
> This was originally reported by Hans-Frieder Vogt for Meson8b [0], but
> the same bug is also present in meson8.dtsi
> 
> [...]

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v6.5/arm-dt)

[1/1] ARM: dts: meson8: correct uart_B and uart_C clock references
      https://git.kernel.org/amlogic/c/98b503c7fb13a17a47d8ebf15fa8f7c10118e75c

These changes has been applied on the intermediate git tree [1].

The v6.5/arm-dt branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil

