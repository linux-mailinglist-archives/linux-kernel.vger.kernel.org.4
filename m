Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07CF5652758
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 20:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234024AbiLTTwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 14:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbiLTTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 14:52:09 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEFE8FF9
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671565882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gtHJ9MviuoYeXsjx6KkSy+TRGm5AU7U7JjwMVdni4JA=;
        b=gJDRzTszxrZCFmktvdaabW6147vl4XDWjvIBABdQNzyGq4eZXb3jpMbz1opUs9HCgHRMye
        fl5hy38HXzqgxi3n+GUFfCiY6q4gWgPRRi930uX7BS9YFnpd6BtbeqhdE2UFiY4YMCgz+R
        jQuPKhK5tmm7XjU+TjsxDsSVMDZuk9Q=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-271-oYGF0N_oM6CKcQRunGkzPg-1; Tue, 20 Dec 2022 14:51:21 -0500
X-MC-Unique: oYGF0N_oM6CKcQRunGkzPg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-143d68edfa1so5987115fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:51:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtHJ9MviuoYeXsjx6KkSy+TRGm5AU7U7JjwMVdni4JA=;
        b=PZkX6wy3XVzB8e7SVVZ6ucm6YKkDQbfLr1S5gvJnvJgWBChCTWdFaPXnc/wWhb+H4p
         cN7nNlPelqd5uRPPje92gelbT4PLNQba9ZguiluxFJ1k+sONtVPExALC0ran5w3JTHY6
         WdhP47hDdXCyQ6shd5p37UZeBxyKNTmG3z6Q1RjWTKmAWcRZ3cX9dIW+37VvXaHxBHv/
         o6dn0F91x4Wa+5pjISAQeH0XZGG+RGPditTz3ck9ftMgO5bqyElloVbsD+OGmu5Vi9Nn
         Trx+EZNuOYQChBOIORQZ7ga2Rp2LYIrFSmhZE1fe5SdzTtnDz8FhFE6rR+N81hfG8fJ3
         y2jQ==
X-Gm-Message-State: ANoB5pl3Sax7wVPcpPkoZnL32DcD7NYWHmbP1n+yzs9TlDpc7TQO1/WP
        YoLzcwx6q+rKPJ6zVGRypHYhBI+1p6aNVTf1UIkk3p4P8iagBkBIRZeaeB320Ap6uT/4mAHzdqZ
        F3r8fMVBvZvQislq9+BBMf8rR
X-Received: by 2002:a05:6870:517:b0:141:d6f8:f83d with SMTP id j23-20020a056870051700b00141d6f8f83dmr23526805oao.1.1671565880553;
        Tue, 20 Dec 2022 11:51:20 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7yJ6MGDycAtuwlTjAtrLORR67RpUKz/dZw9P30th+KL9S89yvHFmjk91A5JmpFjwZ3SXeU/w==
X-Received: by 2002:a05:6870:517:b0:141:d6f8:f83d with SMTP id j23-20020a056870051700b00141d6f8f83dmr23526797oao.1.1671565880325;
        Tue, 20 Dec 2022 11:51:20 -0800 (PST)
Received: from halaney-x13s ([2600:1700:1ff0:d0e0::21])
        by smtp.gmail.com with ESMTPSA id be13-20020a056870588d00b00142fa439ee5sm6400567oab.39.2022.12.20.11.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 11:51:19 -0800 (PST)
Date:   Tue, 20 Dec 2022 13:51:17 -0600
From:   Andrew Halaney <ahalaney@redhat.com>
To:     Eric Chanudet <echanude@redhat.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v4 0/4] arm64: dts: qcom: enable sa8540p-ride rtc
Message-ID: <20221220195117.zrbnzx3glzmijlvo@halaney-x13s>
References: <20221219191000.2570545-1-echanude@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219191000.2570545-1-echanude@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 19, 2022 at 02:09:57PM -0500, Eric Chanudet wrote:
> Enable sa8540p-ride rtc on pmic@0.
> 
> sa8540p base boards share the same pmics description, currently in
> pm8450a.dtsi. Rename the file to make this explicit and use it in both
> sa8540p-ride.dts and sa8295p-adp.dts.
> Add the missing offset where appropriate for the alarm register bank in
> other qcom,pm8941-rtc description.
> 
> Changes since v3:
> - Amend patch #1 incorrect description.
> 
> Changes since v2:
> - rename pm8450a.dtsi to sa8540p-pmics.dtsi.
> 
> Changes since v1:
> - Add "alarm" register bank offset at 0x6100 in qcom,pm8941-rtc
>   descriptions.
> 
> Eric Chanudet (4):
>   arm64: dts: qcom: rename pm8450a dtsi to sa8540p-pmics
>   arm64: dts: qcom: sa8450p-pmics: add rtc node
>   arm64: dts: qcom: sa8295p-adp: use sa8540p-pmics
>   arm64: dts: qcom: pm8941-rtc add alarm register
> 
>  arch/arm64/boot/dts/qcom/pm8150.dtsi          |  2 +-
>  arch/arm64/boot/dts/qcom/pm8916.dtsi          |  3 +-
>  arch/arm64/boot/dts/qcom/pm8950.dtsi          |  2 +-
>  arch/arm64/boot/dts/qcom/pmm8155au_1.dtsi     |  2 +-
>  arch/arm64/boot/dts/qcom/pmp8074.dtsi         |  2 +-
>  arch/arm64/boot/dts/qcom/pms405.dtsi          |  2 +-
>  arch/arm64/boot/dts/qcom/sa8295p-adp.dts      | 79 +------------------
>  .../qcom/{pm8450a.dtsi => sa8540p-pmics.dtsi} |  8 ++
>  arch/arm64/boot/dts/qcom/sa8540p-ride.dts     |  2 +-
>  9 files changed, 17 insertions(+), 85 deletions(-)
>  rename arch/arm64/boot/dts/qcom/{pm8450a.dtsi => sa8540p-pmics.dtsi} (90%)
> 
> -- 
> 2.38.1
> 

Tested-by: Andrew Halaney <ahalaney@redhat.com> # sa8540p-ride

Here's some naive tests I did for the record:

    [root@localhost ~]# cat /proc/interrupts | grep alarm
    180:          2          0          0          0          0          0          0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
    [root@localhost ~]# echocat /proc/interrupts | grep alarm> /sys/class/rtc/rtc0/wakealarm && sleep 10 && cat /proc/interrupts | grep alarm
    180:          3     cat /proc/interrupts | grep alarm0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
    180:          3          0          0          0          0          0          0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
    [root@localhost ~]# 
    [root@localhost ~]# 
    [root@localhost ~]# cat /proc/interrupts | grep alarm
    180:          3          0          0          0          0          0          0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
    [root@localhost ~]# echo $(date '+%s' -d '+ 10 seconds') > /sys/class/rtc/rtc0/wakealarm && sleep 10 && cat /proc/interrupts | grep alarm
    180:          3          0          0          0          0          0          0          0  pmic_arb 101777441 Edge      pm8xxx_rtc_alarm
    [root@localhost ~]# timedatectl && sleep 5 && timedatectl
                   Local time: Wed 1970-01-14 05:20:32 UTC
               Universal time: Wed 1970-01-14 05:20:32 UTC
                     RTC time: Wed 1970-01-14 05:20:32
                    Time zone: UTC (UTC, +0000)
    System clock synchronized: no
                  NTP service: active
              RTC in local TZ: no
                   Local time: Wed 1970-01-14 05:20:37 UTC
               Universal time: Wed 1970-01-14 05:20:37 UTC
                     RTC time: Wed 1970-01-14 05:20:37
                    Time zone: UTC (UTC, +0000)
    System clock synchronized: no
                  NTP service: active
              RTC in local TZ: no
    [root@localhost ~]#

