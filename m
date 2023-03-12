Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7126B68BF
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjCLRVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCLRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:21:30 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55EC83346A
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:29 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id er25so11715257edb.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678641688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBGzNUPx40eWlSyudiAgMdJKbCqGeD4gTi6lxixBKHk=;
        b=E1BKfgZTXss9x6mdMFRs39d3xDN+EgG772xt73ikoVPxKUGS1qcNxcf4XJEtBSZSaG
         rd5FFnvIzAibU5w939o+V088CKIYwoHngFUe6UzKIQXY97ICFdn7is2iXhRBWJ512Yy4
         rb0Il9ZAEjkNapTiO7qca4W9bDjmU/WUGfHzfvUSLbvBIeGzX3Mz6QucLla1GuAsGxT2
         vdBEEpJfv6RvCg9KdyRok1Tb77jh1f4MQNDkBi++NfkBhGv/+IfpoX1NwPSJkWRXBtmO
         aGcXJzdtvv2HWF/swaeqBbUqnDpoO7PAVu++y61N+5Eb+3Amfgk+Tjey9AxftYD9CZt4
         D5lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678641688;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBGzNUPx40eWlSyudiAgMdJKbCqGeD4gTi6lxixBKHk=;
        b=t2WbNhm2Ef9CBNv8I6HLORTB1jImgtFx8lxqzJz6iyqhQvhhVHb9kV/csEG5bknqIc
         CUL0Cm0PsldA6HImCNwN3MGPEpYDeXw4SC8eORPmFbh1fw2MxG+dRe0p6K6HHBp5nbbu
         4dhTbjWjP8oBInxcZ61zRvVZNhp1ah61weowkJYvlNUKLIpB0AnlB2He92D9L+cm2Ox7
         8vJbTQOz0wNWVXteBvII/39CCH+mDLZW0dPuE8hOJDX2NbH0XqjiD2dis8YaNhYIVepb
         ne7CijyWinqGs0zV3l3a6ywGAXq4+abxyTkuv1v/wpEecWnWkPpeJX9Oy7LmST9MbB5n
         JJHw==
X-Gm-Message-State: AO0yUKVVRPDcEDwCpSTToPmDf7Yzrk1bJ/kZfFqD1irHRswoi2Ta3ZNA
        owwY4i7iIzKsGpGxrUnDt27utA==
X-Google-Smtp-Source: AK7set/kVs+9u6kikzXCPsUVOIF7XG29GqtUg2Wlxck4Lz67PS0ioKLNX47DXpFz/87w5rqyeEhwZw==
X-Received: by 2002:a05:6402:181a:b0:4af:51b6:fe49 with SMTP id g26-20020a056402181a00b004af51b6fe49mr9563004edy.13.1678641687814;
        Sun, 12 Mar 2023 10:21:27 -0700 (PDT)
Received: from krzk-bin.. ([2a02:810d:15c0:828:d9f6:3e61:beeb:295a])
        by smtp.gmail.com with ESMTPSA id y13-20020a50ce0d000000b004fa380a14e7sm2055395edi.77.2023.03.12.10.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Mar 2023 10:21:27 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: marvell: use "okay" for status
Date:   Sun, 12 Mar 2023 18:21:21 +0100
Message-Id: <167864162127.395859.11689617186771884910.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127101839.93873-1-krzysztof.kozlowski@linaro.org>
References: <20230127101839.93873-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2023 11:18:38 +0100, Krzysztof Kozlowski wrote:
> "okay" over "ok" is preferred for status property.
> 
> 

Applied, thanks!
(Patch was waiting for quite a long on the lists, let me know if anyone wants
to pick it up instead)

[1/1] ARM: dts: marvell: use "okay" for status
      https://git.kernel.org/krzk/linux-dt/c/90bf48c6ddd3afc406e41a1a193d412f61d2a976

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
