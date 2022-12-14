Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E57D64C910
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbiLNMde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238206AbiLNMdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:33:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBE325C7A
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:30:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671021017;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+vO4DoxPTo+v6Z3oofYVvH1iS9HtJtB6HPIOFQQBy8E=;
        b=dT/B/u+VDWX93quk9rpNLoTkORZ4Zsv/tcPOMlPZlhK7eA++vwjgV95YwM9MpCQd/OyL2c
        JkDTNy+u6ph+FmW09OfHKu8eqVX3mMbzPB+UPiyBxFkBPdnkRPElApR4GDEZF/PJJHwI1z
        oDvZtyPHNjNJduovaxxzJHTbHjNaXLw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-673-WkXN9zcXMoe7VEY6PAtkYA-1; Wed, 14 Dec 2022 07:30:16 -0500
X-MC-Unique: WkXN9zcXMoe7VEY6PAtkYA-1
Received: by mail-qv1-f70.google.com with SMTP id y11-20020ad457cb000000b004c6fafdde42so16925574qvx.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 04:30:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+vO4DoxPTo+v6Z3oofYVvH1iS9HtJtB6HPIOFQQBy8E=;
        b=vT1HidulmsNlvQB+y0niGZWmoY5ZNQVwdBckoDiswNi3HZhovKMoh/oMtPTl4svOIs
         02DQ7r5H/vQbCk9hOUo2WqqLvBPsyLphLe/iDSWqMaQGnv7MG5OLcTSMBbGDqIIkbUT+
         mGIQUqqWhuhN54IJoGA5PcOnSqa2NTvROsz1+hJX1cpbMrP/53lAMfDP+zhQfaIf37FQ
         b+UAh3HZPgxrN7VlJLzTIpLMc4YddPFz7VcWDpIrj4ktTmfHSOvqRoEMFwhK0FXc/lrU
         BO27UWuwu2Cfio5eK8OIygtMZwmRHr+4fw3ymBeB1Oya7S2ETWzam1t9PjBH9gA+aV9b
         kYAg==
X-Gm-Message-State: ANoB5plZ6McCpbZIWYYTdW3jIxq6kG5AVxYykD02/ApT4/qxSCK6bx5D
        Dsf7rdqY2gDAkxjXKK/EVxdUyj1BQcHdsuaY+MytimKU5+8/ZsqI3kyGA265P5TM1AGs7KZ1+gM
        1aNwj0stRo0wm6P5l3yv0e7p/
X-Received: by 2002:a05:6214:843:b0:4c7:9c7:e6ac with SMTP id dg3-20020a056214084300b004c709c7e6acmr31106902qvb.47.1671021015839;
        Wed, 14 Dec 2022 04:30:15 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5S0C9daEbB6SI7DneQvvEiKJe0pIWT/bd1pm4rhI2+NTF7dxpZeZ9sV05cB3CG574f5Cic0A==
X-Received: by 2002:a05:6214:843:b0:4c7:9c7:e6ac with SMTP id dg3-20020a056214084300b004c709c7e6acmr31106876qvb.47.1671021015551;
        Wed, 14 Dec 2022 04:30:15 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id do36-20020a05620a2b2400b006fb8239db65sm9825555qkb.43.2022.12.14.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Dec 2022 04:30:14 -0800 (PST)
Date:   Wed, 14 Dec 2022 07:30:13 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>, quic_shazhuss@quicinc.com
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ahalaney@redhat.com,
        echanude@redhat.com
Subject: Re: [PATCH 3/4] arm64: dts: qcom: sa8540p-ride: add qup1_i2c15 and
 qup2_i2c18 nodes
Message-ID: <Y5nB1epKN4nbk3ma@x1>
References: <20221212182314.1902632-1-bmasney@redhat.com>
 <20221212182314.1902632-4-bmasney@redhat.com>
 <309b3fad-933c-6c45-5cd7-4e082da62c15@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <309b3fad-933c-6c45-5cd7-4e082da62c15@linaro.org>
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

On Tue, Dec 13, 2022 at 03:48:27PM +0100, Konrad Dybcio wrote:
> > +	qup1_i2c15_default: qup1-i2c15-state {
> > +		mux-pins {
> > +			pins = "gpio36", "gpio37";
> > +			function = "qup15";
> > +		};
> > +
> > +		config-pins {
> > +			pins = "gpio36", "gpio37";
> > +			drive-strength = <0x02>;
> > +			bias-pull-up;
> > +		};
> > +	};
>
> You can drop mux/config-pins and have the pin properties live directly
> under the qup1-i2cN-state node.

Hi Konrad (and Shazad below), 

I need to enable 5 i2c buses (0, 1, 12, 15, 18) on this board. I tried
the following combinations with the pin mapping configuration and the
only one that seems to work reliably for me is what I originally had.

With the following, only 2 out of the 5 buses are detected. There's no
i2c mesages in dmesg.

    i2c0_default: i2c0-default-state {
        pins = "gpio135", "gpio136";
        function = "qup15";
    };

Next, I added a drive-strength and bias-pull-up. All 5 buses are
detected. One bus throws read errors when I probe it with i2cdetect, two
others 'i2cdetect -a -y $BUSNUM' takes ~5 seconds to run, and the
remaining two are fast.

    i2c0_default: i2c0-default-state {
        pins = "gpio135", "gpio136";
        function = "qup15";
        drive-strength = <2>;
        bias-pull-up;
    };

This is the style where i2cdetect seems to be happy for all 5 buses and
is fast:

    i2c0_default: i2c0-default-state {
        mux-pins {
            pins = "gpio135", "gpio136";
            function = "qup0";
        };

        config-pins {
            pins = "gpio135", "gpio136";
            drive-strength = <2>;
            bias-pull-up;
        };
    };


Shazad: 'i2cdetect -a -y $BUSNUM) shows that all 5 buses have the same
addresses listening. Is that expected? That seems a bit odd to me.

[root@localhost ~]# i2cdetect -a -y 0
Warning: Can't use SMBus Quick Write command, will skip some addresses
     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00:                                                 
10:                                                 
20:                                                 
30: -- -- -- -- -- -- -- --                         
40:                                                 
50: -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
60:                                                 
70:                                                 

I triple checked that I have the QUP pins defined correctly for the 5
buses. I checked them against what's in the downstream kernel and I also
checked them against what's in upstream's
drivers/pinctrl/qcom/pinctrl-sc8280xp.c. This is the pin mapping that I
have:

    i2c0: gpio135, gpio136
    i2c1: gpio158, gpio159
    i2c12: gpio0, gpio1
    i2c15: gpio36, gpio37
    i2c18: gpio66, gpio67

Brian

