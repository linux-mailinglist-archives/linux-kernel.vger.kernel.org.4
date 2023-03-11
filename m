Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 291636B5F4A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 18:42:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjCKRm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 12:42:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjCKRmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 12:42:51 -0500
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F613A86B
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:42:25 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id m6so10689752lfq.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 09:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678556438;
        h=from:cc:to:in-reply-to:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gucexyEn/MXQiixU059a1/bhO0FmHxte+9JfrT4eP5U=;
        b=Cgfe5XDz8SfS8eTf0QpykdXbG9cYrS5ve/IsdOeifiD8XvdIovBySvXxPngq0F97rQ
         joKlicMIS+PAO3OnzTGZLa5z+gmOy0X1oF8NgsCnj60wOnAWw3n6fCQcGxQMulaD4cAR
         ZlD9udOgMQhr4DUyH2JErtCXToXb7TPODWg88qShBvnqMadV1iGpJP2JvF/Fv1SCZ7T9
         gCQ490dqwkbnd3ghW+AATEslDPpSJatoqmmADdVFqwPR3xKcw+HrJG5UAHjTGM5kt3Je
         7ggLmve6k3mhA6GMFNgS1+rgn+SFge/pSAvS13PYnrxIhCx7XykEwAoqtbXH+59n8sPW
         C7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678556438;
        h=from:cc:to:in-reply-to:message-id:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gucexyEn/MXQiixU059a1/bhO0FmHxte+9JfrT4eP5U=;
        b=TO0uMAOhPul4unPtsA2BKnkosBGIt0YavnrQlt8Sj3wzU+2Zbdh8TV4Yui963YIxFR
         LxMCJ2OIvmgPigpy7qPptO5tvs+xGDzP9stVwWm21aYgqDUR543sTVG2ZrGvewtV0usm
         chiPcDSHeZWCtd9rpjDG+Z+JaG6hy19wA8u7rw7my7V7wC4vtlYysaco4G2b/WASCzYS
         7TsvEIcLqyEVwci+2kpF5EoH51njGlMR3BwU4/MkDM0VXqm0475ey8y3brL9VImfDrBj
         nSneEpVpiNDdXKHqNaUP/btuwBG86ZQExf5RM071ReYwAbfLYPfUqrbu7Q7nHBjQG9Dl
         omAA==
X-Gm-Message-State: AO0yUKU7hNU0z5t4XY2HEixwEK3cJ70tZSB91aRjToTp6cVKMXW8qT98
        rpV44rG1IWHXEYxuraHCnyMK1KBHTmrX4Cf6Udo=
X-Google-Smtp-Source: AK7set/ByuxH07OIf+rsMYJEm0uHwVrIPBdKlVOsrrd7+dQNsUrstq4Ogt/j521YGIaIFan1XLNqGQ==
X-Received: by 2002:ac2:5a4c:0:b0:4dc:7ff4:83f9 with SMTP id r12-20020ac25a4c000000b004dc7ff483f9mr8776360lfn.16.1678556438124;
        Sat, 11 Mar 2023 09:40:38 -0800 (PST)
Received: from letter.txt (46-138-144-249.dynamic.spd-mgts.ru. [46.138.144.249])
        by smtp.gmail.com with ESMTPSA id q26-20020ac24a7a000000b004cb3fbc7925sm377977lfp.77.2023.03.11.09.40.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 09:40:37 -0800 (PST)
Date:   Sat, 11 Mar 2023 09:40:37 -0800 (PST)
Message-ID: <c13993bc-9d12-f20e-de27-fa0b8a58ed33-1-sleirsgoevy@gmail.com>
In-Reply-To: <c13993bc-9d12-f20e-de27-fa0b8a58ed33@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>
Cc:     linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
From:   Sergey Lisov <sleirsgoevy@gmail.com>
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MISSING_SUBJECT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > ---
> >  .../devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml    | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > index 8dfad89c7..2bc5ac528 100644
> > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc-common.yaml
> > @@ -57,6 +57,12 @@ properties:
> >        force fifo watermark setting accordingly.
> >      $ref: /schemas/types.yaml#/definitions/flag
> >  
> > +  fifo-access-32bit:
> 
> Missing type boolean.

Thanks, will add the same $ref as for the entry above.

> > +    description:
> > +      Specifies that this device requires accesses to its 64-bit registers
> > +      to be done as pairs of 32-bit accesses, even on architectures where
> > +      readq is available.
> 
> And why the device would require this? If it has 64-bit registers in the
> first place, they can be accessed in 64-bit. Otherwise these are not
> 64-bit registers, but just lower/upper 32-bit, right?
> 
> Also, why this cannot be implied from compatible? Why different boards
> with same SoC should have different FIFO access?

It probably can be implied, but I am not exactly sure on which boards it
affects, so I decided to go for a new devicetree option. Anyway, the same
argument applies to the "data-addr" property, which is already in the
spec, so I supposed that adding such knobs is fine.
