Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB93A662C6E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 18:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237109AbjAIRPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 12:15:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjAIRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 12:15:14 -0500
Received: from relay06.th.seeweb.it (relay06.th.seeweb.it [IPv6:2001:4b7a:2000:18::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB73C574D4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 09:14:22 -0800 (PST)
Received: from SoMainline.org (unknown [89.205.226.190])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 51DBC3EF10;
        Mon,  9 Jan 2023 18:14:20 +0100 (CET)
Date:   Mon, 9 Jan 2023 18:14:18 +0100
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: reserved-memory: rmtfs: Make
 qcom,vmid an array
Message-ID: <20230109171418.kxz4jwwxrgamaylt@SoMainline.org>
References: <20230109093947.83394-1-konrad.dybcio@linaro.org>
 <2bc5d781-499b-fe39-2dc5-92bc9ba8396d@linaro.org>
 <97dafa30-8b76-8bf9-4411-be6d10e4c71a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97dafa30-8b76-8bf9-4411-be6d10e4c71a@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-01-09 12:41:00, Konrad Dybcio wrote:
> 
> 
> On 9.01.2023 10:51, Krzysztof Kozlowski wrote:
> > On 09/01/2023 10:39, Konrad Dybcio wrote:
> >> Some SoCs mandate that the RMTFS is also assigned to the NAV VM, while
> >> others really don't want that. Since it has to be conditional, turn
> >> qcom,vmid into an u32 array so that we can handle the NAV case, as
> >> well as other similar ones if they pop up in the future.
> >>
> >> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> >> ---
> >> v2 -> v3:
> >> Rewrite to accomodate for changes, don't pick up tags
> >>
> >>  .../devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml   | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> >> index 2998f1c8f0db..cfc2fda30eba 100644
> >> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> >> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> >> @@ -27,9 +27,9 @@ properties:
> >>        identifier of the client to use this region for buffers
> >>  
> >>    qcom,vmid:
> >> -    $ref: /schemas/types.yaml#/definitions/uint32
> >> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> >>      description: >
> >> -      vmid of the remote processor, to set up memory protection
> >> +      Array of vmids of the remote processors, to set up memory protection
> > 
> > You need now min and maxItems.
> Hm, I tested it with and without:
> 
> minItems: 1
> maxItems: 2
> 
> on DTs with either one or two VMIDs defined and neither complains..

This sounds like a constraint, so it'd only fail on DTs with zero or
more than two VMIDs (when min/maxItems is present, no complaints
otherwise).

- Marijn
