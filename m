Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA186512AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbiLSTSc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:18:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbiLSTSP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:18:15 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91FB812767
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671477442;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lw/Fj1Iw2Xi8gGiXlXcO2+qBIKUYLL1c1CqizXCd5bE=;
        b=NwoecDWtM6YJyoBm8+fMH5gVBwg3M625GWg0C4HL7E92BGvJ2QFr9Z7BbyI9627Xwu/++Y
        jHAXRVzRgKrkJSKOoIA2heKJKcTvqaDb32LHGx2fG/SVwbuKihJJueD+kCl+6XLvu+aYS0
        bToAQIbrpEm3KC3Odv0pUOF8erKBaNY=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-638-Py433fNVN2mM5RJnQ3MKFw-1; Mon, 19 Dec 2022 14:17:21 -0500
X-MC-Unique: Py433fNVN2mM5RJnQ3MKFw-1
Received: by mail-ua1-f69.google.com with SMTP id c1-20020a9f3d81000000b00418b667e367so4150297uai.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:17:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lw/Fj1Iw2Xi8gGiXlXcO2+qBIKUYLL1c1CqizXCd5bE=;
        b=TzmLYcXSVI1Aft5mJI0HKV5ZAPxXXRuam3jTJfstj62jgQF6b+EO2ko1MIKKPbr54e
         3U+GlW2ztiZztWdVAf8JOEOyiO5OMySEhcZsCTptZTg86da6Sbo1yHNv5JShL4xMP7WP
         B74g9pBgeQ5DTehIu75PApkNGUZe+WLq3PA3dLB0UFo1WtwP9uGtgD5zwJds54wAaMTu
         IKn5GWHABse7Vayb3XnZTWFpN7WLCqyySxtBTlUxgLt2oIRYX8IWyvsvk+PVyhQjEgyZ
         hrwLM5dvTf7rmtS8TshwC5HhCiFBoGl+zVuI4QtGTrEb1XF1vVmvIczEo4Aj5fJCcSog
         vm+g==
X-Gm-Message-State: ANoB5pkrWyDlPuUU3oucPDi0fiQDMUDEG9VnRbNLo/oOly+y5QolYfvT
        9YoJCW8tN940mMuWGIx3xnRPuTWBicr5cZQSDsJCtuget5JHx5XOE7nHpm2C1x0jB2/PK+lQvGD
        sYI0iA1WlIfDXx5IT3Lk5cT5A
X-Received: by 2002:a05:6102:3083:b0:3b1:4937:2877 with SMTP id l3-20020a056102308300b003b149372877mr23080827vsb.21.1671477436389;
        Mon, 19 Dec 2022 11:17:16 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4iWPbVRwLj078zkvGVS/rMXaSWd3/HYmSgeJhJHRGIOBQ4Q1rAtNoBQr169ipCDx2TZD4nMw==
X-Received: by 2002:a05:6102:3083:b0:3b1:4937:2877 with SMTP id l3-20020a056102308300b003b149372877mr23080807vsb.21.1671477436170;
        Mon, 19 Dec 2022 11:17:16 -0800 (PST)
Received: from localhost (pool-71-184-142-128.bstnma.fios.verizon.net. [71.184.142.128])
        by smtp.gmail.com with ESMTPSA id bp43-20020a05620a45ab00b006fb7c42e73asm7668029qkb.21.2022.12.19.11.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 11:17:15 -0800 (PST)
Date:   Mon, 19 Dec 2022 14:17:15 -0500
From:   Eric Chanudet <echanude@redhat.com>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andrew Halaney <ahalaney@redhat.com>,
        Brian Masney <bmasney@redhat.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: rename pm8450a dtsi to
 sa8540p-pmics
Message-ID: <20221219191715.7vhu2wtrs45zvmh4@echanude>
References: <20221216232606.2123341-1-echanude@redhat.com>
 <20221216232606.2123341-2-echanude@redhat.com>
 <7b6e1c29-4e33-b66c-00c8-836a62a0941d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7b6e1c29-4e33-b66c-00c8-836a62a0941d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2022 at 03:36:58PM +0100, Konrad Dybcio wrote:
> On 17.12.2022 00:26, Eric Chanudet wrote:
> > pm8450a.dtsi was introduced for the descriptions of sa8540p based boards.
> > Rename the dtsi to make this relationship explicit.
> > 
> For the descriptions of PMICs used on SA8540p based boards, I suppose?

Absolutely, thanks! Amended in v4:
https://lore.kernel.org/linux-arm-msm/20221219191000.2570545-1-echanude@redhat.com

-- 
Eric Chanudet

