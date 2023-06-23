Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE7473BAC4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjFWOws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbjFWOwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:52:24 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770E92947;
        Fri, 23 Jun 2023 07:52:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f640e48bc3so912173e87.2;
        Fri, 23 Jun 2023 07:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687531926; x=1690123926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eOAX4+A4m0E167xtJYkA4sIkJeoCW8DDUIaJ2NdOXVE=;
        b=q4pYrXPEdWuF5Buh+yCzF8VfQ/xYyEXosWT85bmj0Rto8DxK1sgsNrz0qhYYS+XZ/F
         Dk4457EKCjzCCtnYHWgbVDyqsNn5pUU2baoicvltQQP35bvpiA64FXVI1qrWWWlPh/G8
         wJXX91OwzCW0PkrkFqEoqp9L2C+CCF3Jt4iBb8Rv8HiDhxilldLINYOSb3b9czcPTDlC
         qIP0bwSMakvAAHU+9yzn8e8vzxeKSEmUPlPgKIEks4XDIeHsWN4emxxFjgSYkabYPygT
         eCdU5mE2IVUb6ioS2nOfG7o18K5Y5+8IMi1IT054uMGqRNg6cOYwsyGD7b5jbtju1mKc
         0k8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687531926; x=1690123926;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eOAX4+A4m0E167xtJYkA4sIkJeoCW8DDUIaJ2NdOXVE=;
        b=YPNODfW98kpp+mPIrQmckptO1S+CR7mRddQsq76GfSXHvfIa4q2pM7d497VSvtCj05
         btVhyGyhuSO/jmVwL1sGmKeQXjRNZAnDAYA43fVR18BNCQs1MnUQo+VoYftbOUPZIANF
         0/pODt+xGM/Bv+y6gRdBUMG5iiVm9/Agp4LlZbC72nEfNNegnQ70qife7ButaQS3pfco
         Kj2vnn1pcyKyAIutC0m/vYq8Fw/YEzqjtNYbx4m7XzZC+9X+aMiobhmSKnsI0UKwIZdg
         Fs67Ass4mboZRP3MHjjdTal/yt+KHvk9JCDcjPBDVKrWywEPI06bc9MaRntpg78hrjNx
         VEkg==
X-Gm-Message-State: AC+VfDxcFfeH66YrBjgd+6eIIDz7ypqrvSei/x8sZE3IGf8RuILGVaj0
        q3A4BAOrlVADmVX3HnMSDny78I1OtgU=
X-Google-Smtp-Source: ACHHUZ71/qcV9YZh9KegTU/GA40seUiP9bMybgbNSWkr5zRGdgqoqHBfDqI6IUfw5FzqGKa1DnI/Fg==
X-Received: by 2002:a19:6d12:0:b0:4f5:a181:97b8 with SMTP id i18-20020a196d12000000b004f5a18197b8mr12983661lfc.25.1687531926115;
        Fri, 23 Jun 2023 07:52:06 -0700 (PDT)
Received: from localhost (p200300e41f305300f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f30:5300:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f23-20020a1c6a17000000b003eddc6aa5fasm2522679wmc.39.2023.06.23.07.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 07:52:05 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        Clark Wang <xiaoning.wang@nxp.com>
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: imx-tpm: force 'real_period' to be zero in suspend
Date:   Fri, 23 Jun 2023 16:51:43 +0200
Message-ID: <168753171965.1191890.769782299829517183.b4-ty@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230505065839.3973693-1-xiaoning.wang@nxp.com>
References: <20230505065839.3973693-1-xiaoning.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 05 May 2023 14:58:39 +0800, Clark Wang wrote:
> During suspend, all the tpm registers will lose values.
> So the 'real_period' value of struct 'imx_tpm_pwm_chip'
> should be forced to be zero to force the period update
> code can be executed after system resume back.
> 
> 

Applied, thanks!

[1/1] pwm: imx-tpm: force 'real_period' to be zero in suspend
      commit: 661dfb7f46298e53f6c3deaa772fa527aae86193

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
