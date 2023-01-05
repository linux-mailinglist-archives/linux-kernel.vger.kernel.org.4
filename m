Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EBF65F2AE
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 18:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbjAERa2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 12:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjAERa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 12:30:26 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733392;
        Thu,  5 Jan 2023 09:30:25 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id b24-20020a05600c4a9800b003d21efdd61dso1882830wmp.3;
        Thu, 05 Jan 2023 09:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o5jZcZ+YgPoIjP8SOU3FjXlsuvcwtes2avBtwRlJmuo=;
        b=Jm4esGPypCFk9CsOcodMN6zqTZiqZyUp+yCwCShUysTZojG5j/XGWOVabVR1zfnKEl
         qarZQJ17W3XHSuVEn72fDOsYjg8LWSryNbUvxOZazMjdM6eZBSbIoVocNxUwJgyWjoED
         Eg5ix4nnNgnKyG/EI8zgmFc56NSBtQeb6VdQ6G+rREAFvOoU00Izcg4Zx9yoEpzT9hNJ
         +2yjaApu6bXySJXBCh5RoQa2QRDE0zDdtjdN/kU9d1xHYEthN1I7rQeLsHQygTrHuVef
         ez7W69mmn5/wR/UG8hzuSSETs5BjIZ/njSj+EUEv6BnoujzKgHWz9ehZz+cV6Ds4xxwy
         +RXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o5jZcZ+YgPoIjP8SOU3FjXlsuvcwtes2avBtwRlJmuo=;
        b=BaaGvKdIXv243ckzlFsM7QB+5bUhurTqECBIkpaBDJz5rpg2gy/LU7XfU+a/7MUras
         xicmSOHBiGEpKxaSjN1/WT34JGf7MeOV6n+dDJNXKalPdjqAeQIB6Pqb7lpr1cTRJPDz
         Z8EQG8PhrHj80gxo5CY0R8Nq9GbQG3fFjXqwkCiCSL1yvp2tGPI6/AQA9qG+lhKfumEP
         k3uWdw+MzzCTqAozM71A/LtJHlcRLgb9Bw/ueZ6fWsxYiANu74ufvClh6JNIQOApUkDW
         yVdF7pB0bMQQgaWvX1WSVkdK5Z9KR78IyZGNn7n+1xxe5iMOLjkH3eiqXF7RTQcmC7Ap
         qFQw==
X-Gm-Message-State: AFqh2krzqk28ElCgqBncev4otmCvkcUDHrMbw05mrwLmD7lnjT/g34kM
        42wYwxU6sUvifdKmCWFo2pY=
X-Google-Smtp-Source: AMrXdXtoWb7E6Dy6FLBwdAlWwtTGcbQjgmyTvP7NyPyv/3l4C9+TmdcOtOwt7pi9RmpFSm+BPb2nLw==
X-Received: by 2002:a05:600c:1e10:b0:3cf:973e:c874 with SMTP id ay16-20020a05600c1e1000b003cf973ec874mr37716677wmb.14.1672939824130;
        Thu, 05 Jan 2023 09:30:24 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-19-102.dynamic.telemach.net. [82.149.19.102])
        by smtp.gmail.com with ESMTPSA id o9-20020a05600c510900b003c6f8d30e40sm3641462wms.31.2023.01.05.09.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 09:30:23 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi-ng: h3/h5: Model H3 CLK_DRAM as a fixed clock
Date:   Thu, 05 Jan 2023 18:30:21 +0100
Message-ID: <3394555.QJadu78ljV@jernej-laptop>
In-Reply-To: <20221229042230.24532-1-samuel@sholland.org>
References: <20221229042230.24532-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne =C4=8Detrtek, 29. december 2022 ob 05:22:30 CET je Samuel Holland napis=
al(a):
> The DRAM controller clock is only allowed to change frequency while the
> DRAM chips are in self-refresh. To support this, changes to the CLK_DRAM
> mux and divider have no effect until acknowledged by the memory dynamic
> frequency scaling (MDFS) hardware inside the DRAM controller. (There is
> a SDRCLK_UPD bit in DRAM_CFG_REG which should serve a similar purpose,
> but this bit actually does nothing.)
>=20
> However, the MDFS hardware in H3 appears to be broken. Triggering a
> frequency change using the procedure from similar SoCs (A64/H5) hangs
> the hardware. Additionally, the vendor BSP specifically avoids using the
> MDFS hardware on H3, instead performing all DRAM PHY parameter updates
> and resets in software.
>=20
> Thus, it is effectively impossible to change the CLK_DRAM mux/divider,
> so those features should not be modeled. Add CLK_SET_RATE_PARENT so
> frequency changes apply to PLL_DDR instead.
>=20
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


