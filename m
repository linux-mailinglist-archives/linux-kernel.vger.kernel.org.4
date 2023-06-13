Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E2472E63B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 16:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242808AbjFMOuj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 10:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242663AbjFMOuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 10:50:18 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2041BEC
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so5555473f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686667811; x=1689259811;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H2LLCez9aorcxAr6mSzBcwQNd+MPuO36BbwLgK2xh80=;
        b=GNp8m+qsxqEl+uS7Tj6/6ghamE63p/fkyDZ4FlqympcOKezI09QyLFWw6gsaaWaeRP
         6T4/9HF5oCvqhyDDUONSs+bmprePA197Xp6i2YKkYNBf8ucQ7TX2o7yDp24OezhysMwJ
         j0dSGYthm1DrdwA0vK64qtjtE0RaStH4MxIu+KXZdv95hJYpmMOFzdObAYShcGSdAIyR
         Cw2PdTZiifXZw6I6wm/NoYyeqioLCVY1mQOTpO8TAIGou/K0ghfylKeSqJ5TmtT2CoZl
         /j8l3uYOldh+7wCe6dCPTHwFShMCLdsdm4EgwtO8xs3E3K2zEbVnQSH7uLfNtqXRIO0P
         yMZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686667811; x=1689259811;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H2LLCez9aorcxAr6mSzBcwQNd+MPuO36BbwLgK2xh80=;
        b=ASZQ35yu8Jd9ow7dhHWZPhvDDaqknvhiGtJ+FakT2bFN0cnZMIu5rQ0QyxPBl9yJcR
         6kP2/ffwVKgH9rZ4tmVt+M8r7P2r4s7M9mHN0OBSbPeD1H7CLTTyGirVrg4GmuYBYu2m
         ve9qXF8D10B81C/qH9EmdKUmEM8nrJZLiomqLeJD3S0aeE78/4GivjrWxUejqDWus2VW
         POz9X/Xsdx4fQCFQMJlUIJuJsHRCmejIGeJFFj0q25OKjrNu9Kdi1aG+l0Z7Dn319ZEl
         D5IK5NRn3wbnH1lrWsRQO7wKNqhYKbEqYhNAqEB2jPQeSAoLge3l598qPVzE9sLV6p7H
         673g==
X-Gm-Message-State: AC+VfDwtc/PzJZ2NgMEpNnakQUVY2FODf5+c/0HLEVU5ioW0aGYFXsMK
        PioGoY8wWB9HjHyvmZhBHCY5xg==
X-Google-Smtp-Source: ACHHUZ7eGVSDoeg1Bfhp4x5ZFfL5I2seRfwd15tZuEAp+bh9gjMZRf3wcAUjugSkGVsqFF7c2iXLNA==
X-Received: by 2002:a5d:678e:0:b0:30f:c2a3:6281 with SMTP id v14-20020a5d678e000000b0030fc2a36281mr4373158wru.64.1686667810982;
        Tue, 13 Jun 2023 07:50:10 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id l15-20020adff48f000000b003078cd719ffsm15623356wro.95.2023.06.13.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 07:50:10 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v3 0/2] typec: add support for the ON Semiconductor
 nb7vpq904m Type-C Linear Redriver
Date:   Tue, 13 Jun 2023 16:50:06 +0200
Message-Id: <20230601-topic-sm8x50-upstream-redriver-v3-0-988c560e2195@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAB6CiGQC/5XOOw7CMBAE0Ksg1yyyDbECFfdAFP5skpWCHa2DB
 UK5OyYdHZQzxZt5iYxMmMVp8xKMhTKlWMN+uxF+sLFHoFCz0FLvpZEK5jSRh3xrH42E+5RnRns
 DxsBUkMGgNgpDaLw7iIo4mxEc2+iHysT7ONZyYuzosa5erjUPlOfEz/VEUZ/2572iQIKxQSt5P
 HSd6c4jRctpl7gXH7vo/zxdvRBse3RaO+Xll7csyxsAR5hOMgEAAA==
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2276;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=xXZb2OsyboZyYfVP+VKtPE7/v/WGx8/ToNBGnKZ/IT8=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkiIIgLITaA7eP/fNWa/QjYWht2TUsg0D8FucwHCcg
 6Le2PVOJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZIiCIAAKCRB33NvayMhJ0St0D/
 9imOc47cGQcR65ep/fNb56nj985Ex5H5OMEliEALAkiw8AgOGErgZD0RNfWCklE1R9OjW1Zm4/VnNm
 usZnQgG71t2Ge9hFWfGOQkjDsbMULtpgQRqzexauMVtEFkVe+nq4wcCetjEtyjd9bEf/t+n0Lmtu+2
 BRTmgbhy2/OpY0qJ+kxfV6vuOaNxf2/WgMZ73DKJAWkFZFAmh45FR2FSPG+jk64Sojtxw0Bfr5mH3m
 afc71i0Q/50rp/tzMxzSq2IazinUlx1I5yPCvINH3Sp7aJIlvUCa9Gon7BNpCd3lyprzmx9EhtC80T
 OTC7R0t1gCr9/vbWlzTEdXhzq5caHDmY3NACHRcnTYy1gu8m82hnvpT39RxtDF3ntCrANgh/QQMm8P
 t2n/xNVIp74eMgI11XH5UgXsV9SgsyXKYtOvYiuLEe+lBn2N50AV1QO8HmSDIL9NwZub5UG9mxmDwY
 tGNls+xgVp0FjJ+Zn0aurj4R8/3zyBye5PyYpHG1KzZ/eUR6S3f2/gmmo6YTZc1AD0w0AMP01t5jEg
 c6F5E/ur/ZJl+MKvzw95PtZ7OP/ERcB2qA/rhrMR/V5c9kPzZ81/awmMxwYMYceYFqlkc1Yb3tKk5P
 OR/otrEM+lJYK5DmlBOUHaK61Ddz9W3cEOFh0Ql2T3d21xgn7RvugWb46LzA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the ON Semiconductor NB7VPQ904M Type-C USB SuperSpeed
and DisplayPort ALT Mode Linear Redriver chip found on some devices
with a Type-C port.

The redriver compensates ultra High-Speeed DisplayPort and USB
Super Speed signal integrity losses mainly due to PCB & transmission
cables.

The redriver doesn't support SuperSpeed lines swapping, but
can support Type-C SBU lines swapping.

Support is designed as a Type-C Switch and Retimer, and can propagate
orientation settings to the source endpoint, which is usually
a Super Speed PHY which does the data lanes swapping.

Bindings are added first and can handle the fact data lanes pairs
can be swapped on the PCB.

Compile-time dependencies:
- svid removal at [1]

[1] https://lore.kernel.org/all/20230526131434.46920-1-heikki.krogerus@linux.intel.com/

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v3:
- Include bitfield.h
- Use correct -EOPNOTSUPP
- Correct nb7vpq904m_sw_set line wrapping
- Link to v2: https://lore.kernel.org/r/20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org

Changes in v2:
- Switch to "retimer" infrastructure
- Slight style fixups after switch to retimer
- Bindings updates (did not keep Reviewed-by tag for those reasons)
 - Update maintainer, was using Bjorn with invalid email
 - Fixed swapped lanes mapping
 - Switched to retimer-switch
 - Fixed i2c top node in example
- Link to v1: https://lore.kernel.org/r/20230601-topic-sm8x50-upstream-redriver-v1-0-6ad21094ff6f@linaro.org

---
Dmitry Baryshkov (1):
      usb: typec: add support for the nb7vpq904m Type-C Linear Redriver

Neil Armstrong (1):
      dt-bindings: usb: add ON Semiconductor nb7vpq904m Type-C Linear Redriver bindings

 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   | 141 ++++++
 drivers/usb/typec/mux/Kconfig                      |   8 +
 drivers/usb/typec/mux/Makefile                     |   1 +
 drivers/usb/typec/mux/nb7vpq904m.c                 | 529 +++++++++++++++++++++
 4 files changed, 679 insertions(+)
---
base-commit: ac9a78681b921877518763ba0e89202254349d1b
change-id: 20230601-topic-sm8x50-upstream-redriver-6e261edd5cb4

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

