Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6A673A8B0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231475AbjFVS7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231442AbjFVS7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:59:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85F1FF5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687460340;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Pa+oZK/sS3e2gfb7B5cDcIjFykC7j8FP/PxBLFuYWZ4=;
        b=BWrSGxUCTbEOKX0atpo0y8+5jk6/UCrEECF0YdPYdg0j50bKIgxE9CeJWUSnIE3IXcNDFt
        ru7uGDLwcKXnnKbLFi0f+DnTRpXj6PBZFyGT6g21+5joj7+/QW8wyOjkdRZjA9Pkf7QrcX
        RGKPxakyEbLynRhwjjBq+dzt9E1MuAw=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-k9YelOA-PA2JmDD8aXyOJg-1; Thu, 22 Jun 2023 14:58:59 -0400
X-MC-Unique: k9YelOA-PA2JmDD8aXyOJg-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b4541c5cc5so4421435a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460338; x=1690052338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pa+oZK/sS3e2gfb7B5cDcIjFykC7j8FP/PxBLFuYWZ4=;
        b=DI59lQkdH3BjCTxdkGOC0r4Qz41oRkw2mZmM/UOR3XGYclPE6voocZaJ45kD7N/D3w
         uurqc1cYi+ssoIKLYXZrXxhWBOCyqi2C+gGa2njCcO+oLq3/1Ng3MAroJZoZKrCo0bKe
         JATaqQggCgcWIafSZH+1+apItVToYy6aemFmIOfdA96L3xqTAMYF1HqXs/XPVb1VaJxm
         U73sBjGLJfbiMeN/PFg4NFZf+L3G+bjcM17JZe/qQUBITXH2V0N9eMgIgIP1kEzrmnZq
         pM6+knNXmB0N61CgUKLAc2ZXoOAYdLrokGq0N6ktxANrMwkmvNYqCJh2m8BwGjocGIQg
         q7wA==
X-Gm-Message-State: AC+VfDzV0/tY8u1IYub6btplCMb0l+nugosx8gRXgtz5+zwX0/TiW5m5
        +bdx43kVtm1O+02rRIDSzkYId3Kkx67IefgWScSVF8S5Ne1x+4d88qZn+FMpJmZC2MBl9erW7l+
        ylQpBoph+/NBm7XbHG02CYeoF
X-Received: by 2002:a05:6830:104e:b0:6b5:eaeb:63ba with SMTP id b14-20020a056830104e00b006b5eaeb63bamr3193849otp.27.1687460338352;
        Thu, 22 Jun 2023 11:58:58 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4xtiYm1AlCWg8QeHKLFR3de2AQr2M0emZBuj2HLlTxb3l4GMDPlkysba03FRcXQD9vQEGY2A==
X-Received: by 2002:a05:6830:104e:b0:6b5:eaeb:63ba with SMTP id b14-20020a056830104e00b006b5eaeb63bamr3193839otp.27.1687460338161;
        Thu, 22 Jun 2023 11:58:58 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::f])
        by smtp.gmail.com with ESMTPSA id t15-20020a9d66cf000000b006b71d22be29sm363209otm.18.2023.06.22.11.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 11:58:57 -0700 (PDT)
Date:   Thu, 22 Jun 2023 13:58:54 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RESEND PATCH v2 0/5] arm64: dts: qcom: enable ethernet on
 sa8775p-ride
Message-ID: <20230622185854.57f7qem5w3ds5nzi@halaney-x13s>
References: <20230622120142.218055-1-brgl@bgdev.pl>
 <20230622184422.4e72vtqk53nnx42g@halaney-x13s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230622184422.4e72vtqk53nnx42g@halaney-x13s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2023 at 01:44:22PM -0500, Andrew Halaney wrote:
> On Thu, Jun 22, 2023 at 02:01:37PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > 
> > Bjorn,
> > 
> > Now that all other bits and pieces are in next, I'm resending the reviewed
> > DTS patches for pick up. This enables one of the 1Gb ethernet ports on
> > sa8775p-ride.
> > 
> > Bartosz Golaszewski (5):
> >   arm64: dts: qcom: sa8775p: add the SGMII PHY node
> >   arm64: dts: qcom: sa8775p: add the first 1Gb ethernet interface
> >   arm64: dts: qcom: sa8775p-ride: enable the SerDes PHY
> >   arm64: dts: qcom: sa8775p-ride: add pin functions for ethernet0
> >   arm64: dts: qcom: sa8775p-ride: enable ethernet0
> > 
> >  arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 109 ++++++++++++++++++++++
> >  arch/arm64/boot/dts/qcom/sa8775p.dtsi     |  42 +++++++++
> >  2 files changed, 151 insertions(+)
> > 
> > -- 
> > 2.39.2
> > 
> 
> Tested-by: Andrew Halaney <ahalaney@redhat.com>
> 
> note, I did uncover a bug in stmmac (imo) wrt unbalanced calls to
> serdes_powerup/serdes_powerdown() which I plan on trying to fix shortly.
> 
> Not really related to any of the Qualcomm specific bits though. This
> looks good to me.
> 

Bart already sent a fix!

https://lore.kernel.org/netdev/20230621135537.376649-1-brgl@bgdev.pl/

Thanks,
Andrew

