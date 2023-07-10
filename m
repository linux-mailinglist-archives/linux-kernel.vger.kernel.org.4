Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2696D74DF0F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 22:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjGJUSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 16:18:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjGJUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 16:18:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73026135
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689020250;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=MatPkdlfWwwrlUu3EVslUzYwQyXM940i5KEhzgEgAcU=;
        b=RD+hDi9cpwOmhPSzV/tdg0/baATuWNefhMompjAqVSuZ4QytETaisOeHxZt0owdZC7ys+u
        7px/Q50prhgEOFo6e2Gi5o3D+hMswORxkyC09mG20TG6WHDu6wKOfoHj1Hgu9GSzm2jKX4
        UtxYzTrE38izrpgcaKfY4tJu8FXOKsg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-63hyyxsUOICdu9PuofiLgA-1; Mon, 10 Jul 2023 16:17:29 -0400
X-MC-Unique: 63hyyxsUOICdu9PuofiLgA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-5707177ff8aso56726547b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 13:17:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689020249; x=1691612249;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MatPkdlfWwwrlUu3EVslUzYwQyXM940i5KEhzgEgAcU=;
        b=crbta3sG9DpUpJ1P6o1eps8HD8UGvTJZEjPxnXHc3ob/t/lgWpfcnZdCZvOKVdG1uc
         CPffwkz10yQU8FV7lwGEQQV8y91Xs4oF5wM1KNxFvG1YeiijGwEii/PWuPrZ7D3gCIfd
         m5EgREd7z0XnbSP2PAqBROthN+8BVB0GxYa8lXO/rKh6IGro2pfRzLe4Eu7PZ/BKOcsa
         QsDG2fxek5lOFDV6kHqwZQZKxH3yfe/Kg4cBTz24/p2d/aCmZWg6zvCwQO2RJcGXP6al
         KxVoucp+7fuLSoeA6zC1tDipt58jJF6e8bR/R7AX+tIG8WvV0GfpAKJTsab1VtALIcpH
         4m6g==
X-Gm-Message-State: ABy/qLb9H5v/rGSUnEiqDbKFl6eaUhZ6Q2MwhB2GZhP61tiiQXzdlg09
        PFPaOilyR/mueSCRIukCe9LUiRTkOohx49wyhGwb51OyeXmjXcwUAFFg4DEpwhaZ3UnbC0cx7kR
        RXjGVnkjp2nlMYogaZOsI9v5ETau4MXpWbBaf85pZRNw+/bjXBw7nYzJJrj+gfTiMOZmiI2ctQK
        OFz34j6836
X-Received: by 2002:a81:4995:0:b0:569:e7cb:cd4e with SMTP id w143-20020a814995000000b00569e7cbcd4emr12772045ywa.48.1689020248868;
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHyRJxkGXCriSJqC1waS5qykotJRzMqF5zfNpiybzK4XMv35z9jl2wuOjlnU4LLJpYREhCLgA==
X-Received: by 2002:a81:4995:0:b0:569:e7cb:cd4e with SMTP id w143-20020a814995000000b00569e7cbcd4emr12772020ywa.48.1689020248527;
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
Received: from halaney-x13s.attlocal.net ([2600:1700:1ff0:d0e0::22])
        by smtp.gmail.com with ESMTPSA id j12-20020a81920c000000b0056d2a19ad91sm155097ywg.103.2023.07.10.13.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 13:17:28 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
        mcoquelin.stm32@gmail.com, pabeni@redhat.com, kuba@kernel.org,
        edumazet@google.com, davem@davemloft.net, joabreu@synopsys.com,
        alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
        bhupesh.sharma@linaro.org, vkoul@kernel.org,
        linux-arm-msm@vger.kernel.org, andrew@lunn.ch,
        simon.horman@corigine.com, Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH net-next v2 0/3] net: stmmac: dwmac-qcom-ethqos: Improve error handling
Date:   Mon, 10 Jul 2023 15:06:36 -0500
Message-ID: <20230710201636.200412-1-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series includes some very minor quality of life patches in the
error handling.

I recently ran into a few issues where these patches would have made my
life easier (messing with the devicetree, dependent driver of this
failing, and incorrect kernel configs resulting in this driver not
probing).

v1: https://lore.kernel.org/netdev/20230629191725.1434142-1-ahalaney@redhat.com/
Changes since v1:
    * Collect tags (Andrew Lunn)
    * Switch to of_get_phy_mode() (Andrew Lunn)
    * Follow netdev patch submission process (net-next subject, wait
      until merge window is open) (Simon)

Andrew Halaney (3):
  net: stmmac: dwmac-qcom-ethqos: Use of_get_phy_mode() over
    device_get_phy_mode()
  net: stmmac: dwmac-qcom-ethqos: Use dev_err_probe()
  net: stmmac: dwmac-qcom-ethqos: Log more errors in probe

 .../stmicro/stmmac/dwmac-qcom-ethqos.c        | 28 +++++++++++--------
 1 file changed, 17 insertions(+), 11 deletions(-)

-- 
2.41.0

