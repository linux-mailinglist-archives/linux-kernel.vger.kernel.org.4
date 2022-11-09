Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13866622CE3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiKINxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiKINxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:53:12 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1900205F2;
        Wed,  9 Nov 2022 05:53:09 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id m204so18827720oib.6;
        Wed, 09 Nov 2022 05:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IP5GuE55LXSPGOYJX6tyMHFgYaUe2wT0zbakn2aZiKA=;
        b=IRoPyveQ9oFrAzTF3HHWGRj0bUrCS8UXLDCa9ddqKqECHwdlDrMOiKDSZFD12lTdMl
         XNBIQOgXzPdtgZPPrv9GafkLQB/QCIIiL+YPya0/Hp1NPKysiaBQGQjOfZI3/fws8WmO
         IC351Nj8xsn5UopowW+WN6XagzJpYeXF21UXhjDo9EsVVx2/tmOi23Yx33AbvliZBYWZ
         rjCm3e40+B0iBtSKK9mkxqcUkAjx9wi3fsP9JzExbAkKPOzS1PbKl5D01nmRmZqwArlf
         c4WRIWu9QxLRLeK41yi7GJb8h2BS48MGKMxNelapj/igM3ozt9vWWbfuoFaITTowNE3m
         D41w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IP5GuE55LXSPGOYJX6tyMHFgYaUe2wT0zbakn2aZiKA=;
        b=FRrIRXX+o4aIfRjgAux1OeF+rXp732Bbku/J1BsB4Bpmw8nNxRuWni5pr7hKmKOfIG
         1wX5zBV+18cltG/z8hMXkhEPTzx8Un5DBIAGg33cGMpl1foK2k2ParWdm92IdN+zRsao
         C5DS6c/S2XLQSf9+g71LZ0bTtE8hwNJ5KV6HtL9/XVRm2Rv8K3SyLaMxVnCxQKtRRT2k
         MW8JuBfMvPPJyJ/zfhVHydxqMidBFvWWDL9q7WfX7lk8mnl8oHWw3FrGOpKF2sCLQoFW
         K3T7s/F6ioKA6NwaeEWHijZ10gFT/5auSUSMoFFuC9MPwe9JBo6frnKBKJoUT5042KLO
         WhKw==
X-Gm-Message-State: ACrzQf1S7RazKyE+7+OavluiX2CMdgFL5q0BGyMQkKsEWY3vMtWwScee
        KF2xzuNJyyoVA43OsSDMBYE=
X-Google-Smtp-Source: AMsMyM7yhbw8cdCur7Z/B3HPRG1UyZ5Xhy0cQKinNow41q8SEdCpF9Q0zCPt1dXhUKXdFyWWSxduvw==
X-Received: by 2002:a05:6808:1b13:b0:35a:57ef:8388 with SMTP id bx19-20020a0568081b1300b0035a57ef8388mr16587593oib.195.1668001989314;
        Wed, 09 Nov 2022 05:53:09 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id f15-20020a056870210f00b0013ae5246449sm6082480oae.22.2022.11.09.05.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 05:53:08 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 9 Nov 2022 05:53:06 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com,
        angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 5/7] dt-bindings: watchdog: mediatek: Convert mtk-wdt
 to json-schema
Message-ID: <20221109135306.GA3538893@roeck-us.net>
References: <20221108033209.22751-1-allen-kh.cheng@mediatek.com>
 <20221108033209.22751-6-allen-kh.cheng@mediatek.com>
 <585a9cbb-4df4-1c06-ecfa-3b9442f1a5e2@gmail.com>
 <5758c2af-c2c5-dfbe-c7d8-036bbdaf71c7@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5758c2af-c2c5-dfbe-c7d8-036bbdaf71c7@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 10:04:09AM +0100, Krzysztof Kozlowski wrote:
> On 08/11/2022 11:50, Matthias Brugger wrote:
> > 
> > 
> > On 08/11/2022 04:32, Allen-KH Cheng wrote:
> >> From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >>
> >> Convert the MediaTek watchdog bindings to schema.
> >>
> >> The original binding only had 4 without a fallback but there is a reset
> >> controller on the "mediatek,mt7986-wdt", "mediatek,mt8186-wdt",
> >> "mediatek,mt8188-wdt" and "mediatek,mt8195-wdt" Since there is no reset
> >> controller for the mt6589, we remove "mediatek,mt6589-wdt" as a
> >> fallback.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> Co-developed-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> >> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> >> Reviewed-by: Rob Herring <robh@kernel.org>
> >> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> >> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > 
> > As I'm put as the maintainer:
> > Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> > 
> > Shall I take that through my tree or shall it go through the watchdog tree?
> > 
> 
> In general, bindings should go via subsystem trees (so watchdog), just
> like drivers. However this got Guenter's review tag, so usually it means
> also an ack... Dunno... :)

For watchdog patches, if I send a Reviewed-by: tag, I expect Wim to pick
up the patch through the watchdog tree. If I expect some other tree to
pick it up, I use Acked-by: and usually add a note saying that I assume
that the patch will be picked up by someone else.

I usually also add watchdog patches to my own watchdog-next tree as
reference for Wim. I already have several mediatek devicetree patches
queued there. Handling some of the patches through watchdog and others
through some other tree would create a mess. Please don't do that.

Guenter
