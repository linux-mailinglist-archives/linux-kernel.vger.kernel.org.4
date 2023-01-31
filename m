Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4816838BC
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 22:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjAaVez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 16:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjAaVex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:34:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA7756884
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675200847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B76IbDg7rfJ1kacwa1GZMxROODg9JF3CJO54jHtr+rw=;
        b=R2X4YfJVggXGHUkQVjGNX1Tfxr/zBVYiiJIgPnWvrY+iYODY+1/J+leiqKpyI3jBenSV9z
        wtOEl3OpLLi3UL68r3Ce9jdHik6E6X+2M8dV6HlwytRBb6jHRxcOf8zVx7XR+PXNrsvuFF
        3OQSHadjydsH65EXRiVtSqY4bh22q9I=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-16-QRi-yvjfM1ecthn5Iqj4Xg-1; Tue, 31 Jan 2023 16:34:03 -0500
X-MC-Unique: QRi-yvjfM1ecthn5Iqj4Xg-1
Received: by mail-qk1-f197.google.com with SMTP id j10-20020a05620a288a00b0070630ecfd9bso10092650qkp.20
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 13:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B76IbDg7rfJ1kacwa1GZMxROODg9JF3CJO54jHtr+rw=;
        b=BiaY4Op7aBlDrHu64dNZcoyktDV2qNkHCV5u1Bm4S5Uk9nCC6FsYGYjHsCP2AU8XtT
         COQ6MOC57k43xLP/S93cssZ8hXGypagA2MNPCpvEVgcO7s9NBmB0FI8rGjzyb9ns5mdP
         4TQSJ26m8LUg7FRRnNAjzpryElZUdVIh/e9wjogwMPtjuXldav0uFmrYJsvzQArnSDAA
         LaZ3mwKubecu56JvCAF4ezALkvD/qI9ZNwmx6mJ8Enb8DmPJPmxWdSzk/9JFMMvs1kNU
         ZolnzLzScOPnjkdObgqgdYyJfwfDHYOK3KU8KF+osYOwWs5jRSXI+7HNomT5ttz0WwJX
         VGTQ==
X-Gm-Message-State: AO0yUKVc6SjOP0DLATphW2OdT8Gq6qOmXgAqJ1v6UWVm+VmcUxtQrCa/
        d2FffVj6z+yP0Ei2vu5pkT4jpiEM7GoQDX/L5yHOE+RSMKphbeLJt26yLwxFU998dUK9sjmKsbW
        khV735lf3RH4VscfzBF1056AB
X-Received: by 2002:a05:622a:210:b0:3b6:5d23:8748 with SMTP id b16-20020a05622a021000b003b65d238748mr310773qtx.52.1675200843208;
        Tue, 31 Jan 2023 13:34:03 -0800 (PST)
X-Google-Smtp-Source: AK7set+5rIaL7g2YNvj8/qHBaDUmprfpdFLKJYma7DpN0DwL9Ze1Djra/CriopTufBe4wvVl6yskiQ==
X-Received: by 2002:a05:622a:210:b0:3b6:5d23:8748 with SMTP id b16-20020a05622a021000b003b65d238748mr310743qtx.52.1675200842889;
        Tue, 31 Jan 2023 13:34:02 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id ga15-20020a05622a590f00b003b880ef08acsm3438551qtb.35.2023.01.31.13.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 13:34:02 -0800 (PST)
Date:   Tue, 31 Jan 2023 16:34:01 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     andersson@kernel.org, agross@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, bmasney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v2 2/2] arm64: dts: qcom: sa8540p-ride: Document i2c
 busses
Message-ID: <20230131213401.dtsewdyuppl6c657@echanude>
References: <20230130154823.117542-1-ahalaney@redhat.com>
 <20230130154823.117542-2-ahalaney@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130154823.117542-2-ahalaney@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2023 at 09:48:23AM -0600, Andrew Halaney wrote:
> It isn't obvious in the current devicetree what is connected. Go ahead
> and document what's on the other end.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---

Reviewed-by: Eric Chanudet <echanude@redhat.com>

> 
> Changes since v1:
> 	* Document i2c12 having a max20411 (Shazad)
> 
> In v1 I said i2c12 was not connected, that's not true though (I just
> have a board schematic which shows it not connected, but it _is_
> connected on the SIP/SOM, which I verified with series [0]).
> 
> I debated waiting for Bjorn to sort out appropriate label names over at
> [0] (and follow suit in a third patch here), but decided to get this
> series out again to clean up the current warnings while that's worked
> out. Once [0] is resubmitted I'll submit a separate patch to enable the
> max20411 on this board as well!
> 
> [0] https://lore.kernel.org/linux-arm-msm/20230130035642.GA464800@hu-bjorande-lv.qualcomm.com/
> 
> Thanks,
> Andrew
> 
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> index 6ab4b435c49e..8b7555f22528 100644
> --- a/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> +++ b/arch/arm64/boot/dts/qcom/sa8540p-ride.dts
> @@ -317,6 +317,7 @@ &xo_board_clk {
> 
>  &tlmm {
>  	i2c0_default: i2c0-default-state {
> +		/* To USB7002T-I/KDXVA0 USB hub (SIP1 only) */
>  		pins = "gpio135", "gpio136";
>  		function = "qup0";
>  		drive-strength = <2>;
> @@ -324,6 +325,7 @@ i2c0_default: i2c0-default-state {
>  	};
> 
>  	i2c1_default: i2c1-default-state {
> +		/* To PM40028B-F3EI PCIe switch */
>  		pins = "gpio158", "gpio159";
>  		function = "qup1";
>  		drive-strength = <2>;
> @@ -331,6 +333,7 @@ i2c1_default: i2c1-default-state {
>  	};
> 
>  	i2c12_default: i2c12-default-state {
> +		/* To Maxim max20411 */
>  		pins = "gpio0", "gpio1";
>  		function = "qup12";
>  		drive-strength = <2>;
> @@ -338,6 +341,7 @@ i2c12_default: i2c12-default-state {
>  	};
> 
>  	i2c15_default: i2c15-default-state {
> +		/* To display connector (SIP1 only) */
>  		pins = "gpio36", "gpio37";
>  		function = "qup15";
>  		drive-strength = <2>;
> @@ -345,6 +349,7 @@ i2c15_default: i2c15-default-state {
>  	};
> 
>  	i2c18_default: i2c18-default-state {
> +		/* To ASM330LHH IMU (SIP1 only) */
>  		pins = "gpio66", "gpio67";
>  		function = "qup18";
>  		drive-strength = <2>;
> --
> 2.39.1
> 

-- 
Eric Chanudet

