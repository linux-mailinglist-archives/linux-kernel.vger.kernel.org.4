Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A49A86CCE0F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 01:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjC1XcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 19:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjC1XcR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 19:32:17 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F89E2D54;
        Tue, 28 Mar 2023 16:32:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PmQvJ6Svyz4whh;
        Wed, 29 Mar 2023 10:32:12 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680046333;
        bh=5yG87VHs92Xl+Vpgs298j+jJMm6F2l+DPLtX816uWKk=;
        h=Date:From:To:Cc:Subject:From;
        b=ozRLcVgkaV+IOuQ2qHyTB91B4TId5VlIeKy+Uay0Fj8cyemkLXhP5XYh06DQC+08+
         o/VhhVgmXmjtgtRuOiZE8wVltugDGVvFguSRZemzKiIlt8uw+Ro1XsQT30bd+SKiuu
         xvZA6VlSJF2e7b9hU+B7Y2TlKg+ssco0dKCI9oeDySbZoFXKC5YKjMIRl5gMkxCgw1
         Ni+QRC63oAS1A7xjFFmmOFB/u/VfyH/rEdgaafEjFXidr2qv4eppcBSODHwUtSOi8b
         x3/sG82MwGKTK4QUf1NcU8tTUiyTEq8qpvDdFIb4rJJbhJSz10JEZ8EMDFlrG8Mr8c
         0oY9ZCjU/JOFQ==
Date:   Wed, 29 Mar 2023 10:32:11 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Herring <robherring2@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Subject: linux-next: manual merge of the devicetree tree with the sound-asoc
 tree
Message-ID: <20230329103211.68563bfd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/qJujE8wC0rtlAIq7njPnaAY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/qJujE8wC0rtlAIq7njPnaAY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the devicetree tree got conflicts in:

  Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
  Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml

between commits:

  e4cf7805f084 ("ASoC: dt-bindings: qcom,lpass-rx-macro: narrow clocks per =
variants")
  bf4afbf95093 ("ASoC: dt-bindings: qcom,lpass-tx-macro: narrow clocks per =
variants")

from the sound-asoc tree and commit:

  d0dcd0ce8437 ("dt-bindings: yamllint: Require a space after a comment '#'=
")

from the devicetree tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
index 78e462e2cdcf,e6fcf542cf87..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-rx-macro.yaml
@@@ -50,65 -61,6 +50,65 @@@ required
    - reg
    - "#sound-dai-cells"
 =20
 +allOf:
 +  - $ref: dai-common.yaml#
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sc7280-lpass-rx-macro
 +    then:
 +      properties:
 +        clock-names:
 +          oneOf:
-             - items:   #for ADSP based platforms
++            - items:   # for ADSP based platforms
 +                - const: mclk
 +                - const: npl
 +                - const: macro
 +                - const: dcodec
 +                - const: fsgen
-             - items:   #for ADSP bypass based platforms
++            - items:   # for ADSP bypass based platforms
 +                - const: mclk
 +                - const: npl
 +                - const: fsgen
 +
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sc8280xp-lpass-rx-macro
 +            - qcom,sm8250-lpass-rx-macro
 +            - qcom,sm8450-lpass-rx-macro
 +    then:
 +      properties:
 +        clocks:
 +          minItems: 5
 +          maxItems: 5
 +        clock-names:
 +          items:
 +            - const: mclk
 +            - const: npl
 +            - const: macro
 +            - const: dcodec
 +            - const: fsgen
 +
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sm8550-lpass-rx-macro
 +    then:
 +      properties:
 +        clocks:
 +          minItems: 4
 +          maxItems: 4
 +        clock-names:
 +          items:
 +            - const: mclk
 +            - const: macro
 +            - const: dcodec
 +            - const: fsgen
 +
  unevaluatedProperties: false
 =20
  examples:
diff --cc Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
index 9d6e67524daf,6c8751497d36..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,lpass-tx-macro.yaml
@@@ -55,65 -67,6 +55,65 @@@ required
    - reg
    - "#sound-dai-cells"
 =20
 +allOf:
 +  - $ref: dai-common.yaml#
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sc7280-lpass-tx-macro
 +    then:
 +      properties:
 +        clock-names:
 +          oneOf:
-             - items:   #for ADSP based platforms
++            - items:   # for ADSP based platforms
 +                - const: mclk
 +                - const: npl
 +                - const: macro
 +                - const: dcodec
 +                - const: fsgen
-             - items:   #for ADSP bypass based platforms
++            - items:   # for ADSP bypass based platforms
 +                - const: mclk
 +                - const: npl
 +                - const: fsgen
 +
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sc8280xp-lpass-tx-macro
 +            - qcom,sm8250-lpass-tx-macro
 +            - qcom,sm8450-lpass-tx-macro
 +    then:
 +      properties:
 +        clocks:
 +          minItems: 5
 +          maxItems: 5
 +        clock-names:
 +          items:
 +            - const: mclk
 +            - const: npl
 +            - const: macro
 +            - const: dcodec
 +            - const: fsgen
 +
 +  - if:
 +      properties:
 +        compatible:
 +          enum:
 +            - qcom,sm8550-lpass-tx-macro
 +    then:
 +      properties:
 +        clocks:
 +          minItems: 4
 +          maxItems: 4
 +        clock-names:
 +          items:
 +            - const: mclk
 +            - const: macro
 +            - const: dcodec
 +            - const: fsgen
 +
  unevaluatedProperties: false
 =20
  examples:

--Sig_/qJujE8wC0rtlAIq7njPnaAY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQjePsACgkQAVBC80lX
0GymhggAh5443/DElEw9t+EMBuTZogcDDtv6S9vEeA7rUqp3zzng6bKJ8rDKGKWr
xCFCMG38LO3acbreBohSCYu5aPD2CEnl168KTq9lu/WaAGGj2nhE6iO8Tagxu46y
eXSCCln3hXQEcbCYWftHK56GwnrjpBxJuujx7D9yQleMQTuZPLws2Xpd5eM59vK6
UTQmVuLhSSnp20vLIyemKK39SqVfoPc9enovdMJAi3bX438l7hoO0ZS1RIZrwy4u
MZ3zEoKuXYygAFuTqkJxknmc/3m2KhcvAq6wcF4Y3wg50d0SQCFUDlsaQFjKqG+s
7wirGmKbUNAwedq6FUFF5aU7WwJfzg==
=ugvw
-----END PGP SIGNATURE-----

--Sig_/qJujE8wC0rtlAIq7njPnaAY--
