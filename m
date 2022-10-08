Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14C7E5F85BB
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Oct 2022 17:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbiJHPKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Oct 2022 11:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJHPKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Oct 2022 11:10:34 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E16E2C12B
        for <linux-kernel@vger.kernel.org>; Sat,  8 Oct 2022 08:10:33 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id qw20so16224017ejc.8
        for <linux-kernel@vger.kernel.org>; Sat, 08 Oct 2022 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C5DKsFFe8GPmeoM51frqAs/ZJNFCYSbjNvK+URttuB0=;
        b=YZEi5wYvmKc822x5qZvwjXOKD/IDcmbU98kIh5rLAX9WDSnrbVNe4M6BVGos4rdcpj
         Uz88wSpTNaflbdEqvvyY3wvFvZLBP7L9iQJQPlz9ZhRBwyNaR3vEIX/KwWCZRNTUHk/J
         KEK0QKfrljjuBE7L7cYhY3GzMXAPWeNEM6mrE11Ktq3m4EXJ/pko9Qb+IGcd5jtdAn7/
         GPnCNELGQx/QfoACdZp8fSuHX4mo2dU0mbXQyipCgOKpJA6YMoFb7YzTGSJW27zuLSTt
         RPwfByzsmEH8Gc25nVf7ImFxZ0n9t/tHYBnIJJ68S/hzi82LtUIkImEEuNSWh+yxnoxp
         VHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5DKsFFe8GPmeoM51frqAs/ZJNFCYSbjNvK+URttuB0=;
        b=tc104BCI8Wx4vZP8/Po6Xkzw4VsNuZwQBQ53HBEOpe4+zunVVY5iXqEsM/r7koeZSu
         UZCZbDmUWXSwUMOlzonbZa9EceSxRz2xbEPEOK/ip5YZr1CVUR4ZmhQoxinkJkhVpC6S
         aE/euMtdTF1/eQm5GSbERpT049JmzqM9ztRDn3la5GtFbXqW/Ndi4sijQQc54IIwlHZJ
         5wzdMnvT3woUWkHVHxyoRLo3hosk0ntj7JuX+cJLOzmLX2thEn0Er+ksXUEE8cPdllMb
         EbM5d72eloCvZPqh1/IrbHf/8hv1bbSVA/8BK6kq61GnvmS2CqMVTzu6P783NiVDtDXn
         HBAA==
X-Gm-Message-State: ACrzQf19M/6TIw+XKBKoe7llRa/J5tzTS5Up06uYTzDZDiwy4CicwDvw
        rCk2Z8XtghCs5uprUiFGVmw=
X-Google-Smtp-Source: AMsMyM6JPxbo4+cgHinL2jtWQLwIksmTxOnGzE4YG9CLtfRaECFGgMBAaRcIrMcuCErVSdbK35q2Qw==
X-Received: by 2002:a17:906:cc56:b0:78d:98c3:8714 with SMTP id mm22-20020a170906cc5600b0078d98c38714mr2194404ejb.445.1665241831517;
        Sat, 08 Oct 2022 08:10:31 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id l25-20020a50d6d9000000b0045723aa48ccsm3523119edj.93.2022.10.08.08.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 08:10:30 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>
Subject: [PATCH V2 0/2] Other misc fixes for Xen grant DMA-mapping layer
Date:   Sat,  8 Oct 2022 18:10:11 +0300
Message-Id: <20221008151013.2537826-1-olekstysh@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

Hello all.

These are other several fixes, which were identified and sent separately,
but now they are put together in completeness here.

Current series depends on the series which has been already pushed
to xen/tip.git for-linus-6.1:
https://lore.kernel.org/xen-devel/20221005174823.1800761-1-olekstysh@gmail.com/

Oleksandr Tyshchenko (2):
  xen/virtio: Handle cases when page offset > PAGE_SIZE properly
  xen/virtio: Convert PAGE_SIZE/PAGE_SHIFT/PFN_UP to Xen counterparts

 drivers/xen/grant-dma-ops.c | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

-- 
2.25.1

