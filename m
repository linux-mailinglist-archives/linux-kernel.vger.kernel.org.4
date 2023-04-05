Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F36A6D7D70
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:10:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238242AbjDENKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238159AbjDENKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:10:00 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D71FEC;
        Wed,  5 Apr 2023 06:09:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ek18so140992747edb.6;
        Wed, 05 Apr 2023 06:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc6lpfSkhCFjZHegYgPH2xzL1XMSoHFdPSi+Hb5EdvY=;
        b=qpg7ZYCUnkTeF3b6x6kbrQyX2BavDizjxk/2XDA79QURowrQ2TbSVfnW9rhylzBJVT
         1Bh7GPohy51Twy9gO++ipoy3Npo7zP1qFrfSpDxjTnCVtD0G5EX3k9J7mtmLF6TiOyZ/
         jp9R9bZUq8O6it5kb8HhTDsI7smP/fK4rrUanIziLOjI+po+bbPTwt+LMQC5lv7AOsx4
         KBmXD+yTXr/wx0/LyNF95sugOW7ylL2LzW/eXYXM6HRABFbuzCGAP+vMVli8IPh6XCXi
         fk5aupAgTSlvSPViPo6Qb9TaBnB3Sqhia0EzRbKYCp3ctOmKWf2/s5tFu6WhrXooniJm
         U11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc6lpfSkhCFjZHegYgPH2xzL1XMSoHFdPSi+Hb5EdvY=;
        b=1Dxk7Ea000htkesDgE8R4v47psAGTCi+v+sXc9HyozFKMQrqF57u+67I2xZ4oya/kq
         1wUCOMOr0/FK+MgOw78O6bjejwqlKpjzUef6/wViicxYF1sGPnVTApT5LubkB9POhnC1
         BM59SlKzDSJjJqY7loEfHW5hg9UgHtDPzdTgfxpcMVpTbAnZEn07Z1nXZDdzQAkA1B5q
         m4KafNb/jsxT74yj2gcx8yN8vW2ofaRK79dkOTMP+GV1ng2Kiiv1nQCaR1lRL/iaydEp
         6Bg58cdq7PjCZlXRWJ9m9jQyq9SGFyCEOrhWR6DhCC1ARTH71OBBK7hFznAvLFpD+zID
         2ktQ==
X-Gm-Message-State: AAQBX9fCpMNlgDrjJuhcsxhLFgtANkPoOSmmYBskOWvGOS4YEMsvC1Iq
        z1JjSLjZbr6JnzEO3IhzoIc=
X-Google-Smtp-Source: AKy350alzGXioav9KKWdOSGxp9WUWI3K1jkYkHhw8Tueh9auQSnW3kxrsPw/x7HQfCybtSFuZaTkmQ==
X-Received: by 2002:a17:906:2b0d:b0:93f:fbe:c389 with SMTP id a13-20020a1709062b0d00b0093f0fbec389mr2911447ejg.13.1680700197494;
        Wed, 05 Apr 2023 06:09:57 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906261700b008e0bb004976sm7311267ejc.134.2023.04.05.06.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:09:57 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Nick Alcock <nick.alcock@oracle.com>, mcgrof@kernel.org
Cc:     Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org
Subject: Re: (subset) [PATCH 20/20] soc/tegra: cbb: remove MODULE_LICENSE in non-modules
Date:   Wed,  5 Apr 2023 15:09:50 +0200
Message-Id: <168070017411.4044223.332660591498857046.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230228130215.289081-21-nick.alcock@oracle.com>
References: <20230228130215.289081-1-nick.alcock@oracle.com> <20230228130215.289081-21-nick.alcock@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

From: Thierry Reding <treding@nvidia.com>

On Tue, 28 Feb 2023 13:02:15 +0000, Nick Alcock wrote:
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> [...]

Applied, thanks!

[20/20] soc/tegra: cbb: remove MODULE_LICENSE in non-modules
        (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
