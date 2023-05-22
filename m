Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4618170B837
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbjEVI7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbjEVI7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:59:18 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BBA1BE;
        Mon, 22 May 2023 01:58:35 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QPrvc5zc2zyTW;
        Mon, 22 May 2023 11:58:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1684745905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctT1nifoev3hHlgWE8Eu+txWc48x8uyKSST1/8B9WGc=;
        b=w7PZ86zyjH3fSidq7rCaEGcLKr+Eu9zcIobfhozFkU6pOpRuepM8640+Im/apSP91WTtok
        13aq/IGEzHHcoJHwVJsshcMdQZwpmy8Xk3omNtfYsWFbUCOpPA5JB1jG3/0b21cttppQLC
        MbLTWcxXr1agKN5GM9vIG6lraDOFIKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1684745905;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ctT1nifoev3hHlgWE8Eu+txWc48x8uyKSST1/8B9WGc=;
        b=VecV+KnmzrrkwGGIz93aqacUUcZ3ehs9+IsNUtsxRmguOBXjxqH1dLp0+iHBqXUuPD2Hcs
        lxCA3URSu3rDZofUIXxqduDDLde6x1gk/+oAcd7oFCc01Z9cW2xwEgl6DyJRcjQIP7hIUU
        rAZ75F2VWzh0te6RqE7iojaOMAOKd/s=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1684745905; a=rsa-sha256; cv=none;
        b=bufxwxn4WKn1MJyZ7FovEvpFcGtfhxM7RrI0GEzzwPy+gOsWGK5NACUJqi+9fd8dr+HsTl
        1uR3jWIcIxwR2fMrkG3lY1F2xA6bsG0FxwFrA7lN1/fd3c6N7T0ck7fa8CQIrUn4lImbOi
        b7dcY5QU8QZ0VvHFLDgKCIPi6JY/5IU=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 35939634C91;
        Mon, 22 May 2023 11:58:20 +0300 (EEST)
Date:   Mon, 22 May 2023 11:58:20 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Heiko =?iso-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Cc:     Michael Tretter <m.tretter@pengutronix.de>,
        Jacob Chen <jacob-chen@iotwrt.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Subject: Re: [PATCH RESEND 2/2] arm64: dts: rockchip: Add RGA2 support to
 rk356x
Message-ID: <ZGsurJERE9uZfMs0@valkosipuli.retiisi.eu>
References: <20230119-rk3568-rga-v1-0-43d4d14365e6@pengutronix.de>
 <20230119-rk3568-rga-v1-2-43d4d14365e6@pengutronix.de>
 <ZGUfTP1EXtlJbtxJ@valkosipuli.retiisi.eu>
 <2290673.ElGaqSPkdT@diego>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2290673.ElGaqSPkdT@diego>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 12:46:11PM +0200, Heiko Stübner wrote:
> Hi,
> 
> Am Mittwoch, 17. Mai 2023, 20:39:08 CEST schrieb Sakari Ailus:
> > Hi folks,
> > 
> > On Fri, Jan 20, 2023 at 10:14:22AM +0100, Michael Tretter wrote:
> > > The rk3568 also features a RGA2 block. Add the necessary device tree
> > > node.
> > > 
> > > Acked-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > > Signed-off-by: Michael Tretter <m.tretter@pengutronix.de>
> > 
> > Can this patch be merged via the media tree? I don't expect merging the
> > other one via a different tree being an issue either, so alternatively to
> > the 1st patch:
> > 
> > Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> 
> thanks for the Ack. To prevent conflicts with other additions to the
> rk356x.dtsi file, I've picked now both patches for the rockchip tree.

Thank you!

-- 
Sakari Ailus
