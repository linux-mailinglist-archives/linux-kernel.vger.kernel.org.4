Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 871046106FE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 02:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiJ1Axb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 20:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbiJ1Ax3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 20:53:29 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 519A0A3F73;
        Thu, 27 Oct 2022 17:53:26 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r61-20020a17090a43c300b00212f4e9cccdso8364960pjg.5;
        Thu, 27 Oct 2022 17:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BTLDGG1JfCbcJjNOZkikvC8f7AaHQJjjKAzvQey3fqs=;
        b=YnAdcvuXVzFEKYlYf+iaNqeO54C1FKncfcUPJNMcb9fT3kuLTBm1UToeqsx0dAmz3w
         YIU1Kk3Af0qMH7kR5YnVFhLLbyG1FR3Z7PuKnPUyVzfL3LtPVEs5BLP3+tHdHJcc8dkh
         l1N2kRSl+QuKM3DEayZicbnVHgQqQKTjGRJgVRsV45fV5suhfQpIm/6z8LKgrYu7EnTb
         po3Mtx06BVaoGcxu8k3H+tovzxKoKxzg5V2gf3LmWmdwGokt1y/pPUO3CsYWoZyHz63l
         gXwoQWf3wkd+Bvcyr7Cavb1POamSpm1W8P6XR7A/XjJOGxm1XHl4rJ4c6KH/dpxj0eCc
         dndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BTLDGG1JfCbcJjNOZkikvC8f7AaHQJjjKAzvQey3fqs=;
        b=K4w4GnidSTQPrAsWtnI0XJ7/K/2gyrQarNd0RssVC6kxBx+YixBtCcl9YuO6q797He
         n7d8/h62Aibk0nL88KYLIBrDYClhkoHkD0tQWdAEIXJINIJjRH8qqc0L/sThLR2fLnNp
         9vADgq9Pu/qxt4k+S+TKiO3Ajea7O3NFg2K5uyK26US6TKdIC3odTn4CbAMzZVqSrI8C
         cgWa4hhcU7vty6YFQ8IEI9W1LY3s0fUJM63hu7CusRTn2H8m56T892uQAPpt8NJoInzs
         j9iyZzJxK2qpLIEFocxralbiGistcPTNZ8h5RK5ywKAhAh5rnNMMXKW4JCWZssJ1e1Q8
         LT3Q==
X-Gm-Message-State: ACrzQf2iLxWow8fW3KZ7vwN+0AIwpGkc2HSmYeB+p606dtnN7ZUUyMaM
        U0YsgHtoGfkqp1JLtm8Gm3wttTHpGIk=
X-Google-Smtp-Source: AMsMyM4MlDLg14I1SS17xTsY8wvg4fC9kOv0osvlxi1GA2wcy5gtR5CrX6S1qEjfxC6MYC0rgq4mEg==
X-Received: by 2002:a17:902:f710:b0:184:7a4c:fdc1 with SMTP id h16-20020a170902f71000b001847a4cfdc1mr51902574plo.27.1666918405546;
        Thu, 27 Oct 2022 17:53:25 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:ea9a:801b:ed52:2db1])
        by smtp.gmail.com with ESMTPSA id a17-20020a170902ecd100b00176b3d7db49sm1843475plh.0.2022.10.27.17.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 17:53:24 -0700 (PDT)
Date:   Thu, 27 Oct 2022 17:53:21 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     neil.armstrong@linaro.org, Bjorn Andersson <andersson@kernel.org>,
        Satya Priya <quic_c_skakit@quicinc.com>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Andy Gross <agross@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-input@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 06/11] dt-bindings: input: qcom,pm8921-pwrkey: convert
 to dt-schema
Message-ID: <Y1soAaUqIHb6+I8T@google.com>
References: <20220928-mdm9615-dt-schema-fixes-v4-0-dac2dfaac703@linaro.org>
 <20220928-mdm9615-dt-schema-fixes-v4-6-dac2dfaac703@linaro.org>
 <Y1o5hYAnBuf1akJ9@google.com>
 <e8f53c8a-2842-9e6e-75bd-e099db3fe6f3@linaro.org>
 <68f6d58e-8b7a-1032-4a3d-c4c74b82d111@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f6d58e-8b7a-1032-4a3d-c4c74b82d111@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 08:43:20AM -0400, Krzysztof Kozlowski wrote:
> On 27/10/2022 08:39, Neil Armstrong wrote:
> > Hi,
> > 
> > On 27/10/2022 09:55, Dmitry Torokhov wrote:
> >> On Fri, Oct 21, 2022 at 11:06:42AM +0200, Neil Armstrong wrote:
> >>> Convert input/qcom,pm8xxx-pwrkey.txt to YAML, and take in account that
> >>> the PM8921 pwrkey compatible is used as fallback for the PM8018 pwrkey.
> >>>
> >>> Reviewed-by: Rob Herring <robh@kernel.org>
> >>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >>
> >> Should I merge this through my tree or you want all these changes to go
> >> together through some particular tree?
> > 
> > I have no preference,
> > Krzysztof will you take it and prepare a branch to Bjorn ?
> 
> No, I did not plan on doing it.
> 
> Dmitry,
> Please grab it (assuming there are no dependencies).

Applied, thank you.

-- 
Dmitry
