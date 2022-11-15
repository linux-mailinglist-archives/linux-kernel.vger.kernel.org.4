Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2A562993B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:51:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbiKOMvc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiKOMv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:51:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A753227DE6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668516625;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9DCj0kCx4cYGdqfJpXlu7fgvdW5ocqgYyNocj0wf4U=;
        b=L08Ft+At3yjmpWCnfpe2IsqMdTiqzd0QH4+b0kubV7SILjp4YfAOQlM+kUeGwE41MUem1e
        TqRB7WDrDt91B4POZwzsb08PtPJh9eQPPRrcLfqlmbBe4VkkIstSIYe6jldrz5M8zCqkZ3
        fQeJrdR9ecEf0KDJ21t+jjedAtgWFO0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-O2prNv1VP0SnVcjMMIQNBQ-1; Tue, 15 Nov 2022 07:50:24 -0500
X-MC-Unique: O2prNv1VP0SnVcjMMIQNBQ-1
Received: by mail-qt1-f198.google.com with SMTP id f4-20020a05622a114400b003a57f828277so10300799qty.22
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l9DCj0kCx4cYGdqfJpXlu7fgvdW5ocqgYyNocj0wf4U=;
        b=IS/GCbT7Z39k0SZCh7La/O87EoAuC60IAN11DI3NRLCEw5Bmdctpequ91V0ctq+qK+
         fkl3dY+UnN1z7ZvQYN+QmoAaSs/T/6BvMzKk0YnXd0mM3cqnHCfzf0Y+yg3btVfMP/Ms
         lEjWvYFel4bch8Fr0h6TEjw4At8s4pw3WWfn1ftmDFpRQpTAMJvqhtH+GEzOQL1X+k64
         lNOjl6MHG34r1pn8SoPyL7BHfrA8RLRSw7CPBVNNHN2zfVjq9O2PP7VXCf9jSd9LJ6W7
         9E1YahNDL1+h5Wj3lR5iPHZlJK2UiJWUoUupxDQ9rIytWATla14QDz8s7OzF67m0VeTr
         G4RA==
X-Gm-Message-State: ANoB5pm0AoSTXk9QcwIgQ9kFW6Jk4PicnQcTqc5KkacAmsNTPg/SS5ol
        qcn0SJh2EsRSUbPs2fcSC7eC4N8eugGVfIVPW2HIK+KJbzPd9qwHMTDpxuFEKkjjBoPhKXblJLD
        vJZ5e9rnrFA5nK/HNlU6ewZHN
X-Received: by 2002:a05:622a:198a:b0:3a4:fa82:c3b8 with SMTP id u10-20020a05622a198a00b003a4fa82c3b8mr16554531qtc.261.1668516624435;
        Tue, 15 Nov 2022 04:50:24 -0800 (PST)
X-Google-Smtp-Source: AA0mqf53dlb3gmpGIvub1w7SAuwsd2MfqfG78wQcAtKtesih8S4x8a5qEDhjUdFAnArbQGs8s3g3JQ==
X-Received: by 2002:a05:622a:198a:b0:3a4:fa82:c3b8 with SMTP id u10-20020a05622a198a00b003a4fa82c3b8mr16554509qtc.261.1668516624214;
        Tue, 15 Nov 2022 04:50:24 -0800 (PST)
Received: from x1 (c-73-214-169-22.hsd1.pa.comcast.net. [73.214.169.22])
        by smtp.gmail.com with ESMTPSA id f21-20020a05620a409500b006fa4a81e895sm8411248qko.67.2022.11.15.04.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:50:23 -0800 (PST)
Date:   Tue, 15 Nov 2022 07:50:22 -0500
From:   Brian Masney <bmasney@redhat.com>
To:     Shazad Hussain <quic_shazhuss@quicinc.com>
Cc:     andersson@kernel.org, johan@kernel.org, sboyd@kernel.org,
        agross@kernel.org, mturquette@baylibre.com,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] clk: qcom: gcc-sc8280xp: add cxo as parent for three
 ufs ref clks
Message-ID: <Y3OLDj6xzOVjvEdV@x1>
References: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115102217.6381-1-quic_shazhuss@quicinc.com>
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

On Tue, Nov 15, 2022 at 03:52:17PM +0530, Shazad Hussain wrote:
> Added parent_data as CXO for three UFS reference clocks named,
> gcc_ufs_ref_clkref_clk, gcc_ufs_card_clkref_clk and
> gcc_ufs_1_card_clkref_clk.
> 
> Fixes: d65d005f9a6c ("clk: qcom: add sc8280xp GCC driver")
> Link: https://lore.kernel.org/lkml/Y2Tber39cHuOSR%2FW@hovoldconsulting.com/
> Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>

Put this Link beneath the --- since Bjorn will add one that's specific
to your patch when he adds it to his tree.

With that change:

Reviewed-by: Brian Masney <bmasney@redhat.com>

