Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE66872B130
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbjFKJhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 05:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjFKJhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 05:37:02 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9C3B3
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 02:36:59 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-30aeee7c8a0so2361772f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 02:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686476218; x=1689068218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1RzKoavleYmYbGi4L50Fse1b510eueYfvrCoJAmsbxo=;
        b=GQKny/Ocfst/o+Iz0zqLh9RYFAbp7j4h3MNYdU0ew61bb+vEXAkw3uBdHqUYfrK5kJ
         Mmo+9ATeTsy6jpHk4rWHMICl+7C8UibYVaL2giyJyB3zqUMVLC/QsdxrQEEoQoKWfbmg
         +Lo3EuyVmxQvNzDGtYq+41t3CP/zZbUuKl5HuNxk+qfYeEqSt+iG4NNUyH9OrtIhmVzp
         UbDUe/olXXA6Cgx1+RhqGFa/0ms3SJiQnQIUOeMrysO1ozG9Z6Fm3bpD34jdKyrPq57H
         uQUVcz7IhjPT78Bp0Ndtwiugfk5Sh0OhOyGLGcIUpuNxbBD92XvQm04DgjSD2PPpoNed
         i66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686476218; x=1689068218;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RzKoavleYmYbGi4L50Fse1b510eueYfvrCoJAmsbxo=;
        b=it0hBKMFS2KryvE4Ymf3T5j16GD1IfVbR9vwbXo+I/1ouM4Yoz2u0ozV2BbfXCCJLB
         X9bS3NcoK2E95EEtZS74yRaW72mKY3eO4+5ehYfd1mPH6/kbseGs8augyevJq8Y7Mhcw
         lJpYJ5b1jBQDFP6pGpJYoq3jtzz9MuvFuJ0NPRoM2c23soIXsZEbNqNd0hDAkl9hCSYQ
         aem7zCSagTngVCIGx7sI2XVom4kQQU76yzZi5THuukNjg/2kxr4Avi4TxB4JEPKaH/0d
         fTsJJGiSfELj6VEg/YemWSUdZJRjDwtw11Y+znEVXSla8VNRvkC1fjYBMRr0B/JORzBc
         9cBw==
X-Gm-Message-State: AC+VfDwK+EFdsq94GSxm0wqXuagHB+7ThiM9WLPHkJUSQJcNulyoQy7K
        Qr6TKnLq1jOGt71XRk98aa9gKA==
X-Google-Smtp-Source: ACHHUZ5+nfn02bkuQTuCe1HVJNha7vkQ+Bf1+3Syh+Cs505sLe6+OvuIFC/T+1SNK4FODSOQZ+G7VQ==
X-Received: by 2002:a5d:6e0c:0:b0:30e:47e2:7eca with SMTP id h12-20020a5d6e0c000000b0030e47e27ecamr2880966wrz.3.1686476218225;
        Sun, 11 Jun 2023 02:36:58 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c0b5400b003f4266965fbsm7983801wmr.5.2023.06.11.02.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 02:36:57 -0700 (PDT)
Date:   Sun, 11 Jun 2023 11:36:56 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc:     kuba@kernel.org, vadfed@meta.com, jonathan.lemon@gmail.com,
        pabeni@redhat.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, vadfed@fb.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, saeedm@nvidia.com, leon@kernel.org,
        richardcochran@gmail.com, sj@kernel.org, javierm@redhat.com,
        ricardo.canuelo@collabora.com, mst@redhat.com, tzimmermann@suse.de,
        michal.michalik@intel.com, gregkh@linuxfoundation.org,
        jacek.lawrynowicz@linux.intel.com, airlied@redhat.com,
        ogabbay@kernel.org, arnd@arndb.de, nipun.gupta@amd.com,
        axboe@kernel.dk, linux@zary.sk, masahiroy@kernel.org,
        benjamin.tissoires@redhat.com, geert+renesas@glider.be,
        milena.olech@intel.com, kuniyu@amazon.com, liuhangbin@gmail.com,
        hkallweit1@gmail.com, andy.ren@getcruise.com, razor@blackwall.org,
        idosch@nvidia.com, lucien.xin@gmail.com, nicolas.dichtel@6wind.com,
        phil@nwl.cc, claudiajkang@gmail.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, linux-rdma@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, poros@redhat.com,
        mschmidt@redhat.com, linux-clk@vger.kernel.org,
        vadim.fedorenko@linux.dev
Subject: Re: [RFC PATCH v8 03/10] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZIWVuPMyKRPv6oyh@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 09, 2023 at 02:18:46PM CEST, arkadiusz.kubalewski@intel.com wrote:
>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

[...]

>+int dpll_device_register(struct dpll_device *dpll, enum dpll_type type,
>+			 const struct dpll_device_ops *ops, void *priv)
>+{
>+	struct dpll_device_registration *reg;
>+	bool first_registration = false;
>+
>+	if (WARN_ON(!ops))
>+		return -EINVAL;
>+	if (WARN_ON(type < DPLL_TYPE_PPS || type > DPLL_TYPE_MAX))
>+		return -EINVAL;
>+
>+	mutex_lock(&dpll_lock);
>+	reg = dpll_device_registration_find(dpll, ops, priv);
>+	if (reg) {
>+		mutex_unlock(&dpll_lock);
>+		return -EEXIST;
>+	}
>+
>+	reg = kzalloc(sizeof(*reg), GFP_KERNEL);
>+	if (!reg) {
>+		mutex_unlock(&dpll_lock);
>+		return -EEXIST;
>+	}
>+	reg->ops = ops;
>+	reg->priv = priv;
>+	dpll->type = type;
>+	first_registration = list_empty(&dpll->registration_list);
>+	list_add_tail(&reg->list, &dpll->registration_list);
>+	if (!first_registration) {
>+		mutex_unlock(&dpll_lock);
>+		return 0;
>+	}
>+
>+	xa_set_mark(&dpll_device_xa, dpll->id, DPLL_REGISTERED);
>+	mutex_unlock(&dpll_lock);
>+	dpll_device_create_ntf(dpll);

This function is introduced in the next patch. Breaks bissection. Make
sure you can compile the code after every patch applied.



>+
>+	return 0;
>+}

[...]
