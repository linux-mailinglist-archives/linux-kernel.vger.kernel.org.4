Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10BD64B808
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiLMPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLMPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:06:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332512183F
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670943923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R9+NLd3jxdSYaQWEDRounaRV4J5+VnhfuGCpFV9Scak=;
        b=XHVNY+ERZUvOgO9l6SWkVcD7ooS34kWraas5qtD6yqmZoeym+MgeiNvDAqzu4gjf8B1tEb
        L+n9t5BEs597LOtwLrzpqOJo51SsPilGC/12CJZ2RhYVr7C4aDvopCmX8Ei3ArrcwCrHqU
        +RxhSizqdx9DLM4huZCzy7osmLdU/YE=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-EJbZO--yO96MM3yXwM5p2Q-1; Tue, 13 Dec 2022 10:05:22 -0500
X-MC-Unique: EJbZO--yO96MM3yXwM5p2Q-1
Received: by mail-qk1-f198.google.com with SMTP id bq13-20020a05620a468d00b006fa5a75759aso17944918qkb.13
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:05:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9+NLd3jxdSYaQWEDRounaRV4J5+VnhfuGCpFV9Scak=;
        b=xDfV/mZIrmuyt+8R0QoRZUkA8zzk/0whN2Ke/AkMb+ECJg3lBQ73gd2JD3J3Z9FHIG
         P7HMFKIIPQ873+iP07RNvHOZTO175RPviQXZ5cJwynkGztit7DsqJ/4WOrIsZIcpgdNl
         DuPxqkKJ1AgbvYH5BJDikci4RyHqT24UKGCn4/1pvfXLIxWlfHUKzATgVbb2si2NkbEO
         1pS5IxXwqtfNjwyZdmCydu/o8T4dWSh/l9U+Af6xRtbYEktgiH+ETZOjn0sMimM5YQKR
         a6eM3fEU1A1+6K/hTG0vyah9yc+tirassBUO4ptB+DvCdg9Jc9HZe+uShzsOkuZ9eNMO
         PP+w==
X-Gm-Message-State: ANoB5pnNNmVLTRexDDVZrAEdlPxWAlEJ7vbS07INtE3MfxezPVKtpbbP
        IC1vF8qJ56c3AWIHpH2iovjgf4Z3XY2HiSMwhe7aaT0MgXttj+KkEdXe8xmG1nFTTvr0DIx9dk7
        uH9GXoKcpZBb++GulVTEzygd6
X-Received: by 2002:a05:622a:4ac6:b0:3a5:2d37:eec3 with SMTP id fx6-20020a05622a4ac600b003a52d37eec3mr29577492qtb.4.1670943921484;
        Tue, 13 Dec 2022 07:05:21 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5luC77xo0MLHMxsKzx3NKc6Ahtqb9hI1942FD7kdl7LQrB5D6dHNM0CS1pPXwf5qk8fkH5Iw==
X-Received: by 2002:a05:622a:4ac6:b0:3a5:2d37:eec3 with SMTP id fx6-20020a05622a4ac600b003a52d37eec3mr29577465qtb.4.1670943921283;
        Tue, 13 Dec 2022 07:05:21 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id p10-20020ac8740a000000b003a4f435e381sm14250qtq.18.2022.12.13.07.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:05:20 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:05:19 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5iUr0V4QYoAa4Du@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5iSDehp72mQPc+h@hovoldconsulting.com>
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

On Tue, Dec 13, 2022 at 03:54:05PM +0100, Johan Hovold wrote:
> Note that the node is labelled qup2_i2c5 and not qup_i2c5.
> 
> That is, the QUP nodes are labelled using two indices, and specifically
> 
> 	qup2_i2c5
> 
> would be another name for
> 
> 	qup_i2c21
> 
> if we'd been using such a flat naming scheme (there are 8 engines per
> QUP).
> 
> So there's nothing wrong with how these nodes are currently named, but
> mixing the two scheme as you are suggesting would not be correct.

OK, I see; that makes sense. I'll drop this patch in v2 and fix up the
new nodes accordingly. Thank you for the explanation!

Brian

