Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07CC6D7D8B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238123AbjDENTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238003AbjDENTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:19:15 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4552626AD;
        Wed,  5 Apr 2023 06:19:14 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id hg25-20020a05600c539900b003f05a99a841so4039973wmb.3;
        Wed, 05 Apr 2023 06:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680700752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lrrn9Os7k/oSQLAsT1c79tz/mKrZxstzRd8x/1yg5OY=;
        b=Vrz6olQ2YQn7JUr1CnWReP6pJECYE7iuvSMJDTkb8zpmLvLnJ3jWlZrpUcdYpadj6E
         vfV34kDBgAj7SC9cTQKZpeyzj0h5baHTrc6wHz/ctPhVtqM9zJyI9WkjXHcdvapTS6t2
         hdVS1pngBQE+g3xPl1M18LJoQdtXdw4S7ewqMAtwmkHK4OY9KlCZ44je9C/CbB/eNCK8
         51lGAkh2H+HgCECP3Y6c+WqXZDRzXhT7Jg2r932srKoePuTfo8x3vSIAIOGpkbeL1W4k
         4W187TJiNlwUxXSSvziuBuHuKLHiMhubps1R+oFTJfkcK8o3TxkffT1ayCzLAI/jziWi
         A1FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680700752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lrrn9Os7k/oSQLAsT1c79tz/mKrZxstzRd8x/1yg5OY=;
        b=Sp2Tu/tDUswJowSWH2QWhtnDB890VlNgymK9gyQBufEW3fjfRpcsmn84OPioJ3kCaN
         EYW37L2wt5jI995lQpvF+L61mgSFJCLu8ESBvs8NGTx8gHPg8zx326U2mvg8Ka75UPJS
         b0ObMGdeXdH2GYe3F7CtQBk4uL7OSfv8jBAOhoK0ANuufiVnV9Edd/oQwK4O8UMaKTAf
         27oZcqu8V8tQGGsRaLWEb6iO+zJ0YXemMFjJ43XxkwulpQ2tBFS8p8j91rswGSX6n5zg
         vvBKDnE6+w4Aq1ELfltBsxiHfhERXizl5ICMma39XUxPtWvmFDHHWBEcC0W/zABsmOoS
         kBjA==
X-Gm-Message-State: AAQBX9dhlh8vJU1MJrxmQWi3TflhyM/U8iW7tJGZDPn10IODrpiAq7f1
        Xc6K7ElCzNFAtWxwxlh3pP8=
X-Google-Smtp-Source: AKy350YehJnPIP/FP8sRfcA+mZ9Sfjv0xepelIXESrZzVxmEpK8XtXbe2rY2IdsBdGRCM7VZsQF0rw==
X-Received: by 2002:a05:600c:3b93:b0:3ed:2346:44bd with SMTP id n19-20020a05600c3b9300b003ed234644bdmr1802370wms.19.1680700752646;
        Wed, 05 Apr 2023 06:19:12 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id p26-20020a05600c205a00b003ee10fb56ebsm2201948wmg.9.2023.04.05.06.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 06:19:12 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Besar Wicaksono <bwicaksono@nvidia.com>, catalin.marinas@arm.com,
        will@kernel.org
Cc:     linux-kernel@vger.kernel.org, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, vsethi@nvidia.com
Subject: Re: [PATCH] arm64: defconfig: enable ARM CoreSight PMU driver
Date:   Wed,  5 Apr 2023 15:19:10 +0200
Message-Id: <168070074189.4045154.5490119907431955822.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230321200535.10584-1-bwicaksono@nvidia.com>
References: <20230321200535.10584-1-bwicaksono@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

On Tue, 21 Mar 2023 15:05:35 -0500, Besar Wicaksono wrote:
> Enable driver for Coresight PMU arch device.
> 
> 

Applied, thanks!

[1/1] arm64: defconfig: enable ARM CoreSight PMU driver
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
