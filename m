Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9CC5F34CA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 19:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJCRrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 13:47:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiJCRqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 13:46:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68AAA3A48F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664819193;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MtA+3tltQ/Pu6j9UWBtNmmPHCMxWKl2rTYLhck5QDqQ=;
        b=AGMmy/0Odj9NKqfEXgtvwEsnkXSD8StJEtyfTKms1SoqjE2RUlhCyI9NPQlBBKRZjcIkoL
        Xf27K0YL35hhzerTUwHoBBmKqJm0iRkeYMo28AFDT87sk3kkBc1Z0JXQzW0xo05Xhi1+h9
        a/D3311MzKZkm0DEMLtHGb8VWfMhvnM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-18-kXqiK6D2N4uBKOx15IzbVQ-1; Mon, 03 Oct 2022 13:46:32 -0400
X-MC-Unique: kXqiK6D2N4uBKOx15IzbVQ-1
Received: by mail-il1-f199.google.com with SMTP id k6-20020a92c246000000b002f80993e780so9033489ilo.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 10:46:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=MtA+3tltQ/Pu6j9UWBtNmmPHCMxWKl2rTYLhck5QDqQ=;
        b=o0rzONSdK742SqMY+uh1oNT/IhXVflne13BfoQufkI9jJ/WQnyrO3BVCt2tEVeMMq9
         GF/12MQaf2k77bGrfXnFxCURqvHOcrAZ2rTHKRCfSGqBDq3iZG84fL4nUogY3WcjYpek
         w/H+BO17U2LMUOA+rGIDfODkyG4HDjyjPslV5L+g4D1e/2wEMyQ7B5a4xX+2sF3yOMDE
         jq+bt3C5cHhWE5kBV/yS2tJy0Dl67gYvCLTCarBGiRxZhnrrKfb7DuyVasZkmyGu1wkT
         v9WLNFn+Ji7YRGDi+GJ9W9Vta893FxWvPFJ6PiDkR6loGpqiZZ6R03cy20H1+bDluoA3
         +Q+Q==
X-Gm-Message-State: ACrzQf26QQLzypUybw1HPybfHhDc7FWsOu/Au9Tol7m7f1HOAupOChiD
        LgShmHETPtZzdK4po/I1YzvD+ALk2bc3Hpme7LV8hrU6As9aFaEmbALlAgpfbPxqQkaNYsQWvEA
        jksmU9wrYNfRdU3iqxPH7YT29
X-Received: by 2002:a05:6638:1655:b0:35a:6ee2:402d with SMTP id a21-20020a056638165500b0035a6ee2402dmr10800148jat.138.1664819191534;
        Mon, 03 Oct 2022 10:46:31 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5FifwWL5T7TEBYUUsogaV1ix6DKF2KWcbNDZOJeBuvpP5FL6MipfFb6zDzBulpSqPkZReg9w==
X-Received: by 2002:a05:6638:1655:b0:35a:6ee2:402d with SMTP id a21-20020a056638165500b0035a6ee2402dmr10800135jat.138.1664819191364;
        Mon, 03 Oct 2022 10:46:31 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b002f50fb937f0sm1339298ilq.27.2022.10.03.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 10:46:31 -0700 (PDT)
Date:   Mon, 3 Oct 2022 13:46:29 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Message-ID: <Yzsf9eoH2A5Xr3bS@x1>
References: <20220915141601.18435-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220915141601.18435-1-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 04:16:01PM +0200, Johan Hovold wrote:
> The size of the UFS PHY serdes register region is 0x1c8 and the
> corresponding 'reg' property should specifically not include the
> adjacent regions that are defined in the child node (e.g. tx and rx).
> 
> Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This fixes an issue that I'm seeing on the QDrive3 in next-20220930.

Reviewed-by: Brian Masney <bmasney@redhat.com>

