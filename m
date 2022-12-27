Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E265703E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 23:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiL0WjW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 17:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiL0WjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 17:39:19 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42642182;
        Tue, 27 Dec 2022 14:39:17 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id z10so13502278wrh.10;
        Tue, 27 Dec 2022 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ElcL0rtEWE6QJVrS6IfgxSOMIRo6g8XMZ+ZYyQilUJ0=;
        b=UcHYWBXhHjA+ykzAmuQhu3DelRitSi7rkEWM96SX5XC+tyJyfLpyCsueUCItvrMW2d
         4FhIvXb+DDoASogSXDufZ6YPiSNiT51UO4LFu6Lt5wxZIF3MO0CawvVSYcotJm6v2voV
         RrF827Vcg9iyx6dm09KzVTsIS1fxd0Prs2AHjjH/EE8Ja5VewEXdhWQ8v1C1K1u/YoQv
         JVeTBzEpIvt4poEFjJ+u8Fs16eR0eIOqMF0kOmtjkLsmJEzgXH828f0Dslug8o07Cn8x
         wDhKYdWAQpP9zMyGiP9kkBP/YN7ctlkNEcZunmmNCR9TxSJHVZUagAkM+ZrgrqRHBeiw
         Dheg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ElcL0rtEWE6QJVrS6IfgxSOMIRo6g8XMZ+ZYyQilUJ0=;
        b=1smxcHF8Sid7GoMhcWvKl185Y2wrRp+T+nh22miUDNfGqk4TqAc0gVD7Gm39ky/MFS
         xrh3ezQvNzpqbQ2gRgFIi1wq/mntJsXBe/WnE6hEZ4anaq1/3s5adnPddHUuZy9OqS26
         0rD7b8uX4fzfLWsiq49nluqJFTG9OUZII6AGboU3MtOZ/MKQzaSjKvEuIdpoquUO4HkY
         GKv1Jw3wX8C6+OaA0moFvAH747TfBHy0Z0uXiHI/hCcpYZmo4RBkWdpFSjRGscW7QFt7
         OCDqWCEHl6Ggmrg7AZ1tC14R+qqrXBbhzO39bacgJbj2cyHLjs2K5zt0ZgxZDxP70EY7
         y6BQ==
X-Gm-Message-State: AFqh2kr8nWCRJUvjl9XCUx7mKKkO1TcrSt0FMFDYYaWLc1Qo04VpeCGY
        Kc+U/ZtfFyxWSJ8PUiF+J3Pb6fsp+KR77YhgOvY=
X-Google-Smtp-Source: AMrXdXvrb0BNfS2qJtsB9q72FQXMqmfm2zpowcbwLA0yA2dUVj1ojlSxmequkTovog1QOBNj2LUVsA==
X-Received: by 2002:a05:6000:501:b0:26b:8177:a5e6 with SMTP id a1-20020a056000050100b0026b8177a5e6mr13390207wrf.51.1672180756239;
        Tue, 27 Dec 2022 14:39:16 -0800 (PST)
Received: from tpt440p.steeds.sam ([2602:fbf6:10:8::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm13739132wrq.10.2022.12.27.14.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 14:39:15 -0800 (PST)
From:   "Sicelo A. Mhlongo" <absicsz@gmail.com>
To:     linux-omap@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tony@atomide.com,
        devicetree@vger.kernel.org
Subject: ARM: dts: n900: switch accelerometer to iio driver
Date:   Wed, 28 Dec 2022 00:38:40 +0200
Message-Id: <20221227223841.2990847-1-absicsz@gmail.com>
X-Mailer: git-send-email 2.39.0
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

[PATCH] ARM: dts: n900: switch accelerometer to iio driver

The lis302dl accelerometer is now supported by an iio driver, so the N900 can
work with modern iio-based userspace. This patch provides the required dts
changes for the switch

