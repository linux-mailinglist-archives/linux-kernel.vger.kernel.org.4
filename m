Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE34F69E76F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 19:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbjBUSZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 13:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjBUSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 13:25:13 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C7123656;
        Tue, 21 Feb 2023 10:25:12 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id g1so20669961edz.7;
        Tue, 21 Feb 2023 10:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3BLHBNbyB6d4PScjJ/843xzZfyZJGKfFJawvu4dX2Y=;
        b=OoQboNmUTe52RXikv+7iuojM9BYFM1K0l2C5ASBMAunqW2ynay57tF+lJN8GW4cxAo
         brqUlL3eGHUDbfj5s3ZBrG/9WomcwJy8fynKVekVh65I8Uezl8KzpgUrtkQZB7TPSCEg
         x8nS3GgGUnVWc0DckOU69z1Cte4Nk3oatH17U2JX5MaJeT6yQHw6AhjzoPHqxItaXmyn
         xeHiHiXTA1OqwqApZjpBZ1eByhH+KV9qz4hftm0lmqvJaUf8fSyccDJEmngHKVI/Pmh8
         Ok8IM2u2zda5szc4POCqpG0/XQdwnpetkfgHqDTtNLMEPwk4ETv8ZTL/3W67gqADpDO2
         ioDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3BLHBNbyB6d4PScjJ/843xzZfyZJGKfFJawvu4dX2Y=;
        b=f08qgd8Xeuk1WdxnnOxKovIX6jplXFvavPx2p00ZdVhrgSgdM0rf0YqhB0rEdK4LZ1
         KUY1016k0lZfIl38qO5xksPaWQHkTYUEDO0tL/Xv5k0V/to08vr1AA9g6Mf1/r0bH1ei
         9cuFKCtmy4Dex1wyctjsPu58cnhBPfQ0v+cIlkJFXyCWgZkhLzCvxemmn6BRpIaPevEJ
         D0qMfmeTyOTFF4am/6+C4QaeNhIQekuSAQ3U/y3hzPmkvCOgtwXyrVq5yWToF+nSkEcS
         HaZ9VmtbJDGjG58AY+omxWcYK+B5aiuHOlNZzvoAL1GH5vGKj7cjJcZBKadNeT41+dEM
         205A==
X-Gm-Message-State: AO0yUKUg0KVRCuOeX/DPLAZ/22Y3TYHYZfNJJrOAhSThHctDaWdnG9Mn
        EH5OdzAtwuu7CBvhdQIuQ3o=
X-Google-Smtp-Source: AK7set82XfQubhD+uVW5tIofQEMfTx1cY8todx0VzsAG9Cqi770GiHgVkzcuEjv+mlLWqFa37ybx2w==
X-Received: by 2002:aa7:c796:0:b0:4aa:a9c7:4224 with SMTP id n22-20020aa7c796000000b004aaa9c74224mr5535537eds.30.1677003911082;
        Tue, 21 Feb 2023 10:25:11 -0800 (PST)
Received: from jernej-laptop.localnet (82-149-1-233.dynamic.telemach.net. [82.149.1.233])
        by smtp.gmail.com with ESMTPSA id j19-20020a508a93000000b004a21c9facd5sm3826686edj.67.2023.02.21.10.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 10:25:10 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     dmitry.torokhov@gmail.com, ye.xingchen@zte.com.cn
Cc:     hdegoede@redhat.com, wens@csie.org, samuel@sholland.org,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: sun4i-lradc-keys - Use devm_platform_ioremap_resource()
Date:   Tue, 21 Feb 2023 19:25:09 +0100
Message-ID: <2133023.irdbgypaU6@jernej-laptop>
In-Reply-To: <202302171036375639285@zte.com.cn>
References: <202302171036375639285@zte.com.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne petek, 17. februar 2023 ob 03:36:37 CET je ye.xingchen@zte.com.cn 
napisal(a):
> From: Ye Xingchen <ye.xingchen@zte.com.cn>
> 
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to Use devm_platform_ioremap_resource(), as this is exactly
> what this function does.
> 
> Signed-off-by: Ye Xingchen <ye.xingchen@zte.com.cn>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


