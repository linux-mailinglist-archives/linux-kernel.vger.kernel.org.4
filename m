Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F21610C35
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiJ1I3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 04:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiJ1I3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 04:29:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02D0F1C4EC0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666945726;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eYvTqJzZRhXZcmDQGfvWqV+LWUYCoBA0yMtYA0vrjX8=;
        b=FqNmvG+TL9QPFjd+7QlwA0mUEBjKthS/QaXgVoB3s+YLHqdABuPa99hfebdB4EDTDTit9p
        KPs3Paz5rqOXFqtLJU1QC79XUluQg4YV8XejDG94NVHL9YfxLywVy4kak3Oouyuv2P5i/z
        K0WX/dGGXaPb+3gjRsz4Vx9j5qSV2QA=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-649-w0zKcqstPXSabV1TEkFhaQ-1; Fri, 28 Oct 2022 04:28:42 -0400
X-MC-Unique: w0zKcqstPXSabV1TEkFhaQ-1
Received: by mail-qt1-f200.google.com with SMTP id 22-20020ac85756000000b0039cf0d41e2cso2955387qtx.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 01:28:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eYvTqJzZRhXZcmDQGfvWqV+LWUYCoBA0yMtYA0vrjX8=;
        b=jh8j1PrbC1os1a3IORErVNYGxFesaOkUkKNnzIJKyG91LcTIb90rYN7S+dd9jSC8Te
         hCQD9I2qDS3nmWMJQeXoOdmnmLVB4OGRTP9IDZdgkqTLHo/Rn2AjWzVovoUrrY4Jqtbs
         9OHDfLPUewcoCqHgAQ0Gkb2+8G4sIStQrLKHLPfgiWwShdIf42ms8BI8gl4sccBMqNFf
         ooDjuZIpwc44aDoSFD/tvabv7Nt9uMoJ9ZemEqgwJQ6HrrT5KexxSiV3TedOylmBU8ja
         Tw+XtnEnishHBfzie/GM4A64wcaBSbYM8wB1UJr/eaZRpByKIKvrnD2qhKl2OM58Vvms
         Pmng==
X-Gm-Message-State: ACrzQf0PcdufGFtbvmla+i1EF8+NvLAmhUI0nPeB5rtIcn3BoE5+Rh9L
        lum9uq9Ap5h9Ydh80HITVLS1AO6dAGGvj02uYeyYdk2sk5AMy/mgque/dJG+zesv4yLnTUiPcZA
        MafNzo8f5y2k6lmqEdUozEZkZ
X-Received: by 2002:a05:620a:51c6:b0:6f9:feea:3a53 with SMTP id cx6-20020a05620a51c600b006f9feea3a53mr4128065qkb.425.1666945722083;
        Fri, 28 Oct 2022 01:28:42 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6lPZseY0YX+Knkpt2FrP+30Epj8TvUR5e8NY8W69ZnO6N8AkrenE+W50V8u4lMSiNkZpmDgQ==
X-Received: by 2002:a05:620a:51c6:b0:6f9:feea:3a53 with SMTP id cx6-20020a05620a51c600b006f9feea3a53mr4128051qkb.425.1666945721891;
        Fri, 28 Oct 2022 01:28:41 -0700 (PDT)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id s4-20020ac85284000000b0039c7b9522ecsm2088432qtn.35.2022.10.28.01.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 01:28:41 -0700 (PDT)
Date:   Fri, 28 Oct 2022 04:28:40 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     konrad.dybcio@somainline.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <Y1uSuBNhAL/YMEVc@x1>
References: <20221020073036.16656-1-quic_ppareek@quicinc.com>
 <20221020073036.16656-3-quic_ppareek@quicinc.com>
 <7a62dd552c02e2b83fabaf9ff55a7c6c@somainline.org>
 <20221028075059.GA15101@hu-ppareek-blr.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028075059.GA15101@hu-ppareek-blr.qualcomm.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:20:59PM +0530, Parikshit Pareek wrote:
> > > +		vreg_l3c: ldo3 {
> > > +			regulator-name = "vreg_l3c";
> > > +			regulator-min-microvolt = <1200000>;
> > > +			regulator-max-microvolt = <1200000>;
> > > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > > +			regulator-allow-set-load;
> > Not sure if setting load is desired after recent rpmh regulator changes.
>
> May I know the exact patch being refered here?

Hi Parikshit,

You now need to specify a regulator-allowed-modes. Here's some links
with more information:

https://lore.kernel.org/all/20220907204924.173030-1-ahalaney@redhat.com/
https://lore.kernel.org/all/20220824142229.RFT.v2.2.I6f77860e5cd98bf5c67208fa9edda4a08847c304@changeid/

Brian

