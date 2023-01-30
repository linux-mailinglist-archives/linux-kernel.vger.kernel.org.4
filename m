Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68C1B681565
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 16:45:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjA3PpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 10:45:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjA3PpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 10:45:14 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3793EFD4;
        Mon, 30 Jan 2023 07:45:07 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mf7so14223606ejc.6;
        Mon, 30 Jan 2023 07:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HPKfZ1FiVPXA8mxWW+VlALwncASGT70c5IKSFv8vcp4=;
        b=nXk99Juo2mzL5FtOV2x0t3TnMs25UyawxejJYdvMelHJhBfp8KEnWRsFpCIVMW83Ah
         Fc/RoUy+z38DLgL9IJDhFIxIsB6NgeOou4kHjBtJa4yS7GZV2bM5mp8dnKLpsUOWOXxp
         GIpSK5Ig+L+XVzKJuCisZpYs5nzAnM+ZN5uz/VKFenaCCgXSMHFO/znewkjGARNJ8pVK
         qeJ1LhBsq2qXynoC6GylHg6h0FCzWo/eynwDkOr1dtaGFQQZzE5jsYJYrLALJJigpdO1
         Po4R5awWvA9hUEPI2mqjDO45/h2+cNtrj1DE/DZtWiFSbBpYo1Dd3yCfKasbr8rIOxZu
         JqAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HPKfZ1FiVPXA8mxWW+VlALwncASGT70c5IKSFv8vcp4=;
        b=CWlakn7Is3plJgZ5hb6+Q7xKzsBdgUU9MqC5TFNkccSMsakLdyWSyPo+OC1l5NcUzo
         U6c4yL/HEmM8E52uJHI9Q2mPcdzAeEaBy33ELL044yMCjD3AHLCKSMZbo7+cnvQvcQp2
         DsNRSlEsSxYj9hi1TIix9ZDJSvUarhKH5epESR6XnfRu7oU86myLeLlzMOgo75KXNclh
         hkhrGQQspM5YbrxtScpyqwsq3PaLTSdBZZPUztXWnaU/1HPbzpImS/geeDurVPO+o/lU
         xDjVeNNOax6Osxt5TtVaNQxgyWNugeLuQJL28JQL+ii6il6+fS/GkLsh0wyX3zdWnN6+
         WYtw==
X-Gm-Message-State: AO0yUKWO4fbYyS2GYAYvcB3gx1CxUmL4O5nlhyQ24GbeCDRhLCxrtbmp
        btNxw4jPox+m1LJzaXvltm8=
X-Google-Smtp-Source: AK7set9DF8ufsPfZTTZm6/e1sCFb3FHJ60JMJa9iaMtFSHRgetnOK9UOHule9/s3mYx2Jl6/lsdhvQ==
X-Received: by 2002:a17:906:4912:b0:878:4e83:b058 with SMTP id b18-20020a170906491200b008784e83b058mr18296813ejq.1.1675093506380;
        Mon, 30 Jan 2023 07:45:06 -0800 (PST)
Received: from localhost (p200300e41f201d00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f20:1d00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id j15-20020aa7c40f000000b0049f88f00f70sm5619884edq.7.2023.01.30.07.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 07:45:05 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        u.kleine-koenig@pengutronix.de
Cc:     linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        olivier.moysan@foss.st.com, linux-pwm@vger.kernel.org,
        alexandre.torgue@foss.st.com
Subject: Re: [PATCH] pwm: stm32-lp: fix the check on arr and cmp registers update
Date:   Mon, 30 Jan 2023 16:45:04 +0100
Message-Id: <167509347310.581147.17334972892537481751.b4-ty@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20221123133652.465724-1-fabrice.gasnier@foss.st.com>
References: <20221123133652.465724-1-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

On Wed, 23 Nov 2022 14:36:52 +0100, Fabrice Gasnier wrote:
> The ARR (auto reload register) and CMP (compare) registers are
> successively written. The status bits to check the update of these
> registers are polled together with regmap_read_poll_timeout().
> The condition to end the loop may become true, even if one of the
> register isn't correctly updated.
> So ensure both status bits are set before clearing them.
> 
> [...]

Applied, thanks!

[1/1] pwm: stm32-lp: fix the check on arr and cmp registers update
      commit: 3066bc2d58be31275afb51a589668f265e419c37

Best regards,
-- 
Thierry Reding <thierry.reding@gmail.com>
