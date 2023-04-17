Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C720F6E40E7
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjDQH3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjDQH3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:29:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BCAD1FF6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:28:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f173af665fso2671145e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681716538; x=1684308538;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ks93xPrb3fXFOs4miszqIce8wwreHasGlxqjnl70wE=;
        b=MT12PihTJId6tbaNYwJ4jJBnaOmYQ8/yaqUEgpRtKaz094Z60GmjVV3oCiGtIJxE3o
         GMir3O/YDj96fCHQQpGVh0z059GqmXUiKbdJXgbmDdcbCjiFLdK9bNHbcYN8yo7qeBWg
         pjOR/nDrWkwy8jOZzmVrjVAMIJH2YDIi//fBWLclZDaD6Abw/B2j3Q6I7IgQ+HrLgg8M
         MLDrJN8ISKPld/iuXghar639S/c05sEWtX4EXOx5JJtMVJ/OecM0n9NjNS1uMDc4ll8F
         Q5BKsZa+GPQHZH7ODm1huNtuvXe+S58Uw9hF/JMSQPXbS/IYLlePM4C8OXMdbn8hEQo5
         XkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716538; x=1684308538;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ks93xPrb3fXFOs4miszqIce8wwreHasGlxqjnl70wE=;
        b=cjy2Okz1NCQ6dKp654M5slyeaMM8htLQrf05fNj8sMCwrQgX8LnWaXE+CEWv4MqqNQ
         uaRXWav0Kh1WMTakKKMAWimSYEAYFv8+Z0jDcH23ifJmUDazPpEcX8DFdZmbgRH1HtY7
         Nos8fIF9+ph1z9P8RzbQDpbi6H6CyyKgTdchIsqLaD2osRY+qhjITlCAklosP23+ePeb
         C28GqyDpYR89TzzKZzJhBWL9gpFYQFeoM5FwFyuTh3jhasHiKQbDFsD7Q5bO7f/hEpuW
         iX57P+61PejnvyAOunePemytBYOkA6WkWwqE6uFmyP+zMeftvxvx5dd/9jy8GCpUhHbl
         RXdA==
X-Gm-Message-State: AAQBX9c7Ksw+hcDdqtoIX4avcmgP7i3X9uOKIhyZLSoEcHPUVR/hMt3k
        jhgP3ORY95mqhYt48zxoUTdMpw==
X-Google-Smtp-Source: AKy350aN+Okoy4hYmAFvnXwByuGTJEOjQlFq/23QpbPOTaAzIlczgNzdVL01tZmWyYI4BL7YMHaGVQ==
X-Received: by 2002:adf:dc90:0:b0:2c7:fc61:12d4 with SMTP id r16-20020adfdc90000000b002c7fc6112d4mr4104948wrj.47.1681716538024;
        Mon, 17 Apr 2023 00:28:58 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id d4-20020a056000114400b002cea8f07813sm9740564wrx.81.2023.04.17.00.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 00:28:57 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org>
References: <20230415-konrad-longbois-next-v1-1-ce695dc9df84@linaro.org>
Subject: Re: [PATCH] drm/panel: novatek-nt35950: Improve error handling
Message-Id: <168171653726.4116174.15834990201475611175.b4-ty@linaro.org>
Date:   Mon, 17 Apr 2023 09:28:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 15 Apr 2023 13:00:30 +0200, Konrad Dybcio wrote:
> In a very peculiar case when probing and registering with the secondary
> DSI host succeeds, but the OF backlight or DSI attachment fails, the
> primary DSI device is automatically cleaned up, but the secondary one
> is not, leading to -EEXIST when the driver core tries to handle
> -EPROBE_DEFER.
> 
> Unregister the DSI1 device manually on failure to prevent that.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next-fixes)

[1/1] drm/panel: novatek-nt35950: Improve error handling
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5dd45b66742a1f3cfa9a92dc0ac8714c7708ee6c

-- 
Neil

