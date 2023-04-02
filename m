Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69EF6D3A44
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 22:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjDBUZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 16:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDBUZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 16:25:48 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C18B753;
        Sun,  2 Apr 2023 13:25:45 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r7-20020a17090b050700b002404be7920aso26500166pjz.5;
        Sun, 02 Apr 2023 13:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680467145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0DsL/zBRqxPzwYW1xlbJyW3fgq5H/wMYEgPOt72hbcQ=;
        b=JJL/4gKUlB+EDrmdGZlbC1jz+27kAyWFXYi5QE2itDS70n3dKKpBlG5+H8Zc68dOF0
         ctfaF/pXj+iAi677i+bxPEBCNwiATGOLjXQZ5f0bS5WBmt3uLh/0STx2EY3hKLsE6QfG
         wVvIubAgfSBn/xRwaBQwpOXKNhiAWvk/yhfR7SnPz5NBfO6/p4Fssiz/SDGCBkNKodFu
         QHfeGzE5VJ38VoIhteEi60M8Zx0E5LQu+vXCOvS+PF1BAYO+BLJ+5yTPTifCkIaFR2xC
         FERc+F5lNGfUyatG99e1THh9yfVJXvp4xC9IFiNGKkxOh8JMkJtQmTj5DYKxqIZRFPGl
         Bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680467145;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0DsL/zBRqxPzwYW1xlbJyW3fgq5H/wMYEgPOt72hbcQ=;
        b=ryJGBpcdIDBH8t/FIyhb4rhJa0Xxr6Ym+32beqR3dHU6yidGtqF+E0qKpcLieb40pp
         ZXxCWHmbrfSWWQu7eXZGEtbbTLiq3/lKx87sje8/kcwhDxu5gvTvAhM/eyIzhChB84/d
         rooHqX06jjWd1xLlByWcKmbubWIrw0mzwoC3NFwE0AqfwkbwJTK11ruSv5d0heC/s9g4
         nAbN5PbVMVI4A2agDR6eQXoPxIyFLWYnNR7spdhBVpK2x6k9P2ODGfeUvlok63bLtuN1
         nZeyOUumIRL37MkifxTtUtD0eVUtwhW7OmiXJlBcPZwX6l94hjRD8KYV7GFri+GuNkIG
         AOuA==
X-Gm-Message-State: AO0yUKVF4bhcxaWzazz+wC8+uP5kU4Ug93ss6it/yfWDnZQ9XlDfeaRl
        w34Efh/pcrBb8ewiGsY0VVE=
X-Google-Smtp-Source: AK7set9XUGbrFlE96WF8zHGlheV864DgSZZVFIrFsngxHwfoI5PoH44vD2xhON661YS8gY4fORuaVg==
X-Received: by 2002:a05:6a20:c426:b0:d3:9c13:606 with SMTP id en38-20020a056a20c42600b000d39c130606mr27917046pzb.47.1680467144889;
        Sun, 02 Apr 2023 13:25:44 -0700 (PDT)
Received: from pavilion.. ([2409:40f2:100f:dc7:7586:11f6:6763:e4a6])
        by smtp.gmail.com with ESMTPSA id i17-20020aa787d1000000b00627ed4e23e0sm5402146pfo.101.2023.04.02.13.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 13:25:44 -0700 (PDT)
From:   Saalim Quadri <danascape@gmail.com>
To:     krzysztof.kozlowski@linaro.org
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        danascape@gmail.com, daniel.baluta@nxp.com,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        shengjiu.wang@nxp.com
Subject: Re: [PATCH v5] ASoC: dt-bindings: ak4458: Convert to dtschema
Date:   Mon,  3 Apr 2023 01:55:37 +0530
Message-Id: <20230402202537.4373-1-danascape@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <7554941f-0b90-5cef-48e4-eda12ef92674@linaro.org>
References: <7554941f-0b90-5cef-48e4-eda12ef92674@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch has no major change, as mentioned under the changelog.
The alignment was changed according to the comment in v4

Apologies,

Saalim
