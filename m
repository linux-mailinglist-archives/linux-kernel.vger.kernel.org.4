Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD7A64F2A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 21:51:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbiLPUvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 15:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiLPUu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 15:50:57 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F5ED2189D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:50:53 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id e13so5289753edj.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:50:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ty4Q6pmKGBdcK+JvghcaxT3SktTZCwT4+BsAt6gEM58=;
        b=K281Hjcnge0R86zglG2H9v4Gt/ejUenfiXW6UYj7GNr4X2YogLbL9zN80GvGkEXpLF
         bAscjiNEWAXJvdbmAen53eXH+PgSzU4jrBtGIts4eu+BzaMaTF5Zcp+/cIJ6ooacQEeD
         7p18N6vnCNtUjS6nqN27cydZ6JYP9JpNOQr6w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ty4Q6pmKGBdcK+JvghcaxT3SktTZCwT4+BsAt6gEM58=;
        b=tkVd12/kn0ItZcf18XdC/9+hfhNhSawkYAhV4mM8UgHvzgyCsmHNmdecZrjo68cU2Z
         eCQRnORSwT1NV6RcHpTfYdLTC417QpVxfywffzp4dnPfuGEkRWTgtnN5o4j/7CRANZpH
         lstYHLYF0WebFlTE06UircdbY5MdIkeQT6frpZPJDyjtuCB39rxiwbp0N/2i6CJHO8xI
         79cHyvyRc7qQPFQRFM0wvb0Mgj4aocfc+VHk03Bj/lMoK99ZZqCof4UZZ1hEmV3AQr4i
         e8pzjTHszIH9AZ7BslJGfFIUEPsNOCY4D9tIzpJKOnMi9c/8+qfnHmA3X9URRn4ojysg
         HKeA==
X-Gm-Message-State: ANoB5pm0wetxmslOhBMIhu3zGGEMxU24ZTUSggPoGnwSek12TGk0xroc
        GLQVCV3iZ+8p5gxZrQ7PC8KZZ64Xln6eFET78Ac=
X-Google-Smtp-Source: AA0mqf4Lw520lM3qgaq7H1rSzlTYOhLDdcMaZVsvFk92xnVtm+dMO4gICMZigRpRuFyb0oxNddMHeA==
X-Received: by 2002:aa7:c787:0:b0:46d:cead:4eab with SMTP id n7-20020aa7c787000000b0046dcead4eabmr27364398eds.6.1671223851805;
        Fri, 16 Dec 2022 12:50:51 -0800 (PST)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id d30-20020a056402401e00b0046b25b93451sm1237896eda.85.2022.12.16.12.50.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 12:50:51 -0800 (PST)
Received: by mail-wr1-f47.google.com with SMTP id h7so3659318wrs.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 12:50:50 -0800 (PST)
X-Received: by 2002:a5d:4950:0:b0:242:1f80:6cd9 with SMTP id
 r16-20020a5d4950000000b002421f806cd9mr26993001wrs.405.1671223850700; Fri, 16
 Dec 2022 12:50:50 -0800 (PST)
MIME-Version: 1.0
References: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
In-Reply-To: <1671212293-14767-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 16 Dec 2022 12:50:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UH_K+oyKOxk88_3zcYTB8C8JHAJVqFwLdO4DE0_wtvBg@mail.gmail.com>
Message-ID: <CAD=FV=UH_K+oyKOxk88_3zcYTB8C8JHAJVqFwLdO4DE0_wtvBg@mail.gmail.com>
Subject: Re: [V2] dmaengine: qcom: gpi: Set link_rx bit on GO TRE for rx operation
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, linux-arm-msm@vger.kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_msavaliy@quicinc.com, mka@chromium.org, swboyd@chromium.org,
        quic_vtanuku@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Dec 16, 2022 at 9:38 AM Vijaya Krishna Nivarthi
<quic_vnivarth@quicinc.com> wrote:
>
> Rx operation on SPI GSI DMA is currently not working.
> As per GSI spec, link_rx bit is to be set on GO TRE on tx
> channel whenever there is going to be a DMA TRE on rx
> channel. This is currently set for duplex operation only.
>
> Set the bit for rx operation as well.
> This is part of changes required to bring up Rx.
>
> Fixes: 94b8f0e58fa1 ("dmaengine: qcom: gpi: set chain and link flag for duplex")
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
> v1 -> v2:
> - updated change description
> ---
>  drivers/dma/qcom/gpi.c | 1 +
>  1 file changed, 1 insertion(+)

Without knowing anything about how the hardware actually works, I can
say that the change looks OK to me.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
