Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28C870463E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 09:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEPHXs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 03:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjEPHXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 03:23:43 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5C33C39;
        Tue, 16 May 2023 00:23:41 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-24e5d5782edso12779521a91.0;
        Tue, 16 May 2023 00:23:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221821; x=1686813821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f2Ewl+pzg/EYDV9r41yW9nhxUrQsVL1ApvJ69sMnczM=;
        b=VQkVb+02i1KNhzRkzyci+tox0yM++34UNlwgqEx8OxnHHIB684ZDNdWovTy5hFMJ/b
         42oE6l5qGNqwcaWjs+hcKcY6vrROIuoiuLl3KN5dmULOYVFPkWuiv/DKL5+gzwdG7Ajc
         3s8rEs2S65LHobPaciEXG4HgU+LMDCPI2kQU5AUQY3QEaGYjmPOKrVeGR68Vo+slZ1cn
         wU80uJBr9kiONoRiT4m/bCaSMgkMip/tKkRIQ225fHy99civYxw3t8ZSKQCFzilA33lp
         EEVi/mZvIFA6BIHel8L16Xf00chCPqgOeiuad91ItHrfCqMJ0y9eG0HEOkZmw7Y00HxQ
         a4Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221821; x=1686813821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f2Ewl+pzg/EYDV9r41yW9nhxUrQsVL1ApvJ69sMnczM=;
        b=XnHAjco8JJIa4ORZAwFi55fSLftBKGOm7NaHVz5cqtw8Hp4TGHdxSeuuH5HHibf8Us
         FVAjbdMQGxYSRc4vgLWaHyzs3lOMZWv0tCvsoxva/tRNP5cZ2CvwSNH8nY+N7+mDrEhL
         EL/ZUAVwGfspgly/859IB9b0B+SvnSOvXBLGlHirL3eN3OBhqj7B/zUJ7eGoWyeIekNr
         ULS4toBHfnm+imITPGeRea+JZisF4NgAFOexG7k1Wu8ysNxWaa3NTayI7zPLVPkRLRK7
         3sPoQbJK8k0oMB7frF6pMgW/ZcKH6vf6Nqsef0FnvIYEW/uGOxll68NqR/PZueaIA73l
         9K3g==
X-Gm-Message-State: AC+VfDy8gdQzXLomZCccz+IDntpTOlbWIqBeCSFkxcMHbabLazWAhOTA
        RYnse0ufGxany/oJ3/qodjo=
X-Google-Smtp-Source: ACHHUZ4QF2JwPYLHFWHCVTLi2c0EzFmHWCbSSwBGXI/vFZK+Deo05KCNHg8C3rqdvl6/JlCBlnXrgw==
X-Received: by 2002:a17:90b:1e4b:b0:24e:1f5:2e05 with SMTP id pi11-20020a17090b1e4b00b0024e01f52e05mr37999296pjb.13.1684221820806;
        Tue, 16 May 2023 00:23:40 -0700 (PDT)
Received: from Gentoo (n220246252240.netvigator.com. [220.246.252.240])
        by smtp.gmail.com with ESMTPSA id fz5-20020a17090b024500b00252d960a8dfsm933923pjb.16.2023.05.16.00.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:23:40 -0700 (PDT)
Date:   Tue, 16 May 2023 15:23:33 +0800
From:   Jianhua Lu <lujianhua000@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
Subject: Re: [RESEND,PATCH 1/3] arm64: dts: qcom: sm8250-xiaomi-elish-boe:
 fix panel compatible
Message-ID: <ZGMvdfY28gNofo2C@Gentoo>
References: <20230516062657.28616-1-lujianhua000@gmail.com>
 <912d7db5-3bb2-cbc6-ed98-eb1dd40f9fbd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <912d7db5-3bb2-cbc6-ed98-eb1dd40f9fbd@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:01:35AM +0200, Krzysztof Kozlowski wrote:
> On 16/05/2023 08:26, Jianhua Lu wrote:
> > From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > 
> > The bindings expect "novatek,nt36523" fallback in the panel compatible:
> > 
> >   sm8250-xiaomi-elish-boe.dtb: panel@0: compatible: ['xiaomi,elish-boe-nt36523'] is too shor
> > 
> > Fixes: 51c4c2bd6f31 ("arm64: dts: qcom: sm8250-xiaomi-elish-boe: Add mdss and dsi panel")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> 
> I think there is no need to resend my patches. They are marked in
> patchwork. Unless I am not responsive to something, please rather avoid
> doing that.

Acked
> 
> Best regards,
> Krzysztof
> 
