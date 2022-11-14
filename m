Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED196286D9
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 18:20:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiKNRTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 12:19:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238187AbiKNRTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 12:19:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A434F21A5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668446309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4sNjUQT2c1OdRFj9eZzZDLaDp00UwMzWHy/U38jOaTo=;
        b=hqvDuJspwSf11BYuOk9hXy5/i9p4jwTL73wT9++TzzNO5tp89A8fMpMyVvo89CN3XRbLuE
        aG3STGNTYYKZFZ6pDNhvq1I1AJ5UnFOPKFmXYZg51iD/iOgEIn6hhZjurkStSvxHgQtBVw
        VCuKIFwSd3Bn0Jv65rSltkoPetLe7uo=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-436-UIfD9TolNCCMzsip1K00jQ-1; Mon, 14 Nov 2022 12:18:27 -0500
X-MC-Unique: UIfD9TolNCCMzsip1K00jQ-1
Received: by mail-il1-f198.google.com with SMTP id s4-20020a056e02216400b003021b648144so9709733ilv.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 09:18:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4sNjUQT2c1OdRFj9eZzZDLaDp00UwMzWHy/U38jOaTo=;
        b=fzwJJ31FD4F7dnMxeE11bfXhyKhwdV9tbEKAVpQN5wMMhs+MNmHQY5IEU1o268vHFt
         0hsng3cNIWAKXzZq+8p4rjgIEH2Ep7hlNdXli3VJSGeieioCBdx6XUw+R8R/V7gd5Q1L
         yktPyei5Y8fe77Z16cMZKZoQzSj7w+lQKiaT9jvKYKTsaiI/O4blNX09WwWIGPhExOfj
         Bj1Ag2wRwsdnGyavVr9QA5yIk35G+yNOUIxKzRjSGLRBUZb63cv3lC786dKDJiXDKSai
         uIy/nsqAKwQg8CNuVQHDKhSXJmbHTYQuXPELhQHi49iYyxrcNoqTVGNr9SZV0NjiMUMk
         N+QQ==
X-Gm-Message-State: ANoB5pn7/DkyyaErtGcaOVZm8v6FNN4wE21HSxZBZSc+/oNfvBpIYnxq
        T3Asoi+Bd6QJ+ufXDmMOq8SOHJ1VMoCn3AM09gBFbG4sjo6yC5Ah7/k1rrV1RcRBdWfigLkjYdU
        Vu+qGx64+zIpNSBKZcmw7K9dm
X-Received: by 2002:a92:1a4e:0:b0:302:4ac4:c168 with SMTP id z14-20020a921a4e000000b003024ac4c168mr4594615ill.246.1668446307007;
        Mon, 14 Nov 2022 09:18:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7LGLmRIZsZFbWtYDSEh/xc5RlcPxmrQMUwzytaM0mhnZf4fylJqnqNvBpB6dpWE938zjwXsQ==
X-Received: by 2002:a92:1a4e:0:b0:302:4ac4:c168 with SMTP id z14-20020a921a4e000000b003024ac4c168mr4594603ill.246.1668446306813;
        Mon, 14 Nov 2022 09:18:26 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id k5-20020a023505000000b003709af661b8sm3570117jaa.51.2022.11.14.09.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 09:18:26 -0800 (PST)
Date:   Mon, 14 Nov 2022 12:18:24 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: qcom: sc8280xp: update UFS PHY nodes
Message-ID: <Y3J4YGPsn8D9wzny@x1>
References: <20221104092045.17410-1-johan+linaro@kernel.org>
 <20221104092045.17410-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104092045.17410-3-johan+linaro@kernel.org>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 10:20:45AM +0100, Johan Hovold wrote:
> Update the UFS PHY nodes to match the new binding.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

This is needed in order to boot the sa8540p on linux-next-20221110.

Reviewed-by: Brian Masney <bmasney@redhat.com>

