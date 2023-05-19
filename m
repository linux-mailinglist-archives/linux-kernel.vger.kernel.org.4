Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECABB709130
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 10:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjESICP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 04:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjESICL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 04:02:11 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B702E50
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:02:05 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-643846c006fso2997139b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 01:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20221208.gappssmtp.com; s=20221208; t=1684483324; x=1687075324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HlEmFTNP9PUL84u+Ib0II+xLrPS1EiFnsGFID7L9rdo=;
        b=Ttjov7FxrgoKOfg1g2SAICXOklfg6xj4N73Vw5FKWFJUkkJIlDwu/VJggLjpvX4lyt
         PEr/NmLmak5S+RBzpclSuu2NZZ+R7Ms8UAm6yJIQgNkkRG7y6FjzmnemZ4bXMdIWRiqf
         LFQ0HnRfu8OVSppLjcXxfkptl1UAts2Z03noutdfB+GrE5eKnhPSUEXDs0iXB+PFTqS0
         r8juNWCbePncLltibJxUwRDHCpRHvcMAMcqXZ5bQc9Q6t3o6nLlz42gXthA6YupF89Oy
         kvynOciRFnSz4stSUj1JxkG8KlQQNkRx3VPm81ivRp4CJMmkj1I+/E1Onlo8mZXlty/e
         6psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684483324; x=1687075324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HlEmFTNP9PUL84u+Ib0II+xLrPS1EiFnsGFID7L9rdo=;
        b=biEDcJ8zEJM3D/8pPMk31dkWS+L+LE6RnOT7mVp0XZ6a+em9JxSkmWBhTAEUiYM+Oz
         5bjSIgzArbqfPLUDTPUdN7R6KfBN3jP9skZ4PY0OydtR8IjC9jyMulsZuCXtJaiwmjPw
         q3V8ym7j2KRYOjGyRW0HihuQ71w4taJFAPid95nWha7ZtqNg2nGk6TnEnna0V1R+adHR
         XhQ1MPNP3tTLQnY3fotRxALKkvqObukXbS/oQnnv0w42FVGgp+YAdVIxWWCiWfDkG4BY
         //R/MTr6E9bYD3yYLf0OBvQjIaNs0n811iHEQzc/QwDwUqHV/3+iEHAbsrKsnFcyEYes
         xX6w==
X-Gm-Message-State: AC+VfDzs0ldDqrjdvm1qw4749Mq0QJQeUdrEgOJaNmzgu0+hnSWr5lWz
        TaLhiKSrYnm23FWPi1vUQRxYWg==
X-Google-Smtp-Source: ACHHUZ4fKTzh2fL7MosNybhfq9X+LbsyMmWzTTd0uVDUCGM8pD/IEEkJL2XH2SGMyiJQmZgEcN2peg==
X-Received: by 2002:a05:6a20:12c1:b0:105:f8e4:7214 with SMTP id v1-20020a056a2012c100b00105f8e47214mr1444727pzg.42.1684483324581;
        Fri, 19 May 2023 01:02:04 -0700 (PDT)
Received: from yc.huaqin.com ([101.78.151.214])
        by smtp.gmail.com with ESMTPSA id e2-20020aa78242000000b0063b86aff031sm2441174pfn.108.2023.05.19.01.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 01:02:04 -0700 (PDT)
From:   Cong Yang <yangcong5@huaqin.corp-partner.google.com>
To:     sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch,
        dianders@google.com, hsinyi@google.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Subject: [v1 0/2] *** Support Starry-himax83102-j02 and Starry-ili9882t TDDI MIPI-DSI panel ***
Date:   Fri, 19 May 2023 16:01:34 +0800
Message-Id: <20230519080136.4058243-1-yangcong5@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519032316.3464732-1-yangcong5@huaqin.corp-partner.google.com>
References: <20230519032316.3464732-1-yangcong5@huaqin.corp-partner.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The previous patch is not based on drm-misc-next, resend this series.
Support Starry-himax83102-j02 and Starry-ili9882t TDDI MIPI-DSI panel,
set the default high for RST at boe_panel_add and add lp11_before_reset flag.

Cong Yang (2):
  drm/panel: Support for Starry-himax83102-j02 TDDI MIPI-DSI panel
  drm/panel: Support for Starry-ili9882t TDDI MIPI-DSI panel

 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 474 +++++++++++++++++-
 1 file changed, 473 insertions(+), 1 deletion(-)

-- 
2.25.1

