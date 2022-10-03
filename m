Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3815F364E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJCTaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJCTac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:30:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60652ED52
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1664825431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlBYJXSMKfnaBFHLLoeXVDsNHkkt4H3c545HLAUa1Nk=;
        b=NTs5EqnXB3MlO05O7pQ8lRxrUSqpZJFOENUAAk/z4Uj8kW/qe4YH3JW+ikC3oLyhyqb5gX
        KC+Lgfk18cgU9/dQ3u4OnLcLb3gQFQ0dEd5n8TdYeNq9GDeFGcTLYpN6zZjY/ehHwgDrZ9
        zkvknab28/Krr0x7W/JptFmVsXqqmGE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-49-4AFKI4S4Nu6E9eBAcVkObQ-1; Mon, 03 Oct 2022 15:30:24 -0400
X-MC-Unique: 4AFKI4S4Nu6E9eBAcVkObQ-1
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-1329ca3a715so540982fac.23
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 12:30:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UlBYJXSMKfnaBFHLLoeXVDsNHkkt4H3c545HLAUa1Nk=;
        b=nVc6Zm6fSepP6JErmlKZKOEYx54TxvVAhaQl6KAaES9tas3yR7Z/0OwPXqFA6iI3nc
         37Q4IwopPm+hmJcpJC73PAx4r4f4gnD6V4v3xPcdq7SUcLMDmKDXbYns5sSz8PfwLsnO
         1nYtR50qqkZL3813Kdrl2w0S+RIGnraxq0eqY7DRGPhrP8oZLD4tOYqgeVwWeaSjiSwd
         qecqQOnh9qO+fzvehaVit2VJErvyaG4lmJBWnK+88eefITReaMw64tqFzFi3EiiUSoKn
         faloDz+jLhSick410au1d+G4xQFSySHQlOJ5IcwHM3Fb/qwtmlYuF9WuHZASVRLHA2+M
         Cebg==
X-Gm-Message-State: ACrzQf0hQ6ysu/PQl7+Xr6h2beQ4aV98drW7Z9DjiVe87TaUJgdMibBM
        sli3uhYoi4EljUZTqt+xDWZ5ZltcH9O3mNCABWQttbZKKe1c9qFRJjR1aROyCGt/+ZIQOgjuBzm
        OBTdx1OlSEVNGPyJdxhSNrzpV
X-Received: by 2002:a9d:61c1:0:b0:65b:d7e7:aba9 with SMTP id h1-20020a9d61c1000000b0065bd7e7aba9mr8239961otk.148.1664825424165;
        Mon, 03 Oct 2022 12:30:24 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5tdFgyP7y22kEo0MjOpgPitAYHYr6fdAe3hwamA3lYQ+GhmpTbSH4G93rr4owvBApnmyT+hA==
X-Received: by 2002:a9d:61c1:0:b0:65b:d7e7:aba9 with SMTP id h1-20020a9d61c1000000b0065bd7e7aba9mr8239952otk.148.1664825423955;
        Mon, 03 Oct 2022 12:30:23 -0700 (PDT)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id x1-20020a4a3f41000000b00432ac97ad09sm2229516ooe.26.2022.10.03.12.30.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 12:30:23 -0700 (PDT)
Date:   Mon, 3 Oct 2022 14:30:20 -0500
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Brian Masney <bmasney@redhat.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix UFS PHY serdes size
Message-ID: <20221003193020.mxt6xumjaguilgli@halaney-x13s>
References: <20220915141601.18435-1-johan+linaro@kernel.org>
 <Yzsf9eoH2A5Xr3bS@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzsf9eoH2A5Xr3bS@x1>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 01:46:29PM -0400, Brian Masney wrote:
> On Thu, Sep 15, 2022 at 04:16:01PM +0200, Johan Hovold wrote:
> > The size of the UFS PHY serdes register region is 0x1c8 and the
> > corresponding 'reg' property should specifically not include the
> > adjacent regions that are defined in the child node (e.g. tx and rx).
> > 
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> 
> This fixes an issue that I'm seeing on the QDrive3 in next-20220930.
> 
> Reviewed-by: Brian Masney <bmasney@redhat.com>
> 

Tested-by: Andrew Halaney <ahalaney@redhat.com> #Qdrive3/sa8540p-adp-ride

