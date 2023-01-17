Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF2D66D41B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbjAQCJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbjAQCJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:09:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECCF92A17B;
        Mon, 16 Jan 2023 18:08:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B14860F75;
        Tue, 17 Jan 2023 02:08:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB4C6C433EF;
        Tue, 17 Jan 2023 02:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673921331;
        bh=du8shApGKSAEIiVDS61csE3tLeRUz3d2271MWxyE6Lc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mlFbAva7gfMg5nvBjGmyKoSxNqLGYv6ZI1S/ke+GlvF7HDfZxKtMXS9Mps4bpvCma
         WNjaScNa/nG/otzAx1z8/k/E3ANav7RNFMSv6srplZ9hDPy7YqJaob1YngjKZ61SCE
         QFhIgMxeieEE/iOTlrb4tr+fLq78GHtCas8IendDMsZkv86ou2dFZEjsZFb0RbF378
         6Wqw0py64CDJJhysgali38CcE9SNQbIUBJWmBj6aoPTgT7ZIizksGWQSTU0ViN0Jqb
         n7aSdkd1um0aPTjYr3qhhaQFX8ZsH79aLa8JckEiV4v5RCI1nM5BkYLVKrh4h6J727
         clk6z7zTX6fUQ==
Date:   Mon, 16 Jan 2023 20:08:48 -0600
From:   Bjorn Andersson <andersson@kernel.org>
To:     Steev Klimaszewski <steev@kali.org>
Cc:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>,
        Johan Hovold <johan@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v2 3/4] soc: qcom: pmic_glink: Introduce altmode support
Message-ID: <20230117020848.7i4znoynf6q5vtom@builder.lan>
References: <20230113041132.4189268-1-quic_bjorande@quicinc.com>
 <20230113041132.4189268-4-quic_bjorande@quicinc.com>
 <CAKXuJqhAFc=YQOYw7tKW5D0AW9S+QfutwgxD3sK2M9+HNtOqfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKXuJqhAFc=YQOYw7tKW5D0AW9S+QfutwgxD3sK2M9+HNtOqfQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 15, 2023 at 01:10:14PM -0600, Steev Klimaszewski wrote:
> > diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
[..]
> > +       msg = data;
> > +       notification = le32_to_cpu(msg->notification);
> > +       port = FIELD_GET(SC8180X_PORT_MASK, notification);
> > +       orientation = FIELD_GET(SC8180X_ORIENTATION_MASK, notification);
> > +       mux = FIELD_GET(SC8180X_MUX_MASK, notification);
> > +       mode = FIELD_GET(SC8180X_MODE_MASK, notification);
> > +       hpd_state = FIELD_GET(SC8180X_HPD_STATE_MASK, notification);
> > +       hpd_irq = FIELD_GET(SC8180X_HPD_IRQ_MASK, notification);
> > +
> The kernel test robot keeps complaining about these FIELD_GET because
> there is no #include <linux/bitfield.h>
> 

I must have missed those complains before, thanks for pointing it out!

Regards,
Bjorn
