Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 108276D96B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237243AbjDFMFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238681AbjDFMFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 08:05:02 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D2E901C;
        Thu,  6 Apr 2023 05:03:31 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id n21so783541ejz.4;
        Thu, 06 Apr 2023 05:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680782609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Go1w/1aC0WMyrU2tHEVEfl1C38hl149Gmuqes9rB4CU=;
        b=PkCc3NvlQhuP1+R3SS09h9Z8RCY8z69FZW6IcytblCWpVTiDmhz5jwclTiasCwT9Oy
         Hjkz00NzbleMgor2QtzlfPHNCDMhONlMs0aOZIDhu9s+kY5w8k2rSwW6NqNznGZwGxXB
         Uok5lWzVAlkfLSSbgqG2SUbsCVWvJkUs2JAtdrty5sa7n70JJtRFeXF2g1iL6zCEMMf9
         To8Bh5tuYLOk0sd5a19fiSigun21Dddl1DqdBc/DF43LcU9rCHgf42qwKcxYk4MciX0q
         60668KYX8/wAdiqETfOP1OIfyeoQsUtcxT3ykCWPoJgrz3u7lASbKFI7B2jC5OM1/YFd
         L2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782609;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Go1w/1aC0WMyrU2tHEVEfl1C38hl149Gmuqes9rB4CU=;
        b=qIV+JONL3qys7FBklGe+0MFP95MlVqVYaw8Wl2IsJREygB7hARtM3lJJPiO3cPnVph
         VmQ8Gzt16uQTBDlp9KNWtDhjgBBsfYlGRH3DckQjWXyPYMO2qpWOz6AYzJm1dJV7i/+S
         vL6+k5FMqeBSaAAr9WIhZofFJXOyGSvQB17WdiRGhiESPdNPzDvoS/7igrSU4Yse0nFz
         pjsYgfXVTL7RNar7HqJKs6Z65vmDpLN6RQFIuR9LbvpMhGeI+zBiBW6rMMiMnByAgAXE
         BnOYR3FW7F7nfsHdso7XqHU2poGDfTgFZIq55aRGifFnt2IFT6cCO/FaHGw4cfC1zhVE
         GiUg==
X-Gm-Message-State: AAQBX9eJyUbnJE+RP7UoQllD1EAu8zcfw+IqKKcOHi6JPUX4+ETqeV3u
        uxCrleq1XuEIQweicj7YboU=
X-Google-Smtp-Source: AKy350YtecHxljjAvQASvWuOoFJYdUQt++BoqDoynDN0CWd+SUGMxylECCAzwF6q1YbVCNQU+UQCKQ==
X-Received: by 2002:a17:906:7150:b0:922:446b:105a with SMTP id z16-20020a170906715000b00922446b105amr5169539ejj.19.1680782609139;
        Thu, 06 Apr 2023 05:03:29 -0700 (PDT)
Received: from localhost (p200300e41f1c0800f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f1c:800:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709067cc300b00947f4e2b2b5sm721007ejp.127.2023.04.06.05.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 05:03:28 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     airlied@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, daniel@ffwll.ch,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        mperttunen@nvidia.com, Nur Hussein <hussein@unixcat.org>,
        thierry.reding@gmail.com
Subject: Re: [PATCH] drm/tegra : Avoid potential integer overflow of 32 bit int
Date:   Thu,  6 Apr 2023 14:03:28 +0200
Message-Id: <168078260130.966805.9780166486659802079.b4-ty@nvidia.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405202559.2232430-1-hussein@unixcat.org>
References: <20230405202559.2232430-1-hussein@unixcat.org>
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

On Thu, 6 Apr 2023 04:25:59 +0800, Nur Hussein wrote:
> In tegra_sor_compute_config(), the 32-bit value mode->clock
> is multiplied by 1000, and assigned to the u64 variable pclk.
> We can avoid a potential 32-bit integer overflow by casting
> mode->clock to u64 before we do the arithmetic and assignment.
> 
> 

Applied, thanks!

[1/1] drm/tegra : Avoid potential integer overflow of 32 bit int
      (no commit info)

Best regards,
-- 
Thierry Reding <treding@nvidia.com>
