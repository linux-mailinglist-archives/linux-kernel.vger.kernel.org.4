Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D35871F051
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 19:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjFARJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjFARJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 13:09:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8970D1;
        Thu,  1 Jun 2023 10:09:21 -0700 (PDT)
Received: from notapiano (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7B1ED6606ECA;
        Thu,  1 Jun 2023 18:09:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685639359;
        bh=Y8F29vZfkHL4Cb3ef4MuhHy4Zp5QvDAZ2kfIEyGPM9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=djfaRrFbe5vpFwhkOMJQAaXxfPSn6juAwXkAr4/vbafpbvECworn4C6+M5gHXSwC/
         omKlx04ZB5h0aJdt1pRwK5f1fh/c0wVQDIoAhMR0OHegtLoUymiw1hnFy5Wg2yblOH
         SoizdaLsweDvPsQ+6QiYYYElLbHJf2pVZsRtIulNG1gHSYjfdSXdHwEoGnHsI9Nrwo
         kC9g+1xMF4lc+XJffyLIolrsX8Xe3yqm354tkULZ4uxHR3nYlYthbfVUEJ4gYxkZ+O
         2R+0K6KZb6diN81tPegpYjt0x83mMUvzIROFsegGI+kMLOEgnoDrS86IzX3s7IGG3U
         v3DweIR4ktFlg==
Date:   Thu, 1 Jun 2023 13:09:12 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Bernhard =?utf-8?Q?Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        james.lo@mediatek.com, rex-bc.chen@mediatek.com,
        abailon@baylibre.com, amergnat@baylibre.com, khilman@baylibre.com
Subject: Re: [PATCH v4 0/5] Add LVTS support for mt8192
Message-ID: <572f5a88-8c2e-4324-b477-836a5024ec67@notapiano>
References: <20230530195132.2286163-1-bero@baylibre.com>
 <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGXv+5EVfgEBDm=7MmQ=OsP322KmE23PwycJ-0LjU+3dEZygUQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 12:49:43PM +0800, Chen-Yu Tsai wrote:
> On Wed, May 31, 2023 at 3:51 AM Bernhard Rosenkränzer <bero@baylibre.com> wrote:
> >
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add full LVTS support (MCU thermal domain + AP thermal domain) to MediaTek MT8192 SoC.
> > Also, add Suspend and Resume support to LVTS Driver (all SoCs),
> > and update the documentation that describes the Calibration Data Offsets.
> >
> > Changelog:
> >     v4 :
> >         - Shrink the lvts_ap thermal sensor I/O range to 0xc00 to make
> >           room for SVS support, pointed out by
> >           AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> >     v3 :
> >         - Rebased :
> >             base-commit: 6a3d37b4d885129561e1cef361216f00472f7d2e
> >         - Fix issues in v2 pointed out by Nícolas F. R. A. Prado <nfraprado@collabora.com>:
> >           Use filtered mode to make sure threshold interrupts are triggered,
> 
> I'm seeing sensor readout (either through sysfs/thermal/<x>/temp or hwmon)
> fail frequently on MT8192. If I run `sensors` (lm-sensors), at least a couple
> of the LVTS sensors would be N/A. Not sure if this is related to this change.

Yes, it is. Filtered mode has some delay associated with reading, meaning most
of the time the value isn't ready, while immediate mode is, well, pretty much
immediate and the read always succeeds.

For temperature monitoring, filtered mode should be used. It supports triggering
interrupts when crossing the thresholds. Immediate mode is meant for one-off
readings of the temperature. This is why I suggested using filtered mode.

As far as the thermal framework goes, it's ok that filtered mode doesn't always
return a value, as it will keep the old one. But of course, having the
temperature readout always work would be a desired improvement.

As for ways to achieve that, I think the intended way would be to enable the
interrupts that signal data ready on filtered mode (bits 19, 20, 21, 28), read
the temperature and cache it so it is always available when the get_temp()
callback is called. The issue with this is that it would cause *a lot* of
interrupts, which doesn't seem worth it.

Another option that comes to mind would be to enable immediate mode only during
the get_temp() callback, to immediately read a value, and return to filtered
mode at the end. That might work, but I haven't tried yet.

Thanks,
Nícolas
