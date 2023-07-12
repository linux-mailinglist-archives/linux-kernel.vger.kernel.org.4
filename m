Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7659C7504DC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 12:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjGLKjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 06:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjGLKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 06:39:29 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC381BDB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:39:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b8b4749013so50139035ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 03:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689158364; x=1691750364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uc+j0nHauw/6H2r/Az5E2Y7roqAWp5N7e9hobTyaCqg=;
        b=xk+9YY5nxZv7P2Er1PiAlOysRfG7n0Ego+oTOTeYVyvcj2Mpts9mNP4EBrrAoKSPH1
         MbBcuatIEw+rYXdbhSmpZDhtKfaXRBCbG7PzTZCxh/bdTiws4PEmLNeRJUp2Hwzvn6EL
         BPVqadL1v3zg69FWg4nk7YftElqeAuWBzyQUsJAVt5j+AWCz3Rs8FHJg/fY8QdgK6GX3
         DFof6rww0StgwWnEb9iSrIGKPZJCV0tswfFMgVPYv1Cz1NYMBYtvM9yjEldfoVkY9TxD
         TZ4Wsxj71HFs0q3gmNsH6httxX+5RQsIJ9A2oApHX5sOg3Anx+WYz1iuds3beKDKi7al
         KNQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689158364; x=1691750364;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uc+j0nHauw/6H2r/Az5E2Y7roqAWp5N7e9hobTyaCqg=;
        b=YCbg9o+IFmgM9dDom45ufSjwG2LiFDZ8s7wLASOHu7Uw6ppSjHDYyxBtJ1Z2uPfwBN
         vD2aOkDVt22ZVDzqrm7eAV3CvmAXmuWbRny4q1py4ORQQcJfvkA09c1Krfc1AYnQJY+I
         V8Kxx0L0pjAVzfaw1/bciLgQQWd0uvIHK3ZLVqH+c1L6rMVSl2DvHtapxwNBe7zoK9gT
         SEPkkr9HTUozoI6sOgqaRxlMqDafBPVD5Q0BZcY15Oavwd2ves6RuDah7iN0ADQRd6+L
         MvzQ75mmSPchTSqlhZjcxYg9F25GaB62L6kNx9y11vwUnN12/ozRwwHg85aJx9G+3eF/
         MkrA==
X-Gm-Message-State: ABy/qLZ9nW6DUtSPg44L7p+WxrGXK7pz5L5vEIC/VAxqL9f18v9Q6ZAO
        qCv524KZ0Ac8ZFdRfh3klIWd0w==
X-Google-Smtp-Source: APBJJlHRAGuyD7rEdovEfYR0fR9Qln9qmCs18kkA12xObV8qC6TJtJPBNfg92tdmp+ysmBxdorRWwg==
X-Received: by 2002:a17:902:d3c6:b0:1b8:90bd:d157 with SMTP id w6-20020a170902d3c600b001b890bdd157mr16923020plb.26.1689158364038;
        Wed, 12 Jul 2023 03:39:24 -0700 (PDT)
Received: from localhost ([122.172.87.195])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902b28400b001b8707b70d1sm3612547plr.214.2023.07.12.03.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 03:39:23 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:09:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        cw00.choi@samsung.com, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com,
        quic_nitirawa@quicinc.com, quic_narepall@quicinc.com,
        quic_bhaskarv@quicinc.com, quic_richardp@quicinc.com,
        quic_nguyenb@quicinc.com, quic_ziqichen@quicinc.com,
        bmasney@redhat.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH 02/14] dt-bindings: opp: Increase maxItems for opp-hz
 property
Message-ID: <20230712103921.rvut4r2kgqe6k42e@vireshk-i7>
References: <20230712103213.101770-1-manivannan.sadhasivam@linaro.org>
 <20230712103213.101770-3-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712103213.101770-3-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-07-23, 16:01, Manivannan Sadhasivam wrote:
> Current limit of 16 will be exhausted by platforms specifying the frequency
> for 9 clocks using opp-hz, like Qcom SDM845 SoC: 9 * 2 (64 bits) = 18

You missed mentioning why you are multiplying by 2 here (I suppose one
place for /bits/ 64 and one for <freq>.

Also full stop (.) is missing at the end.

> So let's increase the limit to 32 which should be enough for most platforms
> (hopefully).
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/opp/opp-v2-base.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> index 47e6f36b7637..e2f8f7af3cf4 100644
> --- a/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> +++ b/Documentation/devicetree/bindings/opp/opp-v2-base.yaml
> @@ -56,7 +56,7 @@ patternProperties:
>            need to be configured and that is left for the implementation
>            specific binding.
>          minItems: 1
> -        maxItems: 16
> +        maxItems: 32
>          items:
>            maxItems: 1
>  
> -- 
> 2.25.1

-- 
viresh
