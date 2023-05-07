Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14A546F9933
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 17:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjEGPKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 11:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjEGPKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 11:10:00 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A0CB9;
        Sun,  7 May 2023 08:09:59 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-956ff2399c9so675277866b.3;
        Sun, 07 May 2023 08:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683472198; x=1686064198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6k7of+oD7aUsR3ZuT5Ha6yGbmcWNRVYGMihlsEz0Xhg=;
        b=cN8WCKzL3z0UDeYh32zhcfq6BPnbBq/473XGNaamAepsq0ySGTjyRZYn8xTBDG2mrx
         QYm9QwRYg8Z85CR6gGPTGK4GULfL8f+pKD68yRYQdXIAGUV3LBBHTnfMYJ8nYBT4jzVU
         Kn9p81vKiVi6kP10iYxs+NageUXik6ESyKb5ARp1JRLGmPNGA49Sd+KTCRZvAdso4I/f
         mKl6RD5w6Af+0s1ur//68pdNLm94Ol78n13MZ6N1Get+dRZGYcgDpqnGSWYnldDkRTnh
         fZkeXR5FGvujWH1pM8KZkj3kxKQWmSeIJMIfQgHkiDteGeqvZO31cZlUcdMTWKnGAx+i
         F5oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683472198; x=1686064198;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6k7of+oD7aUsR3ZuT5Ha6yGbmcWNRVYGMihlsEz0Xhg=;
        b=aGv4dL/ZDZkP0x+TcdafnycY/L0Tvkg46Na9CISz1n/a2yWV/n04zOsTeMlEzSpQAR
         +dmoOOhW1ukQnGhCAF7C7dEJ4zMrtRe8YAWp2m985rmRe8zFZQxKW4ADQVnMRxcZ30rX
         7IEo5rOO7Liss6+Gx7SkYirvYVFy/eBbYivlOs/mQWTX5Ra7K0zsHca58DyFykUpG0lH
         t7x9Pjy9Cj5xPq0MOIjs72bh9+Vdk7yefNXAaRCCsho0EkXSePH6xsGVF77bmIS+eIIQ
         Fokl24OAGrXTS9j2oxJCy4dT4ZwMadN1lbh2MGXK64VcilfpLMYLbZAfs8eXsvv8D6t7
         TIgw==
X-Gm-Message-State: AC+VfDwreMo/Yq1Wkwxuz168Kvu5y7PwJgChHslg46gIoPW37KgjJAw1
        W/Smq3OKvIwKbC1gp1LktKRX5W9uXwArinixDEE=
X-Google-Smtp-Source: ACHHUZ6+VFC93AW7h4sZdYiyaPqZUGGXGfe8vKSCHC7hQOOltYg0zJcH53vc/h7kUSkTyJjHMOz1gnBQknP7XOjm+v4=
X-Received: by 2002:a17:906:7955:b0:94f:9f76:c74f with SMTP id
 l21-20020a170906795500b0094f9f76c74fmr7323137ejo.52.1683472197958; Sun, 07
 May 2023 08:09:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230506232616.1792109-1-bigunclemax@gmail.com>
 <20230506232616.1792109-4-bigunclemax@gmail.com> <20230507105150.31643b87@slackpad.lan>
In-Reply-To: <20230507105150.31643b87@slackpad.lan>
From:   Maxim Kiselev <bigunclemax@gmail.com>
Date:   Sun, 7 May 2023 18:09:45 +0300
Message-ID: <CALHCpMgxsLzRF0FfazMXYiWK1fV99dbxYNDvoj+a0S-RvZP9Hg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] spi: sun6i: add quirk for in-controller clock divider
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This case assumes that the SDM bit is zero already. I think just
> masking both bits off above, right after the read, is the easiest, then
> you can also lose the else branch below entirely.

Thanks for this remark. I fixed it in the next revision.
