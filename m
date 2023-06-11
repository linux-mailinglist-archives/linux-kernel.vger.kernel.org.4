Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E963072B147
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 12:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjFKKBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 06:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjFKKBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 06:01:18 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2D9123
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 03:01:16 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-516a008e495so6890749a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 03:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1686477675; x=1689069675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U7HN0f6TOWWkr11pJT0tfFyGZ1Me6eKxGL1ZqHz5p/E=;
        b=CK+40rDIEO4qBWIjslHU71w2FzcpmL66yJ2ffo8QNiGyJVgjt2njdUY13r8vlWLyRh
         bFzF3aspyFifeybgeAm5JsTbvM0Y0U+htlNyMhY4rZdso0DpijNINO8CzRHkG4h6vTm2
         qDNewH1UtM2COGT2JZr0R53kucC4xe+Scno8vkuo9GrhvTpVhzxcRtNBK/Aq+CslaRWL
         6hGnkuO6xqG3ciKigTB9qYkhGVxQ+wJ/f/yVK+VC1tnSVF3wpmP3pZLfGG23kH9vlrXt
         mefPq9PTmMZ08D7NdNkgeJfPZ4BFv+VTpfc09VRr8QF7C3rGqDJ7tFv5INdS55jkARsQ
         vZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686477675; x=1689069675;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7HN0f6TOWWkr11pJT0tfFyGZ1Me6eKxGL1ZqHz5p/E=;
        b=Hi9H9NQRjg7lP2FAe38gX4NoZab8HpSe+PwPFB6jUT0Lj07TT+RM5u5iG/tM5YdKaL
         qumtrV71i8IHzBqD8L2yt9P88qzXIHBFxK3R1m2Wy3XEdNzuavQzcMLy+9LSL0SfLgru
         ZXTUbqytUbFNKGEp/3Vcpeq2PtR6X3cqvw7cW277NgzJEK54xJRfka0DEchxgWbUoBXe
         oasPhGjSDMEULdIk2a/13+Msl/o0RWX3PypvM/Q/3lvY1Xs4pJZOT1SWsbZonMevZqHK
         8y/Va5SFjArhkU59tIiKq+Y8Yht+koeWKo6CPkfMesp0Af1nFkrmyV0HCj5W8obJ82y6
         hK9A==
X-Gm-Message-State: AC+VfDxsDxs3YB+3eO/Nl27uODIbadRKfB7zWS2D7X4LPyIZEdIjzwah
        EmMiFn1cvHKy8dSRiY8t1Oppfw==
X-Google-Smtp-Source: ACHHUZ5gWuO7BIceLcmBKNYkMGao9xFPw4XyyBHtMY8YchWoEkZuudgzgArbFrxLghboz06yhmTvFA==
X-Received: by 2002:a05:6402:520a:b0:516:a1d5:846f with SMTP id s10-20020a056402520a00b00516a1d5846fmr3286182edd.1.1686477674815;
        Sun, 11 Jun 2023 03:01:14 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c7-20020aa7df07000000b00514b854c399sm3744198edy.84.2023.06.11.03.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 03:01:13 -0700 (PDT)
Date:   Sun, 11 Jun 2023 12:01:12 +0200
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
Message-ID: <ZIWbaLd87EMbkDAY@nanopsycho>
References: <20230609121853.3607724-1-arkadiusz.kubalewski@intel.com>
 <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230609121853.3607724-4-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 09, 2023 at 02:18:46PM CEST, arkadiusz.kubalewski@intel.com wrote:
>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>

[...]


>+ * dpll_xa_ref_dpll_first - find first record of given xarray
>+ * @xa_refs: xarray
>+ *
>+ * Context: shall be called under a lock (dpll_lock)
>+ * Return: first element on given xaaray

typo: xarray


>+ */
>+struct dpll_pin_ref *dpll_xa_ref_dpll_first(struct xarray *xa_refs)

[...]


>+/**
>+ * dpll_device_get - find existing or create new dpll device
>+ * @clock_id: clock_id of creator
>+ * @device_idx: idx given by device driver
>+ * @module: reference to registering module
>+ *
>+ * Get existing object of a dpll device, unique for given arguments.
>+ * Create new if doesn't exist yet.
>+ *
>+ * Context: Acquires a lock (dpll_lock)
>+ * Return:
>+ * * valid dpll_device struct pointer if succeeded
>+ * * ERR_PTR(-ENOMEM) - failed memory allocation

Yeah, that is kind of obvious, isn't? Really, drop this pointless
coments.


>+ * * ERR_PTR(X) - failed allocation on dpll's xa
>+ */
>+struct dpll_device *
>+dpll_device_get(u64 clock_id, u32 device_idx, struct module *module)

[...]


>+/**
>+ * dpll_pin_register - register the dpll pin in the subsystem
>+ * @dpll: pointer to a dpll
>+ * @pin: pointer to a dpll pin
>+ * @ops: ops for a dpll pin ops
>+ * @priv: pointer to private information of owner
>+ *
>+ * Context: Acquires a lock (dpll_lock)
>+ * Return:
>+ * * 0 on success
>+ * * -EINVAL - missing pin ops
>+ * * -ENOMEM - failed to allocate memory

Does not make sense to assign one errno to one specific error.
Avoid tables like this.


>+ */
>+int
>+dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>+		  const struct dpll_pin_ops *ops, void *priv)
>+{
>+	int ret;
>+
>+	mutex_lock(&dpll_lock);
>+	if (WARN_ON(!(dpll->module == pin->module &&
>+		      dpll->clock_id == pin->clock_id)))
>+		ret = -EFAULT;

-EINVAL;


>+	else
>+		ret = __dpll_pin_register(dpll, pin, ops, priv);
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}

[...]
