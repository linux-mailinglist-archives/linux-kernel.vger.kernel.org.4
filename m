Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD9C665EC2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbjAKPHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjAKPHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:07:13 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E62DA
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673449584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Myn34I1yOWHLCCRT341CKLbjbol25HP/clSmV2zQUVA=;
        b=bEQbg/RQV6N+2+IjzWrRiMMhvlydtfhMsU4YUAJRgmgc0UL7nS7KB0Njc7qvdk5tRK0I2Y
        0E96nbB5DCPyMM8KTAPBQ38n9Uf8JWSVMo/dkM3qlggaUbtMR54Ca0qlZsIjJuIgaTfX0F
        GJV5nAONSobTRZ1EfCmbn5TTxpo+CsM=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-541-UOQIJCNGNS6zTz97gFFcqA-1; Wed, 11 Jan 2023 10:06:22 -0500
X-MC-Unique: UOQIJCNGNS6zTz97gFFcqA-1
Received: by mail-oi1-f198.google.com with SMTP id 2-20020aca2802000000b00363b17651dbso4247407oix.10
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:06:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Myn34I1yOWHLCCRT341CKLbjbol25HP/clSmV2zQUVA=;
        b=IlMKCd+m/Y/hQIz/Wes8hajua2Qnx652bWhbrwkrCgf2gHpcK7V+OMWYJjadWp4iQq
         yHnR/goeNM4snIHIzD+ChzMeYSSTWFHuoVfKunaSA4y1azCcObky7WtSBkJU1nmz4bfZ
         Hyg7/68/NTzm1UQsibI9g23xV7t+0oXqEMbep+gp0+dc1MqbKSw6ejWpAYfFljuYufVQ
         FBGxf7XYpdt05r5YgkKDM/XsnnzlKABk1jnQCgM2SBCfvsqAJ+ImeoRt8xu4HTOiXJSo
         PJV3Znau7WU3g0/e7p4VGeJobmAH0X6msDG4N+HCzISwhiD15t7xCCkwnZ/CKFn2Mkwp
         8pjQ==
X-Gm-Message-State: AFqh2koOa3kDOkXBkTvQO3yyPBP9dPh/92BYSWMIR+nULP8tcloKXgVx
        3jC+QMhttQ4ZnokIX1vBFSpvpNmbJK5jpwSVKDsAOe+/j84HquCDHlKflnwUY1DrOGNPExiE8uu
        hvY2QiJJe61h9TTWCrC0y6gkr
X-Received: by 2002:a05:6870:c03:b0:14c:705e:be8c with SMTP id le3-20020a0568700c0300b0014c705ebe8cmr35115961oab.2.1673449581123;
        Wed, 11 Jan 2023 07:06:21 -0800 (PST)
X-Google-Smtp-Source: AMrXdXu8Uy2KPHVWIfK+X7gApwWSrPqKOZdmUIpae+29hH+FsKTAo9JPuf1PRGJTkNMy5Ms/1p31kw==
X-Received: by 2002:a05:6870:c03:b0:14c:705e:be8c with SMTP id le3-20020a0568700c0300b0014c705ebe8cmr35115934oab.2.1673449580634;
        Wed, 11 Jan 2023 07:06:20 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id s15-20020a05620a254f00b007056237b41bsm9100652qko.67.2023.01.11.07.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 07:06:20 -0800 (PST)
Date:   Wed, 11 Jan 2023 10:06:19 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sa8450p-pmics: add missing
 interrupt include
Message-ID: <20230111150619.2g737hldisyhceri@echanude>
References: <20230111082331.20641-1-johan+linaro@kernel.org>
 <20230111082331.20641-2-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111082331.20641-2-johan+linaro@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 11, 2023 at 09:23:30AM +0100, Johan Hovold wrote:
> Add the missing interrupt-controller include which is needed by the RTC
> node.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Eric Chanudet <echanude@redhat.com>

Nit: sa8450p-pmics -> sa8540p-pmics in the subject. It was mistyped in
the commit renaming the file unfortunately.

-- 
Eric Chanudet

