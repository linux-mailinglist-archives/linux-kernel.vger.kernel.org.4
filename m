Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C71A63FAA6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 23:36:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbiLAWgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 17:36:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiLAWgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 17:36:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DF17CAB1
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 14:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669934109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NDjeEfQppabaCfN3PfZotiNpYUYQN1CVDNNLoD78gq8=;
        b=Wu2KSJzWSU8g+2CQ/5oIrEiL6yhJYRQJB4yk/brshR5wXiuu7m98I5tqOWgdlF7/6bRDrD
        Yeo20IDlmMMTAmDmBPuTTCLQUTsvSfzjpY93yMPlgAxQuMN+KkSuujOWCQ6+p99YaQ7JHW
        zuiiC5Vk4Q94v7rTOQlMEWES9GMUE6M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-493-UeDwJTQONAWwFhqOqkiC4A-1; Thu, 01 Dec 2022 17:35:08 -0500
X-MC-Unique: UeDwJTQONAWwFhqOqkiC4A-1
Received: by mail-qt1-f199.google.com with SMTP id ff5-20020a05622a4d8500b003a526107477so9052139qtb.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 14:35:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NDjeEfQppabaCfN3PfZotiNpYUYQN1CVDNNLoD78gq8=;
        b=iV9RE19eMz5RwcXovtavVcgqQKFFLWWvAAIMzJMHdxEGLdpV/ibHGPAaIaxVWDVII3
         xSkb+Ts7cWT4b31IF9czpE/XiIAlh8bICQVT3QqQcU8+k6btPZ0f+LI8UvrtgvTq9iJ4
         Xx/zCwApRVwZuReeXFnNCXTTvPG3BOeQ6vPIImjJlkSlTXKtyZL2h1t2lQeZ+65JHMUn
         o+2tsgaFkLRMpdploLdKuJhxomHkJnMhKmO0HDUoZLiY6TZRniMzlYpiKXm+ROVpTyWO
         dQaokDgV+FfBup5ebGi8gHKzGAW7yJ/T7iGCEMvTP0gzsrGC3zPvZYvxwA2Ok+zehWk5
         w9rg==
X-Gm-Message-State: ANoB5pmaBaHVGm5FfaONodQjERS0SdAmP9kfY45FLmntoiyOPKE52AxN
        qhULp3CNhIgcevLmHf2B7qEfpUQDKUAyFP0ytEOZvBF9MVb+yq25GgRg6ttKvtJLHz+B+tpvZLw
        Uzw7+93SBXj/0tdd/Nb9ptfLW
X-Received: by 2002:ac8:6e8c:0:b0:3a6:996f:6b9d with SMTP id c12-20020ac86e8c000000b003a6996f6b9dmr126465qtv.42.1669934107404;
        Thu, 01 Dec 2022 14:35:07 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6hTTagE5fWY7R0yg+9BDwvx6R5UWlRr2HG/dP1kllTRaddz/3iuPVVszoraFTXQ2H1LgZBKg==
X-Received: by 2002:ac8:6e8c:0:b0:3a6:996f:6b9d with SMTP id c12-20020ac86e8c000000b003a6996f6b9dmr126447qtv.42.1669934107148;
        Thu, 01 Dec 2022 14:35:07 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id y17-20020a05620a25d100b006e54251993esm4291891qko.97.2022.12.01.14.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 14:35:06 -0800 (PST)
Date:   Thu, 1 Dec 2022 17:35:05 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_shazhuss@quicinc.com,
        psodagud@quicinc.com, ahalaney@redhat.com, echanude@redhat.com
Subject: Re: [PATCH v2] arm64: dts: qcom: sa8540p-ride: enable PCIe support
Message-ID: <Y4ksGdtQAqQQ9Shb@x1>
References: <20221201171931.1919961-1-bmasney@redhat.com>
 <20221201223012.r6mvz4updf3qoilj@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201223012.r6mvz4updf3qoilj@builder.lan>
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

On Thu, Dec 01, 2022 at 04:30:12PM -0600, Bjorn Andersson wrote:
> On Thu, Dec 01, 2022 at 12:19:31PM -0500, Brian Masney wrote:
> > +		vreg_l11a: ldo11 {
> > +			regulator-name = "vreg_l11a";
> > +			regulator-min-microvolt = <880000>;
> > +			regulator-max-microvolt = <880000>;
> > +			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
> > +			regulator-allow-set-load;
> 
> In order to specify regulator-allow-set-load you also need
> regulator-allowed-modes.
> 
> But if I read the implementation correction, we don't actually alter the
> load, so perhaps best to just omit this for now?

I can drop regulator-allow-set-load in v3. I almost left it off and
verified the other day that PCIe still works without it.

Brian

