Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CAB7421E7
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjF2ITV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjF2ISI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:18:08 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA0435BC
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:13:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fbc060a2caso1022915e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1688026425; x=1690618425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XCNcU+qQjqANE7miJnt/rRYeXCcZNW96kSXkJVN64sA=;
        b=t+jCRgWMe9clsMdvABkCIyCYTsRENxOd2x1gINk9t8cwUOVP4GpHwYsveP15/BaTxa
         IiY4bWtoAXAchtgGBvWVBSVHajfMyXWMfg8mH09pnBnYrxbBszocjJo87KBBFuLdyr8w
         gDwrrJMKhMocvsJEE+7i6hMpn6aw274D3+HbNb8XDLOh+TxC3BZS79vlWTwn34U7DwIo
         UrNO+xXIyioiE15XYWLzIOxMxZF4seSi5sOpw+1uwvmqFJjPMEFdZ2BjQAT25raMMQuc
         Hd/KixDUkzG8rXkE/gv8cxwnI39xp/f05IZEtVkXU+ZL/rGRqJy4MJyAOvyOgom44ue+
         K2zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688026425; x=1690618425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XCNcU+qQjqANE7miJnt/rRYeXCcZNW96kSXkJVN64sA=;
        b=Or1o1ZP5qSaNUGQ+gq0G0ghqkdSHus7SoAOKVzr77tvPuma+N1dVOUHVraFONf8Bkb
         CJNBdSx6aP3ytX2Y1R4MG5LWlj5XDNsZyB1utUUFhacNi2yH9GL8+UHK+mhqOI91kG8L
         wMaMVGxRdgWBkoF0k4mE7/5Ae8OOKwK5TTnChOMQ5rC8a51t8H/09jyRikASCz4BbpAH
         IDxSF7YgGs51f9Lr+I+d12HpZCmFUMNUD6gx1TgwA7nDKSwezs9aXj2N9cbMXIZHQXwb
         NzX5xPj30rkCGWY+o4xQoQQmgX6CnJgIlVonzbEA0RDdm+Tqg4eH40TQYJsIZOtcBqMU
         Kkbg==
X-Gm-Message-State: AC+VfDxPgF/IvDJ1cCzy516H0ZcG/yECEcgJB6y0MfzjJiBNYvQK80yq
        schVegcN/R0B+5kOKhTll7spjw==
X-Google-Smtp-Source: ACHHUZ4Hq/Ygv5bP0PW9CWoZ78vG28FdK9CR3U+nUITIwO8dut4OijbZB0fTo6rEzYqGldh55avUEQ==
X-Received: by 2002:a1c:7417:0:b0:3f9:b87c:10db with SMTP id p23-20020a1c7417000000b003f9b87c10dbmr20901942wmc.3.1688026425228;
        Thu, 29 Jun 2023 01:13:45 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id g11-20020a7bc4cb000000b003fbab76165asm5145964wmk.48.2023.06.29.01.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 01:13:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 10:13:43 +0200
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
Subject: Re: [RFC PATCH v9 03/10] dpll: core: Add DPLL framework base
 functions
Message-ID: <ZJ09N2TI4wHrA4rB@nanopsycho>
References: <20230623123820.42850-1-arkadiusz.kubalewski@intel.com>
 <20230623123820.42850-4-arkadiusz.kubalewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623123820.42850-4-arkadiusz.kubalewski@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 23, 2023 at 02:38:13PM CEST, arkadiusz.kubalewski@intel.com wrote:
>From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>

One thing I forgot to point out the last time:

[...]	
	
>+int
>+dpll_pin_register(struct dpll_device *dpll, struct dpll_pin *pin,
>+		  const struct dpll_pin_ops *ops, void *priv)
>+{
>+	int ret;
>+
>+	if (WARN_ON(!ops) ||
>+	    WARN_ON(!ops->state_on_dpll_get) ||
>+	    WARN_ON(!ops->direction_get))

Please add check that you don't register to dpll instance which is
unregistered. Similar check needs to be added to pin_on_pin register.

Also, make sure you don't unregister dpll device/pin which has child
pins registered under it.


>+		return -EINVAL;
>+
>+	mutex_lock(&dpll_lock);
>+	if (WARN_ON(!(dpll->module == pin->module &&
>+		      dpll->clock_id == pin->clock_id)))
>+		ret = -EINVAL;
>+	else
>+		ret = __dpll_pin_register(dpll, pin, ops, priv);
>+	mutex_unlock(&dpll_lock);
>+
>+	return ret;
>+}

[...]
