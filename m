Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6893E6065F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiJTQjY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiJTQjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:39:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1714611A0F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666283958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=omwjaJqVpRMhtOWiFbngTkAQCb38UHG2LtZ5YNjxAtA=;
        b=it2FiodO3cBbOs4KN7TDM0lzIURYuXMffN0znUiVV6r/6ORjxZOxmdC7Jm3J6cxd9G0Cl0
        rp5+9nSK5MvGUHbiQlNaSMduPBi/pIbHjRKhlzBoAKXedkhUes1DkRXO5F5fcOEn1hXe3/
        6PhlaASx8TizmYTSaVl5zARB7sMqQeY=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-310-6YF-8XuoM82LJWAReg9gVA-1; Thu, 20 Oct 2022 12:39:16 -0400
X-MC-Unique: 6YF-8XuoM82LJWAReg9gVA-1
Received: by mail-io1-f72.google.com with SMTP id t15-20020a5d81cf000000b006bc1ca3ae00so11085iol.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 09:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=omwjaJqVpRMhtOWiFbngTkAQCb38UHG2LtZ5YNjxAtA=;
        b=UEGYw+1WaLI4nX+Ehr0+DPqZs4hvhJousZoUHXhoReyhw+o0u2NZtvPT/wa0KdINy9
         /8SeGAtbLwBbvgfe4THFOXhMUdAMgOFR2Bs/JlvpFcc3rLIWMPtT3bpBVO/w4l7ujaCD
         uxFj+5ZRzfar4IYZ7fkOynY7eabHN21BjMDLuCfIXdfMnGF5J1fnSftaQwAlNoF2j3zI
         XwhkYiWIjs7wqtbXVgDGkoaJtaRaAtvCLWdT7PCma1J8l+CsozZSIN9N3R55gafyEko+
         9D1qj372j2Pj2I8YNrAJeYY5ExkqBQnVh5yQJxHWoW4yKqpYuHWP0BNtgU+iLPmHlcpt
         JbuA==
X-Gm-Message-State: ACrzQf2mx9GygP5+a+KGc7GVmIr3P08HUGqoNuLzfk3R1BGI6+DF1JAT
        5do4mROO9yaFE7tV2F6HB4rGXdOqDk+b0XNhpMLthr+MvPIjunyQm955F5e1h3zOMwE6nRGe6I+
        vgHkEYbz3eu4mE4prDPaePnc8
X-Received: by 2002:a92:504:0:b0:2fb:43d:2271 with SMTP id q4-20020a920504000000b002fb043d2271mr11064389ile.256.1666283955750;
        Thu, 20 Oct 2022 09:39:15 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6EE4aSqztMreyOxctnSgCWKuz27gi8pWFZs+RXHi18gS6e9oWB11AExqXJVPnhQwLF3k/ykg==
X-Received: by 2002:a92:504:0:b0:2fb:43d:2271 with SMTP id q4-20020a920504000000b002fb043d2271mr11064372ile.256.1666283955516;
        Thu, 20 Oct 2022 09:39:15 -0700 (PDT)
Received: from x1 (c-98-239-145-235.hsd1.wv.comcast.net. [98.239.145.235])
        by smtp.gmail.com with ESMTPSA id o10-20020a056e02068a00b002de7ceafb4esm3247837ils.20.2022.10.20.09.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Oct 2022 09:39:15 -0700 (PDT)
Date:   Thu, 20 Oct 2022 12:39:13 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Parikshit Pareek <quic_ppareek@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v6 2/2] arm64: dts: qcom: add SA8540P ride(Qdrive-3)
Message-ID: <Y1F5sY4ETqNiRVdP@x1>
References: <20221020073036.16656-1-quic_ppareek@quicinc.com>
 <20221020073036.16656-3-quic_ppareek@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020073036.16656-3-quic_ppareek@quicinc.com>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 01:00:36PM +0530, Parikshit Pareek wrote:
> Introduce the Qualcomm SA8540P ride automotive platform, also known as
> Qdrive-3 development board.
> 
> This initial contribution supports SMP, CPUFreq, cluster idle, UFS, RPMh
> regulators, debug UART, PMICs, remoteprocs and USB.
> 
> The SA8540P ride contains four PM8450 PMICs.
> 
> Signed-off-by: Parikshit Pareek <quic_ppareek@quicinc.com>

With Konrad's requested changes:

Reviewed-by: Brian Masney <bmasney@redhat.com>
Tested-by: Brian Masney <bmasney@redhat.com>

After more research, I've verified that the board reboot issue that
I brought up in v5 is unrelated to the DTS, so no need to block merging
this. I'll post some more findings soon about the issue.

Brian

