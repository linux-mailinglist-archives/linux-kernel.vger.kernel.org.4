Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF676CB964
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 10:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbjC1I3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjC1I3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 04:29:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1FD3C34;
        Tue, 28 Mar 2023 01:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03477B81BB2;
        Tue, 28 Mar 2023 08:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8EECC433D2;
        Tue, 28 Mar 2023 08:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679992187;
        bh=SnwELIqmKALLVCVVt5MIOjBTgoc6BuHmgOZFpkq01s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iUJmXpnPtNUiLD/zaG/fChsA4WOoo7LQoP4clU9YqExjtf0qKBmwemJOZfjgvrJ/K
         8U6HksBJ6DuRrDCaQnKIkVguK4WGX5PgAw4pYWDN58AadMK0pv8gt4hC+A5BbWyROa
         UYHwgeRkzTTtuLOVbZzLZXdpxp0HOPKZOUAKlx881s0LRExx3wdXfHjHmAlziFTYip
         aeXz/hnZZwNmvjMwGuGogNXpg29p5TETkktYUTNhd7FZTiGz9Og8MP7tWe+pfXvhJz
         TNdw+yMwe3wyRn6IJr6vJ4kaxuvFZ1+kkjn8Z3+hOQWB49IbrDmam17Fr6lGDgSPH3
         e9vUwJ/fyArCw==
Date:   Tue, 28 Mar 2023 13:59:42 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/12] dt-bindings: interconnect: split SC8180x to own
 schema
Message-ID: <ZCKldukoQxweujzn@matsya>
References: <20230325122444.249507-1-vkoul@kernel.org>
 <20230325122444.249507-6-vkoul@kernel.org>
 <167983963951.350350.7524342280614332456.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167983963951.350350.7524342280614332456.robh@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-03-23, 09:10, Rob Herring wrote:
> 
> On Sat, 25 Mar 2023 17:54:37 +0530, Vinod Koul wrote:
> > SC8180x comes with interconnects having and missing IO address space, and
> > variable number of clocks, so split it from common file for easier
> > maintenance and to fix warnings like:
> > 
> > sc8180x-lenovo-flex-5g.dtb: interconnect-0: 'reg' is a required property
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  .../bindings/interconnect/qcom,rpmh.yaml      | 11 ---
> >  .../interconnect/qcom,sc8180x-rpmh.yaml       | 76 +++++++++++++++++++
> >  2 files changed, 76 insertions(+), 11 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,sc8180x-rpmh.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):

Thanks I have fixed this error, will post v3 soon

-- 
~Vinod
