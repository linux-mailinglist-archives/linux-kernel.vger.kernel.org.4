Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52FDD69C2A0
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 22:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjBSVP3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 16:15:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjBSVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 16:15:27 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28D1969E
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:26 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id er22so4713437edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 13:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hW2ocK3CJdB874yEAAEAF0LaIVuHAH0k3ElV8Y1gCXo=;
        b=UdsJ3T/NnB+R97oklibeADStpFpn/mUQS5jCqpMdkRB4WkYqp+C1s/8IR8g/n78bhC
         WfEBgxDR4CiKvAGPOX07KIHOnUdSsCG1+UajpHLS40ZBU85tIXoAL02t9Ic/FB4fe5h8
         zBR0VwJHFcIHU4S8cn4mi72IfPBvM340rHK7Z9hLmzk/2tsgIJUZqeM/COEFZUF7h2PO
         RF6kjkTKy5EgTk7imrgvgGMWhRxvHaqhMoanU1q32PGUpikA9InwOhhwn515VKCbABOw
         VLFF1HLuhuXguRYI0RYobZDPPczei+EFPZHI0loVlAa8bOLzayfL2DFJrVrWWj5/3YGI
         ULlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hW2ocK3CJdB874yEAAEAF0LaIVuHAH0k3ElV8Y1gCXo=;
        b=ZPOvHhrZNOKMj5FELa4RQ4/8tiL/Ptz82Q69RRJzJeyh9FDuQR/pNGA3pgaJzAALK2
         towE/gxUNfg2JppJjZRA3WiMcwU/YocaQtMMFt+SU6NptTIJfV7U9AnCPb+crhkWtiXm
         Lr9QBg846M79tJZE5n9Q2ZqwSoKRlxj4MXXBuEozQwEiVxsmgVVYX3NzPT1g2BKHQHze
         Kgamm8L3TgUx7zSfm7e1qRnbPZ+lFqcv9+kiTqAm+NikmPf4ggEy56/k4D1PwBv1hYe6
         v0XEYc+dAnPi/yaBRVGBeGmSmaAuFjLtXTDnk6a70TsVnzrI090vU+JY8XkuQ2XAL6mB
         m75w==
X-Gm-Message-State: AO0yUKX3Jt+P5rXw7ltGeVgBrZDHNsAcNzkdoB++qm1H3kWNqfAoy+wu
        2vHJ8jRoqQSzKeMSuv1pygm+k+5Atd0=
X-Google-Smtp-Source: AK7set9/ibGxXrpLWDJkXADKUzmabiJsuLvdcPjLuH6EcUu4i1WwLKbEsE39YEekU6AkfG011Pp3Kg==
X-Received: by 2002:a05:6402:4413:b0:4ac:8e63:3008 with SMTP id y19-20020a056402441300b004ac8e633008mr1616870eda.3.1676841324987;
        Sun, 19 Feb 2023 13:15:24 -0800 (PST)
Received: from matrix-ESPRIMO-P710 (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id m25-20020a509999000000b004ad7bf8be72sm4105089edb.53.2023.02.19.13.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Feb 2023 13:15:23 -0800 (PST)
Date:   Sun, 19 Feb 2023 22:15:21 +0100
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] staging: rtl8192e: Remove entries from struct
 rtl819x_ops start with .get_eeprom_size
Message-ID: <cover.1676840647.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary entries from rtl819x_ops and replace them with with
function names. This increases readability of the code as the reader does
not always need to look up the corresponding function name.

Tested with rtl8192e
Transferred this patch over wlan connection of rtl8192e

Philipp Hortmann (11):
  staging: rtl8192e: Remove entry .get_eeprom_size from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .init_adapter_.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .initialize_ad.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .tx_fill_descr.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .tx_fill_cmd_d.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .rx_query_stat.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .stop_adapter from struct rtl819x_ops
  staging: rtl8192e: Remove entry .update_ratr_t.. from struct
    rtl819x_ops
  staging: rtl8192e: Remove entry .irq_enable from struct rtl819x_ops
  staging: rtl8192e: Remove entry .irq_disable from struct rtl819x_ops
  staging: rtl8192e: Remove entry .rx_enable from struct rtl819x_ops

 .../staging/rtl8192e/rtl8192e/r8192E_dev.c    |  2 +-
 drivers/staging/rtl8192e/rtl8192e/rtl_core.c  | 42 +++++++------------
 drivers/staging/rtl8192e/rtl8192e/rtl_core.h  | 20 ---------
 3 files changed, 15 insertions(+), 49 deletions(-)

-- 
2.39.2

