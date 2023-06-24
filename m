Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCF0B73C704
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 08:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjFXGDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 02:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXGDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 02:03:32 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D797F271F
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:30 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-98502b12fd4so30970566b.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 23:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687586609; x=1690178609;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mL9869uxyI9VJka/GpEbEqxA2gTl4XYgCP6XmikgbWg=;
        b=KrT3nlmFrRckgej3EWQdrMhhwVwBjzrvCeKbYSm4GryxSBGSfZJqopI8ggLhHATxlF
         X3KeiJSxAxHcRIn0Q/B78O+W+ycO7BW5/oCyM1ttUUFo+CEIUqCbufzVFvNIX9F/I2S8
         Sttbp+affykocKqcCf1PYXgtR8K/3j9uN3xx/KrPt8PYWlkTtAiDa3IZWhPIR8PqUma7
         XGi1Inc36tP9z8ig+3GGyzTCrsxPVXQ5pELQtSzpzUPMOF6CUUx1BeMN0Kki8ZC7vYos
         389zdgxNvOPW/TOInfp+0ZG2q4daTAy+BJLvOdCw3jjpvHvbE8ajA7ZFNcqJd6esXV9A
         R9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687586609; x=1690178609;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mL9869uxyI9VJka/GpEbEqxA2gTl4XYgCP6XmikgbWg=;
        b=I6xF/KHTokzwWKuNrqbaPe7lrsAYKYo6+w963nRqKjzma9B3yIvBiqMLFJOVctgP4C
         Hd19o3GBFctUin60oLV64JpqzoCOAIxfHMlRTaHB9VG5nfsyzDN+nUtiO2C2mIJBBAZv
         PKtWdSpENyjZah3mfi3zyliDU2ry3OjruufARv9qTDBKmQNA5SOUUZ5KLbnuPVdqijCe
         H+2V55jD2QE0rgxEJXd8T/UYNbBh+TbiyjGEVxww04h2cBj1+PCa8eQEtkACwtDw/x7w
         JPZkG2qgax8ZVUYl1aCDOS/0mbS7W4cOJVFAxWYtsYsrOQIiLwBkL/Nd546clDh80/PL
         Cd6A==
X-Gm-Message-State: AC+VfDxUxBBszm5I+ww8eK/HHQkGetjadQt1zEP+S1iIxVVVvOPJaCqP
        hMv6qBrwHq0fE83fFqeXx7Q=
X-Google-Smtp-Source: ACHHUZ71JsXJxmduI4bxXw8okqNOiCMMO3kl0Ul5sr3juEPBHKJD0o+3qiywaXc2weRWWgA5B/lPAA==
X-Received: by 2002:a17:906:64d5:b0:988:8e7a:d953 with SMTP id p21-20020a17090664d500b009888e7ad953mr12886879ejn.1.1687586609039;
        Fri, 23 Jun 2023 23:03:29 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id k19-20020a1709061c1300b0098dd3981be9sm491456ejg.224.2023.06.23.23.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 23:03:26 -0700 (PDT)
Date:   Sat, 24 Jun 2023 08:03:22 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove timer function TsSetupTimeOut
Message-ID: <cover.1687583718.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unchanged or unused variables and code.

Tested with rtl8192e (WLL6130-D99) in Modes b, g, n (12.5 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (11):
  staging: rtl8192e: Remove unused timer SetupTimer
  staging: rtl8192e: Remove equation of local variable InactTime of
    AdmitTS
  staging: rtl8192e: Remove unused timer InactTimer
  staging: rtl8192e: Remove empty function AdmitTS
  staging: rtl8192e: Remove variable modulation as it is constant
  staging: rtl8192e: Remove variable host_encrypt as it is constant
  staging: rtl8192e: Remove variable host_decrypt as it is constant
  staging: rtl8192e: Remove variable card_type
  staging: rtl8192e: Remove variable bdisable_nic
  staging: rtl8192e: Remove variable priv->reg_chnl_plan
  staging: rtl8192e: Remove variable ieee->short_slot

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |   5 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  |  20 ---
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  |   8 -
 drivers/staging/rtl8192e/rtl819x_TS.h         |   2 -
 drivers/staging/rtl8192e/rtl819x_TSProc.c     |  35 -----
 drivers/staging/rtl8192e/rtllib.h             |   6 -
 drivers/staging/rtl8192e/rtllib_module.c      |   3 -
 drivers/staging/rtl8192e/rtllib_rx.c          |  44 +++---
 drivers/staging/rtl8192e/rtllib_softmac.c     | 143 +++++++-----------
 drivers/staging/rtl8192e/rtllib_softmac_wx.c  |   4 +-
 drivers/staging/rtl8192e/rtllib_tx.c          |   3 +-
 11 files changed, 80 insertions(+), 193 deletions(-)

-- 
2.41.0

