Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E11649F59
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 14:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiLLNFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 08:05:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiLLNEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 08:04:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6344413FB7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670850090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IAcys2kevC/gc9nuZ3z+Y7/oT9oEQ4M5JbDnTp/1RaM=;
        b=ASbrJ3q7YOv84DiC26fVFxddQJEWj4SelvaQnlFRgPE3LIci0iV2Dks6z6ZlOfk3rUzooA
        bQr1UpoQf/RI5m+j9+aBXpzvPZ+L6Wd3b0m4iaLrMh485z5qwAkF6/ydgP62H4DApRzs4b
        DoQfzWhW4lus3rQdWcoajWX0uQyKQBA=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-111-lff9aoOLOmyvjx7LETHcpQ-1; Mon, 12 Dec 2022 08:01:29 -0500
X-MC-Unique: lff9aoOLOmyvjx7LETHcpQ-1
Received: by mail-io1-f69.google.com with SMTP id p3-20020a6bfa03000000b006df8582e11cso6219992ioh.22
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 05:01:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAcys2kevC/gc9nuZ3z+Y7/oT9oEQ4M5JbDnTp/1RaM=;
        b=b/OpTh75oEb8DcVDdvYTRxrsh061MjYLX+hF/TqDzRRXN8yhi34SChlRYrOtkuwqq0
         59f5AMkBtErbjzis4muNexOu2NJ2Ve3uKkeADCr108r9/peOcW6gGqUeXqMJOtpZuRG1
         vSlTpYYs8HWmj5fCdCnE7hlwUmJx62sUshiln8HCkXG6HOaBA8dNDQTM1ZPGGOLr+f63
         xynZK3WLqGhq2V4tYpxOnjw5uWwWbw5TImVa7zfnlyhP8sZu2+pUL3qnrFIkt0ph5ZSv
         907qpMAAw/BViYMtnZHAD5aJdh5ZyVPbxjoTBGAUifJuVM8P/VArrKWvGISmCPl8ml0o
         oRjA==
X-Gm-Message-State: ANoB5pnhJanYpiYIEuxh7/RETfDa+raKnpfRbPXSFLrP4zA0crKaPQe8
        qw96p92KRnOGOjDGxVWnEvqqv6z9VnfKgvFmkPHttPIVBEGDmQJcDeuEz3kSdiUe/caxFDlQu6J
        owY2qgJm+B4IsskonbIQ3kla3
X-Received: by 2002:a5d:8ad3:0:b0:6d6:d016:b57f with SMTP id e19-20020a5d8ad3000000b006d6d016b57fmr8804455iot.8.1670850088669;
        Mon, 12 Dec 2022 05:01:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7lMCNzvapRWQgP9Do1GVyF6UNm0BOoIJpWHXZg7697fb7i7kT6Bj/WI5IK4JVElqXRUziw4g==
X-Received: by 2002:a5d:8ad3:0:b0:6d6:d016:b57f with SMTP id e19-20020a5d8ad3000000b006d6d016b57fmr8804420iot.8.1670850088386;
        Mon, 12 Dec 2022 05:01:28 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id q33-20020a027b21000000b00363fe31cf55sm3063507jac.40.2022.12.12.05.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 05:01:27 -0800 (PST)
Date:   Mon, 12 Dec 2022 08:01:26 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     andersson@kernel.org, johan@kernel.org,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable pcie2a node
Message-ID: <Y5cmJu5NoBm9lctA@x1>
References: <20221212122058.597-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212122058.597-1-quic_shazhuss@quicinc.com>
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

On Mon, Dec 12, 2022 at 05:50:59PM +0530, Shazad Hussain wrote:
> Add the pcie2a, pcie2a_phy, and respective tlmm
> nodes that are needed to get pcie 2a controller
> enabled on Qdrive3.
> 
> This patch enables 4GB 64bit memory space for
> PCIE_2A to have BAR allocations of 64bit pref mem
> needed on this Qdrive3 platform with dual SoCs
> for root port and switch NT-EP. Hence this ranges
> property is overridden in sa8540p-ride.dts only.
> 
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
> ---
> Changes since v1:
> - Fix ranges property indentation (Konrad)
> 
> This patch depends on below patch series for vreg_l11a.
> 
> [v4] arm64: dts: qcom: sa8540p-ride: enable PCIe support
> https://lore.kernel.org/all/20221206161916.315640-1-bmasney@redhat.com/

I verified that this matches what's in downstream.

Reviewed-by: Brian Masney <bmasney@redhat.com>

I'm not able to test this yet since we're still on an old version of the
PCIe switch firmware and I need to get that upgraded first.

Note that your patch won't apply to linux-next since the v3 of my pcie3a
patch is what was actually merged into the qcom tree. Can you resend? You
can move the tlmm node to the bottom and add the PINCTRL comment.

I have some i2c and SPI changes that I'll be posting soon where I already
made that change but I'll hold off for you to post a new version and base
on top of yours.

Brian

