Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EED63F819
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiLATXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 14:23:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbiLATXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 14:23:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50DB8442
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 11:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669922540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KRzayttSwSsJ/jtFl/tZsSkDN66+m4h4qNmmW/rZF+w=;
        b=fiUXmj7I1Eyn2kbqzMrbBuj0irPhxuhNI4BUrhFQAJgWg6GD4hgjq6gfwUyKjsrcJFnSaY
        SE74awGkjoIwuHRWLHq4hKxfO27GIFUrIIye7flQg4r9h8BEL8ParjmL7j71yYf+Vr+NoO
        kV5YlCxbmHTekaR1j0+SkhP+PEgypKk=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-sHp8kwb5PSeNBLhVunb7tQ-1; Thu, 01 Dec 2022 14:22:19 -0500
X-MC-Unique: sHp8kwb5PSeNBLhVunb7tQ-1
Received: by mail-ot1-f71.google.com with SMTP id o3-20020a9d6d03000000b0066c577eefc4so1222628otp.22
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 11:22:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRzayttSwSsJ/jtFl/tZsSkDN66+m4h4qNmmW/rZF+w=;
        b=E0w5TBLwTePVFmTcNgN5z386aazSSXHq2H4SY7BXffp1u7UFHSfBsjtb7+Wk6L5+tA
         2uIU2Pyhw39YmmWcKkS8FGyjXDajNaGOf/fXHUC7/mp2Si69sNZMkFPpPfEXv8M1ZdOd
         z5Ri7lVZIEH2rx6NhX3HqnxIcm6bXK1uqn+pmAEIKd9yHKZOPi1eLDe3nLjwVsRucXQU
         gx2LLugFbrMG5jafQGOjQ+SADphYpEZkIncu9wMZSn0P7v4ybUiO3pM1zGB3WMl3Bw73
         mFuJq6AREZd90IilVOFxmWcEWtwUBphedNiQjQszku+zAb+5G49JboB52648NyG+Gvyo
         +fDg==
X-Gm-Message-State: ANoB5pn/AVM7kRnZ4BqtcfPbmHHmZjH9yJdKhIRWLB5Ff0IdtaSwl1lU
        Hv+ZWgalYTgCtLne7rde+6ZsOPna5u/fFwd7wxdaIvRAl9Wi5rOAKAAGvrG058D1IzYbWCI1wCv
        AAHezGsrlAwTX2ITPoO+wgCZT
X-Received: by 2002:a05:6808:143:b0:345:8913:17ae with SMTP id h3-20020a056808014300b00345891317aemr23854534oie.155.1669922538579;
        Thu, 01 Dec 2022 11:22:18 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7wn23egEUl8THpuxVHkoTqQX/Vsfjgq1k8BvNPqZn/l+WC1hbIWW2UmvH5OWeWYf3hN7BYhg==
X-Received: by 2002:a05:6808:143:b0:345:8913:17ae with SMTP id h3-20020a056808014300b00345891317aemr23854525oie.155.1669922538390;
        Thu, 01 Dec 2022 11:22:18 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::41])
        by smtp.gmail.com with ESMTPSA id h19-20020a9d6f93000000b006619f38a686sm2415522otq.56.2022.12.01.11.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 11:22:17 -0800 (PST)
Date:   Thu, 1 Dec 2022 13:22:15 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Brian Masney <bmasney@redhat.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v10 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <20221201192215.fi3ekvkntruevxtd@halaney-x13s>
References: <20221118025158.16902-1-quic_ppareek@quicinc.com>
 <20221118025158.16902-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221118025158.16902-3-quic_ppareek@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 08:21:58AM +0530, Parikshit Pareek wrote:
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
> Tested-by: Eric Chanudet <echanude@redhat.com>
> Reviewed-by: Eric Chanudet <echanude@redhat.com>
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

