Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 805FA6F3B63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 02:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjEBA2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 20:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjEBA2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 20:28:06 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2344E75;
        Mon,  1 May 2023 17:28:05 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-24e16918323so727818a91.2;
        Mon, 01 May 2023 17:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682987285; x=1685579285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yuTu0AJ5Ic0Ds+J7fThJCjymKFlMI4pKjzUjDUE4pEo=;
        b=l0cn9yxe5XfXc2lk7rXUI+uV6Xlm9ZySfOKensMTtBGMCDjCMHRiTFtc59Prhl6AcD
         DmxpmnX/uS5OqO8upenRU1Hp9bY08XUofcArD9UEWb4X+S3e9eOGCgff5qpCKE2aujmS
         ehjHg519SVwWJDeIpslzipkTSJYSE8wXgA02HC7angQUiKTebsHpXwCfzJ/e9AsYM0IQ
         2yaJXFaLSVbRcH+n8Smn39BZs/fYWeRyV1lNzvarkgObiMq8I5CrM0Nf8OdPxyHADs2J
         iDXundE/uvJppvIHzLaJHC7E/O2h5gf8QWEFCJFU/m5n0lsQL4GES27q0gDCRvjO0eCS
         wPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682987285; x=1685579285;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yuTu0AJ5Ic0Ds+J7fThJCjymKFlMI4pKjzUjDUE4pEo=;
        b=dAgAZmy8iVZgWQ4UB070T2xizlLGchIDnU90boJctz/Cx7B+yRi2KaHkyFaXl/XZLf
         iK3r8EZ+8QXGN35NZAGThibbDAwPpUmIPqHTvQJtVxbpAISDR/Gi9b8gG5oOsn/vciNw
         nJ+PnK9aaX5hg39oPwslLk7KyclxOH5CGVp/VaiG4/4ETFL40nkxPfOurGMxogcB8Yyd
         r88QP9sMgIZi6Lru6IA4XCTUkE87DAZs1+Bq44QWDVs/DyMjoVWWpXxq1CDABGPBcous
         qN8NFEnKrrEuaT8knHiFZjyAIEK4JIkWFnXUuDTM7fekzaDYGuL+US2Dt9Jhci7G26yS
         Saxg==
X-Gm-Message-State: AC+VfDyML39NSaJxUnj3lj/YL9E4jypVJ3B4nxqTwc8vShbKqV0JOYQ2
        xKf7OMvlnpdvXzp0Ifgau3c=
X-Google-Smtp-Source: ACHHUZ7WX2t9qanx+DoS9thfWyYjeH0tFYpeBstRLh5DK8jAjpodj7DOtLQgeuf/K0o9V7mfD311hA==
X-Received: by 2002:a17:90a:cc0b:b0:24d:f507:5437 with SMTP id b11-20020a17090acc0b00b0024df5075437mr6200900pju.41.1682987285177;
        Mon, 01 May 2023 17:28:05 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:b6ce:736b:e4f7:adb])
        by smtp.gmail.com with ESMTPSA id gj14-20020a17090b108e00b0024deb21eb4dsm3447137pjb.54.2023.05.01.17.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 17:28:04 -0700 (PDT)
Date:   Mon, 1 May 2023 17:28:01 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Maximilian Weigand <mweigand@mweigand.net>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Alistair Francis <alistair@alistair23.me>
Subject: Re: [PATCH v2 5/6] dt-bindings: input: cypress,tt21000 - add
 wakeup-source entry to documentation
Message-ID: <ZFBZEQ623p5SEvkQ@google.com>
References: <20230501113010.891786-1-mweigand@mweigand.net>
 <20230501113010.891786-6-mweigand@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501113010.891786-6-mweigand@mweigand.net>
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2023 at 01:30:09PM +0200, Maximilian Weigand wrote:
> The touchscreen can be used to wake up systems from sleep and therefore
> the wakeup-source entry should be included in the documentation.
> 
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>
> Reviewed-by: Alistair Francis <alistair@alistair23.me>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Applied, thank you.

-- 
Dmitry
