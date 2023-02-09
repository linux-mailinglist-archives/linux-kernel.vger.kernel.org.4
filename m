Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E1E690E98
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 17:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBIQq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 11:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjBIQq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 11:46:56 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45754E078;
        Thu,  9 Feb 2023 08:46:51 -0800 (PST)
Received: from g550jk.localnet (unknown [62.108.10.64])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 1045ACE004;
        Thu,  9 Feb 2023 16:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=z3ntu.xyz; s=z3ntu;
        t=1675961210; bh=WzP22PkUOOEnYEsiechqbOaqD/J6AkmB473A99UfdqE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=noIvF3ES5jB7bjscHwRtjP6qOggwXUwlBBhYkn/6v85fSxTU5X2lstNdwG1Tn/5S7
         EB2AnNp2c5TqTf7JfiSzg/Gj1iEFCXkgSQJ3dykyQTEbtmT/Qyh36thygHSVWof75g
         dNNOmPF1jBlHFfyo6ouNIiPwQBCoiKzDUXLnRIME=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Date:   Thu, 09 Feb 2023 17:46:48 +0100
Message-ID: <2665862.mvXUDI8C0e@z3ntu.xyz>
In-Reply-To: <167572017056.1564123.13342855865502188090.robh@kernel.org>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <167572017056.1564123.13342855865502188090.robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Helen Koike

On Montag, 6. Februar 2023 22:50:08 CET Rob Herring wrote:
> On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
> > Convert the text-based dt-bindings to yaml.
> > 
> > Changes from original txt:
> > * Take wording for various properties from other yaml bindings, this
> > 
> >   removes e.g. volt amount from schema since it isn't really relevant
> >   and the datasheet is a better source.
> > 
> > * Don't make reset-gpios a required property since it can be tied to
> > 
> >   DOVDD instead.
> > 
> > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > ---
> > 
> >  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
> >  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101
> >  +++++++++++++++++++++ MAINTAINERS                                       
> >  |   1 +
> >  3 files changed, 102 insertions(+), 41 deletions(-)
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/medi
> a/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required property From
> schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required
> property From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required
> property From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required
> property From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/i2c/ovti,ov2685.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required
> property From schema:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> ia/i2c/ovti,ov2685.yaml

Looks like rockchip-isp1.yaml uses very incomplete sensor examples in their 
binding example, which sort of makes sense since those bindings are showing 
the rockchip isp bindings and contain the bare minimum to show how a sensor is 
connected in dt.

Not sure how to solve this - ov2685 is also one of three sensors that are used 
very abbreviated there.

Regards
Luca

> 
> doc reference errors (make refcheckdocs):
> 
> See
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230206-ov2
> 685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.




