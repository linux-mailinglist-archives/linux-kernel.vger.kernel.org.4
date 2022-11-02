Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A35B616CB1
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 19:41:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiKBSlf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 14:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbiKBSlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B6372CDF2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 11:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1667414431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z6U2QWI3L7CELeN2uR9v9BKzosx2j/rMnyai3sfNG/I=;
        b=Jf2A6/ikh1aa0WKxSEUMhvSDCGozw2W0re3i+GTS6wLgk8GeIyUdHdXCxCFv9o1jk4GkDZ
        jGFEp33kOSKU+/q72gE0U0P3xTDhs3T+vfZc+k4pdK8PDQibHXSBMGKSjVQ3tvJGmpHICa
        5SORNrXZkMQSSRqZFSfSQ6eho9gEOsI=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-26-ct2tnhidNF6Wu3rlRqfYig-1; Wed, 02 Nov 2022 14:40:29 -0400
X-MC-Unique: ct2tnhidNF6Wu3rlRqfYig-1
Received: by mail-qt1-f197.google.com with SMTP id y19-20020a05622a121300b003a526e0ff9bso6677749qtx.15
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 11:40:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z6U2QWI3L7CELeN2uR9v9BKzosx2j/rMnyai3sfNG/I=;
        b=52T1+ScWe791y5PelCiNFGC10v18ME9Jjy8brVpEiwT2kjzl0VwFXgjCPscyVa3tHN
         6fh4xgjsjFh4tS6llCFd9tvaoewvzdYBya7ikth05W8dnf7p/wBxNB95nnu1OVVWrYfS
         M2khUZjDQ6Wmb/tMNDID4JW0CNuqN1iVDmA8FWK1xazG5MDBHTllkK8Ji6mwzc4B2FA6
         KxLxlQH3Rj7+SeE3NReNhgsJtAAI7CYm2se8MIYnUy178J2WlWhVTKIFJym0WL4O0geo
         9YyCM7CBHVM9FqvOaHkxaDC5hgYNjbFksXlYY2HdTc02AFBjCSRxaR5VanKMEwG/4BTU
         8KYg==
X-Gm-Message-State: ACrzQf2nUdOLNZopU3P29q8IluzPo9bSjAa40OWfgT6Y0Nor0ycxVJQF
        JYK+Q0RYLY/iYitvf115SIwBwQbzyaK2IrbURH9oMJ4P+8pdgLyDqwvYric1MQRXl9BvKLqtSpS
        KLZ59QGW/SlGrPBRGuwWB0NG+
X-Received: by 2002:a05:620a:2984:b0:6fa:6636:d4e5 with SMTP id r4-20020a05620a298400b006fa6636d4e5mr2471922qkp.622.1667414429135;
        Wed, 02 Nov 2022 11:40:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5T4ytHu3K/k7aIWWR9fQduopTkBaK9CqkhKpSxE2oFDFcMEEUfWbOKCZP3zXChPWrTaqbUlg==
X-Received: by 2002:a05:620a:2984:b0:6fa:6636:d4e5 with SMTP id r4-20020a05620a298400b006fa6636d4e5mr2471904qkp.622.1667414428917;
        Wed, 02 Nov 2022 11:40:28 -0700 (PDT)
Received: from localhost (pool-100-0-210-47.bstnma.fios.verizon.net. [100.0.210.47])
        by smtp.gmail.com with ESMTPSA id bm2-20020a05620a198200b006cfc7f9eea0sm8930499qkb.122.2022.11.02.11.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 11:40:28 -0700 (PDT)
Date:   Wed, 2 Nov 2022 14:40:27 -0400
From:   Eric Chanudet <echanude@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v7 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <20221102184027.236affysihqnivh5@echanude>
References: <20221102103552.29388-1-quic_ppareek@quicinc.com>
 <20221102103552.29388-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102103552.29388-3-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2022 at 04:05:52PM +0530, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs. A separate DTSI file has
> been created for PMIC, so that it can be used for future SA8540P based
> boards.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>
> Tested-by: Brian Masney <bmasney@redhat.com>
> Reviewed-by: Brian Masney <bmasney@redhat.com>

Using the default defconfig on next-20221102, preventing
qcom_q6v5_pas.ko to load avoids the board crash observed in v5, as
found during v6 review by Brian.

Tested-by: Eric Chanudet <echanude@redhat.com>
Reviewed-by: Eric Chanudet <echanude@redhat.com>

-- 
Eric Chanudet

