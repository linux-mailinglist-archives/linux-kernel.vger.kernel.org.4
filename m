Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788D06E9041
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjDTKcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234617AbjDTKcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 06:32:03 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0365B95
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:36 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id xi5so5081943ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 03:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681986574; x=1684578574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Id43mOP6UK9z4gfdr/ZZwWU9QENxw9x0rDYGZW5vVuU=;
        b=pbekppmVxmjFbdkMB81jqn2ywgoC4t2mJ0TW8mezUFQpZEOEQU8mR+2I0axBcQ77gX
         KblBXWBaSVX4CDVvFVv0abtn/NnXbluBWebIx6occ9gE/ittrMwM/LJg75PisRt+bXNa
         151qo+latkFkQ4FZkHekMP04c1iizem+Sd7MZZ9ayztfECmxowiUH9fljAGqioCArAA2
         JtXN6vYm3M1s8K3Jr3NzjXntC3gaSGPNjCALY4aFATsmTwwYPnImXL1DQhnNc2sL9zFY
         rcAkfNMJPWjSSRAe2S033wWlFH9o2sHnBL+j8h77cOyP3/AXq7hFFUn2L9K++FK/TABS
         cJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681986574; x=1684578574;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Id43mOP6UK9z4gfdr/ZZwWU9QENxw9x0rDYGZW5vVuU=;
        b=Vjh9XQmvcc5RCtL96WOiicqZHFs3Gz6nlVt3neYcVB57EdYwA3+r8sprJE3rHKoNOn
         9hvONU/tfyY33UpQNDRb/NlAXO9nUcFFfdxME6Di55m7d8uBLeizbTNkBHF8WrH4/qoz
         KQdJeI6NS1Pc8IsYKoBEkPLV0q1G8ZlMkgDYh/6SKbSG92OoDkYWuC8ig783Og5BBQkL
         Jb7jN5oxjo1RFFtOOv4E00Jul+4Er8rWIAIbdKagwaLjQfbSBnFudHiLmdxErMRDPyOf
         ohMcPHGrjHKWlEXV4J+rUQ8Mg3jNgITIIGBZ/Y6RrjGRpr4CTK0HSNSDE3ZB6GsilLse
         THKA==
X-Gm-Message-State: AAQBX9eevra7uAHLeh/hBlX/EIDXobK1/jYlRINcKFclxvuL1sPNj5WJ
        c+sKbFseSEhFUcYd9o+XxaPDN01L8HRnNjPt
X-Google-Smtp-Source: AKy350ZdM4uwy/5s0/ZvWNEIBCgDs+vY1VoMGcDKQFKRfp0R+ssQ3s0Q+7tEv3dDIIb3e0r2zY4aKA==
X-Received: by 2002:a17:907:7786:b0:921:da99:f39c with SMTP id ky6-20020a170907778600b00921da99f39cmr1253002ejc.12.1681986573364;
        Thu, 20 Apr 2023 03:29:33 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090694d500b0094efe88a037sm584512ejy.9.2023.04.20.03.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 03:29:33 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Subject: [PATCH RFC 0/2] regulator: dynamic voltage monitoring support
Date:   Thu, 20 Apr 2023 12:29:19 +0200
Message-Id: <20230419-dynamic-vmon-v1-0-f48b7438e891@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAP8TQWQC/x2NQQrCQAwAv1JyNrCthVavgg/wKj2ku9HmsKkkU
 pTSv7v1OAzDrOBswg7nagXjRVxmLVAfKogT6ZNRUmFoQnMMbX3C9FXKEnHJsyKHPhEFih0lKMl
 IzjgaaZz2KJO/2XbxMn7I5/+5w+16gWHbfsDbU6l8AAAA
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, support.opensource@diasemi.com
Cc:     DLG-Adam.Ward.opensource@dm.renesas.com,
        linux-kernel@vger.kernel.org,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This series targets the "automatic" state handling of voltage monitors
when the state of the monitored regulator is changed. This is e.g.
necessary for the da9063, which reaches an invalid state (!PWR_OK) if
the voltage monitor is not disabled before the regulator is disabled.
The problem could also be tackled inside of the driver's "state change
ops" (.enable(), .disable(), ...) but I thought it might be a good idea
to have a "common framework" independent of the driver's implementation.
Not sure if a good idea, therefore RFC.

For now, 1/2 implements so-called "monitoring constraints", but for now
only for under- and overvoltage monitoring. 
2/2 depends on [1], which implements (static) voltage monitoring for the
da9063. It shows a basic example how to use these constraints.

What's not targeted (for now) are possibly required delay times between
monitor state change and regulator state change. For the da9063, these
are not required but I can imagine there are other regulators where they
might be needed?

Possible next step:
"regulators-{uv,ov}-{warn,error,protection}-enable" dt property on chip
level, with either 1 or 0, to en-/disable the dynamic voltage monitoring
for every regulator of the chip. This would require the regulator's
set_{over,under}_voltage_protection() to work with limit = 1.

Thanks & best regards,
Benjamin

[1] https://lore.kernel.org/all/20230403-da9063-disable-unused-v3-0-cc4dc698864c@skidata.com/

---
Benjamin Bara (2):
      regulator: introduce regulator monitoring constraints
      regulator: da9063: disable monitoring while regulator is off

 drivers/regulator/core.c             | 155 +++++++++++++++++++++++++++++++----
 drivers/regulator/da9063-regulator.c |  17 +++-
 include/linux/regulator/machine.h    |  34 ++++++++
 3 files changed, 190 insertions(+), 16 deletions(-)
---
base-commit: 6a8f57ae2eb07ab39a6f0ccad60c760743051026
change-id: 20230419-dynamic-vmon-e08daa0ac7ad

Best regards,
-- 
Benjamin Bara <benjamin.bara@skidata.com>

