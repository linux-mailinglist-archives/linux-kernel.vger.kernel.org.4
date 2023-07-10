Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BA474D9B7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjGJPVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjGJPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:21:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94081E0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689002438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KB94weOwoWMBQ4tLFhB7umLrTAyrFqDhZCrrtSY4RjA=;
        b=jDIL6TdyewuocuKx6Zitng999/jJNc5NcQi1Tj166pUZkeNBPNLSAA6a1xwlmamQvAfCTE
        IOJUdmKvONkOwf/I9fFN3E7AgKWa0KPkwKW9mY1ZAsRAgYBGooI7F8P6NYU4cgwkkkJcmP
        MqoqLkzWs/c06lZLNH7JJ9XwfsYIxZY=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-_zgcX4ABMoK33OGLp0bdQw-1; Mon, 10 Jul 2023 11:20:37 -0400
X-MC-Unique: _zgcX4ABMoK33OGLp0bdQw-1
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-57704af0e64so54512837b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:20:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689002436; x=1691594436;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KB94weOwoWMBQ4tLFhB7umLrTAyrFqDhZCrrtSY4RjA=;
        b=lB5WRE1Ut5aPEzbBMa7jkcroFPPww8kRMuHI3YwgPRI70RVQB3WN8/3iUPdAImoKLq
         LST/ICfzg+9s2Q6rV1LrXTpd0U6Vu0o/+kVFnTP5DjUN2rFtn0N/bOQ2vUBafBjU4KmW
         hZEB1fUxCUHuwQyw4KvE2jMr8EDeYKDkiN5957pg5V2Wn+S0waVD3Tr+0ZlShnD8Vni+
         T7CMzzcF23QkJoXmLTy5jnlOuXoo3IuyRfhgPWw8nLxlOXrGmncTGeblUPcAZEYzqt4s
         WLKfpqX4P6dpzvtQ2W6xHJWIPqQOXgCrQEP2IC+/NHfLdHLV6BAjAcsYtDYM6abccwrT
         A7FQ==
X-Gm-Message-State: ABy/qLaOL9/q16yzcKDIlW8uttbqhj8PVpCq130aAYcfrG1SUXZj738t
        x1M45A+hH8h/lGaULGO2c3Rdjl67pIhcj1Vn9A+AOagmDCNOwbwGJc3OWu5IEM8u17icdHAsrHT
        DWmiYgD5oe8YoowLK/R6Anlgr
X-Received: by 2002:a81:6604:0:b0:575:4b1c:e5ea with SMTP id a4-20020a816604000000b005754b1ce5eamr12259979ywc.47.1689002436578;
        Mon, 10 Jul 2023 08:20:36 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH+YQLgXa3ThTm8gLDWAioQ62hJ6Tirv8hlhia+ImkkyVm4OGmEzS4D5sR6FzMA+VXStzjR8Q==
X-Received: by 2002:a81:6604:0:b0:575:4b1c:e5ea with SMTP id a4-20020a816604000000b005754b1ce5eamr12259953ywc.47.1689002436338;
        Mon, 10 Jul 2023 08:20:36 -0700 (PDT)
Received: from brian-x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id h126-20020a0df784000000b00559f1cb8444sm9956ywf.70.2023.07.10.08.20.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 08:20:35 -0700 (PDT)
Date:   Mon, 10 Jul 2023 11:20:33 -0400
From:   Brian Masney <bmasney@redhat.com>
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: Re: [PATCH V7 0/2] firmware: Add support for boot_stats
Message-ID: <ZKwhwUnKR7vqQZms@brian-x1>
References: <cover.1688533340.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1688533340.git.quic_schowdhu@quicinc.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 05, 2023 at 11:02:30AM +0530, Souradeep Chowdhury wrote:
> Qualcomm's proprietary Android boot-loaders capture boot time
> stats, like the time when the bootloader started execution and at what
> point the bootloader handed over control to the kernel etc. in the IMEM
> region. This information is captured by the bootloader and populated on
> the device tree properties "pre-abl-time" and "abl-time" which can be
> be viewed from the user space like as follows:-
> 
> /sys/firmware/devicetree/base/bootstats # cat abl_time
> 17898
> 
> As a part of this patch series added the bindings for boot-stats which
> was suggested in the v6 of the series. The link for the same is as
> follows:-

Should boot statistics be exposed to userspace through the qcom socinfo
driver? I see that the socinfo v19 metadata has fields for the boot core
and boot cluster [1], so boot timing wouldn't be out of place.

Brian

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/soc/qcom/socinfo.c#n572

