Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3B568195C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237983AbjA3Sgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237807AbjA3Sgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:36:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDA07AAB
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675103736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Lt1BSrHjqGxTuQATN1FHlMVFUULtc3t75DalFc1DJkQ=;
        b=fz5yxH4r+1zcsNy7z44xpI2WNdxoSQoDfDFDk4ZoIuQ0xyTMZubhBfWuw0Nqge9a+e16ys
        KXsU1GFv7HpWUuJIFOhbZNAKyr+RNuGMNVI1c/0YeCt/bitLRiD/R6hlOtALYu5Vo43Z0l
        7AxtdG/NoAIMT3GnZvZ0+MwSKa0+65c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-621-BTM1rQAEP1iXbFQMxWzPKg-1; Mon, 30 Jan 2023 13:35:35 -0500
X-MC-Unique: BTM1rQAEP1iXbFQMxWzPKg-1
Received: by mail-qt1-f198.google.com with SMTP id cr22-20020a05622a429600b003b694a9f291so5365680qtb.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 10:35:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lt1BSrHjqGxTuQATN1FHlMVFUULtc3t75DalFc1DJkQ=;
        b=yy5Fgrm9GvLHNuuxi7QvY+UA8JLtf41jhxOsDRw/UK9D+V409E3f14wt3igHQK8m4R
         sembF7d4ZGdHzfbi7CMikhoSH8smhCIvlROZXhGT5sYcNmVfF+j1l/MYtAb+PKoO/v9v
         9PvvBaMEcyUqSml08O3iybPzS+XBK7sLwo7NO20IL6YJQBbyuCYO7HGFnlu72ZEXH+HS
         aCweTYkzakbo2jR8pW8y5zCVHCQe9YxbPEfEE7jyAdluD6BIHettfso22/7HFRzw0dNw
         08TEZuvAFqa5mB7ABW+sHnkFEY3kNYOMoIK0wgv0JUpxIm5fn3WjV2QTK1doc+mUKx1G
         Hbtw==
X-Gm-Message-State: AO0yUKUE+OLRGup+PbPVd8Pez1ZOOFg8+UgZlDJxibU+bQYh9K/MZePJ
        0CrDDuQw/hEtlZLfnzHhuYQsQSc4O1uZ52jx3ZQ6kfPxnR5hQdejrTXyoi13I07FMnW8IPegZzq
        kwKuqcddXXI1LT0QnOh9ajIY/
X-Received: by 2002:a05:6214:5086:b0:537:7335:144f with SMTP id kk6-20020a056214508600b005377335144fmr33146799qvb.24.1675103734843;
        Mon, 30 Jan 2023 10:35:34 -0800 (PST)
X-Google-Smtp-Source: AK7set/FPPbNpiUIaqVWHe+TRyIn3OsGXWnrIppmyHYJIz3KP+w5i9mRZLJBY8tMr/xBanz2UMPsXg==
X-Received: by 2002:a05:6214:5086:b0:537:7335:144f with SMTP id kk6-20020a056214508600b005377335144fmr33146764qvb.24.1675103734613;
        Mon, 30 Jan 2023 10:35:34 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id o4-20020a05620a0d4400b006ea7f9d8644sm8448062qkl.96.2023.01.30.10.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:35:33 -0800 (PST)
Date:   Mon, 30 Jan 2023 13:35:32 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sven Peter <sven@svenpeter.dev>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sc8280xp: Enable BT
Message-ID: <Y9gN9IKAr6y3xzh7@x1>
References: <20230129215136.5557-1-steev@kali.org>
 <20230129215136.5557-2-steev@kali.org>
 <20230129215136.5557-3-steev@kali.org>
 <20230129215136.5557-4-steev@kali.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230129215136.5557-4-steev@kali.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 29, 2023 at 03:51:29PM -0600, Steev Klimaszewski wrote:
> From: Bjorn Andersson <bjorn.andersson@linaro.org>
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>

You should also add your Signed-off-by. Also the title of the patch
should be updated to say define uart2 instead of enable BT.

> ---
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> index 122afa03bb40..2d98687fb1ea 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> @@ -1244,6 +1244,20 @@ spi3: spi@98c000 {
>  				status = "disabled";
>  			};
>  
> +			uart2: serial@988000 {

This node needs to go after spi2 instead of spi3.

Everything else looks good to me.

Brian

