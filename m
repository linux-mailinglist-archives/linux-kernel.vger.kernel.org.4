Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB446D8712
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 21:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDETlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 15:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjDETlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 15:41:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EA17DA1;
        Wed,  5 Apr 2023 12:40:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F4763FBA;
        Wed,  5 Apr 2023 19:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51CB0C433D2;
        Wed,  5 Apr 2023 19:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680723579;
        bh=cTudTj8Oo2+RcHiqiFkI4xEdSskDU+0x8+gt+YiMa1U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=dUpRuEo2D1mabWQvXzJqRWoZmOJcNZXwbeYAHRTDQUFia1LQ30DnL5MVT17wgqc4b
         o8XcIvg3F/UEE3btoojmu9yMT55Lip4MsZL85VnqYoh4RfpvbfVRFkeiXjVvfCvZyF
         ZRjMzvkNIKhTuCLBdbGWr4kAB7xyKfDDvSgeMqLun2r+wa9wOD8t9o1jJnfi7Nacan
         7yBa5x2r2+g3RVFcXkLRODsvzRN3FLM9CAFP3wT6XmO0g0GEWURTruNS4KtF1AQ8dq
         Z8rLoFoek5rfhF3xQqU4XR2g1YegMQGsOhNsoULUA0hJeQJcSHZDLuHreD3EKfDV1u
         nDz0i1UhjSPuA==
Message-ID: <4088bcbba60790adebccde35270c792c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230329075104.165176-1-mmyangfl@gmail.com>
References: <20230329075104.165176-1-mmyangfl@gmail.com>
Subject: Re: [PATCH v2 0/4] clk: hisilicon: Migrate devm APIs
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Yang <mmyangfl@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org
To:     David Yang <mmyangfl@gmail.com>, linux-clk@vger.kernel.org
Date:   Wed, 05 Apr 2023 12:39:35 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting David Yang (2023-03-29 00:50:49)
> Migrate devm APIs for HiSilicon clock drivers and remove redundant codes.
>=20
> This series is a partial improvement of [1]
>=20

Run checkpatch.pl=20

WARNING: Macros with flow control statements should be avoided
#591: FILE: drivers/clk/hisilicon/clk.c:146:
+#define hisi_clk_register_fn(fn, type, stmt) \
+int fn(struct device *dev, const struct type *clks, \
+       int num, struct hisi_clock_data *data) \
+{ \
+       void __iomem *base =3D data->base; \
+       int i; \
+\
+       for (i =3D 0; i < num; i++) { \
+               const struct type *p_clk =3D &clks[i]; \
+               struct clk_hw *clk =3D stmt; \
+\
+               if (IS_ERR(clk)) { \
+                       pr_err("%s: failed to register clock %s\n", \
+                              __func__, p_clk->name); \
+                       return PTR_ERR(clk); \
+               } \
+\
+               if (p_clk->alias) \
+                       clk_hw_register_clkdev(clk, p_clk->alias, NULL); \
+\
+               data->clk_data->hws[p_clk->id] =3D clk; \
+       } \
+\
+       return 0; \
+} \
+EXPORT_SYMBOL_GPL(fn);

WARNING: macros should not use a trailing semicolon
#591: FILE: drivers/clk/hisilicon/clk.c:146:
+#define hisi_clk_register_fn(fn, type, stmt) \
+int fn(struct device *dev, const struct type *clks, \
+       int num, struct hisi_clock_data *data) \
+{ \
+       void __iomem *base =3D data->base; \
+       int i; \
+\
+       for (i =3D 0; i < num; i++) { \
+               const struct type *p_clk =3D &clks[i]; \
+               struct clk_hw *clk =3D stmt; \
+\
+               if (IS_ERR(clk)) { \
+                       pr_err("%s: failed to register clock %s\n", \
+                              __func__, p_clk->name); \
+                       return PTR_ERR(clk); \
+               } \
+\
+               if (p_clk->alias) \
+                       clk_hw_register_clkdev(clk, p_clk->alias, NULL); \
+\
+               data->clk_data->hws[p_clk->id] =3D clk; \
+       } \
+\
+       return 0; \
+} \
+EXPORT_SYMBOL_GPL(fn);

total: 0 errors, 2 warnings, 1019 lines checked
in patch 'clk: hisilicon: Migrate devm APIs' (8d960cbef61a)
WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cur=
e the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#627: FILE: drivers/clk/hisilicon/clk-hi6220.c:291:
+MODULE_LICENSE("GPL v2");

WARNING: DT compatible string "hisilicon,hip04-clock" appears un-documented=
 -- check ./Documentation/devicetree/bindings/
#661: FILE: drivers/clk/hisilicon/clk-hip04.c:33:
+       { .compatible =3D "hisilicon,hip04-clock",

WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cur=
e the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#842: FILE: drivers/clk/hisilicon/clk-hix5hd2.c:337:
+MODULE_LICENSE("GPL v2");

total: 0 errors, 3 warnings, 779 lines checked
in patch 'clk: hisilicon: Convert to platform driver' (2681347c2636)
WARNING: Prefer "GPL" over "GPL v2" - see commit bf7fbeeae6db ("module: Cur=
e the MODULE_LICENSE "GPL" vs. "GPL v2" bogosity")
#1044: FILE: drivers/clk/hisilicon/clk-hi3670.c:935:
+MODULE_LICENSE("GPL v2");

total: 0 errors, 1 warnings, 1481 lines checked
