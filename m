Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD94741218
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 15:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjF1NQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjF1NQN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 09:16:13 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1451705;
        Wed, 28 Jun 2023 06:16:13 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-785d3a53ed6so11370539f.1;
        Wed, 28 Jun 2023 06:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687958172; x=1690550172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZrzyOVQ3QAJPAipNHwKEkBm18s9ryw9sFI7AdY1QaUg=;
        b=gXnGbdQQbDTscAw6UOMk/Gi6/IjDwP268V57mgCPE0kKAgqDwCjlVKtIykVyirwABX
         4sSw1Uh40mlrKGznF/pFUORxis+QYMZIxP2g8O6G09zCCnHQiTcCSergfZCU0UMIkwtH
         7ERVdOCw+EVKzdeTjUu0sneU5goP5L+8c+oLDQQe3mFDnlcknLikkKPqEw9zyvWvbFDE
         G3wDS3qHd8CwhgmcujXJIN5FrK8q0fgdcZ0Ckiq2nNdn/rzQiAQ/lAERkdnS+tcnJUDB
         TF/n1VdgUL0u4U8n0MOER9cfBxp+VYQirz9KPvzTySAhN2xLavyNZs2BcuVJbujBAHpV
         z6Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687958172; x=1690550172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZrzyOVQ3QAJPAipNHwKEkBm18s9ryw9sFI7AdY1QaUg=;
        b=Z4vRFI8H07M4LE0s1svpx5B7022pgoeDtEnzZO3/CwznIEZK8RMZs6Sk6fF9EA81AD
         CzZHYT64PkLbdcrumsjBPXsHAtpCpSXULpngatFb6JrMgfkqHhKQXjmzX/L+GIuOKBHe
         4PfJBZOz6ZAj2c2nljsKAq7kL1vz8BaG69rBKB2/g1Y3N03NxwOX1fy1ug4GX2BgZLUv
         QKSlbbbbvVVxeGfbiN3yN7W5XV49UjasrjzDgVJRcIcDwbBzRBx77lC6gPHFqhbPMT0q
         59/mdDHyQiGxAAUg8NdvZZzRuDaWCODENK9rQGN63jhxH12hk+Y0rXKKRRalBvKSxy5p
         v2xg==
X-Gm-Message-State: AC+VfDwigqLNHeL9L+rfYZI1JY5qVJqvPonjdbGKwpoiPv3pren/tNYB
        VW1ArIGhFDzlO1Ydd6WKc+wvL2X2zk6OcVokHmo=
X-Google-Smtp-Source: ACHHUZ5oKIXcI6iYaFjSwYTqID5WH8Vp3u5PGz1tMHmeZ/F1W3446YD6/KZ2S20kWBIASnfpFCFJz5jkKEFt8cjozqM=
X-Received: by 2002:a05:6602:388b:b0:783:743c:fd01 with SMTP id
 br11-20020a056602388b00b00783743cfd01mr5925698iob.0.1687958172551; Wed, 28
 Jun 2023 06:16:12 -0700 (PDT)
MIME-Version: 1.0
References: <20230628125406.237949-1-stefan.moring@technolution.nl>
In-Reply-To: <20230628125406.237949-1-stefan.moring@technolution.nl>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Wed, 28 Jun 2023 10:16:02 -0300
Message-ID: <CAOMZO5AftBB8B-Bb-j0TrTnKiQdGpBkq+jZ3surLSs6xPm_pUQ@mail.gmail.com>
Subject: Re: [PATCH] spi: Increase imx51 ecspi burst length based on transfer length
To:     Stefan Moring <stefan.moring@technolution.nl>
Cc:     broonie@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        linux-imx@nxp.com, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefan,

On Wed, Jun 28, 2023 at 9:54=E2=80=AFAM Stefan Moring
<stefan.moring@technolution.nl> wrote:
>
> IMX51 supports 4096 bit burst lengths. Using the spi transfer length
> instead of bits_per_word increases performance significantly.

Could you please share the performance increase after this change?

Thanks
