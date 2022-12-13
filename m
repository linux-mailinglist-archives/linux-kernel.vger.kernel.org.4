Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E4E64B917
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 17:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiLMQAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 11:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbiLMQAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 11:00:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C71166
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670947192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VKfcx7pkq8LkHwoqbOrspcVXGem6hw74j7W+b/DBJjE=;
        b=eHv9qLIo7xoVVUnfoPMZUONJdUxWNAwr+OTBMzr+ldlBSQkIfS3BAseZK+TviqjZ3UKOxZ
        bLRyVc0Snv6a4jZw/gZUylYNNtw81PhFtTzGnn5RaLkUPdOXwwYxKz2lvG6GNmk0MC8F97
        8tmGFziaa+TEb+d0k2YWjH3/7j/G2Bc=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-358-UvEKJ0rbNK2Fe6bWoxqyPA-1; Tue, 13 Dec 2022 10:59:50 -0500
X-MC-Unique: UvEKJ0rbNK2Fe6bWoxqyPA-1
Received: by mail-io1-f72.google.com with SMTP id j5-20020a5d9d05000000b006e2f0c28177so2132908ioj.17
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 07:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VKfcx7pkq8LkHwoqbOrspcVXGem6hw74j7W+b/DBJjE=;
        b=eC6p3K00zgD8oofRPaytt+1E0EhixiAZVR0X4JePx7MPyxtaYQJoB1xuCz0tnxxmIe
         qw72xMSlCG2veEFmMpJncHAd8vMhG4+4j6g0U787gEL5tgt6wfncN2+eNEvN6f4LgCuH
         MAGjSXdetQj617c4V3XIcopEW1bW68rjMVvgK1B7ttMgePsQdsJuyId3C5MQShEBQ7+h
         Z25dpmCy69zbklELMBRuIMV3RV7HB0d6ddTGLq+rm9yEhSG6BoI4bAgxcghjsgZO3iRu
         XHnBPPKqp3puHfr+V/g0CZaDcAnoVb3j01BFkZbx/UmFyVe7I/rkw4tUfA8rDYDfi5FG
         oWgA==
X-Gm-Message-State: ANoB5plGNAV0FZJhVsmonBbO3o48DHtQZnB4wE8xLE1YBR+fLnn7jhvm
        M1XCMo/ZHS7Q1vdwAPnemEOMes0JkYAlufxnqwf2odLozsZ4JpRzTFO4r+zW7xietqbfaEWKAnZ
        1AYPajyjsvCwz0mo62aBhmxzO
X-Received: by 2002:a5d:8ac8:0:b0:6bc:d712:8bcd with SMTP id e8-20020a5d8ac8000000b006bcd7128bcdmr10964571iot.21.1670947189884;
        Tue, 13 Dec 2022 07:59:49 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4RyM/tNgJp/BidYuSNp90JmxZFBwrBqK2Yha1hSQQq+15GZXjPHmkGKGhC7C6qWogwTcmFAA==
X-Received: by 2002:a5d:8ac8:0:b0:6bc:d712:8bcd with SMTP id e8-20020a5d8ac8000000b006bcd7128bcdmr10964554iot.21.1670947189666;
        Tue, 13 Dec 2022 07:59:49 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id q29-20020a02b05d000000b00389e1f5751asm966242jah.65.2022.12.13.07.59.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:59:49 -0800 (PST)
Date:   Tue, 13 Dec 2022 10:59:47 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        johan+linaro@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahalaney@redhat.com, echanude@redhat.com, quic_shazhuss@quicinc.com
Subject: Re: [PATCH 1/4] arm64: dts: qcom: sc8280xp: rename i2c5 to i2c21
Message-ID: <Y5ihczgZs1RBJ0IN@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-2-bmasney@redhat.com>
 <Y5iSDehp72mQPc+h@hovoldconsulting.com>
 <Y5iXjTQnEtMCZy7W@hovoldconsulting.com>
 <114e960f-3b63-8c8f-9d4a-87173049d730@linaro.org>
 <Y5ibG29yKQgD54Dn@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5ibG29yKQgD54Dn@hovoldconsulting.com>
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

On Tue, Dec 13, 2022 at 04:32:43PM +0100, Johan Hovold wrote:
> On Tue, Dec 13, 2022 at 04:29:04PM +0100, Konrad Dybcio wrote:
> > On 13.12.2022 16:17, Johan Hovold wrote:
> > > It appears sc8280xp is the only qcom platform using a qup prefix (even
> > > if some older platform use a blsp equivalent), and we're not even using
> > > it consistently as we, for example, have both
> > > 
> > > 	qup2_uart17, and
> > > 	qup2_i2c5
> > > 
> > > (where the former should have been qup2_uart1).
> > > 
> > > So either we fix up the current labels or just drop the qup prefixes and
> > > use a flat naming scheme (e.g. uart17 and i2c21).
> 
> > Oh, I didn't notice that! I suppose sticking with i2cN as we've been
> > doing ever since i2c-geni was introduced sounds like the best option..
> 
> Yeah, sounds good to me.

This makes sense and I'll fix up the existing geni nodes and my new
nodes in v2.

I noticed another inconsistency with sc8280xp.dtsi compared to other
platforms. I left off all of the pin mappings in sc8280xp.dtsi and
added them to the sa8540-ride.dts file since the existing sc8280xp.dtsi
file contains no pin mappings. Other platforms such as sm8450.dtsi,
sm8350.dtsi, and sm8250.dtsi contain the geni pin mappings. My
understanding is that these geni pins are fixed within the SoC and
don't change with the different boards. Should I also add the geni
pin mappings to sc8280xp.dtsi?

Brian

