Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB2A6E3371
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 22:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbjDOUNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 16:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjDOUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 16:13:02 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC54A2689;
        Sat, 15 Apr 2023 13:13:01 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-63b5ce4f069so736990b3a.1;
        Sat, 15 Apr 2023 13:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681589581; x=1684181581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac4/gKT5b6/9noaaMeqV09+9MVanu6JqxbGBWbuNNtw=;
        b=pnICfcRMC5zJW6zd7L5SIzJmxGA0+FF4/T5vl51mB4zb0osPEA2/WFwZfE5RS0yBh/
         GqA8se5FnzIbLPqtSA4LUi/hmtRI/nrqVdAJT+S4O7O6bK37IWv9ZBvgvse9C+YeVqEo
         l4QAaVgFhRY1/i86dM1I7lZzC16Eqg7rrynnarRsP+OGvjEALlcoN7iBoBhoZz2WK8lx
         5sYsguCOuUDIxrURqo1T7NOwh2eyAymmYVb0d/NiYgTN0l+QOiXaEYKLLqm/8pe8Y2zl
         vnm2T22MolSYytmyUn+Mm8td5hi6yMYBRXyY5TNeYI9Zl3b3VmS1PGoLNDgl7iOAX0GJ
         P+hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681589581; x=1684181581;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac4/gKT5b6/9noaaMeqV09+9MVanu6JqxbGBWbuNNtw=;
        b=J0ucUnOilLQtqxVg5S5JR/43zRm+iui3qSBOFwJ7ag4mn4byNl62mVxWgG2ZDMX32/
         SchY4agccYakTSRzbT1qbsvPtMg6DAN/BFwMREaas2VPvW0hRTxztEG/lMGepmMMY9lu
         kE7Ya4vjCY+WVBiDJX50KI/5K7Y94btu+l51KgH75Ebf0J1upEAz18ChN4UlW9l2QYOp
         fMSC6DVT0RpE4xkn4uPlsWo0MJh4+eHj8SSd0xh0vadAI/8pe+bknIRCRHC9OTTOIUhI
         +k15woo+LmrOvfVc3YGPGWvx7BDxvRQO2qscP5yWl0AqMhUftfuVKop0uWM3U7170ePN
         T1/A==
X-Gm-Message-State: AAQBX9e7ABS3B6w1nQXvpl35ZWTKLUsDwK5/JT//qqAjaC1lULZ7BO3a
        fSLxJ4ubI4XVOBlHNZ0P2xE=
X-Google-Smtp-Source: AKy350aTASezSjdDMkmYoTpUTGQAoa9iIV+w98sIMwNqUN9M6lufnA0E4sPt38Ew7iNabsq/kmWLxg==
X-Received: by 2002:a05:6a00:1a13:b0:63b:7954:9881 with SMTP id g19-20020a056a001a1300b0063b79549881mr6274176pfv.28.1681589580927;
        Sat, 15 Apr 2023 13:13:00 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:218d:82:ae97:7cb6:b12a:54f5])
        by smtp.gmail.com with ESMTPSA id x24-20020a62fb18000000b0062de9ef6915sm4926228pfm.216.2023.04.15.13.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Apr 2023 13:12:59 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        patches@opensource.cirrus.com, robh+dt@kernel.org
Subject: [PATCH] ASoC: dt-bindings: wm8753: Convert to dtschema
Date:   Sat, 15 Apr 2023 20:12:46 +0000
Message-Id: <20230415201246.1200683-1-danascape@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <5d629ff3-c5ae-bd00-e70d-8c0d58365ce3@linaro.org>
References: <5d629ff3-c5ae-bd00-e70d-8c0d58365ce3@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> You choose unusual bindings to convert to DT schema. It is fine but
> honestly, less useful, with limited impact. This is an old, 12 year old
> binding without users. Maybe it would be even removed by now...
> I suggest converting ones which have a real impact - have users in DTS.
> Otherwise you will be putting quite a lot of effort for no real gains...
> because what is the difference between this binding being TXT and DT schema?

I am converting these bindings as part of my GSoC project where I need to convert
as many files as possible during the given tenure, I am slowly trying to read files
in other subsystems too and will push patches for other subsystems too.
Is it fine?

About the part where you suggested to convert the txt into a single YAML, shall I
continue working on them? As I can see Mark merged the previous 2 patches to linux-next

Kind Regards,

Saalim
